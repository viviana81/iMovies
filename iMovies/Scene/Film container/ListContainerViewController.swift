//
//  ListContainerViewController.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 23/02/21.
//

import UIKit

class ListContainerViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    private let viewModel: HomeViewModel
    
    var filmChildren: [ListViewController] = []
    
    lazy var pageController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        vc.dataSource = self
        vc.delegate = self
        return vc
    }()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        add(pageController, in: containerView)
        viewModel.fetchData()
        
        viewModel.reloadData = { [weak self] in
            
            guard let self = self else { return }
            // popoliamo l'array di filmchildren( che è un array di list view controller, quindi sono i child viewController) una volta che abbiamo ottenuto i dati dalle promise, per questo lo facciamo nel reload
            let nowPlaying = ListViewController(listVM: .init(withFilms: self.viewModel.nowPlaying))
            let popular = ListViewController(listVM: .init(withFilms: self.viewModel.popular))
            let top = ListViewController(listVM: .init(withFilms: self.viewModel.top))
            let upcoming = ListViewController(listVM: .init(withFilms: self.viewModel.upcoming))
            
            // aggiungiamo i viewcontroller instanziati nell'array
            self.filmChildren.append(contentsOf: [nowPlaying, popular, top, upcoming])
            // definiamo il numero di pagine del pageControl
            self.pageControl.numberOfPages = self.filmChildren.count
            
            // chiedere perchè qui settiamo solo nowPlaying ??
            self.pageController.setViewControllers([nowPlaying], direction: .forward, animated: true, completion: nil)
        }
    }
}

extension ListContainerViewController: UIPageViewControllerDataSource {
   
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        // Recupero l'indice del viewcontroller attuale
        // Controlliamo anche che l'indice attuale sia maggiore di zero
        guard let currentIndex = filmChildren.firstIndex(where: { $0 == viewController }), currentIndex > 0 else { return nil }
        // recupero l'indice del viewcontroller precedente che è quello attuale -1
        let finalIndex = currentIndex - 1
        return filmChildren[finalIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        // Recupero l'indice del viewcontroller attuale
        // Controlliamo anche che l'indice attuale sia minore dell'array di viewcontroller -1
        guard let currentIndex = filmChildren.firstIndex(where: { $0 == viewController }), currentIndex < filmChildren.count - 1 else { return nil }
       // recupero l'indice del view controller successivo a aquello attuale che è currentindex+1
        let finalIndex = currentIndex + 1
        return filmChildren[finalIndex]
    }
}

extension ListContainerViewController: UIPageViewControllerDelegate {
    // questo metodo serve per collegare il pageControl al pageController
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed,
           let visibleViewController = pageViewController.viewControllers?.first as? ListViewController,
            let index = filmChildren.firstIndex(of: visibleViewController) {
            
            pageControl.currentPage = index
          
        }
    }
}

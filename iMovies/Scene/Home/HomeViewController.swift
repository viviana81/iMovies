//
//  ViewController.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 22/02/21.
//

import UIKit

class HomeViewController: UIViewController {

    let homeVM: HomeViewModel
    
    init(homeVM: HomeViewModel) {
        self.homeVM = homeVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Vars
    lazy var filmCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collection.register(FilmCollectionViewCell.self)
        collection.register(HeaderView.self, forSupplementaryViewOfKind: HeaderView.kind, withReuseIdentifier: HeaderView.reuseIdentifier)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .clear
        return collection
    }()
    
    // MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.orange, .font: UIFont.boldSystemFont(ofSize: 24)]
        filmCollection.pin(to: view)
        homeVM.fetchData()
        homeVM.reloadCollection = {
            self.filmCollection.reloadData()
        }
    }
    // MARK: - Actions
    func createLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.40),
                                               heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 10,
            bottom: 0,
            trailing: 10)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: HeaderView.kind,
            alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = [sectionHeader]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = Section.allCases[section]
        switch section {
        case .nowPlaying:
            return homeVM.nowPlaying.count
        case .popular:
            return homeVM.popular.count
        case .topRated:
            return homeVM.top.count
        case .upcoming:
            return homeVM.upcoming.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FilmCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let section = Section.allCases[indexPath.section]
        switch section {
        case .nowPlaying:
            let now = homeVM.nowPlaying[indexPath.item]
            cell.configure(withFilm: now)
        case .popular:
            let popular = homeVM.popular[indexPath.item]
            cell.configure(withFilm: popular)
        case .upcoming:
            let upcoming = homeVM.upcoming[indexPath.item]
            cell.configure(withFilm: upcoming)
        case .topRated:
            let top = homeVM.top[indexPath.item]
            cell.configure(withFilm: top)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.reuseIdentifier,
                for: indexPath) as? HeaderView else {
            fatalError("Cannot create header view")
        }
        
        supplementaryView.label.text = Section.allCases[indexPath.section].title
        
        return supplementaryView
    }
    
}

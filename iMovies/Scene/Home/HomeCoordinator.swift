//
//  HomeCoordinator.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 22/02/21.
//

import UIKit

class HomeCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    let window: UIWindow
    let homeVC: HomeViewController
    let navigation: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        homeVC = HomeViewController(homeVM: HomeViewModel())
        navigation = UINavigationController(rootViewController: homeVC)
        navigation.tabBarItem = UITabBarItem(title: "Movie Collection", image: UIImage(systemName: "film"), tag: 0)
    }
    
    func start() {
        homeVC.delegate = self
    }
}

extension HomeCoordinator: HomeViewControllerDelegate {
    
    func openDetail(withId id: Int) {
        let detail = DetailViewController(detailVM: DetailViewModel(filmId: id))
        navigation.pushViewController(detail, animated: true)
    }
}

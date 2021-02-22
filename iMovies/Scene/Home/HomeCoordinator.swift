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
        homeVC = HomeViewController()
        navigation = UINavigationController(rootViewController: homeVC)
    }
    
    func start() {
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
}

//
//  HomeTabBarController.swift
//  iOSAvanzado_Practica
//
//  Created by David Robles Lopez on 21/2/23.
//

import UIKit

class HomeTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupTabs()
    }
    
    private func setupTabs() {
        
        let navigationController1 = UINavigationController(rootViewController: HeroesListViewController())
        let tabImage = UIImage(systemName: "text.justify")
        navigationController1 .tabBarItem = UITabBarItem(title: "TableView", image: tabImage, tag: 0)
        
        let navigationController2 = UINavigationController(rootViewController: MapViewController())
        let tabImg = UIImage(systemName: "map.circle.fill")
        navigationController2.tabBarItem = UITabBarItem(title: "MapView", image: tabImg, tag: 1)
        
        viewControllers = [navigationController1, navigationController2]
    }
    
    private func setupLayout() {
        tabBar.backgroundColor = .systemBackground
    }
}

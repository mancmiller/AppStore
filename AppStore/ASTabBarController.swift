//
//  TabBarController.swift
//  AppStore
//
//  Created by Muslim on 10.04.2023.
//

import UIKit

class ASTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createNC(viewController: AppsVC(), title: "Apps", systemImageName: "square.stack.3d.up.fill"),
            createNC(viewController: UIViewController(), title: "Today", systemImageName: "doc.text.image"),
            createNC(viewController: SearchVC(), title: "Search", systemImageName: "magnifyingglass")
        ]
    }
    
    fileprivate func createNC(viewController: UIViewController, title: String, systemImageName: String) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        viewController.navigationItem.title = title
        navController.tabBarItem.title = title
        viewController.view.backgroundColor = .systemBackground
        navController.tabBarItem.image = UIImage(systemName: systemImageName)
        
        return navController
    }
}

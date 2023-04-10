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
            createNC(viewController: SearchVC(), title: "Search", systemImageName: "magnifyingglass"),
            createNC(viewController: UIViewController(), title: "Today", systemImageName: "doc.text.image"),
            createNC(viewController: UIViewController(), title: "Apps", systemImageName: "square.stack.3d.up.fill")
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

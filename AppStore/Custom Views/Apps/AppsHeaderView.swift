//
//  AppsHeaderView.swift
//  AppStore
//
//  Created by Muslim on 15.04.2023.
//

import UIKit

class AppsHeaderView: UICollectionReusableView {
    
    let appHeaderHorizontalController = AppsHeaderHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        addSubview(appHeaderHorizontalController.view)
        
        appHeaderHorizontalController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appHeaderHorizontalController.view.topAnchor.constraint(equalTo: topAnchor),
            appHeaderHorizontalController.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            appHeaderHorizontalController.view.trailingAnchor.constraint(equalTo: trailingAnchor),
            appHeaderHorizontalController.view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

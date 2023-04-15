//
//  AppsGroupCell.swift
//  AppStore
//
//  Created by Muslim on 12.04.2023.
//

import UIKit

class AppsGroupCell: UICollectionViewCell {
    
    let titleLabel = UILabel(text: "App Section",
                             font: .boldSystemFont(ofSize: 30))
    
    let horizontalController = AppsHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemCyan
        
        addSubview(titleLabel)
        addSubview(horizontalController.view)
        
        horizontalController.view.backgroundColor = .blue
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        horizontalController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
            
            horizontalController.view.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            horizontalController.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            horizontalController.view.trailingAnchor.constraint(equalTo: trailingAnchor),
            horizontalController.view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UILabel {
    convenience init(text: String, font: UIFont) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
    }
}

//
//  PreviewCell.swift
//  AppStore
//
//  Created by Muslim on 19.04.2023.
//

import UIKit

class PreviewCell: UICollectionViewCell {
    
    let horizontalController = PreviewController()
    
    let previewLabel = UILabel(text: "Preview", font: .boldSystemFont(ofSize: 24), textColor: .label)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(previewLabel)
        addSubview(horizontalController.view)
        
        previewLabel.translatesAutoresizingMaskIntoConstraints = false
        horizontalController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            previewLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            previewLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            previewLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            horizontalController.view.topAnchor.constraint(equalTo: previewLabel.bottomAnchor, constant: 12),
            horizontalController.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            horizontalController.view.trailingAnchor.constraint(equalTo: trailingAnchor),
            horizontalController.view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

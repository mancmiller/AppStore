//
//  ReviewRowCell.swift
//  AppStore
//
//  Created by Muslim on 19.04.2023.
//

import UIKit

class ReviewRowCell: UICollectionViewCell {
    
    let sectionLabel = UILabel(text: "Reviews & Ratings", font: .boldSystemFont(ofSize: 24), textColor: .label)
    
    let reviewsController = ReviewsController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(sectionLabel)
        addSubview(reviewsController.view)
        
        sectionLabel.translatesAutoresizingMaskIntoConstraints = false
        reviewsController.view.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            sectionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            sectionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            sectionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            sectionLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
            
            reviewsController.view.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor, constant: 12),
            reviewsController.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            reviewsController.view.trailingAnchor.constraint(equalTo: trailingAnchor),
            reviewsController.view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

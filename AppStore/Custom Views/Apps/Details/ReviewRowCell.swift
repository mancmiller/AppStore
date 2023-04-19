//
//  ReviewRowCell.swift
//  AppStore
//
//  Created by Muslim on 19.04.2023.
//

import UIKit

class ReviewRowCell: UICollectionViewCell {
    
    let reviewsController = ReviewsController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(reviewsController.view)
        reviewsController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reviewsController.view.topAnchor.constraint(equalTo: topAnchor),
            reviewsController.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            reviewsController.view.trailingAnchor.constraint(equalTo: trailingAnchor),
            reviewsController.view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

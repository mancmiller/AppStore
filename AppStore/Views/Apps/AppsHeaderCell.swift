//
//  AppsHeaderCell.swift
//  AppStore
//
//  Created by Muslim on 15.04.2023.
//

import UIKit

class AppsHeaderCell: UICollectionViewCell {
    
    let companyLabel = UILabel(text: "Meta", font: .boldSystemFont(ofSize: 16), textColor: .systemBlue)
    let titleLabel = UILabel(text: "Keeping up with friends is faster than ever.", font: .systemFont(ofSize: 24), textColor: .label)
    
    let imageView = UIImageView(cornerRadius: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.image = UIImage(named: "holiday")
        
        titleLabel.numberOfLines = 2
        
        let stackView = UIStackView(arrangedSubviews: [
        companyLabel, titleLabel, imageView
        ])
        stackView.axis = .vertical
        
        addSubview(stackView)
        
        stackView.spacing = 8
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

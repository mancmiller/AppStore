//
//  TodayCell.swift
//  AppStore
//
//  Created by Muslim on 21.04.2023.
//

import UIKit

class TodayCell: UICollectionViewCell {
    
    var todayItem: TodayItem! {
        didSet {
            categoryLabel.text = todayItem.category
            titleLabel.text = todayItem.title
            imageView.image = todayItem.image
            descriptionLabel.text = todayItem.description
        }
    }
    
    let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20), textColor: .label)
    
    let titleLabel = UILabel(text: "Utilizing Your Time", font: .boldSystemFont(ofSize: 28), textColor: .label)
    
    let imageView = UIImageView(image: UIImage(named: "garden"))
    
    let descriptionLabel = UILabel(text: "All the tools and apps you need to intelligently organize your life the right way", numberOfLines: 3, font: .systemFont(ofSize: 18), textColor: .label)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemGray5
        clipsToBounds = true
        layer.cornerRadius = 16
        imageView.contentMode = .scaleAspectFit
        
        let stackView = UIStackView(arrangedSubviews: [
        categoryLabel, titleLabel, imageView, descriptionLabel
        ], customSpacing: 8)
        stackView.axis = .vertical
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 240),
            imageView.heightAnchor.constraint(equalToConstant: 240)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

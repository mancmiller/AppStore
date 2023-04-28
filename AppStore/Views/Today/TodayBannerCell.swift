//
//  TodayCell.swift
//  AppStore
//
//  Created by Muslim on 21.04.2023.
//

import UIKit

class TodayBannerCell: TodayBaseCell {
    
    var topConstant: NSLayoutConstraint!
    
    override var todayItem: TodayItem! {
        didSet {
            categoryLabel.text = todayItem.category
            titleLabel.text = todayItem.title
            imageView.image = todayItem.image
            descriptionLabel.text = todayItem.description
            backgroundColor = todayItem.backgroundColor
            backgroundView?.backgroundColor = todayItem.backgroundColor
        }
    }
    
    let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 18), textColor: .secondaryLabel)
    
    let titleLabel = UILabel(text: "Utilizing Your Time", font: .boldSystemFont(ofSize: 28), textColor: .label)
    
    let imageView = UIImageView(image: UIImage(named: "garden"))
    
    let descriptionLabel = UILabel(text: "All the tools and apps you need to intelligently organize your life the right way", numberOfLines: 3, font: .systemFont(ofSize: 18), textColor: .label)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        clipsToBounds = true
        layer.cornerRadius = 16
        imageView.contentMode = .scaleAspectFit
        
        let stackView = UIStackView(arrangedSubviews: [
        categoryLabel, titleLabel, imageView, descriptionLabel
        ], customSpacing: 8)
        stackView.axis = .vertical
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        topConstant = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20)
        topConstant.isActive = true
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 210),
            imageView.heightAnchor.constraint(equalToConstant: 210)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

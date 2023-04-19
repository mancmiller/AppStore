//
//  ReviewCell.swift
//  AppStore
//
//  Created by Muslim on 19.04.2023.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    let titleLabel = UILabel(text: "Review Title", font: .boldSystemFont(ofSize: 20), textColor: .label)
    let authorLabel = UILabel(text: "Author", font: .systemFont(ofSize: 18), textColor: .secondaryLabel)
    let starsLabel = UILabel(text: "Stars", font: .systemFont(ofSize: 16), textColor: .label)
    let bodyLabel = UILabel(text: "Review Body\nReview Body\nReview Body\nReview Body\n", numberOfLines: 0, font: .systemFont(ofSize: 18), textColor: .label)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemGray5
        layer.cornerRadius = 16
        clipsToBounds = true
        
        let stackView = UIStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [titleLabel,
                                           authorLabel
                                          ],customSpacing: 8),
            starsLabel,
            bodyLabel,
        ], customSpacing: 12)
        
        titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        
        authorLabel.textAlignment = .right
        
        stackView.axis = .vertical
        
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

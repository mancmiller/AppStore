//
//  AppRowCell.swift
//  AppStore
//
//  Created by Muslim on 15.04.2023.
//

import UIKit

class  AppRowCell: UICollectionViewCell {
    
    let imageView = UIImageView(cornerRadius: 14)
    
    let nameLabel = UILabel(text: "App Name", font: .systemFont(ofSize: 20), textColor: .label)
    let companyLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 13, weight: .medium), textColor: .secondaryLabel)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.backgroundColor = .systemRed
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 64),
            imageView.heightAnchor.constraint(equalToConstant: 64)
        ])
        
        let labelsStackView = UIStackView(arrangedSubviews: [nameLabel, companyLabel])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 4
        
        let stackView = UIStackView(arrangedSubviews: [
        imageView, labelsStackView, GetButton()
        ])
        
        stackView.spacing = 16
        stackView.alignment = .center
        
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

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
    let companyLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 14), textColor: .secondaryLabel)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 64),
            imageView.heightAnchor.constraint(equalToConstant: 64)
        ])
        
        let labelsStackView = UIStackView(arrangedSubviews: [nameLabel, companyLabel], customSpacing: 4)
        labelsStackView.axis = .vertical
        
        let stackView = UIStackView(arrangedSubviews: [
            imageView, labelsStackView, GetButton(backgroundColor: .systemGray5, setTitleColor: .systemBlue)
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

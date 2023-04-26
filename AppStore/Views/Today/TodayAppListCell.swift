//
//  TodayAppListCell.swift
//  AppStore
//
//  Created by Muslim on 25.04.2023.
//

import UIKit

class TodayAppListCell: UICollectionViewCell {
    
    var app: FeedResult! {
        didSet {
            nameLabel.text = app.name
            companyLabel.text = app.artistName
            imageView.sd_setImage(with: URL(string: app.artworkUrl100))
        }
    }
    
    let imageView = UIImageView(cornerRadius: 14)
    
    let nameLabel = UILabel(text: "App Name", font: .systemFont(ofSize: 20), textColor: .label)
    
    let companyLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 14), textColor: .secondaryLabel)
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray2
        return view
    }()
    
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
        addSubview(separatorView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            separatorView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 4),
            separatorView.heightAnchor.constraint(equalToConstant: 0.2)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

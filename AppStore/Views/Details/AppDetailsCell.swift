//
//  AppDetailsCell.swift
//  AppStore
//
//  Created by Muslim on 18.04.2023.
//

import UIKit

class AppDetailsCell: UICollectionViewCell {
    
    var app: Result! {
        didSet {
            nameLabel.text = app?.trackName
            releaseNotesLabel.text = app?.releaseNotes
            iconImageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
            getButton.setTitle(app?.formattedPrice, for: .normal)
        }
    }
    
    let iconImageView = UIImageView(cornerRadius: 16)
    
    let nameLabel = UILabel(text: "App Name", numberOfLines: 2, font: .boldSystemFont(ofSize: 24), textColor: .label)
    
    let getButton = GetButton(backgroundColor: .systemBlue, setTitleColor: .white)
    
    let whatsNewLabel = UILabel(text: "What`s New", font: .boldSystemFont(ofSize: 24), textColor: .label)
    
    let releaseNotesLabel = UILabel(text: "Release Notes", numberOfLines: 0, font: .systemFont(ofSize: 18), textColor: .label)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        iconImageView.backgroundColor = .brown
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant: 140),
            iconImageView.widthAnchor.constraint(equalToConstant: 140)
        ])
        
        let nameAndButtonStackView = UIStackView(arrangedSubviews: [
            nameLabel,
            UIStackView(arrangedSubviews: [
                getButton,
                UIView()
            ], customSpacing: 12),
            UIView()
        ], customSpacing: 12)
        nameAndButtonStackView.axis = .vertical
        
        let whatsNewStackView = UIStackView(arrangedSubviews: [
        whatsNewLabel,
        releaseNotesLabel
        ], customSpacing: 12)
        whatsNewStackView.axis = .vertical
        
        let stackView = UIStackView(arrangedSubviews:[
            UIStackView(arrangedSubviews: [
                iconImageView,
                nameAndButtonStackView
            ], customSpacing: 16),
            whatsNewStackView
        ], customSpacing: 20)
        stackView.axis = .vertical
        
        
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  TodayFullScreenHeaderCell.swift
//  AppStore
//
//  Created by Muslim on 22.04.2023.
//

import UIKit

class TodayFullScreenHeaderCell: UITableViewCell {
    
    let todayCell = TodayBannerCell()
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage.init(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .systemGray
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(todayCell)
        contentView.addSubview(closeButton)
        
        todayCell.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            todayCell.topAnchor.constraint(equalTo: topAnchor),
            todayCell.leadingAnchor.constraint(equalTo: leadingAnchor),
            todayCell.trailingAnchor.constraint(equalTo: trailingAnchor),
            todayCell.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 64),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

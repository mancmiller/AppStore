//
//  TodayFullScreenHeaderCell.swift
//  AppStore
//
//  Created by Muslim on 22.04.2023.
//

import UIKit

class TodayFullScreenHeaderCell: UITableViewCell {
    
    let todayCell = TodayBannerCell()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        todayCell.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(todayCell)
        NSLayoutConstraint.activate([
            todayCell.topAnchor.constraint(equalTo: topAnchor),
            todayCell.leadingAnchor.constraint(equalTo: leadingAnchor),
            todayCell.trailingAnchor.constraint(equalTo: trailingAnchor),
            todayCell.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  TodayMultipleAppCell.swift
//  AppStore
//
//  Created by Muslim on 25.04.2023.
//

import UIKit

class TodayMultipleAppCell: TodayBaseCell {

    override var todayItem: TodayItem! {
        didSet {
            categoryLabel.text = todayItem.category
            titleLabel.text = todayItem.title
            backgroundColor = todayItem.backgroundColor
            multipleAppsController.apps = todayItem.apps
            multipleAppsController.collectionView.reloadData()
        }
    }

    let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 18), textColor: .secondaryLabel)
    let titleLabel = UILabel(text: "Utilizing your Time", numberOfLines: 2, font: .boldSystemFont(ofSize: 28), textColor: .label)

    let multipleAppsController = TodayMultipleAppVC(mode: .small)

    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.cornerRadius = 16

        let stackView = UIStackView(arrangedSubviews: [
            categoryLabel,
            titleLabel,
            multipleAppsController.view
            ], customSpacing: 12)
        stackView.axis = .vertical

        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        ])

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}

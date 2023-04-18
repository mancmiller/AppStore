//
//  SAButton.swift
//  AppStore
//
//  Created by Muslim on 15.04.2023.
//

import UIKit

class GetButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        setTitle("GET", for: .normal)
        titleLabel!.font = .systemFont(ofSize: 14, weight: .bold)
        layer.cornerRadius = 14
        backgroundColor = .systemGray5
        setTitleColor(.systemBlue, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 32),
            self.widthAnchor.constraint (equalToConstant: 80)
        ])
    }
}

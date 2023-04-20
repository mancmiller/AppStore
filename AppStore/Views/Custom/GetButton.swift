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
    
    convenience init(backgroundColor: UIColor, setTitleColor: UIColor){
        self.init()
        self.backgroundColor = backgroundColor
        self.setTitleColor(setTitleColor, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        setTitle("GET", for: .normal)
        titleLabel!.font = .systemFont(ofSize: 14, weight: .bold)
        layer.cornerRadius = 32 / 2
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 32),
            self.widthAnchor.constraint (equalToConstant: 80)
        ])
    }
}

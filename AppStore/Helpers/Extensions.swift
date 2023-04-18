//
//  Extensions.swift
//  AppStore
//
//  Created by Muslim on 15.04.2023.
//

import UIKit

extension UILabel {
    convenience init(text: String, numberOfLines: Int = 1, font: UIFont, textColor: UIColor) {
        self.init(frame: .zero)
        self.text = text
        self.numberOfLines = numberOfLines
        self.font = font
        self.textColor = textColor
    }
}

extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], customSpacing: CGFloat = 0){
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = customSpacing
    }
    
}

//
//  SearchResultCell.swift
//  AppStore
//
//  Created by Muslim on 10.04.2023.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    
    var appResult: Result! {
        didSet {
            nameLabel.text = appResult.trackName
            categoryLabel.text = appResult.primaryGenreName
            ratingsLabel.text = "Rating: \(appResult.averageUserRating ?? 0)"
            
            appIconImageView.sd_setImage(with: URL(string: appResult.artworkUrl100))
            
            screenshotImageView1.sd_setImage(with: URL(string: appResult.screenshotUrls[0]))
            if appResult.screenshotUrls.count > 1 {
                screenshotImageView2.sd_setImage(with: URL(string: appResult.screenshotUrls[1]))
            }
            if appResult.screenshotUrls.count > 2 {
                screenshotImageView3.sd_setImage(with: URL(string: appResult.screenshotUrls[2]))
            }
        }
    }
    
    let appIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 14
        iv.clipsToBounds = true
        NSLayoutConstraint.activate([
            iv.widthAnchor.constraint(equalToConstant: 64),
            iv.heightAnchor.constraint(equalToConstant: 64)
        ])
        return iv
    }()
    
    let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "App Name"
        return label
    }()
    
    let categoryLabel: UILabel = {
       let label = UILabel()
        label.text = "Photos & Video"
        return label
    }()
    
    let ratingsLabel: UILabel = {
       let label = UILabel()
        label.text = "9.26M"
        return label
    }()
    
    let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = UIColor.systemGray5
        button.layer.cornerRadius = 14
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 32),
            button.widthAnchor.constraint(equalToConstant: 80)
        ])
        return button
    }()
    
    lazy var screenshotImageView1 = self.createScreenshotImageView()
    lazy var screenshotImageView2 = self.createScreenshotImageView()
    lazy var screenshotImageView3 = self.createScreenshotImageView()
    
    func createScreenshotImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 14
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.3
        imageView.layer.borderColor = UIColor.systemGray.cgColor
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureStackViews()
    }
    
    fileprivate func configureStackViews() {
        
        let labelsStackView = UIStackView(arrangedSubviews: [
        nameLabel, categoryLabel, ratingsLabel
        ])
        labelsStackView.axis = .vertical
        
        let infoStackView = UIStackView(arrangedSubviews: [
            appIconImageView, labelsStackView, getButton
        ])
        infoStackView.spacing = 12
        infoStackView.alignment = .center
        
        let screenshotsStackView = UIStackView(arrangedSubviews: [
        screenshotImageView1, screenshotImageView2, screenshotImageView3
        ])
        screenshotsStackView.spacing = 12
        screenshotsStackView.distribution = .fillEqually
        
        let overallStackView = UIStackView(arrangedSubviews: [
        infoStackView, screenshotsStackView
        ])
        overallStackView.axis = .vertical
        overallStackView.spacing = 16
        
        addSubview(overallStackView)
        
        overallStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            overallStackView.topAnchor.constraint(equalTo: self.topAnchor),
            overallStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            overallStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            overallStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

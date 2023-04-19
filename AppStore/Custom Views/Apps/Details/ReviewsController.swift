//
//  ReviewsController.swift
//  AppStore
//
//  Created by Muslim on 19.04.2023.
//

import UIKit

class ReviewsController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    let cellID = "CellID"
    
    class ReviewCell: UICollectionViewCell {
        
        let titleLabel = UILabel(text: "Review Title", font: .boldSystemFont(ofSize: 20), textColor: .label)
        let authorLabel = UILabel(text: "Author", font: .systemFont(ofSize: 18), textColor: .secondaryLabel)
        let starsLabel = UILabel(text: "Stars", font: .systemFont(ofSize: 16), textColor: .label)
        let bodyLabel = UILabel(text: "Review Body\nReview Body\nReview Body\nReview Body\n", numberOfLines: 0, font: .systemFont(ofSize: 18), textColor: .label)
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .systemGray5
            layer.cornerRadius = 16
            clipsToBounds = true
            
            let stackView = UIStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [titleLabel, UIView(), authorLabel]),
            starsLabel,
            bodyLabel,
            ], customSpacing: 12)
            stackView.axis = .vertical
            addSubview(stackView)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
                stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
            ])
        }
  
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ReviewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 48, height: view.frame.height)
    }
}

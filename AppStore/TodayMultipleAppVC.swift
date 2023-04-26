//
//  TodayMultipleAppVC.swift
//  AppStore
//
//  Created by Muslim on 25.04.2023.
//

import UIKit

class TodayMultipleAppVC: BaseListController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellID = "CellID"
    
    var results = [FeedResult]()
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage.init(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .systemGray
        button.addTarget(target.self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    @objc func handleDismiss() {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if mode == .fullscreen {
            setupCloseButton()
        } else {
            collectionView.isScrollEnabled = false
        }
        
        collectionView.backgroundColor = .systemGray6
        
        collectionView.register(TodayAppListCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    fileprivate func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if mode == .fullscreen {
            return UIEdgeInsets(top: 40, left: 20, bottom: 20, right: 20)
        }
            return .zero
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mode == .fullscreen {
            return results.count
        }
        return min(4, results.count)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! TodayAppListCell
        cell.app = self.results[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        let cellHeight: CGFloat = (view.frame.height - 3 * interCellSpacing) / 4
        
        let cellHeight: CGFloat = 68
        if mode == .fullscreen {
            return .init(width: view.frame.width - 40, height: cellHeight)
        }
        return .init(width: view.frame.width, height: cellHeight)
    }
    
    fileprivate let interCellSpacing: CGFloat = 16
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return interCellSpacing
    }
    
    fileprivate let mode: Mode
    
    enum Mode {
        case small, fullscreen
    }
    
    init(mode: Mode) {
        self.mode = mode
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

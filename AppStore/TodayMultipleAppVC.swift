//
//  TodayMultipleAppVC.swift
//  AppStore
//
//  Created by Muslim on 25.04.2023.
//

import UIKit

class TodayMultipleAppVC: BaseListController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellID = "CellID"
    
    var apps = [FeedResult]()
    
    @objc func handleDismiss() {
        dismiss(animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let appID = self.apps[indexPath.item].id
        let appDetailVC = AppDetailVC(appID: appID)
        navigationController?.pushViewController(appDetailVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if mode == .fullscreen {
            navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .close, target: self, action: #selector(handleDismiss))
        }
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(TodayAppListCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if mode == .fullscreen {
            return UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
        }
            return .zero
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mode == .fullscreen {
            return apps.count
        }
        return min(4, apps.count)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! TodayAppListCell
        cell.app = self.apps[indexPath.item]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
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

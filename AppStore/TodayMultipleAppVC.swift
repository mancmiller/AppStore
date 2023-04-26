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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemGray6
        collectionView.isScrollEnabled = false
        
        collectionView.register(TodayAppListCell.self, forCellWithReuseIdentifier: cellID)
        
//        APIManager.shared.fetchTopFreeApps { appGroup, error in
//            self.results = appGroup?.feed.results ?? []
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//            }
//        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(4, results.count)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! TodayAppListCell
        cell.app = self.results[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellHeight: CGFloat = (view.frame.height - 3 * interCellSpacing) / 4
        
        return .init(width: view.frame.width, height: cellHeight)
    }
    
    fileprivate let interCellSpacing: CGFloat = 16
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return interCellSpacing
    }
}

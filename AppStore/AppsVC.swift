//
//  AppsVC.swift
//  AppStore
//
//  Created by Muslim on 12.04.2023.
//

import UIKit

class AppsVC: BaseListController, UICollectionViewDelegateFlowLayout {
    
    let cellID = "id"
    let headerID = "headerID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellID)
        
        collectionView.register(AppsHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        
        fetchData()
    }
    
    var top: AppResutls?
    
    fileprivate func fetchData() {
        APIManager.shared.fetchApps { (appResults, error) in
            if let error = error {
                print("Failed to fetch apps:", error)
                return
            }
            self.top = appResults
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AppsGroupCell
        
        cell.titleLabel.text = top?.feed.title
        cell.horizontalController.appGroup = top
        cell.horizontalController.collectionView.reloadData()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
    
}
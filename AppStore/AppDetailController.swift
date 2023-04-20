//
//  AppDetailController.swift
//  AppStore
//
//  Created by Muslim on 17.04.2023.
//

import UIKit

class AppDetailController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    var appID: String! {
        didSet {
            APIManager.shared.fetchGenericJSONData(urlString: "https://itunes.apple.com/lookup?id=\(appID ?? "")") { (result: SearchResult?, error) in
                let app = result?.results.first
                self.app = app 
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            let reviewsUrl = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(appID ?? "")/sortby=mostrecent/json?l=en&cc=us"
            APIManager.shared.fetchGenericJSONData(urlString: reviewsUrl) { (reviews: Reviews?, error) in
                if let error = error {
                    print("Failed to decode reviews:", error)
                    return
                }
                
                self.reviews = reviews
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    var app: Result?
    var reviews: Reviews?
    
    let detailCellID = "detailCellID"
    let previewCellID = "previewCellID"
    let reviewCellID = "reviewCellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(AppDetailsCell.self, forCellWithReuseIdentifier: detailCellID)
        
        collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: previewCellID)
        
        collectionView.register(ReviewRowCell.self, forCellWithReuseIdentifier: reviewCellID)
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title?.removeAll()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCellID, for: indexPath) as! AppDetailsCell
            cell.app = app
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: previewCellID, for: indexPath) as! PreviewCell
            cell.horizontalController.app = self.app
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewCellID, for: indexPath) as! ReviewRowCell
            cell.reviewsController.reviews = self.reviews
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        var height: CGFloat

        if indexPath.item == 0 {
            
            let dummyCell = AppDetailsCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
            dummyCell.app = app
            dummyCell.layoutIfNeeded()
            
            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
            height = estimatedSize.height
        } else if indexPath.item == 1 {
            height = 500
        } else {
            height = 320
        }
        return .init(width: view.frame.width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 20, right: 0)
    }
}

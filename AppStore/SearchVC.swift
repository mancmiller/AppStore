//
//  ASSearchVC.swift
//  AppStore
//
//  Created by Muslim on 10.04.2023.
//

import UIKit

class SearchVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellID = "reuseID"

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellID)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 250)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

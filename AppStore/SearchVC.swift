//
//  ASSearchVC.swift
//  AppStore
//
//  Created by Muslim on 10.04.2023.
//

import UIKit

class SearchVC: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  TodayItem.swift
//  AppStore
//
//  Created by Muslim on 23.04.2023.
//

import UIKit

struct TodayItem {
    let category: String
    let title: String
    let image: UIImage!
    let description: String
    let backgroundColor: UIColor
    
    let cellType: CellType
    
    let apps: [FeedResult]
    
    enum CellType: String {
        case single, multiple
    }
}

//
//  todayFullScreenVC.swift
//  AppStore
//
//  Created by Muslim on 21.04.2023.
//

import UIKit

class TodayFullScreenVC: UITableViewController {
    
    let cellID = "cellid"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.item == 0 {
            let cell = UITableViewCell()
            cell.backgroundColor = .systemGray5
            let todayCell = TodayCell()
            cell.addSubview(todayCell)
            todayCell.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                todayCell.centerYAnchor.constraint(lessThanOrEqualTo: cell.centerYAnchor),
                todayCell.centerXAnchor.constraint(greaterThanOrEqualTo: cell.centerXAnchor),
                todayCell.widthAnchor.constraint(equalToConstant: 250),
                todayCell.heightAnchor.constraint(equalToConstant: 250)
            ])
            return cell
        }
        
        let cell = TodayFullScreenDescriptionCell()
        cell.backgroundColor = .systemGray5
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = TodayCell()
//        return header
//    }
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 450
//    }
    
}

//
//  todayFullScreenVC.swift
//  AppStore
//
//  Created by Muslim on 21.04.2023.
//

import UIKit

class TodayBannerFullScreenVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var dismissHandler: (() -> ())?
    var todayItem: TodayItem?
    
    let tableView = UITableView(frame: .zero, style: .plain)
    let closeButton = UIButton(type: .close)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.clipsToBounds = true
        setupTableView()
        setupCloseButton()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.isScrollEnabled = false
            scrollView.isScrollEnabled = true
        }
    }
    
    fileprivate func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.contentInset = .init(top: 0, left: 0, bottom: 60, right: 0)
    }
    
    fileprivate func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 64),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -28)
        ])
        closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.item == 0 {
            let headerCell = TodayFullScreenHeaderCell()
            headerCell.todayCell.todayItem = todayItem
            headerCell.clipsToBounds = true
            
            return headerCell
        }
        
        let cell = TodayFullScreenDescriptionCell()
        return cell
    }
    
    @objc fileprivate func handleDismiss(button: UIButton) {
        button.isHidden = true
        dismissHandler?()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return TodayVC.cellHeight
        }
        return UITableView.automaticDimension
    }
}

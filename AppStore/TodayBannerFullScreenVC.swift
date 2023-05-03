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
        setupFloatingControls()
    }
    
    let floatingContainerView = UIView()
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.isScrollEnabled = false
            scrollView.isScrollEnabled = true
        }
        
        let transform = scrollView.contentOffset.y > 100 ? CGAffineTransform(translationX: 0, y: -122) : .identity
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.floatingContainerView.transform = transform
        })
    }
    
    fileprivate func setupFloatingControls() {
        
        floatingContainerView.clipsToBounds = true
        floatingContainerView.layer.cornerRadius = 16
        view.addSubview(floatingContainerView)
        floatingContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            floatingContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            floatingContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            floatingContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 90),
            floatingContainerView.heightAnchor.constraint(equalToConstant: 90)
        ])
        
        let blurVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        floatingContainerView.addSubview(blurVisualEffectView)
        blurVisualEffectView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blurVisualEffectView.topAnchor.constraint(equalTo: floatingContainerView.topAnchor),
            blurVisualEffectView.leadingAnchor.constraint(equalTo: floatingContainerView.leadingAnchor),
            blurVisualEffectView.trailingAnchor.constraint(equalTo: floatingContainerView.trailingAnchor),
            blurVisualEffectView.bottomAnchor.constraint(equalTo: floatingContainerView.bottomAnchor)
        ])
        
        let imageView = UIImageView(cornerRadius: 16)
        imageView.image = todayItem?.image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 68),
            imageView.widthAnchor.constraint(equalToConstant: 68)
        ])
        
        let textStackView = UIStackView(arrangedSubviews: [
            UILabel(text: "Life Hack", font: .boldSystemFont(ofSize: 18), textColor: .label),
            UILabel(text: "Uitilizing your time", font: .systemFont(ofSize: 16), textColor: .secondaryLabel)
        ], customSpacing: 8)
        textStackView.axis = .vertical
        
        let stackView = UIStackView(arrangedSubviews: [
        imageView,
        textStackView,
        GetButton(backgroundColor: .systemGray, setTitleColor: .systemGray6)
        ], customSpacing: 16)
        stackView.alignment = .center
        floatingContainerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: floatingContainerView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: floatingContainerView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: floatingContainerView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: floatingContainerView.bottomAnchor)
        ])
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

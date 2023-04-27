//
//  TodayVC.swift
//  AppStore
//
//  Created by Muslim on 21.04.2023.
//

import UIKit

class TodayVC: BaseListController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellID = "cellID"
    fileprivate let multipleAppCellID = "multipleAppCellID"
    
    var items = [TodayItem]()
    
    var activityIndicatorView = UIActivityIndicatorView(style: .large)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureActivityIndicatorView()
        
        fetchData()
        
        navigationController?.isNavigationBarHidden = true
        
        collectionView.backgroundColor = .systemBackground
        
        collectionView.register(TodayBannerCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
        collectionView.register(TodayMultipleAppCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
    }
    
    fileprivate func configureActivityIndicatorView() {
        activityIndicatorView.color = .systemGray
        activityIndicatorView.startAnimating()
        activityIndicatorView.hidesWhenStopped = true
        view.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatorView.topAnchor.constraint(equalTo: view.topAnchor),
            activityIndicatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            activityIndicatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    fileprivate func fetchData() {
        let dispatchGroup = DispatchGroup()
        
        var topGrossing: AppResutls?
        var topFree: AppResutls?
        
        dispatchGroup.enter()
        APIManager.shared.fetchTopPaidApps { appGroup, error in
            if let error = error {
                print("Failed to fetch apps,", error)
            }
            topGrossing = appGroup
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        APIManager.shared.fetchTopFreeApps { appGroup, error in
            if let error = error {
                print("Failed to fetch apps,", error)
            }
            topFree = appGroup
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) {

            self.activityIndicatorView.stopAnimating()
            self.items = [
                TodayItem(category: "Daily List", title: "Top Grossing iPhone Apps", image: nil, description: "", backgroundColor: .systemGray6, cellType: .multiple, apps: topGrossing?.feed.results ?? []),
                TodayItem(category: "HOLIDAYS", title: "Travel on a Budget", image: UIImage.init(named: "holiday"), description: "Find out all you need to know on how to travel without packing everything!", backgroundColor: UIColor(named: "backgroundColor") ?? .white, cellType: .single, apps: []),
                TodayItem(category: "Daily List", title: topFree?.feed.title ?? "", image: nil, description: "", backgroundColor: .systemGray6, cellType: .multiple, apps: topFree?.feed.results ?? []),
                TodayItem(category: "LIFE HACK", title: "Utilizing Your Time", image: UIImage.init(named: "garden"), description: "All the tools and apps you need to intelligently organize your life the right way", backgroundColor: .systemGray6, cellType: .single, apps: [])
            ]
            
            self.collectionView.reloadData()
        }
    }
    
    var todayFullScreenVC: TodayFullScreenVC!
    
    var topConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if items[indexPath.item].cellType == .multiple {
            
            let fullAppListVC = TodayMultipleAppVC(mode: .fullscreen)
            fullAppListVC.apps = self.items[indexPath.item].apps
            present(UINavigationController(rootViewController: fullAppListVC ), animated: true)
            return
        }
        
        let todayFullScreenVC = TodayFullScreenVC()
        todayFullScreenVC.todayItem = items[indexPath.row]
        todayFullScreenVC.dismissHandler = {
            self.removeFullScreeinView()
        }
        
        let fullScreenView = todayFullScreenVC.view!
        view.addSubview(fullScreenView)
        
        addChild(todayFullScreenVC)
        
        self.todayFullScreenVC = todayFullScreenVC
        
        self.collectionView.isUserInteractionEnabled = false
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        
        // absolute coordinates of cell
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        
        self.startingFrame = startingFrame
        fullScreenView.translatesAutoresizingMaskIntoConstraints = false
        topConstraint = fullScreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        leadingConstraint = fullScreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        widthConstraint = fullScreenView.widthAnchor.constraint(equalToConstant: startingFrame.width)
        heightConstraint = fullScreenView.heightAnchor.constraint(equalToConstant: startingFrame.height)
        
        [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach({$0?.isActive = true})
        
        fullScreenView.layer.cornerRadius = 16
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.topConstraint?.constant = 0
            self.leadingConstraint?.constant = 0
            self.widthConstraint?.constant = self.view.frame.width
            self.heightConstraint?.constant = self.view.frame.height
            
            self.view.layoutIfNeeded()
            
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
//            self.tabBarController?.tabBar.frame.origin.y = self.view.frame.height
            
//            guard let cell = todayFullScreenVC.tableView.cellForRow(at: [0,0]) as? TodayFullScreenHeaderCell else { return }
//            cell.todayCell.topConstraint.constant = 48
//            cell.layoutIfNeeded()

        }, completion: nil)
    }
    
    var startingFrame: CGRect?
    
    @objc func removeFullScreeinView() {
        self.navigationController?.navigationBar.isHidden = false
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.todayFullScreenVC.tableView.contentOffset = .zero
            
            guard let startingFrame = self.startingFrame else { return }
            self.topConstraint?.constant = startingFrame.origin.y
            self.leadingConstraint?.constant = startingFrame.origin.x
            self.widthConstraint?.constant = startingFrame.width
            self.heightConstraint?.constant = startingFrame.height
            
            self.view.layoutIfNeeded()
            
            if let tabBarFrame = self.tabBarController?.tabBar.frame {
                self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height - tabBarFrame.height
            }
            
//            guard let cell = self.todayFullScreenVC.tableView.cellForRow(at: [0,0]) as? TodayFullScreenHeaderCell else { return }
//            cell.todayCell.topConstraint.constant = 24
//            cell.layoutIfNeeded()
            
        }, completion: { _ in
            self.todayFullScreenVC.view.removeFromSuperview()
            self.todayFullScreenVC.removeFromParent()
            self.collectionView.isUserInteractionEnabled = true
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellID = items[indexPath.item].cellType.rawValue
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! TodayBaseCell
        cell.todayItem = items[indexPath.item]
        
        (cell as? TodayMultipleAppCell)?.multipleAppsController.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMultipleAppsTap)))
        
        return cell
    }
    
    @objc func handleMultipleAppsTap(gesture: UITapGestureRecognizer) {
        let collectionView = gesture.view
        
        var superview = collectionView?.superview
        while superview != nil {
            
            if let cell = superview as? TodayMultipleAppCell{
                guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
                
                let fullController = TodayMultipleAppVC(mode: .fullscreen)
                let apps = self.items[indexPath.item].apps
                fullController.apps = apps
                present(UINavigationController(rootViewController: fullController), animated: true)
                return
            }
            superview = superview?.superview
        }
        
        
    }
    
    static let cellHeight: CGFloat = 500
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 40, height: TodayVC.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 20, left: 0, bottom: 20, right: 0)
    }
}

//
//  TodayVC.swift
//  AppStore
//
//  Created by Muslim on 21.04.2023.
//

import UIKit

class TodayVC: BaseListController, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {
    
    fileprivate let cellID = "cellID"
    fileprivate let multipleAppCellID = "multipleAppCellID"
    
    var items = [TodayItem]()
    
    var activityIndicatorView = UIActivityIndicatorView(style: .large)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.superview?.setNeedsLayout()
    }
    
    let blurVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(blurVisualEffectView)
        blurVisualEffectView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blurVisualEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            blurVisualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurVisualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurVisualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        blurVisualEffectView.alpha = 0
        
        configureActivityIndicatorView()
        
        fetchData()
        
        navigationController?.isNavigationBarHidden = true
        
        collectionView.backgroundColor = .systemGray6
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
                TodayItem(category: "Daily List", title: "Top Grossing iPhone Apps", image: nil, description: "", backgroundColor: .systemBackground, cellType: .multiple, apps: topGrossing?.feed.results ?? []),
                TodayItem(category: "HOLIDAYS", title: "Travel on a Budget", image: UIImage.init(named: "holiday"), description: "Find out all you need to know on how to travel without packing everything!", backgroundColor: UIColor(named: "backgroundColor") ?? .white, cellType: .single, apps: []),
                TodayItem(category: "Daily List", title: topFree?.feed.title ?? "", image: nil, description: "", backgroundColor: .systemBackground, cellType: .multiple, apps: topFree?.feed.results ?? []),
                TodayItem(category: "LIFE HACK", title: "Utilizing Your Time", image: UIImage.init(named: "garden"), description: "All the tools and apps you need to intelligently organize your life the right way", backgroundColor: .systemBackground, cellType: .single, apps: [])
            ]
            
            self.collectionView.reloadData()
        }
    }
    
    fileprivate func showMultipleAppListFullScreen(_ indexPath: IndexPath) {
        let fullAppListVC = TodayMultipleAppVC(mode: .fullscreen)
        fullAppListVC.apps = self.items[indexPath.item].apps
        present(UINavigationController(rootViewController: fullAppListVC), animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch items[indexPath.item].cellType {
        case .multiple:
            showMultipleAppListFullScreen(indexPath)
        default:
            showTodayBannerFullScreen(indexPath: indexPath)
        }
    }
    
    var todayBannerFullScreenVC: TodayBannerFullScreenVC!
    
    var topConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    
    fileprivate func animateTodayBannerFullScreen() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.blurVisualEffectView.alpha = 1
            
            self.topConstraint?.constant = 0
            self.leadingConstraint?.constant = 0
            self.widthConstraint?.constant = self.view.frame.width
            self.heightConstraint?.constant = self.view.frame.height
            
            self.view.layoutIfNeeded()
            
            self.tabBarController?.tabBar.frame.origin.y = self.view.frame.height
            
            guard let cell = self.todayBannerFullScreenVC.tableView.cellForRow(at: [0,0]) as? TodayFullScreenHeaderCell else { return }
            cell.todayCell.topConstraint.constant = 60
            cell.layoutIfNeeded()
        })
    }
    
    fileprivate func setupTodayBannerFullScreenVC(_ indexPath: IndexPath) {
        let todayBannerFullScreenVC = TodayBannerFullScreenVC()
        todayBannerFullScreenVC.todayItem = items[indexPath.row]
        
        todayBannerFullScreenVC.dismissHandler = {
            self.removeFullScreeinView()
        }
        
        todayBannerFullScreenVC.view.layer.cornerRadius = 16
        self.todayBannerFullScreenVC = todayBannerFullScreenVC
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleDrag))
        gesture.delegate = self
        todayBannerFullScreenVC.view.addGestureRecognizer(gesture)
    }
    
    var todayBannerFullScreenBeginOffset: CGFloat = 0
    
    @objc fileprivate func handleDrag(gesture: UIPanGestureRecognizer) {
        
        if gesture.state == .began {
            todayBannerFullScreenBeginOffset = todayBannerFullScreenVC.tableView.contentOffset.y
        }
        
        if todayBannerFullScreenVC.tableView.contentOffset.y > 0 {
            return
        }
        
        let translationY = gesture.translation(in: todayBannerFullScreenVC.view).y
        
        if gesture.state == .changed {
            if translationY > 0 {
                
                let trueOffset = translationY - todayBannerFullScreenBeginOffset
                
                var scale = 1 - trueOffset / 1000
                scale = min(1, scale)
                scale = max(0.5, scale)
                
                let transform: CGAffineTransform = .init(scaleX: scale, y: scale)
                self.todayBannerFullScreenVC.view.transform = transform
            }
        } else if gesture.state == .ended {
            if translationY > 0 {
                removeFullScreeinView()
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    fileprivate func setupStartingCellFrame(_ indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        
        // absolute coordinates of cell
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        
        self.startingFrame = startingFrame
    }
    
    fileprivate func setupTodayBannerStartingPosition(_ indexPath: IndexPath) {
        let fullScreenView = todayBannerFullScreenVC.view!
        view.addSubview(fullScreenView)
        
        addChild(todayBannerFullScreenVC)
        
        self.collectionView.isUserInteractionEnabled = false
        
        setupStartingCellFrame(indexPath)
        
        guard let startingFrame = self.startingFrame else { return }
        
        fullScreenView.translatesAutoresizingMaskIntoConstraints = false
        topConstraint = fullScreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        leadingConstraint = fullScreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        widthConstraint = fullScreenView.widthAnchor.constraint(equalToConstant: startingFrame.width)
        heightConstraint = fullScreenView.heightAnchor.constraint(equalToConstant: startingFrame.height)
        
        [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach({$0?.isActive = true})
        self.view.layoutIfNeeded()
    }
    
    fileprivate func showTodayBannerFullScreen(indexPath: IndexPath) {
        setupTodayBannerFullScreenVC(indexPath)
        setupTodayBannerStartingPosition(indexPath)
        animateTodayBannerFullScreen()
        
    }
    
    var startingFrame: CGRect?
    
    @objc func removeFullScreeinView() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.blurVisualEffectView.alpha = 0
            self.todayBannerFullScreenVC.view.transform = .identity
            
            self.todayBannerFullScreenVC.tableView.contentOffset = .zero
            
            guard let startingFrame = self.startingFrame else { return }
            self.topConstraint?.constant = startingFrame.origin.y
            self.leadingConstraint?.constant = startingFrame.origin.x
            self.widthConstraint?.constant = startingFrame.width
            self.heightConstraint?.constant = startingFrame.height
            
            self.view.layoutIfNeeded()
            
            if let tabBarFrame = self.tabBarController?.tabBar.frame {
                self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height - tabBarFrame.height
            }
            
            guard let cell = self.todayBannerFullScreenVC.tableView.cellForRow(at: [0,0]) as? TodayFullScreenHeaderCell else { return }
            cell.todayCell.topConstraint.constant = 20
            self.todayBannerFullScreenVC.closeButton.alpha = 0
            cell.layoutIfNeeded()
            
        }, completion: { _ in
            self.todayBannerFullScreenVC.view.removeFromSuperview()
            self.todayBannerFullScreenVC.removeFromParent()
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

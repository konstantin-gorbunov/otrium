//
//  ProfileViewController.swift
//  Otrium
//
//  Created by Kostiantyn Gorbunov on 29/11/2021.
//

import UIKit

protocol ProfileViewControllabel: AnyObject {
    func refresh(_ sender: ProfileViewController)
}

class ProfileViewController: UICollectionViewController {
    
    weak var delegate: ProfileViewControllabel?
    
    private var viewModel: ProfileViewModel
    private let refreshControl = UIRefreshControl()
    
    init(viewModel: ProfileViewModel, layout: UICollectionViewLayout) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: layout)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        collectionView?.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
        collectionView?.alwaysBounceVertical = true
        collectionView?.refreshControl = refreshControl
    }
    
    func update(viewModel: ProfileViewModel?) {
        refreshControl.endRefreshing()
        if let viewModel = viewModel {
            self.viewModel = viewModel
        }
    }
    
    @objc private func didPullToRefresh(_ sender: Any) {
        delegate?.refresh(self)
    }
}

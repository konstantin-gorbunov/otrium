//
//  ProfileViewController.swift
//  Otrium
//
//  Created by Kostiantyn Gorbunov on 29/11/2021.
//

import UIKit

class ProfileViewController: UICollectionViewController {
    
    private let viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel, layout: UICollectionViewLayout) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: layout)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
    }
}

//
//  HomeCoordinator.swift
//  Otrium
//
//  Created by Kostiantyn Gorbunov on 29/11/2021.
//

import UIKit

/// Home (Profile) Coordinator
class HomeCoordinator<T: Dependency>: Coordinator<T> {
    
    let navigationViewController: UINavigationController
    private let title = NSLocalizedString("Profile", comment: "Profile in title")
    
    init(dependency: T, navigation: UINavigationController) {
        self.navigationViewController = navigation
        super.init(dependency: dependency)
    }

    override func start() {
        super.start()

        let loadingViewController = LoadingViewController(nibName: nil, bundle: nil)
        navigationViewController.viewControllers = [loadingViewController]
        loadingViewController.title = title

        dependency.dataProvider.fetchProfile { result in
            DispatchQueue.main.async { [weak self] in
                self?.processResults(result)
            }
        }
    }

    private func processResults(_ result: DataProvider.FetchProfileResult) {
        guard case .success(let profile) = result, let profileUserData = profile.data?.user else {
            let errorViewController = ErrorViewController(nibName: nil, bundle: nil)
            errorViewController.title = title
            navigationViewController.viewControllers = [errorViewController]
            return
        }

        let profileViewController = ProfileViewController(
            viewModel: ProfileViewModel(user: profileUserData),
            layout: UICollectionViewFlowLayout()
        )
        profileViewController.title = title
        navigationViewController.viewControllers = [profileViewController]
    }
}

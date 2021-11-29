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
                self?.processResults(result, success: { [weak self] profileUserData in
                    self?.showProfileViewController(profileUserData)
                }, error: { [weak self] errorViewController in
                    self?.navigationViewController.viewControllers = [errorViewController]
                })
            }
        }
    }
    
    private func showProfileViewController(_ profileUserData: User) {
        let profileViewController = ProfileViewController(
            viewModel: ProfileViewModel(user: profileUserData),
            layout: UICollectionViewFlowLayout()
        )
        profileViewController.delegate = self
        profileViewController.title = title
        navigationViewController.viewControllers = [profileViewController]
    }

    private func processResults(_ result: DataProvider.FetchProfileResult, success: ((_ profileUserData: User) -> Void), error: ((_ errorViewController: ErrorViewController) -> Void)) {
        guard case .success(let profile) = result, let profileUserData = profile.data?.user else {
            let errorViewController = ErrorViewController(nibName: nil, bundle: nil)
            errorViewController.title = title
            error(errorViewController)
            return
        }
        success(profileUserData)
    }
}

extension HomeCoordinator: ProfileViewControllabel {
    func refresh(_ sender: ProfileViewController) {
        dependency.dataProvider.fetchProfile { result in
            DispatchQueue.main.async { [weak self] in
                self?.processResults(result, success: { profileUserData in
                    sender.update(viewModel: ProfileViewModel(user: profileUserData))
                }, error: { [weak self] errorViewController in
                    sender.update(viewModel: nil)
                    self?.navigationViewController.pushViewController(errorViewController, animated: true)
                })
            }
        }
    }
}

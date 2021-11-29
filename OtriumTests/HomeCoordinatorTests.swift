//
//  HomeCoordinatorTests.swift
//  OtriumTests
//
//  Created by Kostiantyn Gorbunov on 29/11/2021.
//

import XCTest
@testable import Otrium

class HomeCoordinatorTests: XCTestCase {

    var dependency: MockDependency?
    var coordinator: HomeCoordinator<MockDependency>?

    override func setUp() {
        super.setUp()
        
        let navigation = UINavigationController(rootViewController: UIViewController())
        let localDependency = MockDependency()
        dependency = localDependency
        coordinator = HomeCoordinator(
            dependency: localDependency,
            navigation: navigation
        )
    }

    override func tearDown() {
        coordinator = nil
        dependency = nil
        super.tearDown()
    }

    func testInit() {
        XCTAssertNotNil(dependency)
        XCTAssertNotNil(coordinator)
    }

    func testLoadingScreen() {
        let expectation = self.expectation(description: "Data Fetched")
        let profile = Profile.mockProfile()
        if let mock = (dependency?.dataProvider as? MockDataProvider) {
            mock.onFetch = { completion in
                completion(.success(profile))
                DispatchQueue.main.async {
                    expectation.fulfill()
                }
            }
        }
        coordinator?.start()
        let firstVisible = coordinator?.navigationViewController.visibleViewController
        XCTAssertTrue(firstVisible is LoadingViewController)
        wait(for: [expectation], timeout: 2)
        let secondVisible = coordinator?.navigationViewController.visibleViewController
        XCTAssertTrue(secondVisible is ProfileViewController)
    }

    func testErrorScreen() {
        let expectation = self.expectation(description: "Data Fetched")
        let emptyProfile = Profile.mockEmptyProfile()
        if let mock = (dependency?.dataProvider as? MockDataProvider) {
            mock.onFetch = { completion in
                completion(.success(emptyProfile))
                DispatchQueue.main.async {
                    expectation.fulfill()
                }
            }
        }
        coordinator?.start()
        let firstVisible = coordinator?.navigationViewController.visibleViewController
        XCTAssertTrue(firstVisible is LoadingViewController)
        wait(for: [expectation], timeout: 2)
        let secondVisible = coordinator?.navigationViewController.visibleViewController
        XCTAssertTrue(secondVisible is ErrorViewController)
    }
}

//
//  ProfileViewModelTests.swift
//  OtriumTests
//
//  Created by Kostiantyn Gorbunov on 02/12/2021.
//

import XCTest
@testable import Otrium

class ProfileViewModelTests: XCTestCase {

    var dependency: Dependency?
    var user: User?
    
    override func setUp() {
        super.setUp()
        dependency = LocalDependency()
        
        let expectation = XCTestExpectation(description: "Parsing user profile JSON")
        dependency?.dataProvider.fetchProfile { result in
            DispatchQueue.main.async { [weak self] in
                guard case .success(let profile) = result, let profileUserData = profile.data?.user else {
                    XCTAssert(false, "profile was not parsed")
                    return
                }
                self?.user = profileUserData
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }

    override func tearDown() {
        dependency = nil
        super.tearDown()
    }

    func testParsingLocalData() throws {
        XCTAssertNotNil(user, "No data was parsed")
        let viewModel = ProfileViewModel(user: user)
        XCTAssertEqual(viewModel.pinnedNodes?.count, 3, "Three pinned repos")
        XCTAssertEqual(viewModel.starNodes?.count, 10, "Ten starred repos")
        XCTAssertEqual(viewModel.topNodes?.count, 10, "Ten top repos")
        
        XCTAssertEqual(viewModel.headerTitles[safeIndex: 2], "Top repositories", "Third section name")
        
        let node = (viewModel.nodes[3] ?? [])?[safeIndex: 1]
        XCTAssertEqual(node?.stargazerCount, 176, "Star total count of second element in forth section")
    }
}

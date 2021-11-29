//
//  MockDependency.swift
//  OtriumTests
//
//  Created by Kostiantyn Gorbunov on 29/11/2021.
//

import Foundation
@testable import Otrium

class MockDataProvider: DataProvider {

    var onFetch: ((DataProvider.FetchProfileCompletion) -> Void)?

    func fetchProfile(_ completion: @escaping DataProvider.FetchProfileCompletion) {
        onFetch?(completion)
    }
}

class MockDependency: Dependency {

//    let dataProvider: DataProvider = LocalProfileDataProvider()
    let dataProvider: DataProvider = MockDataProvider()
}

extension Profile {
    static func mockEmptyProfile() -> Profile {
        return Profile(data: DataClass(user: nil))
    }
    
    static func mockProfile() -> Profile {
        let user = User(avatarURL: "https://avatars.githubusercontent.com/u/359601?v=4",
                        name: "Kostiantyn Gorbunov",
                        login: "konstantin-gorbunov",
                        email: "gkboxmail@gmail.com",
                        pinnedItems: PinnedItems(nodes: []),
                        topRepositories: PinnedItems(nodes: []),
                        starredRepositories: StarredRepositories(totalCount: 0, nodes: []),
                        followers: Follow(totalCount: 0),
                        following: Follow(totalCount: 0))
        return Profile(data: DataClass(user: user))
    }
}

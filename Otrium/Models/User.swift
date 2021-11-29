//
//  User.swift
//  Otrium
//
//  Created by Kostiantyn Gorbunov on 29/11/2021.
//

struct User: Codable {
    let avatarURL: String?
    let name, login, email: String?
    let pinnedItems, topRepositories: PinnedItems?
    let starredRepositories: StarredRepositories?
    let followers, following: Follow?

    enum CodingKeys: String, CodingKey {
        case avatarURL
        case name, login, email, pinnedItems, topRepositories, starredRepositories, followers, following
    }
}

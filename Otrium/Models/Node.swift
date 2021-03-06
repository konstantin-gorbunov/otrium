//
//  Node.swift
//  Otrium
//
//  Created by Kostiantyn Gorbunov on 29/11/2021.
//

struct Node: Codable {
    let owner: Owner?
    let name: String?
    let nodeDescription: String?
    let stargazerCount: Int?
    let primaryLanguage: PrimaryLanguage?

    enum CodingKeys: String, CodingKey {
        case owner, name
        case nodeDescription = "description"
        case stargazerCount, primaryLanguage
    }
}

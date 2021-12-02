//
//  Node.swift
//  Otrium
//
//  Created by Kostiantyn Gorbunov on 29/11/2021.
//

struct Node: Codable {
    let owner: Owner?
    let name: String?
    let description: String?
    let stargazerCount: Int?
    let primaryLanguage: PrimaryLanguage?
}

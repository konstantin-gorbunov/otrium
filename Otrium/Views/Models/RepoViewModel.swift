//
//  RepoViewModel.swift
//  Otrium
//
//  Created by Kostiantyn Gorbunov on 02/12/2021.
//

import Foundation

struct RepoViewModel {
    let starCount: Int
    let nickname: String
    let name: String
    let description: String
    let language: String
    let imageUrl: URL?
    
    init(node: Node) {
        starCount = node.stargazerCount ?? 0
        nickname = node.owner?.login ?? ""
        name = node.name ?? ""
        description = node.description ?? ""
        language = node.primaryLanguage?.name ?? ""
        guard let avatarStrURL = node.owner?.avatarUrl else {
            imageUrl = nil
            return
        }
        imageUrl = URL.init(string: avatarStrURL)
    }
}

//
//  Owner.swift
//  Otrium
//
//  Created by Kostiantyn Gorbunov on 29/11/2021.
//

struct Owner: Codable {
    let avatarURL: String?
    let login: String?

    enum CodingKeys: String, CodingKey {
        case avatarURL
        case login
    }
}

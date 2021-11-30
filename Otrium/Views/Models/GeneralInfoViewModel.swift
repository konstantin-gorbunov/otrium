//
//  GeneralInfoViewModel.swift
//  Otrium
//
//  Created by Kostiantyn Gorbunov on 29/11/2021.
//

import Foundation

struct GeneralInfoViewModel {

    let imageUrl: URL?
    let name: String?
    let nickname: String?
    let email: String?
    let followers: Int?
    let following: Int?
    
    init(user: User?) {
        name = user?.name
        nickname = user?.login
        email = user?.email
        followers = user?.followers?.totalCount
        following = user?.following?.totalCount
        guard let avatarStrURL = user?.avatarUrl else {
            imageUrl = nil
            return
        }
        imageUrl = URL.init(string: avatarStrURL)
    }
}

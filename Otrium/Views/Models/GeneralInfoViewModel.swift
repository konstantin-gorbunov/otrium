//
//  GeneralInfoViewModel.swift
//  Otrium
//
//  Created by Kostiantyn Gorbunov on 29/11/2021.
//

import Foundation

struct GeneralInfoViewModel {

    let imageUrl: URL?
    let name: String
    let nickname: String
    let email: String
    private let followersCount: Int
    private let followingCount: Int
    
    var followers: String {
        return "\(followersCount) followers"
    }
    
    var following: String {
        return "\(followingCount) following"
    }
    
    init(user: User?) {
        name = user?.name ?? ""
        nickname = user?.login ?? "" 
        email = user?.email ?? ""
        followersCount = user?.followers?.totalCount ?? 0
        followingCount = user?.following?.totalCount ?? 0
        guard let avatarStrURL = user?.avatarUrl else {
            imageUrl = nil
            return
        }
        imageUrl = URL.init(string: avatarStrURL)
    }
}

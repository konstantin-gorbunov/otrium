//
//  ProfileViewModel.swift
//  Otrium
//
//  Created by Kostiantyn Gorbunov on 29/11/2021.
//

struct ProfileViewModel {
    let user: User?
    var pinnedNotes: [Node]? {
        return user?.pinnedItems?.nodes
    }
    var headerTitles: [String] {
        var headers: [String] = [""]
        if pinnedNotes?.count ?? 0 > 0 {
            headers.append("Pinned")
        }
        if user?.topRepositories?.nodes?.count ?? 0 > 0 {
            headers.append("Top repositories")
        }
        if user?.starredRepositories?.nodes?.count ?? 0 > 0 {
            headers.append("Starred repositories")
        }
        return headers
    }
}

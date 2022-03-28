//
//  ProfileViewModel.swift
//  Otrium
//
//  Created by Kostiantyn Gorbunov on 29/11/2021.
//

struct ProfileViewModel {
    let user: User?
    var pinnedNodes: [Node]? {
        return user?.pinnedItems?.nodes
    }
    var topNodes: [Node?]? {
        return user?.topRepositories?.nodes
    }
    var starNodes: [Node]? {
        return user?.starredRepositories?.nodes
    }
    var headerTitles: [String] {
        var headers: [String] = [""]
        if (pinnedNodes?.count ?? 0) > 0 {
            headers.append("Pinned")
        }
        if (topNodes?.count ?? 0) > 0 {
            headers.append("Top repositories")
        }
        if (starNodes?.count ?? 0) > 0 {
            headers.append("Starred repositories")
        }
        return headers
    }
    var nodes: [Int: [Node?]?] {
        var nodes: [Int: [Node?]?] = [0 : nil]
        var sectionIndex = 1
        if (pinnedNodes?.count ?? 0) > 0 {
            nodes[sectionIndex] = pinnedNodes
            sectionIndex += 1
        }
        if (topNodes?.count ?? 0) > 0 {
            nodes[sectionIndex] = topNodes
            sectionIndex += 1
        }
        if (starNodes?.count ?? 0) > 0 {
            nodes[sectionIndex] = starNodes
            sectionIndex += 1
        }
        return nodes
    }
}

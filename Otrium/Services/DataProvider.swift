//
//  DataProvider.swift
//  Otrium
//
//  Created by Kostiantyn Gorbunov on 29/11/2021.
//

import Foundation

enum DataProviderError: Error {
    case resourceNotFound
    case parsingFailure(inner: Error)
}

protocol DataProvider {
    typealias FetchProfileResult = Result<Profile, Error>
    typealias FetchProfileCompletion = (FetchProfileResult) -> Void

    func fetchProfile(_ completion: @escaping FetchProfileCompletion)
}

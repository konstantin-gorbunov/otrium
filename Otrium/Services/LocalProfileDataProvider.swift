//
//  LocalProfileDataProvider.swift
//  Otrium
//
//  Created by Kostiantyn Gorbunov on 29/11/2021.
//

import Foundation

struct LocalProfileDataProvider: DataProvider {

    private let queue = DispatchQueue(label: "LocalProfileDataProviderQueue")

    // Completion block will be called on main queue
    func fetchProfile(_ completion: @escaping FetchProfileCompletion) {
        guard let path = Bundle.main.url(forResource: "profile", withExtension: "json") else {
            DispatchQueue.main.async {
                completion(.failure(DataProviderError.resourceNotFound))
            }
            return
        }
        queue.async {
            do {
                let jsonData = try Data(contentsOf: path)
                let result = try JSONDecoder().decode(Profile.self, from: jsonData)

                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(DataProviderError.parsingFailure(inner: error)))
                }
            }
        }
    }
}

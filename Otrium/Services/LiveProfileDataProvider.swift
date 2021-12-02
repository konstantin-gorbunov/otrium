//
//  LiveProfileDataProvider.swift
//  Otrium
//
//  Created by Kostiantyn Gorbunov on 29/11/2021.
//

import Foundation

struct LiveProfileDataProvider: DataProvider {
    
    private enum Constants {
        static let url: URL? = URL(string: "https://api.github.com/graphql")
    }
    
    private let queue = DispatchQueue(label: "LiveProfileDataProviderQueue")

    func fetchProfile(_ completion: @escaping FetchProfileCompletion) {
        guard let url = Constants.url,
              let path = Bundle.main.url(forResource: "query", withExtension: "yaml") else {
            DispatchQueue.main.async {
                completion(.failure(DataProviderError.resourceNotFound))
            }
            return
        }
        queue.async {
            do {
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "content-type")
                request.setValue("bearer ghp_QMcGg8ulSHWv3Fjq5AqIPd1tucMlzj" + "30pBdl", forHTTPHeaderField: "Authorization")
                request.httpBody = try Data(contentsOf: path)
                let task = URLSession.shared.profileTask(with: request) { profile, response, error in
                    if let error = error {
                        DispatchQueue.main.async {
                            completion(.failure(DataProviderError.parsingFailure(inner: error)))
                        }
                    }
                    if let result = profile {
                        DispatchQueue.main.async {
                            completion(.success(result))
                        }
                    }
                }
                task.resume()
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(DataProviderError.parsingFailure(inner: error)))
                }
            }
        }
    }
}

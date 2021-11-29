//
//  URLSession+Profile.swift
//  Otrium
//
//  Created by Kostiantyn Gorbunov on 29/11/2021.
//

import Foundation

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URLRequest, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            completionHandler(try? decoder.decode(T.self, from: data), response, nil)
        }
    }

    func profileTask(with url: URLRequest, completionHandler: @escaping (Profile?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}

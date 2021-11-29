//
//  UIImage+Load.swift
//  Otrium
//
//  Created by Kostiantyn Gorbunov on 29/11/2021.
//

import UIKit

/**
 The hit problems can arise.
 The alternative is https://github.com/rs/SDWebImage or implementing of own solution with cached data and priority queue.
 */
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}

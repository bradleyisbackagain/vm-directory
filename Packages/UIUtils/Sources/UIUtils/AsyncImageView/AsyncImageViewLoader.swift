//
//  AsyncImageViewLoader.swift
//
//  Created by Bradley Mackey on 10/04/2022.
//

import UIKit

/// A service that can load images for `UIAsyncImageView`.
public protocol AsyncImageViewLoader {
    func load(url: URL, completion: @escaping (Result<UIImage?, Error>) -> Void)
    func cancelLoad()
}

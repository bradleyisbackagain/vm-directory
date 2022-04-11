//
//  URLSessionAsyncImageViewLoader.swift
//
//  Created by Bradley Mackey on 10/04/2022.
//

import UIKit

/// Loads async images from `URLSession`.
public final class URLSessionAsyncImageViewLoader: AsyncImageViewLoader {
    public var urlSession: URLSession
    
    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    private var currentRequest: URLSessionDataTask?
    
    public func load(url: URL, completion: @escaping (Result<UIImage?, Error>) -> Void) {
        let request = URLRequest(url: url)
        currentRequest?.cancel()
        currentRequest = urlSession.dataTask(with: request) { (data, _, error) in
            if let data = data {
                let image = UIImage(data: data)
                completion(.success(image))
            } else if let error = error {
                completion(.failure(error))
            } else {
                fatalError("impossible state")
            }
        }
        currentRequest?.resume()
    }
    
    public func cancelLoad() {
        currentRequest?.cancel()
    }
}

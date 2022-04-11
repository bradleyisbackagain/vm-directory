//
//  RemoteDirectoryAPI.swift
//
//  Created by Bradley Mackey on 08/04/2022.
//

import Foundation

/// A directory API that fetches from the network relative to a base url.
public class RemoteDirectoryAPI: DirectoryAPI {
    typealias NetworkResponse = (Data, URLResponse)
    
    public let baseURL: URL
    public let urlSession: URLSession
    public let jsonDecoder: JSONDecoder
    
    public init(baseURL: URL, jsonDecoder: JSONDecoder, urlSession: URLSession = .shared) {
        self.baseURL = baseURL
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }
}

// MARK: - Endpoints

extension RemoteDirectoryAPI {
    public func people(completion: @escaping (Result<[Person], Error>) -> Void) {
        let url = baseURL.appendingPathComponent("people")
        let request = URLRequest(url: url)
        fetch(request: request, decoding: [Person].self, completion: completion)
    }
    
    public func rooms(completion: @escaping (Result<[Room], Error>) -> Void) {
        let url = baseURL.appendingPathComponent("rooms")
        let request = URLRequest(url: url)
        fetch(request: request, decoding: [Room].self, completion: completion)
    }
}

// MARK: - Networking

extension RemoteDirectoryAPI {
    /// Fetch and decode the given type.
    private func fetch<T>(
        request: URLRequest,
        decoding type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) where T: Decodable {
        fetchRawData(request: request) { [self] result in
            let decoded = mapNetworkResponse(T.self, result: result)
            completion(decoded)
        }
    }
    
    /// Fetches the contents of the given URL using this API's `URLSession`.
    private func fetchRawData(
        request: URLRequest,
        completion: @escaping (Result<NetworkResponse, Error>) -> Void
    ) {
        urlSession.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let response = response {
                completion(.success((data, response)))
            } else {
                fatalError("Impossible state")
            }
        }.resume()
    }
    
    /// Converts the raw network response to a decodable type.
    private func mapNetworkResponse<T>(
        _ type: T.Type,
        result: Result<NetworkResponse, Error>
    ) -> Result<T, Error>
        where T: Decodable
    {
        return result.flatMap { data, _ in
            Result {
                try self.jsonDecoder.decode(type, from: data)
            }
        }
    }
}

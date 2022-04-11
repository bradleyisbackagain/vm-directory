//
//  ListItemService.swift
//  Directory
//
//  Created by Bradley Mackey on 08/04/2022.
//

import Foundation

/// A service that provides items to the `ListItemTableViewController`.
protocol ListItemService {
    func items(completion: @escaping (Result<[ListItemViewModel], Error>) -> Void)
}

extension ListItemService {
    /// Retries to fetch data from this service the given number of times.
    func retry(_ times: UInt) -> ListItemService {
        var service: ListItemService = self
        for _ in 0..<times {
            service = ListItemFallbackService(primary: service, fallback: self)
        }
        return service
    }
}

// MARK: - Default Services

/// A `ListItemService` that falls back to a secondary source if the
struct ListItemFallbackService: ListItemService {
    let primary: ListItemService
    let fallback: ListItemService
    
    func items(completion: @escaping (Result<[ListItemViewModel], Error>) -> Void) {
        primary.items { result in
            switch result {
            case .success:
                completion(result)
            case .failure:
                fallback.items(completion: completion)
            }
        }
    }
}

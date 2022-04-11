//
//  ListItemTableViewModel.swift
//  Directory
//
//  Created by Bradley Mackey on 08/04/2022.
//

import Foundation
import CommonUtils

/// ViewModel for `ListItemTableViewController`
final class ListItemTableViewModel {
    var service: ListItemService
    /// The list items that should be displayed, as loaded from the service.
    private(set) var items = Box<[ListItemViewModel]>([])
    
    init(service: ListItemService) {
        self.service = service
    }
    
    /// Reloads the data from the service, calling the handler on completion.
    func loadData(completion: @escaping (Result<(), Error>) -> Void) {
        service.items { result in
            switch result {
            case .success(let items):
                self.items.value = items
                completion(.success(()))
            case .failure:
                completion(result.map { _ in })
            }
        }
    }
}

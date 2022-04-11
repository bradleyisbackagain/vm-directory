//
//  ListItemTableViewModel.swift
//  Directory
//
//  Created by Bradley Mackey on 08/04/2022.
//

import Foundation

/// ViewModel for `ListItemTableViewController`
final class ListItemTableViewModel {
    var service: ListItemService
    private(set) var items = [ListItemViewModel]()
    
    init(service: ListItemService) {
        self.service = service
   }
    
    /// Reloads the data from the service, calling the handler on completion.
    func loadData(completion: @escaping (Result<(), Error>) -> Void) {
        service.items { result in
            switch result {
            case .success(let items):
                self.items = items
                completion(.success(()))
            case .failure:
                completion(result.map { _ in })
            }
        }
    }
    
    /// The number of sections the table should display.
    func sectionCount() -> Int {
        1
    }
    
    /// The number of rows the table should display.
    func rowCount() -> Int {
        items.count
    }
}

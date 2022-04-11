//
//  ListItemViewModel+People.swift
//  Directory
//
//  Created by Bradley Mackey on 08/04/2022.
//

import Foundation
import DirectoryService

extension ListItemViewModel {
    init(person: Person) {
        self.title = Box(person.firstName)
        self.subtitle = Box(person.jobTitle)
        self.icon = Box(.url(person.avatar))
        // TODO: check query
        self.matchesQuery = { _ in true }
    }
}

/// Adapts the people directory API response 
struct ListItemViewModelPersonServiceAdapter: ListItemService {
    let api: DirectoryAPI
    
    func items(completion: @escaping (Result<[ListItemViewModel], Error>) -> Void) {
        api.people { result in
            completion(result.map { people in
                people.map(ListItemViewModel.init)
            })
        }
    }
}

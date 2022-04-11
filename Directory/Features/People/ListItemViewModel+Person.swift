//
//  ListItemViewModel+People.swift
//  Directory
//
//  Created by Bradley Mackey on 08/04/2022.
//

import Foundation
import DirectoryService

extension ListItemViewModel {
    init(person: Person, onSelection: @escaping () -> Void) {
        self.title = Box(person.firstName)
        self.subtitle = Box(person.jobTitle)
        self.icon = Box(.url(person.avatar))
        self.onSelection = onSelection
        // TODO: check query
        self.matchesQuery = { _ in true }
    }
}

/// Adapts the people directory API response 
final class ListItemViewModelPersonServiceAdapter: ListItemService {
    let api: DirectoryAPI
    var onSelection: ((Person) -> Void)?
    
    init(api: DirectoryAPI) {
        self.api = api
        self.onSelection = nil
    }
    
    func items(completion: @escaping (Result<[ListItemViewModel], Error>) -> Void) {
        api.people { result in
            completion(result.map { people in
                people.map { person in
                    ListItemViewModel(person: person) {
                        self.onSelection?(person)
                    }
                }
            })
        }
    }
}

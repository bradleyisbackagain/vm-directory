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
        let detail = PersonDetailViewModel(person)
        self.title = Box(detail.fullName)
        self.subtitle = Box(person.email)
        self.icon = Box(.url(person.avatar))
        self.onSelection = onSelection
        self.matchesQuery = { search in
            let lc = search.lowercased()
            return person.email.lowercased().contains(lc) ||
                person.firstName.lowercased().contains(lc) ||
                person.lastName.lowercased().contains(lc) ||
                person.id.lowercased() == lc
        }
    }
}

/// Adapts the people directory API response.
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

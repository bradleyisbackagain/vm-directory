//
//  ListItemViewModel+Room.swift
//  Directory
//
//  Created by Bradley Mackey on 08/04/2022.
//

import Foundation
import DirectoryService

extension ListItemViewModel {
    init(room: Room) {
        let availableTitle = room.isOccupied ? "Occupied" : "Available"
        self.title = "Room \(room.id) • \(availableTitle)"
        self.subtitle = "\(room.maxOccupancy) seats available"
        // TODO: update query
        self.matchesQuery = { _ in true }
        self.icon = .local(named: "test")
    }
}

/// Converst api endpoint for "rooms" to a `ListItemService`.
struct ListItemViewModelRoomServiceAdapter: ListItemService {
    let api: DirectoryAPI
    
    func items(completion: @escaping (Result<[ListItemViewModel], Error>) -> Void) {
        api.rooms { result in
            completion(result.map { rooms in
                rooms.map(ListItemViewModel.init)
            })
        }
    }
}

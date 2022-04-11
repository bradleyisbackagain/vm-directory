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
        self.title = Box("Room \(room.id) • \(availableTitle)")
        self.subtitle = Box("\(room.maxOccupancy) seats available")
        let icon = room.isOccupied ? "round_no_meeting_room_black_24pt" : "round_meeting_room_black_24pt"
        self.icon = Box(.local(named: icon))
        // TODO: update query
        self.matchesQuery = { _ in true }
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

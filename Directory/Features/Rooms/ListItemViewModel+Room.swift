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
        self.title = Box("Room \(room.id)")
        let seatsTitle = room.maxOccupancy == 1 ? "seat" : "seats"
        let availableTitle = room.isOccupied ? "Occupied" : "Available"
        self.subtitle = Box("\(availableTitle) • \(room.maxOccupancy) \(seatsTitle)")
        let icon = room.isOccupied ? "round_no_meeting_room_black_24pt" : "round_meeting_room_black_24pt"
        self.icon = Box(.local(named: icon))
        self.matchesQuery = { search in
            let lc = search.lowercased()
            return room.id.lowercased().contains(lc) ||
                availableTitle.lowercased().contains(lc)
        }
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

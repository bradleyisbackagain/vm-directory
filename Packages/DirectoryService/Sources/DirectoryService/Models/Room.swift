//
//  Room.swift
//
//  Created by Bradley Mackey on 08/04/2022.
//

import Foundation

// Demo data:
//  {
//    "createdAt": "2022-01-24T20:52:50.765Z",
//    "isOccupied": false,
//    "maxOccupancy": 53539,
//    "id": "1"
//  }

public struct Room: Identifiable, Hashable, Equatable, Codable {
    public var id: String
    public var createdAt: Date
    public var maxOccupancy: UInt
    public var isOccupied: Bool
    
    public init(
        id: String,
        createdAt: Date,
        maxOccupancy: UInt,
        isOccupied: Bool
    ) {
        self.id = id
        self.createdAt = createdAt
        self.maxOccupancy = maxOccupancy
        self.isOccupied = isOccupied
    }
}

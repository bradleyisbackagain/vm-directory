//
//  StubDirectoryAPI.swift
//
//  Created by Bradley Mackey on 08/04/2022.
//

import Foundation

/// A directory api that returns fixed, mocked results.
public struct StubDirectoryAPI: DirectoryAPI {
    public var peopleData: Result<[Person], Error>
    public var roomsData: Result<[Room], Error>
    
    public init(
        peopleData: Result<[Person], Error>,
        roomsData: Result<[Room], Error>
    ) {
        self.peopleData = peopleData
        self.roomsData = roomsData
    }
    
    public func people(completion: @escaping (Result<[Person], Error>) -> Void) {
        completion(peopleData)
    }
    
    public func rooms(completion: @escaping (Result<[Room], Error>) -> Void) {
        completion(roomsData)
    }
}

//
//  Person.swift
//
//  Created by Bradley Mackey on 08/04/2022.
//

import Foundation

// Demo data:
//  {
//    "createdAt": "2022-01-24T17:02:23.729Z",
//    "firstName": "Maggie",
//    "avatar": "https://randomuser.me/api/portraits/women/21.jpg",
//    "lastName": "Brekke",
//    "email": "Crystel.Nicolas61@hotmail.com",
//    "jobtitle": "Future Functionality Strategist",
//    "favouriteColor": "pink",
//    "id": "1"
//  }

public struct Person: Identifiable, Equatable, Hashable {
    public var id: String
    /// - note: Encoded as ISO-8601
    public var createdAt: Date
    public var firstName: String
    public var lastName: String
    public var avatar: URL
    public var email: String
    public var jobTitle: String
    public var favouriteColor: String
    
    public init(
        id: String,
        createdAt: Date,
        firstName: String,
        lastName: String,
        avatar: URL,
        email: String,
        jobTitle: String,
        favouriteColor: String
    ) {
        self.id = id
        self.createdAt = createdAt
        self.firstName = firstName
        self.lastName = lastName
        self.avatar = avatar
        self.email = email
        self.jobTitle = jobTitle
        self.favouriteColor = favouriteColor
    }
    

}

extension Person: Codable {
    
    public enum CodingKeys: String, CodingKey {
        case id, createdAt, firstName, lastName, avatar, email, favouriteColor
        // Enforce consistent camelCasing in our API
        case jobTitle = "jobtitle"
    }
    
}

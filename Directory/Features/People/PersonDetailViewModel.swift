//
//  PersonDetailViewModel.swift
//  Directory
//
//  Created by Bradley Mackey on 10/04/2022.
//

import Foundation
import DirectoryService

struct PersonDetailViewModel {
    private static let nameFormatter = PersonNameComponentsFormatter()
    private let person: Person
    
    init(_ person: Person) {
        self.person = person
    }
    
    private var nameComponents: PersonNameComponents {
        var components = PersonNameComponents()
        components.givenName = person.firstName
        components.familyName = person.lastName
        return components
    }
    
    var fullName: String {
        Self.nameFormatter.string(from: nameComponents)
    }
    
    var avatarURL: URL {
        person.avatar
    }
}

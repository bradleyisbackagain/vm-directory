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
    private static let dateFormatter = DateFormatter()
    
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
    
    var createdDateFormatted: String {
        Self.dateFormatter.string(from: person.createdAt)
    }
    
    var avatarURL: URL {
        person.avatar
    }
    
    var detailItems: [DetailItemViewModel] {
        [
            DetailItemViewModel(title: "ID", detail: person.id),
            DetailItemViewModel(title: "Favourite Color", detail: person.favouriteColor),
            DetailItemViewModel(title: "Job Title", detail: person.jobTitle),
            DetailItemViewModel(title: "Created", detail: createdDateFormatted),
            DetailItemViewModel(title: "Email", detail: person.email),
        ]
    }
}

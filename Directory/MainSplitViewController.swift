//
//  MainSplitViewController.swift
//  Directory
//
//  Created by Bradley Mackey on 11/04/2022.
//

import UIKit
import DirectoryService
import CommonUtils

/// The UI Entrypoint for the app.
final class MainSplitViewController: UISplitViewController {
    
    // TODO: work out some splitviewcontroller logic on phones vs. ipads
    // We ideally want compact details to be shown as a navigationcontroller push vs
    // split view controller modal.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preferredDisplayMode = .allVisible
        
        let placeholder = UIViewController()
        viewControllers = [
            ItemsTabBarController(api: api()),
            placeholder,
        ]
    }
    
    func api() -> DirectoryAPI {
        #if DEBUG
        if ProcessInfo.processInfo.arguments.contains("UITEST") {
            return makeStubAPI()
        }
        #endif
        return makeProductionAPI()
    }
    
    func makeProductionAPI() -> RemoteDirectoryAPI {
        let url = URL("https://61e947967bc0550017bc61bf.mockapi.io/api/v1")
        let decoder = JSONDecoder()
        let dateDecoder = ISO8601MillisecondsDecoder()
        decoder.dateDecodingStrategy = .custom(dateDecoder.decode)
        return RemoteDirectoryAPI(baseURL: url, jsonDecoder: decoder)
    }
    
    #if DEBUG
    func makeStubAPI() -> StubDirectoryAPI {
        return StubDirectoryAPI(
            peopleData: .success(stubPeople),
            roomsData: .success(stubRooms)
        )
    }
    #endif
}

#if DEBUG

extension MainSplitViewController {
    
    var stubPeople: [Person] {
        [
            Person(
                id: "1",
                createdAt: Date(),
                firstName: "Tom",
                lastName: "Jones",
                avatar: URL("https://randomuser.me/api/portraits/women/21.jpg"),
                email: "tom.jones@example.com",
                jobTitle: "Developer",
                favouriteColor: "Green"
            ),
            Person(
                id: "2",
                createdAt: Date(),
                firstName: "Rob",
                lastName: "Marks",
                avatar: URL("https://randomuser.me/api/portraits/women/21.jpg"),
                email: "rob.marks@example.com",
                jobTitle: "Hustler",
                favouriteColor: "Blue"
            ),
        ]
    }
    
    var stubRooms: [Room] {
        [
            Room(
                id: "1", createdAt: Date(), maxOccupancy: 100, isOccupied: false
            ),
            Room(
                id: "2", createdAt: Date(), maxOccupancy: 100, isOccupied: true
            ),
        ]
    }
    
}

#endif

//
//  MainTabBarController.swift
//  Directory
//
//  Created by Bradley Mackey on 08/04/2022.
//

import UIKit
import DirectoryService

final class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        let productionAPI = makeProductionAPI()
        self.viewControllers = [
            makePeopleViewController(api: productionAPI),
            makeRoomsViewController(api: productionAPI),
        ]
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("selected", viewController)
    }
    
    func makeProductionAPI() -> RemoteDirectoryAPI {
        let url = URL("https://61e947967bc0550017bc61bf.mockapi.io/api/v1")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return RemoteDirectoryAPI(baseURL: url, jsonDecoder: decoder)
    }
    
    func makeStubAPI() -> StubDirectoryAPI {
        StubDirectoryAPI(
            peopleData: .success([.init(id: "1", createdAt: Date(), firstName: "test", lastName: "test", avatar: URL(string: "https://google.com")!, email: "test@test.com", jobTitle: "Runner", favouriteColor: "green")]),
            roomsData: .success([])
        )
    }
    
    func makePeopleViewController(api: any DirectoryAPI) -> UIViewController {
        let title = "People"
        
        let service = ListItemViewModelPersonServiceAdapter(api: api)
        let viewModel = ListItemTableViewModel(service: service)
        let vc = ListItemTableViewController(viewModel: viewModel)
        vc.title = title
        service.onSelection = { [weak vc] person in
            vc?.select(person: person)
        }
        let tabItem = UITabBarItem(
            title: title,
            image: UIImage(named: "round_supervisor_account_black_36pt"),
            tag: 0
        )
        vc.tabBarItem = tabItem
        
        let navigation = UINavigationController(rootViewController: vc)
        return navigation
    }
    
    func makeRoomsViewController(api: any DirectoryAPI) -> UIViewController {
        let title = "Rooms"
        let service = ListItemViewModelRoomServiceAdapter(api: api)
        let viewModel = ListItemTableViewModel(service: service)
        
        let vc = ListItemTableViewController(viewModel: viewModel)
        vc.title = title
        let tabItem = UITabBarItem(
            title: title,
            image: UIImage(named: "round_meeting_room_black_36pt"),
            tag: 1
        )
        vc.tabBarItem = tabItem
        
        let navigation = UINavigationController(rootViewController: vc)
        return navigation
    }
}

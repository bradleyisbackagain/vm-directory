//
//  MainTabBarController.swift
//  Directory
//
//  Created by Bradley Mackey on 08/04/2022.
//

import UIKit
import DirectoryService

final class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    let stubAPI = StubDirectoryAPI(
        peopleData: .success([.init(id: "1", createdAt: Date(), firstName: "test", lastName: "test", avatar: URL(string: "https://google.com")!, email: "test@test.com", jobTitle: "Runner", favouriteColor: "green")]),
        roomsData: .success([])
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        self.viewControllers = [
            makePeopleViewController(),
            makeRoomsViewController(),
        ]
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("selected", viewController)
    }
    
    func makePeopleViewController() -> UIViewController {
        let service = ListItemViewModelPersonServiceAdapter(api: stubAPI)
        let viewModel = ListItemTableViewModel(service: service)
        let viewController = ListItemTableViewController(viewModel: viewModel)
        let tabItem = UITabBarItem(
            title: "People",
            image: UIImage(named: "round_supervisor_account_black_36pt"),
            tag: 0
        )
        viewController.tabBarItem = tabItem
        return viewController
    }
    
    func makeRoomsViewController() -> UIViewController {
        let service = ListItemViewModelPersonServiceAdapter(api: stubAPI)
        let viewModel = ListItemTableViewModel(service: service)
        let viewController = ListItemTableViewController(viewModel: viewModel)
        let tabItem = UITabBarItem(
            title: "Rooms",
            image: UIImage(named: "round_meeting_room_black_36pt"),
            tag: 1
        )
        viewController.tabBarItem = tabItem
        return viewController
    }
}

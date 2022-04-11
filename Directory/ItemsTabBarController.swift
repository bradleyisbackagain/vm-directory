//
//  ItemsTabBarController.swift
//  Directory
//
//  Created by Bradley Mackey on 08/04/2022.
//

import UIKit
import DirectoryService

final class ItemsTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    let api: DirectoryAPI
    
    init(api: DirectoryAPI) {
        self.api = api
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        self.viewControllers = [
            makePeopleViewController(api: api),
            makeRoomsViewController(api: api),
        ]
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("selected", viewController)
    }
    
    func makePeopleViewController(api: DirectoryAPI) -> UIViewController {
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
    
    func makeRoomsViewController(api: DirectoryAPI) -> UIViewController {
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

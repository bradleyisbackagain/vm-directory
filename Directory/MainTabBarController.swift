//
//  MainTabBarController.swift
//  Directory
//
//  Created by Bradley Mackey on 08/04/2022.
//

import UIKit

final class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
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
        let viewController = ListItemTableViewController()
        let tabItem = UITabBarItem(
            title: "People",
            image: UIImage(named: "round_supervisor_account_black_36pt"),
            tag: 0
        )
        viewController.tabBarItem = tabItem
        return viewController
    }
    
    func makeRoomsViewController() -> UIViewController {
        let viewController = ListItemTableViewController()
        let tabItem = UITabBarItem(
            title: "Rooms",
            image: UIImage(named: "round_meeting_room_black_36pt"),
            tag: 1
        )
        viewController.tabBarItem = tabItem
        return viewController
    }
}

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
        
        let listTab = ListItemTableViewController()
        let firstTabItem = UITabBarItem(title: "First", image: nil, tag: 0)
        listTab.tabBarItem = firstTabItem
        
        self.viewControllers = [listTab]
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("selected", viewController)
    }
    
}

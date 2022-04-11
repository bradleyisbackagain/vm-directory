//
//  MainSplitViewController.swift
//  Directory
//
//  Created by Bradley Mackey on 11/04/2022.
//

import UIKit

final class MainSplitViewController: UISplitViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let placeholder = UIViewController()
        viewControllers = [
            ItemsTabBarController(),
            placeholder,
        ]
    }
    
}

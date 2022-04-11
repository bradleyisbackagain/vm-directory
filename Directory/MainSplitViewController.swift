//
//  MainSplitViewController.swift
//  Directory
//
//  Created by Bradley Mackey on 11/04/2022.
//

import UIKit
import DirectoryService
import CommonUtils

final class MainSplitViewController: UISplitViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let placeholder = UIViewController()
        viewControllers = [
            ItemsTabBarController(api: makeProductionAPI()),
            placeholder,
        ]
    }
    
    func makeProductionAPI() -> RemoteDirectoryAPI {
        let url = URL("https://61e947967bc0550017bc61bf.mockapi.io/api/v1")
        let decoder = JSONDecoder()
        let dateDecoder = ISO8601MillisecondsDecoder()
        decoder.dateDecodingStrategy = .custom(dateDecoder.decode)
        return RemoteDirectoryAPI(baseURL: url, jsonDecoder: decoder)
    }
}

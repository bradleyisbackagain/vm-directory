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

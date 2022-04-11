//
//  UIViewController+Person.swift
//  Directory
//
//  Created by Bradley Mackey on 10/04/2022.
//

import UIKit
import DirectoryService

// Update to coordinator if the view becomes more complex.
// Simple presentation logic is sufficient for the moment.

extension UIViewController {
    /// Presents a view controller with detail for the given person.
    func select(person: Person) {
        let viewModel = PersonDetailViewModel(person)
        let vc = PersonDetailViewController(viewModel: viewModel)
        // FIXME: use better way to determine the UISplitViewController presentation
        if UIDevice.current.userInterfaceIdiom == .phone {
            vc.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: vc, action: #selector(dismissAnimated))
        }
        let nav = UINavigationController(rootViewController: vc)
        showDetailViewController(nav, sender: self)
    }
    
    @objc func dismissAnimated() {
        dismiss(animated: true)
    }
}

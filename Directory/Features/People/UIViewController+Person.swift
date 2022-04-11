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
        show(vc, sender: self)
    }
}

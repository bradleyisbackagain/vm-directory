//
//  UIViewController+Error.swift
//  Directory
//
//  Created by Bradley Mackey on 09/04/2022.
//

import UIKit

extension UIViewController {
    /// Presents an error as a detail view controller.
    func show(error: Error) {
        let alert = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        let dismiss = UIAlertAction(title: "Dismiss", style: .cancel)
        alert.addAction(dismiss)
        showDetailViewController(alert, sender: self)
    }
}

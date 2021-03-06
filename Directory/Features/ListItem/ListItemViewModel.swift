//
//  ListItemViewModel.swift
//  Directory
//
//  Created by Bradley Mackey on 08/04/2022.
//

import Foundation
import CommonUtils
import UIKit

/// An item that can be displayed in `ListItemTableViewController`
struct ListItemViewModel {
    var icon: Box<Icon?>
    var title: Box<String>
    var subtitle: Box<String>
    /// When filtering, does this user query match this item?
    var matchesQuery: (String) -> Bool
    var onSelection: (() -> Void)?
}

// MARK: - Icon

extension ListItemViewModel {
    enum Icon {
        case url(URL)
        case local(named: String, tint: UIColor? = nil)
    }
}

//
//  ListItemViewModel.swift
//  Directory
//
//  Created by Bradley Mackey on 08/04/2022.
//

import Foundation

/// An item that can be displayed in `ListItemTableViewController`
struct ListItemViewModel {
    var icon: Icon
    var title: String
    var subtitle: String
    /// When filtering, does this user query match this item?
    var matchesQuery: (String) -> Bool
}

// MARK: - Icon

extension ListItemViewModel {
    enum Icon {
        case url(URL)
        case local(named: String)
    }
}

//
//  Queryable.swift
//
//  Created by Bradley Mackey on 08/04/2022.
//

import Foundation

/// This model can be queried according to a given search.
public protocol Queryable {
    /// Does this item match this user search query term?
    func matches(query: String) -> Bool
}

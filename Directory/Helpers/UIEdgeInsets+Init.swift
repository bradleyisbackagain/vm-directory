//
//  UIEdgeInsets+Init.swift
//  Directory
//
//  Created by Bradley Mackey on 11/04/2022.
//

import UIKit

extension UIEdgeInsets {
    /// Creates edge insets with all 4 edges initialized to the given value.
    static func all(_ size: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: size, left: size, bottom: size, right: size)
    }
}

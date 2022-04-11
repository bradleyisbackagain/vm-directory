//
//  UIView+Padding.swift
//  Directory
//
//  Created by Bradley Mackey on 11/04/2022.
//

import UIKit

extension UIView {
    /// Adds padding to this view by wrapping in a container.
    public func padding(_ insets: UIEdgeInsets, color: UIColor) -> UIView {
        let container = UIView()
        container.addSubview(self)
        container.edgeConstrain(subview: self, layoutGuide: .safeArea, inset: insets, priority: .required)
        container.backgroundColor = color
        return container
    }
}

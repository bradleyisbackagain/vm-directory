//
//  AutolayoutHelpers.swift
//  Directory
//
//  Created by Bradley Mackey on 08/04/2022.
//

import UIKit

extension UIView {
    
    /// Directive for how to perform edge contraining.
    enum LayoutGuide {
        /// The safe area layout guides should be used.
        case safeArea
        /// The layout guide for the margins of the view.
        case margins
        case custom(UILayoutGuide)
        
        func guide(for view: UIView) -> UILayoutGuide {
            switch self {
            case .safeArea:
                return view.safeAreaLayoutGuide
            case .margins:
                return view.layoutMarginsGuide
            case .custom(let guide):
                return guide
            }
        }
    }
    
    /// Constrains the given subview to all edges of this parent.
    func edgeConstrain(
        subview: UIView,
        layoutGuide: LayoutGuide,
        inset: UIEdgeInsets = .zero,
        priority: UILayoutPriority = .required
    ) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let layoutGuide = layoutGuide.guide(for: self)
        let top = subview.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: inset.top)
        let bottom = subview.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -inset.bottom)
        let leading = subview.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: inset.left)
        let trailing = subview.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -inset.right)
        let newContraints = [top, bottom, leading, trailing]
        newContraints.forEach { constraint in
            constraint.priority = priority
        }
        NSLayoutConstraint.activate(newContraints)
    }
    
}

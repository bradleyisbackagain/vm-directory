//
//  SemanticColor.swift
//
//  Created by Bradley Mackey on 11/04/2022.
//

import Foundation
import UIKit

/// Colors which can change depending on the user's appearance settings.
public enum SemanticColor {
    public static var textPrimary: UIColor {
        if #available(iOS 13.0, *) {
            return .label
        } else {
            return .black
        }
    }
    public static var textSecondary: UIColor {
        if #available(iOS 13.0, *) {
            return .secondaryLabel
        } else {
            return .gray
        }
    }
    public static var backgroundPrimary: UIColor {
        if #available(iOS 13.0, *) {
            return .systemBackground
        } else {
            return .white
        }
    }
}

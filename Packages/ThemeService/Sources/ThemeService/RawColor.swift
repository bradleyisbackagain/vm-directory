//
//  RawColor.swift
//
//  Created by Bradley Mackey on 08/04/2022.
//

import Foundation

/// A platform-independant representation of color.
public struct RawColor {
    public let red: Float
    public let green: Float
    public let blue: Float
    public let opacity: Float
    
    public init(
        red: Float,
        green: Float,
        blue: Float,
        opacity: Float = 1
    ) {
        self.red = red
        self.green = green
        self.blue = blue
        self.opacity = opacity
    }
}

extension RawColor {
    /// Create a `RawColor` from an RGB integer value (hex).
    ///
    /// ```swift
    /// RawColor(hex: 0xffffff)
    /// ```
    public init?(hex: UInt32) {
        guard (0...0xFFFFFF).contains(hex) else { return nil }
        let abs = Float(0xFF)
        self.red = Float((hex & 0xFF0000) >> 16) / abs
        self.green = Float((hex & 0x00FF00) >> 8) / abs
        self.blue = Float((hex & 0x0000FF) >> 0) / abs
        self.opacity = 1
    }
    
    /// Create a `RawColor` from an RGB hex string.
    /// The string must start with `#` and have exactly 6 hex characters.
    public init?(hex: String) {
        guard hex.first == "#" else { return nil }
        guard hex.count == 7 else { return nil }
        // ignore the first '#'
        let strIndex = hex.index(after: hex.startIndex)
        guard let parsed = UInt32(hex[strIndex...], radix: 16) else {
            return nil
        }
        self.init(hex: parsed)
    }
}

// MARK: - Apple Frameworks

#if canImport(UIKit)

import UIKit

extension RawColor {
    /// Convert the `RawColor` to a `UIColor`.
    public func uiColor() -> UIColor {
        return UIColor(
            red: CGFloat(red),
            green: CGFloat(green),
            blue: CGFloat(blue),
            alpha: CGFloat(opacity)
        )
    }
}

#endif

#if canImport(SwiftUI)

import SwiftUI

@available(iOS 13.0, *)
extension RawColor {
    /// Convert the `RawColor` to a color that can be used by SwiftUI.
    public func color() -> Color {
        return Color(
            red: Double(red),
            green: Double(green),
            blue: Double(blue)
        )
        .opacity(Double(opacity))
    }
}

#endif

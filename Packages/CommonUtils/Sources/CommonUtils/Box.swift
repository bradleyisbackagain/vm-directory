//
//  Box.swift
//
//  Created by Bradley Mackey on 09/04/2022.
//

import Dispatch

/// A box to bind data, sending updates to the `listener` when the value changes.
///
/// This can be used with MVVM to provide value updates.
public final class Box<T> {
    public typealias Listener = (T) -> Void
    public var listener: Listener?
    
    /// The current value for this object.
    public var value: T {
        didSet {
            DispatchQueue.asyncMainIfNeeded {
                self.listener?(self.value)
            }
        }
    }
    
    /// Creates a new box with the given value.
    /// Don't forget to add a binding to recieve data update notifications.
    public init(_ value: T) {
        self.value = value
    }
    
    /// Create a listener that will recieve binding updates when the value of the data changes.
    ///
    /// The callback will always run on the main thread, as required for UI updates.
    /// This means you don't need to dispatch yourself to the main thread.
    public func bind(listener: Listener?) {
        self.listener = listener
        DispatchQueue.asyncMainIfNeeded {
            listener?(self.value)
        }
    }
}

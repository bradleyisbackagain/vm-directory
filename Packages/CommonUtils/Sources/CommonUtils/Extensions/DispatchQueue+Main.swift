//
//  DispatchQueue+Main.swift
//  
//
//  Created by Bradley Mackey on 11/04/2022.
//

import Foundation

extension DispatchQueue {
    /// Runs the work on the main thread if it is needed, otherwise runs synchronously.
    public static func asyncMainIfNeeded(handler: @escaping () -> Void) {
        if Thread.isMainThread {
            handler()
        } else {
            DispatchQueue.main.async {
                handler()
            }
        }
    }
}

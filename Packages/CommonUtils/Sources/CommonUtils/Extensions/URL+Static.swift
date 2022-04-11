//
//  File.swift
//  
//
//  Created by Bradley Mackey on 09/04/2022.
//

import Foundation

extension URL {
    /// Construct a `URL` from a compile-time static string.
    /// Traps if the URL is invalid.
    public init(_ staticString: StaticString) {
        let string = String(staticString)
        guard let url = URL(string: string) else {
            fatalError("The URL \(string) is invalid!")
        }
        self = url
    }
}

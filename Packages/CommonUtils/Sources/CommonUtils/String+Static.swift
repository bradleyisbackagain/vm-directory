//
//  String+Static.swift
//
//  Created by Bradley Mackey on 09/04/2022.
//

import Foundation

extension String {
    /// Construct a `String` from a `StaticString`.
    public init(_ staticString: StaticString) {
        self = staticString.withUTF8Buffer { buffer in
            String(decoding: buffer, as: UTF8.self)
        }
    }
}

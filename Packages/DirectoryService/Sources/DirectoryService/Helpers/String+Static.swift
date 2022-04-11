//
//  String+Static.swift
//
//  Created by Bradley Mackey on 08/04/2022.
//

extension String {
    /// Construct a `String` from a `StaticString`.
    init(_ staticString: StaticString) {
        self = staticString.withUTF8Buffer { buffer in
            String(decoding: buffer, as: UTF8.self)
        }
    }
}

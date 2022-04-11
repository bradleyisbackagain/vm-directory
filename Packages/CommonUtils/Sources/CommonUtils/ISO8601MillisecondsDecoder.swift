//
//  ISO8601MillisecondsDecoder.swift
//
//  Created by Bradley Mackey on 11/04/2022.
//

import Foundation

/// Decoding context for ISO8601 with milliseconds.
///
/// This is not supported by default by `JSONDecoder`, so we define a custom strategy here.
/// See: https://stackoverflow.com/a/55470440
public final class ISO8601MillisecondsDecoder {
    public init() { }
    
    private let formatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [
            .withFullDate,
            .withFullTime,
            .withTimeZone,
            .withFractionalSeconds,
        ]
        return formatter
    }()
    
    /// Using the decoder, decode an ISO8601 date string (with milliseconds).
    public func decode(_ decoder: Decoder) throws -> Date {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        if let date = formatter.date(from: string) {
            return date
        } else {
            let context = DecodingError.Context(
                codingPath: decoder.codingPath,
                debugDescription: "The data is not ISO8601 formatted with milliseconds!"
            )
            throw DecodingError.dataCorrupted(context)
        }
    }
}

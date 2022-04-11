//
//  DirectoryAPI.swift
//
//  Created by Bradley Mackey on 07/04/2022.
//

import Foundation

/// Description of a service that can return directory information.
public protocol DirectoryAPI {
    func people(completion: @escaping (Result<[Person], Error>) -> Void)
    func rooms(completion: @escaping (Result<[Room], Error>) -> Void)
}

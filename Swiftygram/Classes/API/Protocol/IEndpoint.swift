//
//  IEndpoint.swift
//  InstaGQL_01
//
//  Created by Mahmoud HodaeeNia on 7/9/23.
//

import Foundation

public protocol IEndpoint {
    func getPost(withShortCode shortCode: String) async throws -> Media?
    
    func getUser(withUsername username: String) async throws -> User?
}

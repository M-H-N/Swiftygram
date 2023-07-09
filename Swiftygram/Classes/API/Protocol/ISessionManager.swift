//
//  ISessionManager.swift
//  InstaGQL_01
//
//  Created by Mahmoud HodaeeNia on 7/9/23.
//

import Foundation

public protocol ISessionManager {
    var urlSession: URLSession { get }
    
    func getRequest(_ request: URLRequest) async throws -> URLResult
}

//
//  SessionManager.swift
//  InstaGQL_01
//
//  Created by Mahmoud HodaeeNia on 7/9/23.
//

import Foundation

open class SessionManager: ISessionManager {
    public init() {}
    
    open var urlSession: URLSession { .shared }
    
    
    open func getRequest(_ request: URLRequest) async throws -> URLResult {
        try await self.urlSession.dataResult(for: request)
    }
}

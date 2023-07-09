//
//  URLResult.swift
//  InstaGQL_01
//
//  Created by Mahmoud HodaeeNia on 7/9/23.
//

import Foundation

open class URLResult {
    public let data: Data
    public let response: URLResponse
    
    public init(data: Data, response: URLResponse) {
        self.data = data
        self.response = response
    }
}


public extension URLSession {
    func dataResult(for request: URLRequest) async throws -> URLResult {
        let (data, response) = try await self.data(for: request)
        return .init(data: data, response: response)
    }
}

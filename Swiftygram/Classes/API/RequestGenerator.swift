//
//  RequestGenerator.swift
//  InstaGQL_01
//
//  Created by Mahmoud HodaeeNia on 7/9/23.
//

import Foundation

open class RequestGenerator: IRequestGenerator {
    let httpHeaders: [String : String]
    
    public init(httpHeaders: [String : String] = [:]) {
        self.httpHeaders = httpHeaders
    }
    
    
    open func request(forUrl url: URL) -> URLRequest {
        var request: URLRequest = .init(url: url, cachePolicy: .useProtocolCachePolicy)
        self.httpHeaders.forEach({ request.addValue($0.value, forHTTPHeaderField: $0.key) })
        request.allowsCellularAccess = true
        request.httpShouldHandleCookies = false
        return request
    }
}

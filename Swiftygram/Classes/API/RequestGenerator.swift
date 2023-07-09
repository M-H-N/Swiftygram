//
//  RequestGenerator.swift
//  InstaGQL_01
//
//  Created by Mahmoud HodaeeNia on 7/9/23.
//

import Foundation

open class RequestGenerator: IRequestGenerator {
    public init() {}
    
    
    open func request(forUrl url: URL) -> URLRequest {
        .init(url: url, cachePolicy: .useProtocolCachePolicy)
    }
}

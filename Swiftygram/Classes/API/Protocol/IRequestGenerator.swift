//
//  IRequestGenerator.swift
//  InstaGQL_01
//
//  Created by Mahmoud HodaeeNia on 7/9/23.
//

import Foundation

public protocol IRequestGenerator {
    func request(forUrl url: URL) -> URLRequest
}

//
//  IURLGenerator.swift
//  InstaGQL_01
//
//  Created by Mahmoud HodaeeNia on 7/9/23.
//

import Foundation

public protocol IURLGenerator {
    func postUrl(withShortCode shortCode: String) -> URL
    
    func userUrl(withUsername username: String) -> URL
}

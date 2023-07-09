//
//  IDable.swift
//  InstaGQL_01
//
//  Created by Mahmoud HodaeeNia on 7/9/23.
//

import Foundation

open class IDable: WrappedBase {
    lazy var identifier: String? = {
        self["id"].optional()?.string()
    }()
}

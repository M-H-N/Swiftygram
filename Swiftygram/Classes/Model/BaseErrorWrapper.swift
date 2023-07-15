//
//  BanError.swift
//  Swiftygram
//
//  Created by Mahmoud HodaeeNia on 7/15/23.
//

import Foundation

open class BaseErrorWrapper: WrappedBase {
    open lazy var message: String? = self["message"].optional()?.string()
    
    open lazy var requireLogin: Bool? = self["require_login"].optional()?.bool()
    
    open lazy var status: String? = self["status"].optional()?.string()
    
    
    open var isIPBanError: Bool {
        self.status == "fail" && self.requireLogin == true
    }
}


public extension BaseErrorWrapper {
    static func isIPBanError(from data: Data) -> Bool {
        guard let wrapper: Wrapper = try? .decode(data) else { return false }
        let baseError: BaseErrorWrapper = .init(wrapper: wrapper)
        return baseError.isIPBanError
    }
}

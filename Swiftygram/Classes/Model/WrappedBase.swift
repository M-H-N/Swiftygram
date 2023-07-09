//
//  WappedBase.swift
//  InstaGQL_01
//
//  Created by Mahmoud HodaeeNia on 7/9/23.
//

import Foundation

open class WrappedBase: Wrapped {
    open var wrapper: () -> Wrapper
    
    
    public required init(wrapper: @escaping () -> Wrapper) {
        self.wrapper = wrapper
    }
}

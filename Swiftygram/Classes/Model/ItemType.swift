//
//  ItemType.swift
//  InstaGQL_01
//
//  Created by Mahmoud HodaeeNia on 7/9/23.
//

import Foundation

public enum ItemType: CustomStringConvertible {
    case user
    case reel
    case post
    
    
    public var pathComponent: String? {
        switch self {
        case .post: return "p"
        case .reel: return "reel"
        case .user: fallthrough
        default: return nil
        }
    }
    
    public static func from(pathComponent: String) -> ItemType? {
        switch pathComponent {
        case Self.reel.pathComponent: return .reel
        case Self.post.pathComponent: return .post
        default: return nil
        }
    }
    
    public static func from(pathComponents: [String]) -> ItemType? {
        pathComponents.compactMap(Self.from(pathComponent:)).first
    }
    
    public var description: String {
        switch self {
        case .user: return "user"
        case .post: return "post"
        case .reel: return "reel"
        }
    }
}

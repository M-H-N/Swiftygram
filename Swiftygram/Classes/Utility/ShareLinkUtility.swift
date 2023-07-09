//
//  ShareLinkUtility.swift
//  Swiftygram
//
//  Created by Mahmoud HodaeeNia on 7/9/23.
//


import Foundation

public class ShareLinkUtility {
    public static func shortCode(forUrl url: URL) -> (String, ItemType)? {
        guard let shortCode = url.pathComponents.last else {
            return nil
        }
        
        if let type = ItemType.from(pathComponents: url.pathComponents) {
            return (shortCode, type)
        } else {
            return (shortCode, .user)
        }
    }
}

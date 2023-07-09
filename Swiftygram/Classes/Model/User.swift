//
//  User.swift
//  InstaGQL_01
//
//  Created by Mahmoud HodaeeNia on 7/9/23.
//

import Foundation

open class User: IDable {
    // MARK: Basic Info
    open lazy var biography: String? = self["biography"].string()
    open lazy var name: String? = self["full_name"].string()
    open lazy var username: String? = self["username"].string()
    open lazy var isPrivate: Bool? = self["is_private"].bool()
    open lazy var isVerified: Bool? = self["is_verified"].bool()
    
    
    // MARK: Profile Pic
    open lazy var profilePic: ProfilePic? = .init(wrapper: self.wrapped)
    
    // MARK: Friendship
    open lazy var friendship: Friendship? = .init(wrapper: self.wrapped)
    
    
}



// MARK: Friendship
extension User {
    open class Friendship: WrappedBase {
        lazy var followersCount: Int? = self["edge_followed_by"].optional()?["count"].int()
        
        lazy var followingsCount: Int? = self["edge_follow"].optional()?["count"].int()
    }
}


// MARK: Profile Pic
extension User {
    open class ProfilePic: WrappedBase {
        lazy var thumbnailUrl: URL? = self["profile_pic_url"].url()
        
        lazy var hqUrl: URL? = self["profile_pic_url_hd"].url()
    }
}

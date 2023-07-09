//
//  String+Utils.swift
//  InstaGQL_01
//
//  Created by Mahmoud HodaeeNia on 7/9/23.
//

import Foundation

/// `String` extension to convert `snake_case` into `camelCase`, and back.
public extension String {
    /// To `camelCase`.
    var camelCased: String {
//        return split(separator: "_")
//            .map(String.init)
//            .enumerated()
//            .map { $0.offset > 0 ? $0.element.beginningWithUppercase : $0.element.beginningWithLowercase }
//            .joined()
        self
    }

    /// To `snake-case`.
    var snakeCased: String {
//        return reduce(into: "") { result, new in
//            result += new.isUppercase ? "_" + String(new).lowercased() : String(new)
//        }
        self
    }

    /// Convert first letter to uppercase.
    var beginningWithUppercase: String {
        return prefix(1).uppercased() + dropFirst()
    }

    /// Convert first letter to lowercase.
    var beginningWithLowercase: String {
        return prefix(1).lowercased() + dropFirst()
    }
}

extension String {
    /// Escape according to *RFC3986*.
    var escaped: String! { addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) }
}


/// An `extension` for `CharacterSet`.
public extension CharacterSet {
    /// A `.urlQueryAllowed` subset, used for body requests.
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        // Compose and return.
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}


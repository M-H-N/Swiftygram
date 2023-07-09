//
//  URLGenerator.swift
//  InstaGQL_01
//
//  Created by Mahmoud HodaeeNia on 7/9/23.
//

import Foundation

open class URLGenerator: IURLGenerator {
    public init() {}
    
    open var baseUrl: URL {
        URL(string: "https://www.instagram.com/")!
    }
    
    open func postUrl(withShortCode shortCode: String) -> URL {
        self.baseUrl
            .appendingPathComponent(URLPath.post.rawValue)
            .appendingPathComponent(shortCode)
            .appendingDefaultQueryParams()
    }
    
    open func userUrl(withUsername username: String) -> URL {
        self.baseUrl
            .appendingPathComponent(username)
            .appendingDefaultQueryParams()
    }
}


public extension URLGenerator {
    enum URLPath: String {
        case post = "p"
    }
}

fileprivate extension URL {
    func appendingDefaultQueryParams() -> URL {
        let queryItems: [URLQueryItem] = [
            .init(name: "__a", value: "1"),
            .init(name: "__d", value: "dis")
        ]
        if #available(iOS 16.0, *) {
            return self.appending(queryItems: queryItems)
        } else {
            // Fallback on earlier versions
            return self
                .appending(queryItems[0].name, value: queryItems[0].value)
                .appending(queryItems[1].name, value: queryItems[1].value)
        }
    }
}


fileprivate extension URL {
    func appending(_ queryItem: String, value: String?) -> URL {

        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }

        // Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

        // Create query item
        let queryItem = URLQueryItem(name: queryItem, value: value)

        // Append the new query item in the existing query items array
        queryItems.append(queryItem)

        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems

        // Returns the url from new url components
        return urlComponents.url!
    }
}

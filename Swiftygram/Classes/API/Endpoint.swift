//
//  Endpoint.swift
//  InstaGQL_01
//
//  Created by Mahmoud HodaeeNia on 7/9/23.
//

import Foundation

open class Endpoint: IEndpoint {
    public let urlGenerator: IURLGenerator
    public let requestGenerator: IRequestGenerator
    public let sessionManager: ISessionManager
    
    
    
    public init(
        urlGenerator: IURLGenerator = URLGenerator(),
        requestGenerator: IRequestGenerator = RequestGenerator(),
        sessionManager: ISessionManager = SessionManager()
    ) {
        self.urlGenerator = urlGenerator
        self.requestGenerator = requestGenerator
        self.sessionManager = sessionManager
    }
    
    
    open func getPost(withShortCode shortCode: String) async throws -> Media? {
        // Prepare the url
        let url = self.urlGenerator.postUrl(withShortCode: shortCode)
        
        // Prepare the request
        let request = self.requestGenerator.request(forUrl: url)
        
        // Call the network
        let result = try await self.sessionManager.getRequest(request)
        let resultData: Data = result.data
        
        // Get the obj
        do {
            let wrapper: Wrapper = try .decode(resultData)
            guard let graphQlWrapper = wrapper["graphql"].optional(),
                  let mediaWrapper = graphQlWrapper["shortcode_media"].optional() else {
                return nil
            }
        } catch let error {
            // Check if it's a IP-Address ban error
            if BaseErrorWrapper.isIPBanError(from: resultData) {
                throw SwiftygramError.ipBanError
            }
            
            // Otherwise throw the actual error
            throw error
        }
        
        
        // Parse the response
        return .init(wrapper: mediaWrapper)
    }
    
    open func getUser(withUsername username: String) async throws -> User? {
        // URL
        let url = self.urlGenerator.userUrl(withUsername: username)
        
        let request = self.requestGenerator.request(forUrl: url)
        
        let result = try await self.sessionManager.getRequest(request)
        
        
        let wrapper: Wrapper = try .decode(result.data)
        guard let graphQlWrapper = wrapper["graphql"].optional(),
              let userWrapper = graphQlWrapper["user"].optional() else {
            return nil
        }
        
        return .init(wrapper: userWrapper)
    }
}

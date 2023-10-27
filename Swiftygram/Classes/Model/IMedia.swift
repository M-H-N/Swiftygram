//
//  IMedia.swift
//  Swiftygram
//
//  Created by Mahmoud HodaeeNia on 10/27/23.
//

import Foundation

public protocol IMedia {
    var identifier: String? { get }
    
    var shortCode: String? { get }
    
    var images: [any IMediaContentVersion]? { get }
    
    var hasVideo: Bool { get }
    
    var content: (any IMediaContent)? { get }
    
    var caption: IMediaCaption? { get }
}


public protocol IMediaContent: Identifiable {
    var contentType: MediaContentType? { get }
    var sideCarContents: [any IMediaContent]? { get }
    var videoVersions: [any IMediaContentVersion]? { get }
    var imageVersions: [any IMediaContentVersion]? { get }
}


public protocol IMediaContentVersion: Identifiable {
    var url: URL? { get }
    var width: CGFloat? { get }
    var height: CGFloat? { get }
    var size: CGSize? { get }
    var aspectRatio: CGFloat? { get }
    var resolution: CGFloat? { get }
}

public enum MediaContentType {
    case video, image, sidecar
}


public protocol IMediaCaption {
    var date: Date? { get }
    var text: String? { get }
}

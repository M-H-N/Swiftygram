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
    
    var images: [IMediaContentVersion]? { get }
    
    var hasVideo: Bool { get }
    
    var content: IMediaContent? { get }
    
    var caption: IMediaCaption? { get }
}


public protocol IMediaContent {
    var contentType: MediaContentType? { get }
    var sideCarContents: [IMediaContent]? { get }
    var videoVersions: [IMediaContentVersion]? { get }
    var imageVersions: [IMediaContentVersion]? { get }
}


public protocol IMediaContentVersion {
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

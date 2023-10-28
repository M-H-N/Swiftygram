//
//  IMedia.swift
//  Swiftygram
//
//  Created by Mahmoud HodaeeNia on 10/27/23.
//

import Foundation

open class MediaBase: WrappedBase {
    open var identifier: String? { nil }
    
    open var shortCode: String? { nil }
    
    open var images: [VersionBase]? { nil }
    
    open var hasVideo: Bool { false }
    
    open var content: ContentBase? { nil }
    
    open var caption: CaptionBase? { nil }
}


extension MediaBase {
    open class ContentBase: WrappedBase, Identifiable {
        open var contentType: ContentType? { nil }
        open var sideCarContents: [ContentBase]? { nil }
        open var videoVersions: [VersionBase]? { nil }
        open var imageVersions: [VersionBase]? { nil }
    }
    
    open class VersionBase: WrappedBase, Identifiable {
        open var url: URL? { nil }
        open var width: CGFloat? { nil }
        open var height: CGFloat? { nil }
        open var size: CGSize? { nil }
        open var aspectRatio: CGFloat? { nil }
        open var resolution: CGFloat? { nil }
    }
    
    open class CaptionBase: WrappedBase, Identifiable {
        open var date: Date? { nil }
        open var text: String? { nil }
    }
}

public extension MediaBase.ContentBase {
    enum ContentType {
        case video, image, sidecar
    }
}

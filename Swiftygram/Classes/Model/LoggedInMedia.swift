//
//  LoggedInMedia.swift
//  Swiftygram
//
//  Created by Mahmoud HodaeeNia on 10/27/23.
//

import Foundation

open class LoggedInMedia: WrappedBase, IMedia {
    open var identifier: String? {
        self["id"].string()
    }
    
    open var shortCode: String? {
        self["code"].string()
    }
    
    open var images: [any IMediaContentVersion]? {
        self["image_versions2"].optional()?["candidates"].array()?.compactMap(Version.init)
    }
    
    open var hasVideo: Bool {
        self["video_versions"].optional()?.array() != nil
    }
    
    open var content: (any IMediaContent)? {
        Content.init(wrapper: self.wrapped)
    }
    
    open var caption: IMediaCaption? {
        guard let wrapped = self["caption"].optional() else { return nil }
        return Caption(wrapper: wrapped)
    }
}



extension LoggedInMedia {
    open class Content: WrappedBase, IMediaContent {
        public var contentType: MediaContentType? {
            if self.sideCarContents != nil {
                return .sidecar
            } else if self.videoVersions != nil {
                return .video
            } else {
                return .image
            }
        }
        
        public var sideCarContents: [any IMediaContent]? {
            self["carousel_media"].optional()?.array()?.compactMap(Content.init)
        }
        
        public var videoVersions: [any IMediaContentVersion]? {
            self["video_versions"].optional()?.array()?.compactMap(Version.init)
        }
        
        public var imageVersions: [any IMediaContentVersion]? {
            self["image_versions2"].optional()?["candidates"].array()?.compactMap(Version.init)
        }
    }
}



extension LoggedInMedia {
    open class Version: WrappedBase, IMediaContentVersion {
        open var url: URL? {
            self["url"].url()
        }
        
        open var width: CGFloat? {
            self["width"].double().flatMap(CGFloat.init)
        }
        
        open var height: CGFloat? {
            self["height"].double().flatMap(CGFloat.init)
        }
        
        open var aspectRatio: CGFloat? {
            guard let width, let height else { return nil }
            return width / height
        }
        
        open var resolution: CGFloat? {
            guard let width, let height else { return nil }
            return width * height
        }
        
        open var size: CGSize? {
            guard let width, let height else { return nil }
            return .init(width: width, height: height)
        }
    }
}



extension LoggedInMedia {
    open class Caption: WrappedBase, IMediaCaption {
        open var date: Date? {
            // format is like: 1688912369
            self["created_at"].optional()?.date()
        }
        
        open var text: String? {
            self["text"].optional()?.string()
        }
    }
}

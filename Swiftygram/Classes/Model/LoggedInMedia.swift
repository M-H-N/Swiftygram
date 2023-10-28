//
//  LoggedInMedia.swift
//  Swiftygram
//
//  Created by Mahmoud HodaeeNia on 10/27/23.
//

import Foundation

open class LoggedInMedia: MediaBase {
    open override var identifier: String? {
        self["id"].string()
    }
    
    open override var shortCode: String? {
        self["code"].string()
    }
    
    open override var images: [MediaBase.VersionBase]? {
        self["image_versions2"].optional()?["candidates"].array()?.compactMap(Version.init)
    }
    
    open override var hasVideo: Bool {
        self["video_versions"].optional()?.array() != nil
    }
    
    open override var content: MediaBase.ContentBase? {
        Content.init(wrapper: self.wrapped)
    }
    
    open override var caption: MediaBase.CaptionBase? {
        guard let wrapped = self["caption"].optional() else { return nil }
        return Caption(wrapper: wrapped)
    }
}



extension LoggedInMedia {
    open class Content: MediaBase.ContentBase {
        open override var contentType: MediaBase.ContentBase.ContentType? {
            if self.sideCarContents != nil {
                return .sidecar
            } else if self.videoVersions != nil {
                return .video
            } else {
                return .image
            }
        }
        
        open override var sideCarContents: [MediaBase.ContentBase]? {
            self["carousel_media"].optional()?.array()?.compactMap(Content.init)
        }
        
        open override var videoVersions: [MediaBase.VersionBase]? {
            self["video_versions"].optional()?.array()?.compactMap(Version.init)
        }
        
        open override var imageVersions: [MediaBase.VersionBase]? {
            self["image_versions2"].optional()?["candidates"].array()?.compactMap(Version.init)
        }
    }
}



extension LoggedInMedia {
    open class Version: MediaBase.VersionBase {
        open override var url: URL? {
            self["url"].url()
        }
        
        open override var width: CGFloat? {
            self["width"].double().flatMap(CGFloat.init)
        }
        
        open override var height: CGFloat? {
            self["height"].double().flatMap(CGFloat.init)
        }
        
        open override var aspectRatio: CGFloat? {
            guard let width, let height else { return nil }
            return width / height
        }
        
        open override var resolution: CGFloat? {
            guard let width, let height else { return nil }
            return width * height
        }
        
        open override var size: CGSize? {
            guard let width, let height else { return nil }
            return .init(width: width, height: height)
        }
    }
}



extension LoggedInMedia {
    open class Caption: MediaBase.CaptionBase {
        open override var date: Date? {
            // format is like: 1688912369
            self["created_at"].optional()?.date()
        }
        
        open override var text: String? {
            self["text"].optional()?.string()
        }
    }
}

//
//  Media.swift
//  InstaGQL_01
//
//  Created by Mahmoud HodaeeNia on 7/9/23.
//

import Foundation

open class Media: MediaBase {
    open override var identifier: String? {
        self["id"].optional()?.string()
    }
    
    open override var images: [MediaBase.VersionBase]? {
        self["display_resources"].optional()?.array()?.compactMap(Version.init)
    }
    
    open override var hasVideo: Bool {
        self["is_video"].optional()?.bool() ?? false
    }
    
    open override var content: (MediaBase.ContentBase)? {
        Media.Content(wrapper: self.wrapped)
    }

    open override var shortCode: String? {
        self["shortcode"].optional()?.string()
    }
    

    // MARK: Caption
    open override var caption: MediaBase.CaptionBase? {
        guard let wrapped = self["edge_media_to_caption"].optional()?["edges"].optional()?.array()?.first?["node"] else { return nil }
        return Caption.init(wrapper: wrapped)
    }
}

// MARK: TypeName
extension Media {
    public enum TypeName: String {
        case graphVideo = "GraphVideo"
        case graphImage = "GraphImage"
        case graphSidecar = "GraphSidecar"
    }
}

// MARK: Content
extension Media {
    open class Content: MediaBase.ContentBase {
        open var typeNameString: String? {
            self["__typename"].string()
        }
        
        open override var contentType: MediaBase.ContentBase.ContentType? {
            switch self.typeNameString {
            case "GraphVideo": return .video
            case "GraphImage": return .image
            case "GraphSidecar": return .sidecar
            default: return nil
            }
        }
        
        open override var sideCarContents: [MediaBase.ContentBase]? {
            guard contentType == .sidecar else { return nil }
            return self["edge_sidecar_to_children"].optional()?["edges"].array()?.compactMap { edge in
                guard let node = edge["node"].optional() else { return nil }
                return Media.Content(wrapper: node)
            }
        }
        
        open override var videoVersions: [MediaBase.VersionBase]? {
            guard contentType == .video else { return nil }
            return [Version(wrapper: self.wrapped)]
        }
        
        open override var imageVersions: [MediaBase.VersionBase]? {
            guard contentType == .image else { return nil }
            return self["display_resources"].optional()?.array()?.compactMap(Version.init)
        }
    }
}

// MARK: Version
extension Media {
    open class Version: MediaBase.VersionBase {
        open override var width: CGFloat? {
            self["config_width"].double().flatMap(CGFloat.init) ?? self["dimensions"]["width"].double().flatMap(CGFloat.init)
        }
        
        open override var height: CGFloat? {
            self["config_height"].double().flatMap(CGFloat.init) ?? self["dimensions"]["height"].double().flatMap(CGFloat.init)
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
        
        /// The `url`.
        open override var url: URL? {
            self["src"].url() ?? self["video_url"].url()
        }
    }
}


// MARK: Caption
extension Media {
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

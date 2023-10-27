//
//  Media.swift
//  InstaGQL_01
//
//  Created by Mahmoud HodaeeNia on 7/9/23.
//

import Foundation

open class Media: WrappedBase, IMedia {
    open var identifier: String? {
        self["id"].optional()?.string()
    }
    
    open var images: [any IMediaContentVersion]? {
        self["display_resources"].optional()?.array()?.compactMap(Version.init)
    }
    
    open var hasVideo: Bool {
        self["is_video"].optional()?.bool() ?? false
    }
    
    open var content: (any IMediaContent)? {
        Media.Content(wrapper: self.wrapped)
    }

    open var shortCode: String? {
        self["shortcode"].optional()?.string()
    }
    

    // MARK: Caption
    open var caption: IMediaCaption? {
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
    open class Content: WrappedBase, IMediaContent {
        open var typeNameString: String? {
            self["__typename"].string()
        }
        
        open var contentType: MediaContentType? {
            switch self.typeNameString {
            case "GraphVideo": return .video
            case "GraphImage": return .image
            case "GraphSidecar": return .sidecar
            default: return nil
            }
        }
        
        open var sideCarContents: [any IMediaContent]? {
            guard contentType == .sidecar else { return nil }
            return self["edge_sidecar_to_children"].optional()?["edges"].array()?.compactMap { edge in
                guard let node = edge["node"].optional() else { return nil }
                return Media.Content(wrapper: node)
            }
        }
        
        open var videoVersions: [any IMediaContentVersion]? {
            guard contentType == .video else { return nil }
            return [Version(wrapper: self.wrapped)]
        }
        
        open var imageVersions: [any IMediaContentVersion]? {
            guard contentType == .image else { return nil }
            return self["display_resources"].optional()?.array()?.compactMap(Version.init)
        }
    }
}

// MARK: Version
extension Media {
    open class Version: WrappedBase, IMediaContentVersion {
        open var width: CGFloat? {
            self["config_width"].double().flatMap(CGFloat.init) ?? self["dimensions"]["width"].double().flatMap(CGFloat.init)
        }
        
        open var height: CGFloat? {
            self["config_height"].double().flatMap(CGFloat.init) ?? self["dimensions"]["height"].double().flatMap(CGFloat.init)
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
        
        /// The `url`.
        open var url: URL? {
            self["src"].url() ?? self["video_url"].url()
        }
    }
}


// MARK: Caption
extension Media {
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

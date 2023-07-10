//
//  Media.swift
//  InstaGQL_01
//
//  Created by Mahmoud HodaeeNia on 7/9/23.
//

import Foundation

open class Media: IDable {
    open lazy var typeName: TypeName? = {
        guard let typeNameString = self["__typename"].optional()?.string() else { return nil }
        return .init(rawValue: typeNameString)
    }()
    
    open lazy var shortCode: String? = self["shortcode"].optional()?.string()
    
    
    // MARK: Caption
    open lazy var caption: Caption? = {
        guard let wrapped = self["edge_media_to_caption"].optional()?["edges"].optional()?.array()?.first?["node"] else { return nil }
        return .init(wrapper: wrapped)
    }()
    
    
    // MARK: Content
    open lazy var content: Media.Content? = .parseAccordingly(media: self)
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
    open class Content: WrappedBase {
        open lazy var images: [Version]? = self["display_resources"].optional()?.array()?.compactMap(Version.init)
        
        open lazy var isVideo: Bool? = self["is_video"].optional()?.bool()
        
        public static func from(wrapped: Wrapper) -> Media.Content? {
            guard let typeNameString = wrapped["__typename"].string() else { return nil }
            guard let typeName: Media.TypeName = .init(rawValue: typeNameString) else { return nil }
            switch typeName {
            case .graphVideo: return Media.Content.Video(wrapper: wrapped)
            case .graphImage: return Media.Content.Image(wrapper: wrapped)
            case .graphSidecar: return Media.Content.Sidecar(wrapper: wrapped)
            }
        }
        
        public static func parseAccordingly(media: Media) -> Media.Content? {
            guard let type = media.typeName else { return nil }
            switch type {
            case .graphVideo: return Media.Content.Video(wrapper: media.wrapped)
            case .graphImage: return Media.Content.Image(wrapper: media.wrapped)
            case .graphSidecar: return Media.Content.Sidecar(wrapper: media.wrapped)
            }
        }
    }
}

// MARK: ImageContent
extension Media.Content {
    open class Image: Media.Content {}
}

// MARK: VideoContent
extension Media.Content {
    open class Video: Media.Content {
        open lazy var videoUrl: URL? = {
            guard let urlString = self["video_url"].optional()?.string() else { return nil }
            return .init(string: urlString)
        }()
        
        open lazy var hasAudio: Bool? = self["has_audio"].optional()?.bool()
    }
}


// MARK: SideCarContent
extension Media.Content {
    open class Sidecar: Media.Content {
        open lazy var contents: [Media.Content]? = {
            self["edge_sidecar_to_children"].optional()?["edges"].array()?.compactMap { edge in
                guard let node = edge["node"].optional() else { return nil }
                return .from(wrapped: node)
            }
        }()
    }
}


// MARK: Version
extension Media {
    open class Version: WrappedBase {
        /// The `url`.
        public lazy var url: URL? = { self["src"].url() }()
        /// The `size` value.
        public lazy var size: CGSize? = {
            guard let width = self["config_width"].double().flatMap(CGFloat.init),
                  let height = self["config_height"].double().flatMap(CGFloat.init) else { return nil }
            return .init(width: width, height: height)
        }()

        /// The `aspectRatio` value, or `1`.
        public lazy var aspectRatio: CGFloat = { size.flatMap { $0.width/$0.height } ?? 1 }()
        /// The `resolution` value, or `0`.
        public lazy var resolution: CGFloat = { size.flatMap { $0.width*$0.height } ?? .zero }()
    }
}


// MARK: Caption
extension Media {
    open class Caption: WrappedBase {
        open lazy var date: Date? = {
            // format is like: 1688912369
            self["created_at"].optional()?.date()
        }()
        
        open lazy var text: String? = self["text"].optional()?.string()
    }
}

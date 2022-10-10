//
//  WPMedia.swift
//  WordPressSimplify
//
//  Created by Diego Badaracco on 09/10/2022.
//

import Foundation

public protocol WPMediaModel: Codable {
    associatedtype MediaDetail: WPMediaDetailProtocol
    var id: Int? {get}
    var date: String? {get}
    var date_gmt: String? {get}
    var guid: WPGuid? {get}
    var link: String? {get}
    var modified: String? {get}
    var modified_gmt: String? {get}
    var slug: String? {get}
    var status: WPPublishStatus? {get}
    var type: String? {get}
    var title: WPTitle? {get}
    var author: Int? {get}
    var comment_status: WPCommentStatus? {get}
    var ping_status: WPPingStatus? {get}
    var template: String? {get}
    var alt_text: String? {get}
    var caption: WPCaption? {get}
    var description: WPDescription? {get}
    var media_type: WPMediaType? {get}
    var mime_type: String? {get}
    var media_details: MediaDetail? {get}
    var post: Int? {get}
    var source_url: String? {get}
}

public struct WPMedia: WPMediaModel {
    public typealias MediaDetail = WPMediaDetail
    
    public let id: Int?
    public let date: String?
    public let date_gmt: String?
    public let guid: WPGuid?
    public let link: String?
    public let modified: String?
    public let modified_gmt: String?
    public let slug: String?
    public let status: WPPublishStatus?
    public let type: String?
    public let title: WPTitle?
    public let author: Int?
    public let comment_status: WPCommentStatus?
    public let ping_status: WPPingStatus?
    public let template: String?
    public let alt_text: String?
    public let caption: WPCaption?
    public let description: WPDescription?
    public let media_type: WPMediaType?
    public let mime_type: String?
    public let media_details: WPMediaDetail?
    public let post: Int?
    public let source_url: String?
}




//
//  WPPage.swift
//  WordPressSimplify
//
//  Created by Diego Badaracco on 07/10/2022.
//

import Foundation

public protocol WPPageModel: Codable {
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
    var parent: Int? {get}
    var title: WPTitle? {get}
    var content: WPContent? {get}
    var author: Int? {get}
    var excerpt: WPExcerpt? {get}
    var featured_media: Int? {get}
    var comment_status: WPCommentStatus? {get}
    var ping_status: WPPingStatus? {get}
    var menu_order: Int? {get}
    var template: String? {get}
}

public struct WPPage: WPPageModel {
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
    public let parent: Int?
    public let title: WPTitle?
    public let content: WPContent?
    public let author: Int?
    public let excerpt: WPExcerpt?
    public let featured_media: Int?
    public let comment_status: WPCommentStatus?
    public let ping_status: WPPingStatus?
    public let menu_order: Int?
    public let template: String?
}

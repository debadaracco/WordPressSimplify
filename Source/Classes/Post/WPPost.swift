//
//  WPPost.swift
//  WordPressSimplify
//
//  Created by Diego Badaracco on 07/10/2022.
//

import Foundation

public enum WPPostFormat: String, Codable {
    case standard
    case aside
    case chat
    case gallery
    case link
    case image
    case quote
    case status
    case video
    case audio
}

public protocol WPPostModel: Codable {
    var id: Int {get}
    var date: String? {get}
    var date_gmt: String? {get}
    var guid: WPGuid? {get}
    var link: String {get}
    var modified: String? {get}
    var modified_gmt: String? {get}
    var slug: String {get}
    var status: WPPublishStatus {get}
    var type: String {get}
    var title: WPTitle {get}
    var content: WPContent {get}
    var author: Int {get}
    var excerpt: WPExcerpt {get}
    var featured_media: Int {get}
    var comment_status: WPCommentStatus {get}
    var ping_status: WPPingStatus {get}
    var format: WPPostFormat {get}
    var sticky: Bool {get}
    var template: String {get}
    var categories: [Int] {get}
    var tags: [Int] {get}
}

public struct WPPost: WPPostModel {
    public let id: Int
    public let date: String?
    public let date_gmt: String?
    public let guid: WPGuid?
    public let link: String
    public let modified: String?
    public let modified_gmt: String?
    public let slug: String
    public let status: WPPublishStatus
    public let type: String
    public let title: WPTitle
    public let content: WPContent
    public let author: Int
    public let excerpt: WPExcerpt
    public let featured_media: Int
    public let comment_status: WPCommentStatus
    public let ping_status: WPPingStatus
    public let format: WPPostFormat
    public let sticky: Bool
    public let template: String
    public let categories: [Int]
    public let tags: [Int]
}

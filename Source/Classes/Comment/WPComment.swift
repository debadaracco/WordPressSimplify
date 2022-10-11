//
//  WPMedia.swift
//  WordPressSimplify
//
//  Created by Diego Badaracco on 09/10/2022.
//

import Foundation

public enum WPCommentPostStatus: String, Codable {
    case approved
    case pending
    case spam
    case trash
}

public protocol WPCommentModel: Codable, WPAvatarProtocol {
    var id: Int? {get}
    var author: Int? {get}
    var author_name: String? {get}
    var author_url: String? {get}
    var date: String? {get}
    var date_gmt: String? {get}
    var content: WPContent? {get}
    var link: String? {get}
    var parent: Int? {get}
    var post: Int? {get}
    var status: WPCommentPostStatus? {get}
    var type: String? {get}
    var author_avatar_urls: WPAvatarURLS? {get}
}

extension WPCommentModel {
    public func avatarUrl(by size: WPAvatarSizes) -> String? {
        return self.author_avatar_urls?[size.rawValue]
    }
}

public struct WPComment: WPCommentModel {
    public let id: Int?
    public let author: Int?
    public let author_name: String?
    public let author_url: String?
    public let date: String?
    public let date_gmt: String?
    public let content: WPContent?
    public let link: String?
    public let parent: Int?
    public let post: Int?
    public let status: WPCommentPostStatus?
    public let type: String?
    public let author_avatar_urls: WPAvatarURLS?
}

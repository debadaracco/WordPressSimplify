//
//  WPUser.swift
//  WordPressSimplify-iOS
//
//  Created by Diego Badaracco on 20/09/2022.
//

import Foundation

public protocol WPUserModel: Codable, WPAvatarProtocol {
    var id: Int? {get}
    var username: String? {get}
    var name: String {get}
    var first_name: String? {get}
    var last_name: String? {get}
    var email: String? {get}
    var url: String? {get}
    var description: String? {get}
    var link: String? {get}
    var locale: String? {get}
    var nickname: String? {get}
    var slug: String? {get}
    var avatar_urls: WPAvatarURLS? {get}
}

extension WPUserModel {
    public func avatarUrl(by size: WPAvatarSizes) -> String? {
        return self.avatar_urls?[size.rawValue]
    }
}

public struct WPUser: WPUserModel {
    public let id: Int?
    public let username: String?
    public let name: String
    public let first_name: String?
    public let last_name: String?
    public let email: String?
    public let url: String?
    public let description: String?
    public let link: String?
    public let locale: String?
    public let nickname: String?
    public let slug: String?
    public let avatar_urls: WPAvatarURLS?
}

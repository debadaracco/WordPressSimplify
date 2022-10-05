//
//  WPUser.swift
//  WordPressSimplify-iOS
//
//  Created by Diego Badaracco on 20/09/2022.
//

import Foundation

public protocol WPUserModel: Codable {
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
}

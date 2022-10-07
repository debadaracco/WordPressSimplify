//
//  WPUserRequestFields.swift
//  WordPressSimplify-iOS
//
//  Created by Diego Badaracco on 23/09/2022.
//

import Foundation

public extension WPRequestField {
    enum UserFields: CaseIterable, WPRequestFieldTypeProtocol {
        public static var allCases: [WPRequestField.UserFields] = [
            .id,
            .username,
            .name,
            .firstName,
            .lastName,
            .email,
            .url,
            .description,
            .link,
            .locale,
            .nickname,
            .slug,
            .custom(field: "")
        ]

        case id
        case username
        case name
        case firstName
        case lastName
        case email
        case url
        case description
        case link
        case locale
        case nickname
        case slug
        case custom(field: String)

        var fieldValue: String {
            switch self {
            case .id:
                return "id"
            case .username:
                return "username"
            case .name:
                return "name"
            case .firstName:
                return "first_name"
            case .lastName:
                return "last_name"
            case .email:
                return "email"
            case .url:
                return "url"
            case .description:
                return "description"
            case .link:
                return "link"
            case .locale:
                return "locale"
            case .nickname:
                return "nickname"
            case .slug:
                return "slug"
            case .custom(let field):
                return field
            }
        }
    }
}

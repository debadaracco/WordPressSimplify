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
                return Constants.AllFields.id
            case .username:
                return Constants.AllFields.username
            case .name:
                return Constants.AllFields.name
            case .firstName:
                return Constants.AllFields.firstName
            case .lastName:
                return Constants.AllFields.lastName
            case .email:
                return Constants.AllFields.email
            case .url:
                return Constants.AllFields.url
            case .description:
                return Constants.AllFields.description
            case .link:
                return Constants.AllFields.link
            case .locale:
                return Constants.AllFields.locale
            case .nickname:
                return Constants.AllFields.nickname
            case .slug:
                return Constants.AllFields.slug
            case .custom(let field):
                return field
            }
        }
    }
}

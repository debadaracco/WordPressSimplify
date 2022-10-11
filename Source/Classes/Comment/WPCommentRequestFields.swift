//
//  WPMediaRequestFields.swift
//  WordPressSimplify
//
//  Created by Diego Badaracco on 09/10/2022.
//

import Foundation

public extension WPRequestField {
    enum CommentFields: CaseIterable, WPRequestFieldTypeProtocol {
        public static var allCases: [WPRequestField.CommentFields] = [
            .id,
            .author,
            .authorEmail,
            .authorName,
            .authorUrl,
            .date,
            .dateGmt,
            .content,
            .link,
            .parent,
            .post,
            .status,
            .type,
            .authorAvatarUrls,
            .custom(field: "")
        ]

        case id
        case author
        case authorEmail
        case authorName
        case authorUrl
        case date
        case dateGmt
        case content
        case link
        case parent
        case post
        case status
        case type
        case authorAvatarUrls
        case custom(field: String)

        var fieldValue: String {
            switch self {
            case .id:
                return Constants.AllFields.id
            case .author:
                return Constants.AllFields.author
            case .authorEmail:
                return Constants.AllFields.authorEmail
            case .authorName:
                return Constants.AllFields.authorName
            case .authorUrl:
                return Constants.AllFields.authorUrl
            case .date:
                return Constants.AllFields.date
            case .dateGmt:
                return Constants.AllFields.dateGmt
            case .content:
                return Constants.AllFields.content
            case .link:
                return Constants.AllFields.link
            case .parent:
                return Constants.AllFields.parent
            case .post:
                return Constants.AllFields.post
            case .status:
                return Constants.AllFields.status
            case .type:
                return Constants.AllFields.type
            case .authorAvatarUrls:
                return Constants.AllFields.authorAvatarUrls
            case .custom(let field):
                return field
            }
        }
    }
}

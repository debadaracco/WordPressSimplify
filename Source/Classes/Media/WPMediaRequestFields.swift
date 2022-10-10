//
//  WPMediaRequestFields.swift
//  WordPressSimplify
//
//  Created by Diego Badaracco on 09/10/2022.
//

import Foundation

public extension WPRequestField {
    enum MediaFields: CaseIterable, WPRequestFieldTypeProtocol {
        public static var allCases: [WPRequestField.MediaFields] = [
            .id,
            .date,
            .dateGmt,
            .guid,
            .link,
            .modified,
            .modifiedGmt,
            .slug,
            .status,
            .type,
            .title,
            .author,
            .commentStatus,
            .pingStatus,
            .template,
            .altText,
            .caption,
            .description,
            .mediaType,
            .mimeType,
            .mediaDetails,
            .post,
            .sourceUrl,
            .custom(field: "")
        ]

        case id
        case date
        case dateGmt
        case guid
        case link
        case modified
        case modifiedGmt
        case slug
        case status
        case type
        case title
        case author
        case commentStatus
        case pingStatus
        case template
        case altText
        case caption
        case description
        case mediaType
        case mimeType
        case mediaDetails
        case post
        case sourceUrl
        case custom(field: String)

        var fieldValue: String {
            switch self {
            case .id:
                return Constants.AllFields.id
            case .date:
                return Constants.AllFields.date
            case .dateGmt:
                return Constants.AllFields.dateGmt
            case .guid:
                return Constants.AllFields.guid
            case .link:
                return Constants.AllFields.link
            case .modified:
                return Constants.AllFields.modified
            case .modifiedGmt:
                return Constants.AllFields.modifiedGmt
            case .slug:
                return Constants.AllFields.slug
            case .status:
                return Constants.AllFields.status
            case .type:
                return Constants.AllFields.type
            case .title:
                return Constants.AllFields.title
            case .author:
                return Constants.AllFields.author
            case .commentStatus:
                return Constants.AllFields.commentStatus
            case .pingStatus:
                return Constants.AllFields.pingStatus
            case .template:
                return Constants.AllFields.template
            case .altText:
                return Constants.AllFields.altText
            case .caption:
                return Constants.AllFields.caption
            case .description:
                return Constants.AllFields.description
            case .mediaType:
                return Constants.AllFields.mediaType
            case .mimeType:
                return Constants.AllFields.mimeType
            case .mediaDetails:
                return Constants.AllFields.mediaDetails
            case .post:
                return Constants.AllFields.post
            case .sourceUrl:
                return Constants.AllFields.sourceUrl
            case .custom(let field):
                return field
            }
        }
    }
}

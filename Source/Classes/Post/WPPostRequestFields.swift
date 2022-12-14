//
//  WPPostRequestFields.swift
//  WordPressSimplify
//
//  Created by Diego Badaracco on 07/10/2022.
//

import Foundation

public extension WPRequestField {
    enum PostFields: CaseIterable, WPRequestFieldTypeProtocol {
        public static var allCases: [WPRequestField.PostFields] = [
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
            .content,
            .author,
            .excerpt,
            .featuredMedia,
            .commentStatus,
            .pingStatus,
            .format,
            .sticky,
            .template,
            .categories,
            .tags,
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
        case content
        case author
        case excerpt
        case featuredMedia
        case commentStatus
        case pingStatus
        case format
        case sticky
        case template
        case categories
        case tags
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
            case .content:
                return Constants.AllFields.content
            case .author:
                return Constants.AllFields.author
            case .excerpt:
                return Constants.AllFields.excerpt
            case .featuredMedia:
                return Constants.AllFields.featuredMedia
            case .commentStatus:
                return Constants.AllFields.commentStatus
            case .pingStatus:
                return Constants.AllFields.pingStatus
            case .format:
                return Constants.AllFields.format
            case .sticky:
                return Constants.AllFields.sticky
            case .template:
                return Constants.AllFields.template
            case .categories:
                return Constants.AllFields.categories
            case .tags:
                return Constants.AllFields.tags
            case .custom(let field):
                return field
            }
        }
    }
}

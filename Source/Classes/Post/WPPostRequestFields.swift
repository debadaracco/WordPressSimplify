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
                return "id"
            case .date:
                return "date"
            case .dateGmt:
                return "date_gmt"
            case .guid:
                return "guid"
            case .link:
                return "link"
            case .modified:
                return "modified"
            case .modifiedGmt:
                return "modified_gmt"
            case .slug:
                return "slug"
            case .status:
                return "status"
            case .type:
                return "type"
            case .title:
                return "title"
            case .content:
                return "content"
            case .author:
                return "author"
            case .excerpt:
                return "excerpt"
            case .featuredMedia:
                return "featured_media"
            case .commentStatus:
                return "comment_status"
            case .pingStatus:
                return "ping_status"
            case .format:
                return "format"
            case .sticky:
                return "sticky"
            case .template:
                return "template"
            case .categories:
                return "categories"
            case .tags:
                return "tags"
            case .custom(let field):
                return field
            }
        }
    }
}

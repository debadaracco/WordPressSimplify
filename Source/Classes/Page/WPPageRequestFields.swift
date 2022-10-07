//
//  WPPageRequestFields.swift
//  WordPressSimplify
//
//  Created by Diego Badaracco on 07/10/2022.
//

import Foundation

public extension WPRequestField {
    enum PageFields: WPRequestFieldTypeProtocol {
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
        case parent
        case title
        case content
        case author
        case excerpt
        case featuredMedia
        case commentStatus
        case pingStatus
        case menuOrder
        case template
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
            case .parent:
                return "parent"
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
            case .menuOrder:
                return "menu_order"
            case .template:
                return "template"
            case .custom(let field):
                return field
            }
        }
    }
}

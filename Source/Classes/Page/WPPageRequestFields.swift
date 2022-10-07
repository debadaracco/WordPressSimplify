//
//  WPPageRequestFields.swift
//  WordPressSimplify
//
//  Created by Diego Badaracco on 07/10/2022.
//

import Foundation

public extension WPRequestField {
    enum PageFields: String, CaseIterable, WPRequestFieldTypeProtocol {
        case id
        case date
        case dateGmt = "date_gmt"
        case guid
        case link
        case modified
        case modifiedGmt = "modified_gmt"
        case slug
        case status
        case type
        case parent
        case title
        case content
        case author
        case excerpt
        case featuredMedia = "featured_media"
        case commentStatus = "comment_status"
        case pingStatus = "ping_status"
        case menuOrder = "menu_order"
        case template

        var fieldValue: String {
            self.rawValue
        }
    }
}

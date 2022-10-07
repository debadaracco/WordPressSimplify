//
//  WPTagRequestFields.swift
//  WordPressSimplify
//
//  Created by Diego Badaracco on 07/10/2022.
//

import Foundation

public extension WPRequestField {
    enum TagFields: WPRequestFieldTypeProtocol {
        case id
        case count
        case description
        case link
        case name
        case slug
        case taxonomy
        case custom(field: String)

        var fieldValue: String {
            switch self {
            case .id:
                return "id"
            case .count:
                return "count"
            case .description:
                return "description"
            case .link:
                return "link"
            case .name:
                return "name"
            case .slug:
                return "slug"
            case .taxonomy:
                return "taxonomy"
            case .custom(let field):
                return field
            }
        }
    }
}

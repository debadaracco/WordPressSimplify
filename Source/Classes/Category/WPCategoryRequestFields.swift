//
//  WPCategoryRequestFields.swift
//  WordPressSimplify
//
//  Created by Diego Badaracco on 04/10/2022.
//

import Foundation

public extension WPRequestField {
    enum CategoryFields: WPRequestFieldTypeProtocol {
        case id
        case count
        case description
        case link
        case name
        case slug
        case taxonomy
        case parent
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
            case .parent:
                return "parent"
            case .custom(let field):
                return field
            }
        }
    }
}

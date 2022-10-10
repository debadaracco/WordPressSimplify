//
//  WPTagRequestFields.swift
//  WordPressSimplify
//
//  Created by Diego Badaracco on 07/10/2022.
//

import Foundation

public extension WPRequestField {
    enum TagFields: CaseIterable, WPRequestFieldTypeProtocol {
        public static var allCases: [WPRequestField.TagFields] = [
            .id,
            .count,
            .description,
            .link,
            .name,
            .slug,
            .taxonomy,
            .custom(field: "")
        ]

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
                return Constants.AllFields.id
            case .count:
                return Constants.AllFields.count
            case .description:
                return Constants.AllFields.description
            case .link:
                return Constants.AllFields.link
            case .name:
                return Constants.AllFields.name
            case .slug:
                return Constants.AllFields.slug
            case .taxonomy:
                return Constants.AllFields.taxonomy
            case .custom(let field):
                return field
            }
        }
    }
}

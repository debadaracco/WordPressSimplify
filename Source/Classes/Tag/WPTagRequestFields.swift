//
//  WPTagRequestFields.swift
//  WordPressSimplify
//
//  Created by Diego Badaracco on 07/10/2022.
//

import Foundation

public extension WPRequestField {
    enum TagFields: String, CaseIterable, WPRequestFieldTypeProtocol {
        case id
        case count
        case description
        case link
        case name
        case slug
        case taxonomy

        var fieldValue: String {
            self.rawValue
        }
    }
}

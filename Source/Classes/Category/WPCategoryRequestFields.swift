//
//  WPCategoryRequestFields.swift
//  WordPressSimplify
//
//  Created by Diego Badaracco on 04/10/2022.
//

import Foundation

public extension WPRequestField {
    enum CategoryFields: String, CaseIterable, WPRequestFieldTypeProtocol {
        case id
        case count
        case description
        case link
        case name
        case slug
        case taxonomy
        case parent

        var fieldValue: String {
            self.rawValue
        }
    }
}

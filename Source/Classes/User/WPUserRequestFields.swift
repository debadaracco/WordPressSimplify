//
//  WPUserRequestFields.swift
//  WordPressSimplify-iOS
//
//  Created by Diego Badaracco on 23/09/2022.
//

import Foundation

public extension WPRequestField {
    enum UserFields: String, CaseIterable {
        case id
        case username
        case name
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case url
        case description
        case link
        case locale
        case nickname
        case slug
    }
}

extension Array: WPRequestFieldProtocol where Element == WPRequestField.UserFields {
    var valueQueryItem: String {
        return self.map { field in
            field.rawValue
        }.makeQueryItemValue()
    }
}

//
//  WPRequestField.swift
//  WordPressSimplify-iOS
//
//  Created by Diego Badaracco on 23/09/2022.
//

import Foundation

extension Array where Element == WPRequestFieldTypeProtocol {
    var valueQueryItem: String {
        return self.map { field in
            field.fieldValue
        }.makeQueryItemValue()
    }

    func makeQueryItem() -> URLQueryItem? {
        guard !self.valueQueryItem.isEmpty else {
            return nil
        }
        return URLQueryItem(
            name: "_fields",
            value: self.valueQueryItem
        )
    }
}

public enum WPRequestField {}

protocol WPRequestFieldTypeProtocol {
    var fieldValue: String {get}
}

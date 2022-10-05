//
//  WPRequestField.swift
//  WordPressSimplify-iOS
//
//  Created by Diego Badaracco on 23/09/2022.
//

import Foundation

protocol WPRequestFieldProtocol {
    var nameQueryItem: String {get}
    var valueQueryItem: String {get}
    func makeQueryItem() -> URLQueryItem?
}

extension WPRequestFieldProtocol {
    var nameQueryItem: String { return "_fields" }
}

extension WPRequestFieldProtocol {
    func makeQueryItem() -> URLQueryItem? {
        guard !self.valueQueryItem.isEmpty else {
            return nil
        }
        return URLQueryItem(
            name: self.nameQueryItem,
            value: self.valueQueryItem
        )
    }
}

public enum WPRequestField {}

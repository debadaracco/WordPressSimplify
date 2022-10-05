//
//  WPRequestFilter.swift
//  WordPressSimplify-iOS
//
//  Created by Diego Badaracco on 21/09/2022.
//

import Foundation

protocol WPRequestFilterProtocol {
    var nameQueryItem: String {get}
    var valueQueryItem: String {get}
    func makeQueryItem() -> URLQueryItem?
}

extension WPRequestFilterProtocol {
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

extension Array where Element == WPRequestFilterProtocol {
    func makeQueryItems() -> [URLQueryItem] {
        return self.compactMap { filter in
            return filter.makeQueryItem()
        }
    }
}

public enum WPRequestFilter {
    public enum Order: String {
        case asc
        case desc
    }

    public enum Context: String {
        case embed
        case view
    }
}

//
//  WPTagRequestFilters.swift
//  WordPressSimplify
//
//  Created by Diego Badaracco on 07/10/2022.
//

import Foundation

// MARK: - ListTag
public extension WPRequestFilter {
    enum ListTag: WPRequestFilterProtocol {
        public enum OrderBy: String {
            case id
            case include
            case name
            case slug
            case includeSlugs = "include_slugs"
            case termGroup = "term_group"
            case description
            case count
        }

        case context(type: Context)
        case page(number: Int)
        case perPage(number: Int)
        case search(value: String)
        case exclude(ids: [Int])
        case include(ids: [Int])
        case offset(number: Int)
        case order(type: Order)
        case orderBy(type: OrderBy)
        case hideEmpty
        case post(value: Int)
        case slug(slugs: [String])
        case custom(key: String, value: String)

        public var nameQueryItem: String {
            switch self {
            case .context(_ ):
                return Constants.QueryParamNames.context
            case .page(_ ):
                return Constants.QueryParamNames.page
            case .perPage(_ ):
                return Constants.QueryParamNames.perPage
            case .search(_ ):
                return Constants.QueryParamNames.search
            case .exclude(_ ):
                return Constants.QueryParamNames.exclude
            case .include(_ ):
                return Constants.QueryParamNames.include
            case .offset(_ ):
                return Constants.QueryParamNames.offset
            case .hideEmpty:
                return Constants.QueryParamNames.hideEmpty
            case .order(_ ):
                return Constants.QueryParamNames.order
            case .orderBy(_ ):
                return Constants.QueryParamNames.orderBy
            case .slug(_ ):
                return Constants.QueryParamNames.slug
            case .post(_ ):
                return Constants.QueryParamNames.post
            case .custom(let key, _):
                return key
            }
        }

        public var valueQueryItem: String {
            switch self {
            case .context(let type):
                return type.rawValue
            case .page(let number):
                return "\(number)"
            case .perPage(let number):
                return "\(number)"
            case .search(let value):
                return value
            case .exclude(let ids):
                return ids.makeQueryItemValue()
            case .include(let ids):
                return ids.makeQueryItemValue()
            case .hideEmpty:
                return "1"
            case .order(let type):
                return type.rawValue
            case .orderBy(let type):
                return type.rawValue
            case .slug(let slugs):
                return slugs.makeQueryItemValue()
            case .post(let value):
                return "\(value)"
            case .offset(let number):
                return "\(number)"
            case .custom(_, let value):
                return value
            }
        }
    }
}

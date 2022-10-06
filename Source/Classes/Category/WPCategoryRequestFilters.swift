//
//  WPCategoryRequestFilters.swift
//  WordPressSimplify
//
//  Created by Diego Badaracco on 04/10/2022.
//

import Foundation

// MARK: - ListUser
public extension WPRequestFilter {
    enum ListCategory: WPRequestFilterProtocol {
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
        case hideEmpty
        case parent(value: String)
        case post(value: String)
        case order(type: Order)
        case orderBy(type: OrderBy)
        case slug(slugs: [String])

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
            case .parent(_ ):
                return Constants.QueryParamNames.parent
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
                return "true"
            case .order(let type):
                return type.rawValue
            case .orderBy(let type):
                return type.rawValue
            case .slug(let slugs):
                return slugs.makeQueryItemValue()
            case .post(let value):
                return value
            case .parent(let value):
                return value
            }
        }
    }
}

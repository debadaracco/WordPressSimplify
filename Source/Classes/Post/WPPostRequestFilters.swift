//
//  WPPostRequestFilters.swift
//  WordPressSimplify
//
//  Created by Diego Badaracco on 07/10/2022.
//

import Foundation

// MARK: - ListPost
public extension WPRequestFilter {
    enum ListPost: WPRequestFilterProtocol {
        public enum OrderBy: String {
            case author
            case date
            case id
            case include
            case modified
            case parent
            case relevance
            case slug
            case includeSlugs = "include_slugs"
            case title
        }

        public enum WPTaxRelation: String {
            case AND
            case OR
        }

        case context(type: Context)
        case page(number: Int)
        case perPage(number: Int)
        case search(value: String)
        case after(dateISO8601: String)
        case author(id: Int)
        case authorsExclude(ids: [Int])
        case before(dateISO8601: String)
        case exclude(ids: [Int])
        case include(ids: [Int])
        case offset(number: Int)
        case order(type: Order)
        case orderBy(type: OrderBy)
        case slug(slugs: [String])
        case status(value: WPPublishStatus)
        case taxRelation(value: WPTaxRelation)
        case categories(ids: [Int])
        case categoriesExclude(ids: [Int])
        case tags(ids: [Int])
        case tagsExclude(ids: [Int])
        case sticky

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
            case .after(_ ):
                return Constants.QueryParamNames.after
            case .author(_ ):
                return Constants.QueryParamNames.author
            case .authorsExclude(_ ):
                return Constants.QueryParamNames.authorsExclude
            case .before(_ ):
                return Constants.QueryParamNames.before
            case .exclude(_ ):
                return Constants.QueryParamNames.exclude
            case .include(_ ):
                return Constants.QueryParamNames.include
            case .offset(_ ):
                return Constants.QueryParamNames.offset
            case .order(_ ):
                return Constants.QueryParamNames.order
            case .orderBy(_ ):
                return Constants.QueryParamNames.orderBy
            case .slug(_ ):
                return Constants.QueryParamNames.slug
            case .status(_ ):
                return Constants.QueryParamNames.status
            case .taxRelation(_ ):
                return Constants.QueryParamNames.taxRelation
            case .categories(_ ):
                return Constants.QueryParamNames.categories
            case .categoriesExclude(_ ):
                return Constants.QueryParamNames.categoriesExclude
            case .tags(_ ):
                return Constants.QueryParamNames.tags
            case .tagsExclude(_ ):
                return Constants.QueryParamNames.tagsExclude
            case .sticky:
                return Constants.QueryParamNames.sticky
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
            case .order(let type):
                return type.rawValue
            case .orderBy(let type):
                return type.rawValue
            case .slug(let slugs):
                return slugs.makeQueryItemValue()
            case .offset(let number):
                return "\(number)"
            case .after(dateISO8601: let dateISO8601):
                return dateISO8601
            case .author(id: let id):
                return "\(id)"
            case .authorsExclude(ids: let ids):
                return ids.makeQueryItemValue()
            case .before(dateISO8601: let dateISO8601):
                return dateISO8601
            case .status(value: let value):
                return value.rawValue
            case .taxRelation(value: let value):
                return value.rawValue
            case .categories(ids: let ids):
                return ids.makeQueryItemValue()
            case .categoriesExclude(ids: let ids):
                return ids.makeQueryItemValue()
            case .tags(ids: let ids):
                return ids.makeQueryItemValue()
            case .tagsExclude(ids: let ids):
                return ids.makeQueryItemValue()
            case .sticky:
                return "1"
            }
        }
    }
}

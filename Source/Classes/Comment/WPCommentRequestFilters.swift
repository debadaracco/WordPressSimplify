//
//  WPMediaRequestFilters.swift
//  WordPressSimplify
//
//  Created by Diego Badaracco on 09/10/2022.
//

import Foundation

// MARK: - ListComment
public extension WPRequestFilter {
    enum ListComment: WPRequestFilterProtocol {
        public enum OrderBy: String {
            case date
            case dateGmt = "date_gmt"
            case id
            case include
            case post
            case parent
            case type
        }

        case context(type: Context)
        case page(number: Int)
        case perPage(number: Int)
        case search(value: String)
        case after(dateISO8601: String)
        case before(dateISO8601: String)
        case exclude(ids: [Int])
        case include(ids: [Int])
        case offset(number: Int)
        case order(type: Order)
        case orderBy(type: OrderBy)
        case parent(id: Int)
        case parentExclude(ids: [Int])
        case post(id: Int)
        case status(value: WPCommentPostStatus)
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
            case .after(_ ):
                return Constants.QueryParamNames.after
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
            case .status(_ ):
                return Constants.QueryParamNames.status
            case .parent(_ ):
                return Constants.QueryParamNames.parent
            case .parentExclude(_ ):
                return Constants.QueryParamNames.parentExclude
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
            case .order(let type):
                return type.rawValue
            case .orderBy(let type):
                return type.rawValue
            case .offset(let number):
                return "\(number)"
            case .after(dateISO8601: let dateISO8601):
                return dateISO8601
            case .before(dateISO8601: let dateISO8601):
                return dateISO8601
            case .status(value: let value):
                return value.rawValue
            case .custom(_, let value):
                return value
            case .parent(id: let id):
                return "\(id)"
            case .parentExclude(let ids):
                return ids.makeQueryItemValue()
            case .post(let id):
                return "\(id)"
            }
        }
    }
}

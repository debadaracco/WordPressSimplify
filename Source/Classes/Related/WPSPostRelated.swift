//
//  WPSPostRelated.swift
//  
//
//  Created by Diego Badaracco on 15/10/2022.
//

import Foundation

public protocol WPSPostRelatedModel {
    var post: WPPostModel {get}
    var user: WPUserModel? {get}
    var media: (any WPMediaModel)? {get}
    var tags: [WPTagModel]? {get}
    var comments: [WPCommentModel]? {get}
    var categories: [WPCategoryModel]? {get}
}

public struct WPSPostRelated: WPSPostRelatedModel {
    public let post: WPPostModel
    public let user: WPUserModel?
    public let media: (any WPMediaModel)?
    public let tags: [WPTagModel]?
    public let comments: [WPCommentModel]?
    public let categories: [WPCategoryModel]?
}

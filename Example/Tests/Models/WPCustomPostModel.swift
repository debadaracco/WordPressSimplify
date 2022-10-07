//
//  WPCustomPostModel.swift
//  WordPressSimplify_Tests
//
//  Created by Diego Badaracco on 07/10/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import WordPressSimplify

struct WPCustomPostModel: WPPostModel {
    public let id: Int
    public let date: String?
    public let date_gmt: String?
    public let guid: WPGuid?
    public let link: String
    public let modified: String?
    public let modified_gmt: String?
    public let slug: String
    public let status: WPPublishStatus
    public let type: String
    public let title: WPTitle
    public let content: WPContent
    public let author: Int
    public let excerpt: WPExcerpt
    public let featured_media: Int
    public let comment_status: WPCommentStatus
    public let ping_status: WPPingStatus
    public let format: WPPostFormat
    public let sticky: Bool
    public let template: String
    public let categories: [Int]
    public let tags: [Int]
}


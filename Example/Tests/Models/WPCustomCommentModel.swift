//
//  WPCustomCommentModel.swift
//  WordPressSimplify_Tests
//
//  Created by Diego Badaracco on 10/10/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import WordPressSimplify

struct WPCustomCommentModel: WPCommentModel {
    
    
    public let id: Int?
    public let author: Int?
    public let author_email: String?
    public let author_name: String?
    public let author_url: String?
    public let date: String?
    public let date_gmt: String?
    public let content: WPContent?
    public let link: String?
    public let parent: Int?
    public let post: Int?
    public let status: WPCommentPostStatus?
    public let type: String?
    public let author_avatar_urls: WPAvatarURLS?
}

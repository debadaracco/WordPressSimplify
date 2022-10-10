//
//  WPCustomMediaModel.swift
//  WordPressSimplify_Tests
//
//  Created by Diego Badaracco on 09/10/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
@testable import WordPressSimplify

public struct WPCustomMediaModel: WPMediaModel {
    public let id: Int?
    public let date: String?
    public let date_gmt: String?
    public let guid: WPGuid?
    public let link: String?
    public let modified: String?
    public let modified_gmt: String?
    public let slug: String?
    public let status: WPPublishStatus?
    public let type: String?
    public let title: WPTitle?
    public let author: Int?
    public let comment_status: WPCommentStatus?
    public let ping_status: WPPingStatus?
    public let template: String?
    public let alt_text: String?
    public let caption: WPCaption?
    public let description: WPDescription?
    public let media_type: WPMediaType?
    public let mime_type: String?
    public let media_details: WPMediaDetail?
    public let post: Int?
    public let source_url: String?
}

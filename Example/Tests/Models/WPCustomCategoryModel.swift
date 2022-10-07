//
//  WPCustomCategoryModel.swift
//  WordPressSimplify_Tests
//
//  Created by Diego Badaracco on 07/10/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation

import Foundation
import WordPressSimplify

struct WPCustomCategoryModel: WPCategoryModel {
    public let id: Int?
    public let count: Int?
    public let description: String?
    public let link: String?
    public let name: String?
    public let slug: String?
    public let taxonomy: String?
    public let parent: Int?
}

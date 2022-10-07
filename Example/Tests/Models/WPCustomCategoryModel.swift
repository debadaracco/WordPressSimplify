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
    let id: Int
    let count: Int
    let description: String
    let link: String
    let name: String
    let slug: String
    let taxonomy: String
    let parent: Int
}

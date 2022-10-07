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
    var id: Int
    var count: Int
    var description: String
    var link: String
    var name: String
    var slug: String
    var taxonomy: String
    var parent: Int
}

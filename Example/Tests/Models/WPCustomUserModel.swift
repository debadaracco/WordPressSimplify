//
//  WPCustomUserModel.swift
//  WordPressSimplifyTests-iOS
//
//  Created by Diego Badaracco on 25/09/2022.
//

import Foundation
import WordPressSimplify

struct WPCustomUserModel: WPUserModel {
    let id: Int?
    let username: String?
    let name: String
    let first_name: String?
    let last_name: String?
    let email: String?
    let url: String?
    let description: String?
    let link: String?
    let locale: String?
    let nickname: String?
    let slug: String?
}

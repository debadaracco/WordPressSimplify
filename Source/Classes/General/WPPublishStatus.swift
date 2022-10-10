//
//  WPPublishStatus.swift
//  WordPressSimplify
//
//  Created by Diego Badaracco on 07/10/2022.
//

import Foundation

public enum WPPublishStatus: String, Codable {
    case publish
    case future
    case draft
    case pending
    case ´private´ = "private"
    case inherit
}

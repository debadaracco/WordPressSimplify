//
//  WPAvatars.swift
//  WordPressSimplify
//
//  Created by Diego Badaracco on 10/10/2022.
//

import Foundation

public typealias WPAvatarURLS = [String: String]

public enum WPAvatarSizes: String, Codable {
    case ´24´ = "24"
    case ´48´ = "48"
    case ´96´ = "96"
    case ´128´ = "128"
}

public protocol WPAvatarProtocol {
    func avatarUrl(by size: WPAvatarSizes) -> String?
}

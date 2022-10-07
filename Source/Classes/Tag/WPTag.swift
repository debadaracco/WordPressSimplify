//
//  WPTag.swift
//  WordPressSimplify
//
//  Created by Diego Badaracco on 07/10/2022.
//

import Foundation

public protocol WPTagModel: Codable {
    var id: Int {get}
    var count: Int {get}
    var description: String {get}
    var link: String {get}
    var name: String {get}
    var slug: String {get}
    var taxonomy: String {get}
}

public struct WPTag: WPTagModel {
    public let id: Int
    public let count: Int
    public let description: String
    public let link: String
    public let name: String
    public let slug: String
    public let taxonomy: String
}

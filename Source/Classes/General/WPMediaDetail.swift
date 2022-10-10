//
//  WPMediaDetail.swift
//  WordPressSimplify
//
//  Created by Diego Badaracco on 09/10/2022.
//

import Foundation

public protocol WPMediaDetailProtocol: Codable {
    associatedtype MediaDetailSizes
    var width: Int? {get}
    var height: Int? {get}
    var file: String? {get}
    var filesize: Int? {get}
    var sizes: MediaDetailSizes? {get}
}

public struct WPMediaDetail: WPMediaDetailProtocol {
    public struct Sizes: Codable {
        public let featsmall: SizeData?
        public let full: SizeData?
        public let medium: SizeData?
        public let medium_large: SizeData?
        public let thumbnail: SizeData?
    }

    public struct SizeData: Codable {
        public let width: Int?
        public let height: Int?
        public let file: String?
        public let filesize: Int?
        public let mime_type: String?
        public let source_url: String?
    }

    public typealias MediaDetailSizes = Sizes

    public let width: Int?
    public let height: Int?
    public let file: String?
    public let filesize: Int?
    public let sizes: Sizes?
}

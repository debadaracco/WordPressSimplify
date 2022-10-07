//
//  WPTagRepository.swift
//  WordPressSimplify
//
//  Created by Diego Badaracco on 07/10/2022.
//

import Foundation

protocol WPTagRepositoryProtocol {
    func fetch<T: WPTagModel> (
        filters: [WPRequestFilter.ListTag],
        fields: [WPRequestField.TagFields],
        completion: @escaping (Result<[T], Error>) -> Void
    )

    func fetch<T: WPTagModel> (
        id: Int,
        fields: [WPRequestField.TagFields],
        completion: @escaping (Result<T, Error>) -> Void
    )
}

class WPTagRepository: WPTagRepositoryProtocol {
    private let path = "/wp-json/wp/v2/tags"
    private let networking: WPNetworkingProtocol

    init(networking: WPNetworkingProtocol) {
        self.networking = networking
    }

    func fetch<T: WPTagModel> (
        filters: [WPRequestFilter.ListTag],
        fields: [WPRequestField.TagFields],
        completion: @escaping (Result<[T], Error>) -> Void
    ) {
        self.networking.get(
            path: self.path,
            filters: filters,
            fields: fields,
            completion: completion
        )
    }

    func fetch<T: WPTagModel> (
        id: Int,
        fields: [WPRequestField.TagFields],
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        self.networking.get(
            path: "\(self.path)/\(id)",
            filters: [],
            fields: fields,
            completion: completion
        )
    }
}

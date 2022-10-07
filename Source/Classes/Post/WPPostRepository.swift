//
//  WPPostRepository.swift
//  WordPressSimplify
//
//  Created by Diego Badaracco on 07/10/2022.
//

import Foundation

protocol WPPostRepositoryProtocol {
    func fetch<T: WPPostModel> (
        filters: [WPRequestFilter.ListPost],
        fields: [WPRequestField.PostFields],
        completion: @escaping (Result<[T], Error>) -> Void
    )

    func fetch<T: WPPostModel> (
        id: Int,
        fields: [WPRequestField.PostFields],
        completion: @escaping (Result<T, Error>) -> Void
    )
}

class WPPostRepository: WPPostRepositoryProtocol {
    private let path = "/wp-json/wp/v2/posts"
    private let networking: WPNetworkingProtocol

    init(networking: WPNetworkingProtocol) {
        self.networking = networking
    }

    func fetch<T: WPPostModel> (
        filters: [WPRequestFilter.ListPost],
        fields: [WPRequestField.PostFields],
        completion: @escaping (Result<[T], Error>) -> Void
    ) {
        self.networking.get(
            path: self.path,
            filters: filters,
            fields: fields,
            completion: completion
        )
    }

    func fetch<T: WPPostModel> (
        id: Int,
        fields: [WPRequestField.PostFields],
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

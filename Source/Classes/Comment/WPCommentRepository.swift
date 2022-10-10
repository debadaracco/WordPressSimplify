//
//  WPMediaRepository.swift
//  WordPressSimplify
//
//  Created by Diego Badaracco on 09/10/2022.
//

import Foundation

protocol WPCommentRepositoryProtocol {
    func fetch<T: WPCommentModel> (
        filters: [WPRequestFilter.ListComment],
        fields: [WPRequestField.CommentFields],
        completion: @escaping (Result<[T], Error>) -> Void
    )

    func fetch<T: WPCommentModel> (
        id: Int,
        fields: [WPRequestField.CommentFields],
        completion: @escaping (Result<T, Error>) -> Void
    )
}

class WPCommentRepository: WPCommentRepositoryProtocol {
    private let path = "/wp-json/wp/v2/comments"
    private let networking: WPNetworkingProtocol

    init(networking: WPNetworkingProtocol) {
        self.networking = networking
    }

    func fetch<T: WPCommentModel> (
        filters: [WPRequestFilter.ListComment],
        fields: [WPRequestField.CommentFields],
        completion: @escaping (Result<[T], Error>) -> Void
    ) {
        self.networking.get(
            path: self.path,
            filters: filters,
            fields: fields,
            completion: completion
        )
    }

    func fetch<T: WPCommentModel> (
        id: Int,
        fields: [WPRequestField.CommentFields],
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

//
//  WPUserRepository.swift
//  WordPressSimplify-iOS
//
//  Created by Diego Badaracco on 20/09/2022.
//

import Foundation

protocol WPUserRepositoryProtocol {
    func fetch<T: WPUserModel> (
        filters: [WPRequestFilter.ListUser],
        fields: [WPRequestField.UserFields],
        completion: @escaping (Result<[T], Error>) -> Void
    )

    func fetch<T: WPUserModel> (
        id: Int,
        fields: [WPRequestField.UserFields],
        completion: @escaping (Result<T, Error>) -> Void
    )
}

class WPUserRepository: WPUserRepositoryProtocol {
    private let path = "/wp-json/wp/v2/users"
    private let networking: WPNetworkingProtocol

    init(networking: WPNetworkingProtocol) {
        self.networking = networking
    }

    func fetch<T: WPUserModel>(
        filters: [WPRequestFilter.ListUser],
        fields: [WPRequestField.UserFields],
        completion: @escaping (Result<[T], Error>) -> Void
    ) {
        self.networking.get(
            path: self.path,
            filters: filters,
            fields: fields,
            completion: completion
        )
    }

    func fetch<T: WPUserModel>(
        id: Int,
        fields: [WPRequestField.UserFields],
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

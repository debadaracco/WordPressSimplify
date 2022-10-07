//
//  WPPageRepository.swift
//  WordPressSimplify
//
//  Created by Diego Badaracco on 07/10/2022.
//

import Foundation

protocol WPPageRepositoryProtocol {
    func fetch<T: WPPageModel> (
        filters: [WPRequestFilter.ListPage],
        fields: [WPRequestField.PageFields],
        completion: @escaping (Result<[T], Error>) -> Void
    )

    func fetch<T: WPPageModel> (
        id: Int,
        fields: [WPRequestField.PageFields],
        completion: @escaping (Result<T, Error>) -> Void
    )
}

class WPPageRepository: WPPageRepositoryProtocol {
    private let path = "/wp-json/wp/v2/pages"
    private let networking: WPNetworkingProtocol

    init(networking: WPNetworkingProtocol) {
        self.networking = networking
    }

    func fetch<T: WPPageModel> (
        filters: [WPRequestFilter.ListPage],
        fields: [WPRequestField.PageFields],
        completion: @escaping (Result<[T], Error>) -> Void
    ) {
        self.networking.get(
            path: self.path,
            filters: filters,
            fields: fields,
            completion: completion
        )
    }

    func fetch<T: WPPageModel> (
        id: Int,
        fields: [WPRequestField.PageFields],
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

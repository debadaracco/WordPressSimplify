//
//  WPCategoryRepository.swift
//  WordPressSimplify
//
//  Created by Diego Badaracco on 04/10/2022.
//

import Foundation

protocol WPCategoryRepositoryProtocol {
    func fetch<T: WPCategoryModel> (
        filters: [WPRequestFilter.ListCategory],
        fields: [WPRequestField.CategoryFields],
        completion: @escaping (Result<[T], Error>) -> Void
    )

    func fetch<T: WPCategoryModel> (
        id: Int,
        fields: [WPRequestField.CategoryFields],
        completion: @escaping (Result<T, Error>) -> Void
    )
}

class WPCategoryRepository: WPCategoryRepositoryProtocol {
    private let path = "/wp-json/wp/v2/categories"
    private let networking: WPNetworkingProtocol

    init(networking: WPNetworkingProtocol) {
        self.networking = networking
    }

    func fetch<T: WPCategoryModel>(
        filters: [WPRequestFilter.ListCategory],
        fields: [WPRequestField.CategoryFields],
        completion: @escaping (Result<[T], Error>) -> Void
    ) {
        self.networking.get(
            path: self.path,
            filters: filters,
            fields: fields,
            completion: completion
        )
    }

    func fetch<T: WPCategoryModel>(
        id: Int,
        fields: [WPRequestField.CategoryFields],
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

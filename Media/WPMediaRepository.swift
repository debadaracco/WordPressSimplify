//
//  WPMediaRepository.swift
//  WordPressSimplify
//
//  Created by Diego Badaracco on 09/10/2022.
//

import Foundation

protocol WPMediaRepositoryProtocol {
    func fetch<T: WPMediaModel> (
        filters: [WPRequestFilter.ListMedia],
        fields: [WPRequestField.MediaFields],
        completion: @escaping (Result<[T], Error>) -> Void
    )
    
    func fetch<T: WPMediaModel> (
        id: Int,
        fields: [WPRequestField.MediaFields],
        completion: @escaping (Result<T, Error>) -> Void
    )
}

class WPMediaRepository: WPMediaRepositoryProtocol {
    private let path = "/wp-json/wp/v2/media"
    private let networking: WPNetworkingProtocol
    
    init(networking: WPNetworkingProtocol) {
        self.networking = networking
    }
    
    func fetch<T: WPMediaModel> (
        filters: [WPRequestFilter.ListMedia],
        fields: [WPRequestField.MediaFields],
        completion: @escaping (Result<[T], Error>) -> Void
    ) {
        self.networking.get(
            path: self.path,
            filters: filters,
            fields: fields,
            completion: completion
        )
    }
    
    func fetch<T: WPMediaModel> (
        id: Int,
        fields: [WPRequestField.MediaFields],
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

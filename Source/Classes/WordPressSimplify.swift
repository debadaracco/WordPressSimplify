//
//  WordPressSimplify.swift
//  WordPressSimplify-iOS
//
//  Created by Diego Badaracco on 21/09/2022.
//

import Foundation

public class WordPressSimplify {
    fileprivate let wpUserRepository: WPUserRepositoryProtocol

    public init(
        baseURL: String,
        networkingClientStrategy: WPNetworkingClientStrategy? = nil
    ) {
        let networking = WPNetworking(
            baseURL: baseURL,
            clientStrategy: networkingClientStrategy ?? WPDefaultNetworkingClient()
        )
        self.wpUserRepository = WPUserRepository(networking: networking)
    }

    public func fetchUsers<T: WPUserModel> (
        filters: [WPRequestFilter.ListUser] = [WPRequestFilter.ListUser](),
        fields: [WPRequestField.UserFields] = [WPRequestField.UserFields](),
        completion: @escaping (Result<[T], Error>) -> Void
    ) {
        self.wpUserRepository.fetch(
            filters: filters,
            fields: fields,
            completion: completion
        )
    }

    public func fetchUser<T: WPUserModel>(
        id: Int,
        fields: [WPRequestField.UserFields] = [WPRequestField.UserFields](),
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        self.wpUserRepository.fetch(id: id, fields: fields, completion: completion)
    }
}

extension WordPressSimplify {
    public func fetchUsers(
        filters: [WPRequestFilter.ListUser] = [WPRequestFilter.ListUser](),
        fields: [WPRequestField.UserFields] = [WPRequestField.UserFields](),
        completion: @escaping (Result<[WPUser], Error>) -> Void
    ) {
        self.wpUserRepository.fetch(
            filters: filters,
            fields: fields,
            completion: completion
        )
    }

    public func fetchUser(
        id: Int,
        fields: [WPRequestField.UserFields] = [WPRequestField.UserFields](),
        completion: @escaping (Result<WPUser, Error>) -> Void
    ) {
        self.wpUserRepository.fetch(id: id, fields: fields, completion: completion)
    }
}

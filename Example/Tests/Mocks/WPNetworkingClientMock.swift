//
//  WPNetworkingClientMock.swift
//  WordPressSimplifyTests-iOS
//
//  Created by Diego Badaracco on 23/09/2022.
//

import Foundation
@testable import WordPressSimplify

class WPNetworkingClientMock: WPNetworkingClientStrategy {
    enum WPNetworkingClientError: Error {
        case anError
    }

    let localPath: String

    init(localPath: String) {
        self.localPath = localPath
    }

    func get(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = Bundle(
            for: WPNetworkingClientMock.self
        ).url(
            forResource: self.localPath,
            withExtension: "json"
        ) else {
            completion(.failure(WPNetworkingClientError.anError))
            return
        }

        do {
            let data = try Data(contentsOf: url)
            completion(.success(data))
        } catch let error {
            completion(.failure(error))
        }
    }
}

//
//  WPNetworking.swift
//  WordPressSimplify-iOS
//
//  Created by Diego Badaracco on 20/09/2022.
//
import Foundation

public protocol WPNetworkingClientStrategy {
    func get(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void)
}

class WPDefaultNetworkingClient: WPNetworkingClientStrategy {
    private var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession.init(configuration: configuration)
        return session
    }()

    func get(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        let dataTask = self.session.dataTask(with: request) { data, _, error in
            guard let resultData = data else {
                guard let error = error else {
                    return
                }
                completion(.failure(error))
                return
            }
            completion(.success(resultData))
        }
        dataTask.resume()
    }
}

protocol WPNetworkingProtocol {
    func get<T: Decodable>(
        path: String,
        filters: [WPRequestFilterProtocol],
        fields: [WPRequestFieldTypeProtocol],
        completion: @escaping (Result<T, Error>) -> Void
    )
}

class WPNetworking: WPNetworkingProtocol {
    private let clientStrategy: WPNetworkingClientStrategy
    private let baseURL: String

    init(
        baseURL: String,
        clientStrategy: WPNetworkingClientStrategy = WPDefaultNetworkingClient()
    ) {
        self.baseURL = baseURL
        self.clientStrategy = clientStrategy
    }

    func get<T: Decodable>(
        path: String,
        filters: [WPRequestFilterProtocol],
        fields: [WPRequestFieldTypeProtocol],
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        var urlComponents = URLComponents(string: "\(self.baseURL)\(path)")!

        var queryItems = filters.makeQueryItems()
        if let fieldsQueryItems = fields.makeQueryItem() {
            queryItems.append(fieldsQueryItems)
        }

        urlComponents.queryItems = queryItems

        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"

        self.clientStrategy.get(request: request) { result in
            switch result {
            case .success(let data):
                do {
                    let jsonDecoder = JSONDecoder()
                    let dataParsed = try jsonDecoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(dataParsed))
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}

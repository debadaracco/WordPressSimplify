//
//  AlamofireNetworking.swift
//  WordPressSimplify_Example
//
//  Created by Diego Badaracco on 07/10/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Alamofire
import WordPressSimplify

class AlamofireWPNetworkingImp: WPNetworkingClientStrategy {
    enum CustomErrorAlamofire: Error {
    case data
    }
    func get(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        AF.request(request).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else {
                    completion(.failure(CustomErrorAlamofire.data))
                    return
                }
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

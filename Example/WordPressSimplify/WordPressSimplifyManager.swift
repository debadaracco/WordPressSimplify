//
//  WordPressSimplifyManager.swift
//  WordPressSimplify_Example
//
//  Created by Diego Badaracco on 15/10/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import WordPressSimplify

enum WPType: String, CaseIterable {
    case categories
    case comments
    case media
    case pages
    case posts
    case tags
    case users
}

class WordPressSimplifyManager {
    enum RestClients: String, CaseIterable {
        case alamofire
        case ´default´
        
        var wpNetworkingClientStrategy: WPNetworkingClientStrategy? {
            switch self {
            case .´default´:
                return nil
            case .alamofire:
                return AlamofireWPNetworkingImp()
            }
        }
        
    }

    var baseURL: String!
    
    var restClient: RestClients = .´default´ {
        didSet {
            self.wordpressSimplify = WordPressSimplify(
                baseURL: self.baseURL,
                networkingClientStrategy: self.restClient.wpNetworkingClientStrategy
            )
        }
    }
    private(set) var wordpressSimplify: WordPressSimplify!
    
    static let shared = WordPressSimplifyManager()
    
    private init() {}
    
}


protocol ContentListeable {
    var listeableTitle: String {get}
    var imageURL: URL? {get}
}

extension ContentListeable {
    var imageURL: URL? { return nil }
}

extension WPUser: ContentListeable {
    var listeableTitle: String {
        return self.name
    }
}

extension WPCategory: ContentListeable {
    var listeableTitle: String {
        return self.name ?? ""
    }
}

extension WPTag: ContentListeable {
    var listeableTitle: String {
        return self.name ?? ""
    }
}

extension WPPost: ContentListeable {
    var listeableTitle: String {
        return self.title?.rendered ?? ""
    }
}

extension WPPage: ContentListeable {
    var listeableTitle: String {
        return self.title?.rendered ?? ""
    }
}

extension WPMedia: ContentListeable {
    var listeableTitle: String {
        return self.title?.rendered ?? ""
    }
    
    var imageURL: URL? {
        guard let source_url = self.source_url else {
            return nil
        }
        
        return URL(string: source_url)
    }
}
extension WPComment: ContentListeable {
    var listeableTitle: String {
        return self.content?.rendered ?? ""
    }
}

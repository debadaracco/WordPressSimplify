//
//  WordPressSimplifyTests_Posts.swift
//  WordPressSimplify_Tests
//
//  Created by Diego Badaracco on 10/10/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import XCTest
@testable import WordPressSimplify

final class WordPressSimplifyTests_Posts: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Posts
    func testWPS_PostRepository_AllPosts_With_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch post")
        var error: Error?
        wps.fetchPosts(filters: [], fields: []) { result in
            switch result {
            case .failure(let resulterror):
                error = resulterror
            default:
                break
            }
            
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0)
        
        let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
        
        XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
    }
    
    func testWPS_PostRepository_AllPosts_With_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_posts_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch posts")
        var posts = [WPPost]()
        wps.fetchPosts(filters: [], fields: []) { (result: Result<[WPPost], Error>) in
            switch result {
            case .failure(_ ):
                break
            case .success(let resultposts):
                posts = resultposts
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0)
        
        XCTAssertEqual(posts.count, 4)
        for (idx, post) in posts.enumerated() {
            XCTAssertEqual(post.id, idx + 1)
            XCTAssertNotNil(post.date)
            XCTAssertNotNil(post.date_gmt)
            XCTAssertNotNil(post.guid?.rendered)
            XCTAssertEqual(post.link, "https://site.com/test_\(idx + 1)/")
            XCTAssertNotNil(post.modified)
            XCTAssertNotNil(post.modified_gmt)
            XCTAssertEqual(post.slug, "test_\(idx + 1)")
            XCTAssertEqual(post.status, .publish)
            XCTAssertEqual(post.type, "post")
            XCTAssertNotNil(post.title?.rendered)
            XCTAssertNotNil(post.content?.rendered)
            XCTAssertEqual(post.author, 1)
            XCTAssertNotNil(post.excerpt?.rendered)
            XCTAssertEqual(post.featured_media, 1)
            XCTAssertEqual(post.comment_status, .open)
            XCTAssertEqual(post.ping_status, .closed)
            XCTAssertEqual(post.format, .standard)
            XCTAssertTrue(post.sticky == false)
            XCTAssertEqual(post.template, "")
            XCTAssertEqual(post.categories?.count, 1)
            XCTAssertEqual(post.tags?.count, 1)
        }
    }
    
    func testWPS_PostRepository_SpecificPost_With_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        let exp = expectation(description: "fetch post")
        var error: Error?
        wps.fetchPost(id: 1, fields: []) { result in
            switch result {
            case .failure(let resulterror):
                error = resulterror
            default:
                break
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0)
        
        let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
        
        XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
    }
    
    func testWPS_PostRepository_SpecificPost_With_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_post_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        let exp = expectation(description: "fetch post")
        var post: WPPost!
        wps.fetchPost(id: 1, fields: []) { (result: Result<WPPost, Error>) in
            switch result {
            case .failure(_ ):
                break
            case .success(let resultpost):
                post = resultpost
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0)
        
        XCTAssertEqual(post.id, 1)
        XCTAssertNotNil(post.date)
        XCTAssertNotNil(post.date_gmt)
        XCTAssertNotNil(post.guid?.rendered)
        XCTAssertEqual(post.link, "https://site.com/test_1/")
        XCTAssertNotNil(post.modified)
        XCTAssertNotNil(post.modified_gmt)
        XCTAssertEqual(post.slug, "test_1")
        XCTAssertEqual(post.status, .publish)
        XCTAssertEqual(post.type, "post")
        XCTAssertNotNil(post.title?.rendered)
        XCTAssertNotNil(post.content?.rendered)
        XCTAssertEqual(post.author, 1)
        XCTAssertNotNil(post.excerpt?.rendered)
        XCTAssertEqual(post.featured_media, 1)
        XCTAssertEqual(post.comment_status, .open)
        XCTAssertEqual(post.ping_status, .closed)
        XCTAssertEqual(post.format, .standard)
        XCTAssertTrue(post.sticky == false)
        XCTAssertEqual(post.template, "")
        XCTAssertEqual(post.categories?.count, 1)
        XCTAssertEqual(post.tags?.count, 1)
    }
    
    func testWPS_PostRepository_AllPosts_WithCustomModel_And_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        let exp = expectation(description: "fetch posts")
        var error: Error?
        wps.fetchPosts(filters: [], fields: []) { (result: Result<[WPCustomPostModel], Error>) in
            switch result {
            case .failure(let resulterror):
                error = resulterror
            default:
                break
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0)
        
        let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
        
        XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
    }
    
    func testWPS_PostRepository_AllPosts_WithCustomModel_And_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_posts_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch posts")
        var posts = [WPCustomPostModel]()
        wps.fetchPosts(filters: [], fields: []) { (result: Result<[WPCustomPostModel], Error>) in
            switch result {
            case .failure(_ ):
                break
            case .success(let resultposts):
                posts = resultposts
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0)
        
        XCTAssertEqual(posts.count, 4)
        for (idx, post) in posts.enumerated() {
            XCTAssertEqual(post.id, idx + 1)
            XCTAssertNotNil(post.date)
            XCTAssertNotNil(post.date_gmt)
            XCTAssertNotNil(post.guid?.rendered)
            XCTAssertEqual(post.link, "https://site.com/test_\(idx + 1)/")
            XCTAssertNotNil(post.modified)
            XCTAssertNotNil(post.modified_gmt)
            XCTAssertEqual(post.slug, "test_\(idx + 1)")
            XCTAssertEqual(post.status, .publish)
            XCTAssertEqual(post.type, "post")
            XCTAssertNotNil(post.title?.rendered)
            XCTAssertNotNil(post.content?.rendered)
            XCTAssertEqual(post.author, 1)
            XCTAssertNotNil(post.excerpt?.rendered)
            XCTAssertEqual(post.featured_media, 1)
            XCTAssertEqual(post.comment_status, .open)
            XCTAssertEqual(post.ping_status, .closed)
            XCTAssertEqual(post.format, .standard)
            XCTAssertTrue(post.sticky == false)
            XCTAssertEqual(post.template, "")
            XCTAssertEqual(post.categories?.count, 1)
            XCTAssertEqual(post.tags?.count, 1)
        }
    }
    
    func testWPS_PostRepository_UserPost_WithCustomModel_And_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch post")
        var error: Error?
        
        wps.fetchPost(id: 1, fields: []) { (result: Result<WPCustomPostModel, Error>) in
            switch result {
            case .failure(let resulterror):
                error = resulterror
            default:
                break
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0)
        
        let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
        
        XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
    }
    
    func testWPS_PostRepository_UserPost_WithCustomModel_And_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_post_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch post")
        var post: WPCustomPostModel!
        wps.fetchPost(id: 1, fields: []) { (result: Result<WPCustomPostModel, Error>) in
            switch result {
            case .failure(_ ):
                break
            case .success(let resultpost):
                post = resultpost
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0)
        
        XCTAssertEqual(post.id, 1)
        XCTAssertNotNil(post.date)
        XCTAssertNotNil(post.date_gmt)
        XCTAssertNotNil(post.guid?.rendered)
        XCTAssertEqual(post.link, "https://site.com/test_1/")
        XCTAssertNotNil(post.modified)
        XCTAssertNotNil(post.modified_gmt)
        XCTAssertEqual(post.slug, "test_1")
        XCTAssertEqual(post.status, .publish)
        XCTAssertEqual(post.type, "post")
        XCTAssertNotNil(post.title?.rendered)
        XCTAssertNotNil(post.content?.rendered)
        XCTAssertEqual(post.author, 1)
        XCTAssertNotNil(post.excerpt?.rendered)
        XCTAssertEqual(post.featured_media, 1)
        XCTAssertEqual(post.comment_status, .open)
        XCTAssertEqual(post.ping_status, .closed)
        XCTAssertEqual(post.format, .standard)
        XCTAssertTrue(post.sticky == false)
        XCTAssertEqual(post.template, "")
        XCTAssertEqual(post.categories?.count, 1)
        XCTAssertEqual(post.tags?.count, 1)
    }

}

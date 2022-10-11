//
//  WordPressSimplifyTests_Comments.swift
//  WordPressSimplify_Tests
//
//  Created by Diego Badaracco on 10/10/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import XCTest
@testable import WordPressSimplify

final class WordPressSimplifyTests_Comments: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Comment
    func testWPS_CommentRepository_AllComments_With_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        let exp = expectation(description: "fetch comments")
        var error: Error?
        wps.fetchComments(filters: [], fields: []) { result in
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
    
    func testWPS_CommentRepository_AllComments_With_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_comments_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        let exp = expectation(description: "Loading comments")
        
        var comments = [WPComment]()
        
        wps.fetchComments(filters: [], fields: []) { (result: Result<[WPComment], Error>) in
            switch result {
            case .failure(_ ):
                break
            case .success(let resultComments):
                comments = resultComments
                
            }
            
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0)
        
        XCTAssertEqual(comments.count, 2)
        for (idx, comment) in comments.enumerated() {
            XCTAssertEqual(comment.id, idx + 1)
            XCTAssertEqual(comment.author, idx + 1)
            XCTAssertEqual(comment.author_name, "test-\(idx + 1)")
            XCTAssertEqual(comment.author_url, "https://sitio.com/test-\(idx + 1)")
            XCTAssertNotNil(comment.date)
            XCTAssertNotNil(comment.date_gmt)
            XCTAssertNotNil(comment.content?.rendered)
            XCTAssertEqual(comment.link, "https://sitio.com/test-\(idx + 1)")
            XCTAssertEqual(comment.parent, idx + 1)
            XCTAssertEqual(comment.post, idx + 1)
            XCTAssertEqual(comment.status, .approved)
            XCTAssertEqual(comment.type, "comment")
            XCTAssertNotNil(comment.author_avatar_urls)
            XCTAssertNotNil(comment.avatarUrl(by: .´24´))
            XCTAssertNotNil(comment.avatarUrl(by: .´48´))
            XCTAssertNotNil(comment.avatarUrl(by: .´96´))
            XCTAssertNotNil(comment.avatarUrl(by: .´128´))
        }
    }
    
    func testWPS_CommentRepository_SpecificComment_With_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch comment")
        
        var error: Error?
        wps.fetchComment(id: 1, fields: []) { result in
            switch result {
            case .failure(let resultError):
                error = resultError
            default:
                break
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 3.0)
        
        let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
        
        XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
    }
    
    func testWPS_CommentRepository_SpecificComment_With_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_comment_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch comment")
        
        var comment: WPComment!
        
        wps.fetchComment(id: 1, fields: []) { (result: Result<WPComment, Error>) in
            switch result {
            case .failure(_ ):
                break
            case .success(let resultcomment):
                comment = resultcomment
            }
            
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0)
        
        XCTAssertEqual(comment.id, 1)
        XCTAssertEqual(comment.author, 1)
        XCTAssertEqual(comment.author_name, "test-1")
        XCTAssertEqual(comment.author_url, "https://sitio.com/test_1/")
        XCTAssertNotNil(comment.date)
        XCTAssertNotNil(comment.date_gmt)
        XCTAssertNotNil(comment.content?.rendered)
        XCTAssertEqual(comment.link, "https://sitio.com/test-1")
        XCTAssertEqual(comment.parent, 1)
        XCTAssertEqual(comment.post, 1)
        XCTAssertEqual(comment.status, .approved)
        XCTAssertEqual(comment.type, "comment")
        XCTAssertNotNil(comment.author_avatar_urls)
        XCTAssertNotNil(comment.avatarUrl(by: .´24´))
        XCTAssertNotNil(comment.avatarUrl(by: .´48´))
        XCTAssertNotNil(comment.avatarUrl(by: .´96´))
        XCTAssertNotNil(comment.avatarUrl(by: .´128´))
    }
    
    func testWPS_CommentRepository_AllComments_WithCustomModel_And_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch comments")
        
        var error: Error?
        
        wps.fetchComments(filters: [], fields: []) { (result: Result<[WPCustomCommentModel], Error>) in
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
    
    func testWPS_CommentRepository_AllComments_WithCustomModel_And_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_comments_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch comments")
        
        var comments = [WPCustomCommentModel]()
        wps.fetchComments(filters: [], fields: []) { (result: Result<[WPCustomCommentModel], Error>) in
            switch result {
            case .failure(_ ):
                break
            case .success(let resultcomments):
                comments = resultcomments
            }
            
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0)

        XCTAssertEqual(comments.count, 2)
        for (idx, comment) in comments.enumerated() {
            XCTAssertEqual(comment.id, idx + 1)
            XCTAssertEqual(comment.author, idx + 1)
            XCTAssertEqual(comment.author_name, "test-\(idx + 1)")
            XCTAssertEqual(comment.author_url, "https://sitio.com/test-\(idx + 1)")
            XCTAssertNotNil(comment.date)
            XCTAssertNotNil(comment.date_gmt)
            XCTAssertNotNil(comment.content?.rendered)
            XCTAssertEqual(comment.link, "https://sitio.com/test-\(idx + 1)")
            XCTAssertEqual(comment.parent, idx + 1)
            XCTAssertEqual(comment.post, idx + 1)
            XCTAssertEqual(comment.status, .approved)
            XCTAssertEqual(comment.type, "comment")
            XCTAssertNotNil(comment.author_avatar_urls)
            XCTAssertNotNil(comment.avatarUrl(by: .´24´))
            XCTAssertNotNil(comment.avatarUrl(by: .´48´))
            XCTAssertNotNil(comment.avatarUrl(by: .´96´))
            XCTAssertNotNil(comment.avatarUrl(by: .´128´))
        }
    }
    
    func testWPS_CommentRepository_UserComment_WithCustomModel_And_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch comment")
        
        var error: Error?
        
        wps.fetchComment(id: 1, fields: []) { (result: Result<WPCustomCommentModel, Error>) in
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
    
    func testWPS_CommentRepository_UserComment_WithCustomModel_And_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_comment_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch comment")
        
        var comment: WPCustomCommentModel!
        
        wps.fetchComment(id: 1, fields: []) { (result: Result<WPCustomCommentModel, Error>) in
            switch result {
            case .failure(_ ):
                break
            case .success(let resultcomment):
                comment = resultcomment
            }
            
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0)
        
        XCTAssertEqual(comment.id, 1)
        XCTAssertEqual(comment.author, 1)
        XCTAssertEqual(comment.author_name, "test-1")
        XCTAssertEqual(comment.author_url, "https://sitio.com/test_1/")
        XCTAssertNotNil(comment.date)
        XCTAssertNotNil(comment.date_gmt)
        XCTAssertNotNil(comment.content?.rendered)
        XCTAssertEqual(comment.link, "https://sitio.com/test-1")
        XCTAssertEqual(comment.parent, 1)
        XCTAssertEqual(comment.post, 1)
        XCTAssertEqual(comment.status, .approved)
        XCTAssertEqual(comment.type, "comment")
        XCTAssertNotNil(comment.author_avatar_urls)
        XCTAssertNotNil(comment.avatarUrl(by: .´24´))
        XCTAssertNotNil(comment.avatarUrl(by: .´48´))
        XCTAssertNotNil(comment.avatarUrl(by: .´96´))
        XCTAssertNotNil(comment.avatarUrl(by: .´128´))
    }

}

//
//  WordPressSimplifyTests_Media.swift
//  WordPressSimplify_Tests
//
//  Created by Diego Badaracco on 10/10/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import XCTest
@testable import WordPressSimplify

final class WordPressSimplifyTests_Media: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Media
    func testWPS_MediaRepository_AllMedias_With_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        let exp = expectation(description: "fetch media")

        var error: Error?
        wps.fetchMedias(filters: [], fields: []) { result in
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
    
    func testWPS_MediaRepository_AllMedias_With_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_medias_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        let exp = expectation(description: "fetch medias")
        
        var medias = [WPMedia]()
        
        wps.fetchMedias(filters: [], fields: []) { (result: Result<[WPMedia], Error>) in
            switch result {
            case .failure(_ ):
                break
            case .success(let resultmedias):
                medias = resultmedias
                
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0)
        
        XCTAssertEqual(medias.count, 2)
        for (idx, media) in medias.enumerated() {
            XCTAssertEqual(media.id, idx + 1)
            XCTAssertNotNil(media.date)
            XCTAssertNotNil(media.date_gmt)
            XCTAssertNotNil(media.guid?.rendered)
            XCTAssertEqual(media.link, "https://sitio.com/test-\(idx + 1)")
            XCTAssertNotNil(media.modified)
            XCTAssertNotNil(media.modified_gmt)
            XCTAssertEqual(media.slug, "test-\(idx + 1)")
            XCTAssertEqual(media.status, .inherit)
            XCTAssertEqual(media.type, "attachment")
            XCTAssertNotNil(media.title?.rendered)
            XCTAssertEqual(media.author, idx + 1)
            XCTAssertEqual(media.comment_status, .open)
            XCTAssertEqual(media.ping_status, .closed)
            XCTAssertEqual(media.template, "")
            XCTAssertEqual(media.alt_text, "test")
            XCTAssertNotNil(media.caption?.rendered)
            XCTAssertNotNil(media.description?.rendered)
            XCTAssertEqual(media.media_type, .image)
            XCTAssertNotNil(media.media_details)
            XCTAssertNotNil(media.media_details?.sizes?.full)
            XCTAssertEqual(media.post, idx + 1)
            XCTAssertEqual(media.source_url, "https://sitio.com/test_\(idx + 1)")
        }
    }
    
    func testWPS_MediaRepository_SpecificMedia_With_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        let exp = expectation(description: "fetch media")
        
        var error: Error?
        wps.fetchMedia(id: 1, fields: []) { result in
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
    
    func testWPS_MediaRepository_SpecificMedia_With_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_media_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        let exp = expectation(description: "fetch media")

        var media: WPMedia!
        wps.fetchMedia(id: 1, fields: []) { (result: Result<WPMedia, Error>) in
            switch result {
            case .failure(_ ):
                break
            case .success(let resultmedia):
                media = resultmedia
            }
            exp.fulfill()
        }

        waitForExpectations(timeout: 3.0)

        XCTAssertEqual(media.id, 1)
        XCTAssertNotNil(media.date)
        XCTAssertNotNil(media.date_gmt)
        XCTAssertNotNil(media.guid?.rendered)
        XCTAssertEqual(media.link, "https://sitio.com/test-1")
        XCTAssertNotNil(media.modified)
        XCTAssertNotNil(media.modified_gmt)
        XCTAssertEqual(media.slug, "test-1")
        XCTAssertEqual(media.status, .inherit)
        XCTAssertEqual(media.type, "attachment")
        XCTAssertNotNil(media.title?.rendered)
        XCTAssertEqual(media.author, 177)
        XCTAssertEqual(media.comment_status, .open)
        XCTAssertEqual(media.ping_status, .closed)
        XCTAssertEqual(media.template, "")
        XCTAssertEqual(media.alt_text, "test")
        XCTAssertNotNil(media.caption?.rendered)
        XCTAssertNotNil(media.description?.rendered)
        XCTAssertEqual(media.media_type, .image)
        XCTAssertNotNil(media.media_details)
        XCTAssertNotNil(media.media_details?.sizes?.full)
        XCTAssertEqual(media.post, 1)
        XCTAssertEqual(media.source_url, "https://sitio.com/test")
    }
    
    func testWPS_MediaRepository_AllMedias_WithCustomModel_And_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)

        let exp = expectation(description: "fetch medias")
        var error: Error?

        wps.fetchMedias(filters: [], fields: []) { (result: Result<[WPCustomMediaModel], Error>) in
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
    
    func testWPS_MediaRepository_AllMedias_WithCustomModel_And_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_medias_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)

        let exp = expectation(description: "fetch medias")

        var medias = [WPCustomMediaModel]()
        wps.fetchMedias(filters: [], fields: []) { (result: Result<[WPCustomMediaModel], Error>) in
            switch result {
            case .failure(_ ):
                break
            case .success(let resultmedias):
                medias = resultmedias
            }
            exp.fulfill()
        }

        waitForExpectations(timeout: 3.0)

        XCTAssertEqual(medias.count, 2)
        for (idx, media) in medias.enumerated() {
            XCTAssertEqual(media.id, idx + 1)
            XCTAssertNotNil(media.date)
            XCTAssertNotNil(media.date_gmt)
            XCTAssertNotNil(media.guid?.rendered)
            XCTAssertEqual(media.link, "https://sitio.com/test-\(idx + 1)")
            XCTAssertNotNil(media.modified)
            XCTAssertNotNil(media.modified_gmt)
            XCTAssertEqual(media.slug, "test-\(idx + 1)")
            XCTAssertEqual(media.status, .inherit)
            XCTAssertEqual(media.type, "attachment")
            XCTAssertNotNil(media.title?.rendered)
            XCTAssertEqual(media.author, idx + 1)
            XCTAssertEqual(media.comment_status, .open)
            XCTAssertEqual(media.ping_status, .closed)
            XCTAssertEqual(media.template, "")
            XCTAssertEqual(media.alt_text, "test")
            XCTAssertNotNil(media.caption?.rendered)
            XCTAssertNotNil(media.description?.rendered)
            XCTAssertEqual(media.media_type, .image)
            XCTAssertNotNil(media.media_details)
            XCTAssertNotNil(media.media_details?.sizes?.full)
            XCTAssertEqual(media.post, idx + 1)
            XCTAssertEqual(media.source_url, "https://sitio.com/test_\(idx + 1)")
        }
    }
    
    func testWPS_MediaRepository_UserMedia_WithCustomModel_And_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch media")
        
        var error: Error?
        wps.fetchMedia(id: 1, fields: []) { (result: Result<WPCustomMediaModel, Error>) in
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
    
    func testWPS_MediaRepository_UserMedia_WithCustomModel_And_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_media_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        var media: WPCustomMediaModel!
        let exp = expectation(description: "fetch media")
        wps.fetchMedia(id: 1, fields: []) { (result: Result<WPCustomMediaModel, Error>) in
            switch result {
            case .failure(_ ):
                break
            case .success(let resultmedia):
                media = resultmedia
            }
            
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0)
        
        XCTAssertEqual(media.id, 1)
        XCTAssertNotNil(media.date)
        XCTAssertNotNil(media.date_gmt)
        XCTAssertNotNil(media.guid?.rendered)
        XCTAssertEqual(media.link, "https://sitio.com/test-1")
        XCTAssertNotNil(media.modified)
        XCTAssertNotNil(media.modified_gmt)
        XCTAssertEqual(media.slug, "test-1")
        XCTAssertEqual(media.status, .inherit)
        XCTAssertEqual(media.type, "attachment")
        XCTAssertNotNil(media.title?.rendered)
        XCTAssertEqual(media.author, 177)
        XCTAssertEqual(media.comment_status, .open)
        XCTAssertEqual(media.ping_status, .closed)
        XCTAssertEqual(media.template, "")
        XCTAssertEqual(media.alt_text, "test")
        XCTAssertNotNil(media.caption?.rendered)
        XCTAssertNotNil(media.description?.rendered)
        XCTAssertEqual(media.media_type, .image)
        XCTAssertNotNil(media.media_details)
        XCTAssertNotNil(media.media_details?.sizes?.full)
        XCTAssertEqual(media.post, 1)
        XCTAssertEqual(media.source_url, "https://sitio.com/test")
    }

}

//
//  WordPressSimplifyTests_Pages.swift
//  WordPressSimplify_Tests
//
//  Created by Diego Badaracco on 10/10/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import XCTest
@testable import WordPressSimplify

final class WordPressSimplifyTests_Pages: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Pages
    func testWPS_PageRepository_AllPages_With_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch page")
        var error: Error?

        wps.fetchPages(filters: [], fields: []) { result in
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
    
    func testWPS_PageRepository_AllPages_With_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_pages_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch page")
        var pages = [WPPage]()

        wps.fetchPages(filters: [], fields: []) { (result: Result<[WPPage], Error>) in
            switch result {
            case .failure(_ ):
                break
            case .success(let resultpages):
                pages = resultpages
            }
            
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0)
        
        XCTAssertEqual(pages.count, 4)
        for (idx, page) in pages.enumerated() {
            XCTAssertEqual(page.id, idx + 1)
            XCTAssertNotNil(page.date)
            XCTAssertNotNil(page.date_gmt)
            XCTAssertNotNil(page.guid?.rendered)
            XCTAssertEqual(page.link, "https://site.com/test-\(idx + 1)/")
            XCTAssertNotNil(page.modified)
            XCTAssertNotNil(page.modified_gmt)
            XCTAssertEqual(page.slug, "test-\(idx + 1)")
            XCTAssertEqual(page.status, .publish)
            XCTAssertEqual(page.type, "page")
            XCTAssertNotNil(page.title?.rendered)
            XCTAssertNotNil(page.content?.rendered)
            XCTAssertEqual(page.author, idx + 1)
            XCTAssertNotNil(page.excerpt?.rendered)
            XCTAssertEqual(page.featured_media, 0)
            XCTAssertEqual(page.comment_status, .closed)
            XCTAssertEqual(page.ping_status, .closed)
            XCTAssertEqual(page.template, "")
        }
    }
    
    func testWPS_PageRepository_SpecificPage_With_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch page")
        var error: Error?
        
        wps.fetchPage(id: 1, fields: []) { result in
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
    
    func testWPS_PageRepository_SpecificPage_With_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_page_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch page")
        var page: WPPage!
        wps.fetchPage(id: 1, fields: []) { (result: Result<WPPage, Error>) in
            switch result {
            case .failure(_ ):
                break
            case .success(let resultpage):
                page = resultpage
            }
            
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0)
        
        XCTAssertEqual(page.id, 1)
        XCTAssertNotNil(page.date)
        XCTAssertNotNil(page.date_gmt)
        XCTAssertNotNil(page.guid?.rendered)
        XCTAssertEqual(page.link, "https://site.com/test-1/")
        XCTAssertNotNil(page.modified)
        XCTAssertNotNil(page.modified_gmt)
        XCTAssertEqual(page.slug, "test-1")
        XCTAssertEqual(page.status, .publish)
        XCTAssertEqual(page.type, "page")
        XCTAssertNotNil(page.title?.rendered)
        XCTAssertNotNil(page.content?.rendered)
        XCTAssertEqual(page.author, 1)
        XCTAssertNotNil(page.excerpt?.rendered)
        XCTAssertEqual(page.featured_media, 0)
        XCTAssertEqual(page.comment_status, .closed)
        XCTAssertEqual(page.ping_status, .closed)
        XCTAssertEqual(page.template, "")
    }
    
    func testWPS_PageRepository_AllPages_WithCustomModel_And_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch pages")
        var error: Error?

        wps.fetchPages(filters: [], fields: []) { (result: Result<[WPCustomPageModel], Error>) in
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
    
    func testWPS_PageRepository_AllPages_WithCustomModel_And_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_pages_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch pages")
        var pages = [WPCustomPageModel]()
        
        wps.fetchPages(filters: [], fields: []) { (result: Result<[WPCustomPageModel], Error>) in
            switch result {
            case .failure(_ ):
                break
            case .success(let resultpages):
                pages = resultpages
            }
            exp.fulfill()
        }

        waitForExpectations(timeout: 3.0)
        
        XCTAssertEqual(pages.count, 4)
        for (idx, page) in pages.enumerated() {
            XCTAssertEqual(page.id, idx + 1)
            XCTAssertNotNil(page.date)
            XCTAssertNotNil(page.date_gmt)
            XCTAssertNotNil(page.guid?.rendered)
            XCTAssertEqual(page.link, "https://site.com/test-\(idx + 1)/")
            XCTAssertNotNil(page.modified)
            XCTAssertNotNil(page.modified_gmt)
            XCTAssertEqual(page.slug, "test-\(idx + 1)")
            XCTAssertEqual(page.status, .publish)
            XCTAssertEqual(page.type, "page")
            XCTAssertNotNil(page.title?.rendered)
            XCTAssertNotNil(page.content?.rendered)
            XCTAssertEqual(page.author, idx + 1)
            XCTAssertNotNil(page.excerpt?.rendered)
            XCTAssertEqual(page.featured_media, 0)
            XCTAssertEqual(page.comment_status, .closed)
            XCTAssertEqual(page.ping_status, .closed)
            XCTAssertEqual(page.template, "")
        }
    }
    
    func testWPS_PageRepository_UserPage_WithCustomModel_And_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch page")
        var error: Error?
        
        wps.fetchPage(id: 1, fields: []) { (result: Result<WPCustomPageModel, Error>) in
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
    
    func testWPS_PageRepository_UserPage_WithCustomModel_And_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_page_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch page")
        var page: WPCustomPageModel!
        
        wps.fetchPage(id: 1, fields: []) { (result: Result<WPCustomPageModel, Error>) in
            switch result {
            case .failure(_ ):
                break
            case .success(let resultpage):
               page = resultpage
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0)
        
        
        XCTAssertEqual(page.id, 1)
        XCTAssertNotNil(page.date)
        XCTAssertNotNil(page.date_gmt)
        XCTAssertNotNil(page.guid?.rendered)
        XCTAssertEqual(page.link, "https://site.com/test-1/")
        XCTAssertNotNil(page.modified)
        XCTAssertNotNil(page.modified_gmt)
        XCTAssertEqual(page.slug, "test-1")
        XCTAssertEqual(page.status, .publish)
        XCTAssertEqual(page.type, "page")
        XCTAssertNotNil(page.title?.rendered)
        XCTAssertNotNil(page.content?.rendered)
        XCTAssertEqual(page.author, 1)
        XCTAssertNotNil(page.excerpt?.rendered)
        XCTAssertEqual(page.featured_media, 0)
        XCTAssertEqual(page.comment_status, .closed)
        XCTAssertEqual(page.ping_status, .closed)
        XCTAssertEqual(page.template, "")
    }
}

//
//  WordPressSimplifyTests.swift
//  WordPressSimplifyTests
//
//  Created by Diego Badaracco on 20/09/2022.
//

import XCTest
@testable import WordPressSimplify

final class WordPressSimplifyTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Users
    func testWPS_UserRepository_AllUsers_With_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchUsers(filters: [], fields: []) { result in
            switch result {
            case .failure(let error):
                let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
                XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
            default:
                XCTAssertTrue(false)
            }
        }
    }

    func testWPS_UserRepository_AllUsers_With_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_users_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchUsers(filters: [], fields: []) { result in
            switch result {
            case .failure(_ ):
                XCTAssertTrue(false)
            case .success(let users):
                XCTAssertEqual(users.count, 4)
                for (idx, user) in users.enumerated() {
                    XCTAssertEqual(user.id, idx + 1)
                    XCTAssertEqual(user.name, "test\(idx + 1)")
                    XCTAssertEqual(user.url, "http://www.test\(idx + 1).com")
                    XCTAssertEqual(user.link, "https://test\(idx + 1).com/author/test\(idx + 1)/")
                    XCTAssertEqual(user.slug, "test-\(idx + 1)")
                }
            }
        }
    }

    func testWPS_UserRepository_SpecificUser_With_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchUser(id: 1, fields: []) { result in
            switch result {
            case .failure(let error):
                let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
                XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
            default:
                XCTAssertTrue(false)
            }
        }
    }

    func testWPS_UserRepository_SpecificUser_With_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_user_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchUser(id: 1, fields: []) { result in
            switch result {
            case .failure(_ ):
                XCTAssertTrue(false)
            case .success(let user):
                XCTAssertEqual(user.id, 1)
                XCTAssertEqual(user.name, "test1")
                XCTAssertEqual(user.url, "http://www.test1.com")
                XCTAssertEqual(user.link, "https://test1.com/author/test1/")
                XCTAssertEqual(user.slug, "test-1")
            }
        }
    }

    func testWPS_UserRepository_AllUsers_WithCustomModel_And_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchUsers(filters: [], fields: []) { (result: Result<[WPCustomUserModel], Error>) in
            switch result {
            case .failure(let error):
                let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
                XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
            default:
                XCTAssertTrue(false)
            }
        }
    }

    func testWPS_UserRepository_AllUsers_WithCustomModel_And_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_users_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchUsers(filters: [], fields: []) { (result: Result<[WPCustomUserModel], Error>) in
            switch result {
            case .failure(_ ):
                XCTAssertTrue(false)
            case .success(let users):
                XCTAssertEqual(users.count, 4)
                for (idx, user) in users.enumerated() {
                    XCTAssertEqual(user.id, idx + 1)
                    XCTAssertEqual(user.name, "test\(idx + 1)")
                    XCTAssertEqual(user.url, "http://www.test\(idx + 1).com")
                    XCTAssertEqual(user.link, "https://test\(idx + 1).com/author/test\(idx + 1)/")
                    XCTAssertEqual(user.slug, "test-\(idx + 1)")
                }
            }
        }
    }

    func testWPS_UserRepository_SpecificUser_WithCustomModel_And_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchUser(id: 1, fields: []) { (result: Result<WPCustomUserModel, Error>) in
            switch result {
            case .failure(let error):
                let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
                XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
            default:
                XCTAssertTrue(false)
            }
        }
    }

    func testWPS_UserRepository_SpecificUser_WithCustomModel_And_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_user_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchUser(id: 1, fields: []) { (result: Result<WPCustomUserModel, Error>) in
            switch result {
            case .failure(_ ):
                XCTAssertTrue(false)
            case .success(let user):
                XCTAssertEqual(user.id, 1)
                XCTAssertEqual(user.name, "test1")
                XCTAssertEqual(user.url, "http://www.test1.com")
                XCTAssertEqual(user.link, "https://test1.com/author/test1/")
                XCTAssertEqual(user.slug, "test-1")
            }
        }
    }

    // MARK: - Categories
    
    func testWPS_CategoryRepository_AllCategories_With_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchCategories(filters: [], fields: []) { result in
            switch result {
            case .failure(let error):
                let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
                XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
            default:
                XCTAssertTrue(false)
            }
        }
    }
    
    func testWPS_CategoryRepository_AllCategories_With_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_categories_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        wps.fetchCategories(filters: [], fields: []) { (result: Result<[WPCategory], Error>) in
            switch result {
            case .failure(_ ):
                XCTAssertTrue(false)
            case .success(let categories):
                XCTAssertEqual(categories.count, 4)
                for (idx, category) in categories.enumerated() {
                    XCTAssertEqual(category.id, idx + 1)
                    XCTAssertEqual(category.count, idx + 1)
                    XCTAssertEqual(category.description, "test_\(idx + 1)")
                    XCTAssertEqual(category.name, "Test-\(idx + 1)")
                    XCTAssertEqual(category.link, "https://test\(idx + 1).com/category/test\(idx + 1)/")
                    XCTAssertEqual(category.slug, "test-\(idx + 1)")
                    XCTAssertEqual(category.slug, "test-\(idx + 1)")
                    XCTAssertEqual(category.taxonomy, "category")
                    XCTAssertEqual(category.parent, 0)
                }
            }
        }
    }
    
    func testWPS_CategoryRepository_SpecificCategory_With_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchCategory(id: 1, fields: []) { result in
            switch result {
            case .failure(let error):
                let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
                XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
            default:
                XCTAssertTrue(false)
            }
        }
    }
    
    func testWPS_CategoryRepository_SpecificCategory_With_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_category_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchCategory(id: 1, fields: []) { (result: Result<WPCategory, Error>) in
            switch result {
            case .failure(_ ):
                XCTAssertTrue(false)
            case .success(let category):
                XCTAssertEqual(category.id, 1)
                XCTAssertEqual(category.count, 1)
                XCTAssertEqual(category.description, "test_1")
                XCTAssertEqual(category.name, "Test-1")
                XCTAssertEqual(category.link, "https://test1.com/category/test1/")
                XCTAssertEqual(category.slug, "test-1")
                XCTAssertEqual(category.slug, "test-1")
                XCTAssertEqual(category.taxonomy, "category")
                XCTAssertEqual(category.parent, 0)
            }
        }
    }
    
    func testWPS_CategoryRepository_AllCategories_WithCustomModel_And_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchCategories(filters: [], fields: []) { (result: Result<[WPCustomCategoryModel], Error>) in
            switch result {
            case .failure(let error):
                let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
                XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
            default:
                XCTAssertTrue(false)
            }
        }
    }
    
    func testWPS_CategoryRepository_AllCategories_WithCustomModel_And_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_categories_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchCategories(filters: [], fields: []) { (result: Result<[WPCustomCategoryModel], Error>) in
            switch result {
            case .failure(_ ):
                XCTAssertTrue(false)
            case .success(let categories):
                XCTAssertEqual(categories.count, 4)
                for (idx, category) in categories.enumerated() {
                    XCTAssertEqual(category.id, idx + 1)
                    XCTAssertEqual(category.count, idx + 1)
                    XCTAssertEqual(category.description, "test_\(idx + 1)")
                    XCTAssertEqual(category.name, "Test-\(idx + 1)")
                    XCTAssertEqual(category.link, "https://test\(idx + 1).com/category/test\(idx + 1)/")
                    XCTAssertEqual(category.slug, "test-\(idx + 1)")
                    XCTAssertEqual(category.slug, "test-\(idx + 1)")
                    XCTAssertEqual(category.taxonomy, "category")
                    XCTAssertEqual(category.parent, 0)
                }
            }
        }
    }
    
    func testWPS_CategoryRepository_UserCategory_WithCustomModel_And_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchCategory(id: 1, fields: []) { (result: Result<WPCustomCategoryModel, Error>) in
            switch result {
            case .failure(let error):
                let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
                XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
            default:
                XCTAssertTrue(false)
            }
        }
    }
    
    func testWPS_CategoryRepository_UserCategory_WithCustomModel_And_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_category_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchCategory(id: 1, fields: []) { (result: Result<WPCustomCategoryModel, Error>) in
            switch result {
            case .failure(_ ):
                XCTAssertTrue(false)
            case .success(let category):
                XCTAssertEqual(category.id, 1)
                XCTAssertEqual(category.count, 1)
                XCTAssertEqual(category.description, "test_1")
                XCTAssertEqual(category.name, "Test-1")
                XCTAssertEqual(category.link, "https://test1.com/category/test1/")
                XCTAssertEqual(category.slug, "test-1")
                XCTAssertEqual(category.slug, "test-1")
                XCTAssertEqual(category.taxonomy, "category")
                XCTAssertEqual(category.parent, 0)
            }
        }
    }
    
    
    // MARK: - Tags
    func testWPS_TagRepository_AllTags_With_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchTags(filters: [], fields: []) { result in
            switch result {
            case .failure(let error):
                let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
                XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
            default:
                XCTAssertTrue(false)
            }
        }
    }
    
    func testWPS_TagRepository_AllTags_With_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_tags_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        wps.fetchTags(filters: [], fields: []) { (result: Result<[WPTag], Error>) in
            switch result {
            case .failure(_ ):
                XCTAssertTrue(false)
            case .success(let tags):
                XCTAssertEqual(tags.count, 4)
                for (idx, tag) in tags.enumerated() {
                    XCTAssertEqual(tag.id, idx + 1)
                    XCTAssertEqual(tag.count, idx + 1)
                    XCTAssertEqual(tag.description, "test_\(idx + 1)")
                    XCTAssertEqual(tag.name, "Test-\(idx + 1)")
                    XCTAssertEqual(tag.link, "https://test\(idx + 1).com/tag/test\(idx + 1)/")
                    XCTAssertEqual(tag.slug, "test-\(idx + 1)")
                    XCTAssertEqual(tag.slug, "test-\(idx + 1)")
                    XCTAssertEqual(tag.taxonomy, "tag")
                }
            }
        }
    }
    
    func testWPS_TagRepository_SpecificTag_With_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchTag(id: 1, fields: []) { result in
            switch result {
            case .failure(let error):
                let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
                XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
            default:
                XCTAssertTrue(false)
            }
        }
    }
    
    func testWPS_TagRepository_SpecificTag_With_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_tag_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchTag(id: 1, fields: []) { (result: Result<WPTag, Error>) in
            switch result {
            case .failure(_ ):
                XCTAssertTrue(false)
            case .success(let tag):
                XCTAssertEqual(tag.id, 1)
                XCTAssertEqual(tag.count, 1)
                XCTAssertEqual(tag.description, "test_1")
                XCTAssertEqual(tag.name, "Test-1")
                XCTAssertEqual(tag.link, "https://test1.com/tag/test1/")
                XCTAssertEqual(tag.slug, "test-1")
                XCTAssertEqual(tag.slug, "test-1")
                XCTAssertEqual(tag.taxonomy, "tag")
            }
        }
    }
    
    func testWPS_TagRepository_AllTags_WithCustomModel_And_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchTags(filters: [], fields: []) { (result: Result<[WPCustomTagModel], Error>) in
            switch result {
            case .failure(let error):
                let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
                XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
            default:
                XCTAssertTrue(false)
            }
        }
    }
    
    func testWPS_TagRepository_AllTags_WithCustomModel_And_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_tags_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchTags(filters: [], fields: []) { (result: Result<[WPCustomTagModel], Error>) in
            switch result {
            case .failure(_ ):
                XCTAssertTrue(false)
            case .success(let tags):
                XCTAssertEqual(tags.count, 4)
                for (idx, tag) in tags.enumerated() {
                    XCTAssertEqual(tag.id, idx + 1)
                    XCTAssertEqual(tag.count, idx + 1)
                    XCTAssertEqual(tag.description, "test_\(idx + 1)")
                    XCTAssertEqual(tag.name, "Test-\(idx + 1)")
                    XCTAssertEqual(tag.link, "https://test\(idx + 1).com/tag/test\(idx + 1)/")
                    XCTAssertEqual(tag.slug, "test-\(idx + 1)")
                    XCTAssertEqual(tag.slug, "test-\(idx + 1)")
                    XCTAssertEqual(tag.taxonomy, "tag")
                }
            }
        }
    }
    
    func testWPS_TagRepository_UserTag_WithCustomModel_And_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchTag(id: 1, fields: []) { (result: Result<WPCustomTagModel, Error>) in
            switch result {
            case .failure(let error):
                let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
                XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
            default:
                XCTAssertTrue(false)
            }
        }
    }
    
    func testWPS_TagRepository_UserTag_WithCustomModel_And_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_tag_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchTag(id: 1, fields: []) { (result: Result<WPCustomTagModel, Error>) in
            switch result {
            case .failure(_ ):
                XCTAssertTrue(false)
            case .success(let tag):
                XCTAssertEqual(tag.id, 1)
                XCTAssertEqual(tag.count, 1)
                XCTAssertEqual(tag.description, "test_1")
                XCTAssertEqual(tag.name, "Test-1")
                XCTAssertEqual(tag.link, "https://test1.com/tag/test1/")
                XCTAssertEqual(tag.slug, "test-1")
                XCTAssertEqual(tag.slug, "test-1")
                XCTAssertEqual(tag.taxonomy, "tag")
            }
        }
    }
    
    // MARK: - Posts
    func testWPS_PostRepository_AllPosts_With_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchPosts(filters: [], fields: []) { result in
            switch result {
            case .failure(let error):
                let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
                XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
            default:
                XCTAssertTrue(false)
            }
        }
    }
    
    func testWPS_PostRepository_AllPosts_With_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_posts_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        wps.fetchPosts(filters: [], fields: []) { (result: Result<[WPPost], Error>) in
            switch result {
            case .failure(_ ):
                XCTAssertTrue(false)
            case .success(let posts):
                XCTAssertEqual(posts.count, 4)
                for (idx, post) in posts.enumerated() {
                    XCTAssertEqual(post.id, idx + 1)
                    XCTAssertNotNil(post.date)
                    XCTAssertNotNil(post.date_gmt)
                    XCTAssertNotNil(post.guid?.rendered)
                    XCTAssertEqual(post.link, "https://site.com/title_\(idx + 1)/")
                    XCTAssertNotNil(post.modified)
                    XCTAssertNotNil(post.modified_gmt)
                    XCTAssertEqual(post.slug, "title_\(idx + 1)")
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
        }
    }
    
    func testWPS_PostRepository_SpecificPost_With_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchPost(id: 1, fields: []) { result in
            switch result {
            case .failure(let error):
                let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
                XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
            default:
                XCTAssertTrue(false)
            }
        }
    }
    
    func testWPS_PostRepository_SpecificPost_With_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_post_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchPost(id: 1, fields: []) { (result: Result<WPPost, Error>) in
            switch result {
            case .failure(_ ):
                XCTAssertTrue(false)
            case .success(let post):
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
    }
    
    func testWPS_PostRepository_AllPosts_WithCustomModel_And_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchPosts(filters: [], fields: []) { (result: Result<[WPCustomPostModel], Error>) in
            switch result {
            case .failure(let error):
                let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
                XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
            default:
                XCTAssertTrue(false)
            }
        }
    }
    
    func testWPS_PostRepository_AllPosts_WithCustomModel_And_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_posts_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchPosts(filters: [], fields: []) { (result: Result<[WPCustomPostModel], Error>) in
            switch result {
            case .failure(_ ):
                XCTAssertTrue(false)
            case .success(let posts):
                XCTAssertEqual(posts.count, 4)
                for (idx, post) in posts.enumerated() {
                    XCTAssertEqual(post.id, idx + 1)
                    XCTAssertNotNil(post.date)
                    XCTAssertNotNil(post.date_gmt)
                    XCTAssertNotNil(post.guid?.rendered)
                    XCTAssertEqual(post.link, "https://site.com/title_\(idx + 1)/")
                    XCTAssertNotNil(post.modified)
                    XCTAssertNotNil(post.modified_gmt)
                    XCTAssertEqual(post.slug, "title_\(idx + 1)")
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
        }
    }
    
    func testWPS_PostRepository_UserPost_WithCustomModel_And_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchPost(id: 1, fields: []) { (result: Result<WPCustomPostModel, Error>) in
            switch result {
            case .failure(let error):
                let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
                XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
            default:
                XCTAssertTrue(false)
            }
        }
    }
    
    func testWPS_PostRepository_UserPost_WithCustomModel_And_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_post_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchPost(id: 1, fields: []) { (result: Result<WPCustomPostModel, Error>) in
            switch result {
            case .failure(_ ):
                XCTAssertTrue(false)
            case .success(let post):
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
    }
    
    // MARK: - Pages
    func testWPS_PageRepository_AllPages_With_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchPages(filters: [], fields: []) { result in
            switch result {
            case .failure(let error):
                let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
                XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
            default:
                XCTAssertTrue(false)
            }
        }
    }
    
    func testWPS_PageRepository_AllPages_With_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_pages_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        wps.fetchPages(filters: [], fields: []) { (result: Result<[WPPage], Error>) in
            switch result {
            case .failure(_ ):
                XCTAssertTrue(false)
            case .success(let pages):
                XCTAssertEqual(pages.count, 4)
                for (idx, page) in pages.enumerated() {
                    XCTAssertEqual(page.id, idx + 1)
                    XCTAssertNotNil(page.date)
                    XCTAssertNotNil(page.date_gmt)
                    XCTAssertNotNil(page.guid?.rendered)
                    XCTAssertEqual(page.link, "https://site.com/test_\(idx + 1)/")
                    XCTAssertNotNil(page.modified)
                    XCTAssertNotNil(page.modified_gmt)
                    XCTAssertEqual(page.slug, "test_\(idx + 1)")
                    XCTAssertEqual(page.status, .publish)
                    XCTAssertEqual(page.type, "page")
                    XCTAssertNotNil(page.title?.rendered)
                    XCTAssertNotNil(page.content?.rendered)
                    XCTAssertEqual(page.author, 1)
                    XCTAssertNotNil(page.excerpt?.rendered)
                    XCTAssertEqual(page.featured_media, 1)
                    XCTAssertEqual(page.comment_status, .open)
                    XCTAssertEqual(page.ping_status, .closed)
                    XCTAssertEqual(page.template, "")
                }
            }
        }
    }
    
    func testWPS_PageRepository_SpecificPage_With_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchPage(id: 1, fields: []) { result in
            switch result {
            case .failure(let error):
                let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
                XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
            default:
                XCTAssertTrue(false)
            }
        }
    }
    
    func testWPS_PageRepository_SpecificPage_With_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_page_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchPage(id: 1, fields: []) { (result: Result<WPPage, Error>) in
            switch result {
            case .failure(_ ):
                XCTAssertTrue(false)
            case .success(let page):
                XCTAssertEqual(page.id, 1)
                XCTAssertNotNil(page.date)
                XCTAssertNotNil(page.date_gmt)
                XCTAssertNotNil(page.guid?.rendered)
                XCTAssertEqual(page.link, "https://site.com/test_1/")
                XCTAssertNotNil(page.modified)
                XCTAssertNotNil(page.modified_gmt)
                XCTAssertEqual(page.slug, "test_1")
                XCTAssertEqual(page.status, .publish)
                XCTAssertEqual(page.type, "page")
                XCTAssertNotNil(page.title?.rendered)
                XCTAssertNotNil(page.content?.rendered)
                XCTAssertEqual(page.author, 1)
                XCTAssertNotNil(page.excerpt?.rendered)
                XCTAssertEqual(page.featured_media, 1)
                XCTAssertEqual(page.comment_status, .open)
                XCTAssertEqual(page.ping_status, .closed)
                XCTAssertEqual(page.template, "")
            }
        }
    }
    
    func testWPS_PageRepository_AllPages_WithCustomModel_And_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchPages(filters: [], fields: []) { (result: Result<[WPCustomPageModel], Error>) in
            switch result {
            case .failure(let error):
                let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
                XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
            default:
                XCTAssertTrue(false)
            }
        }
    }
    
    func testWPS_PageRepository_AllPages_WithCustomModel_And_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_pages_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchPages(filters: [], fields: []) { (result: Result<[WPCustomPageModel], Error>) in
            switch result {
            case .failure(_ ):
                XCTAssertTrue(false)
            case .success(let pages):
                XCTAssertEqual(pages.count, 4)
                for (idx, page) in pages.enumerated() {
                    XCTAssertEqual(page.id, idx + 1)
                    XCTAssertNotNil(page.date)
                    XCTAssertNotNil(page.date_gmt)
                    XCTAssertNotNil(page.guid?.rendered)
                    XCTAssertEqual(page.link, "https://site.com/test_\(idx + 1)/")
                    XCTAssertNotNil(page.modified)
                    XCTAssertNotNil(page.modified_gmt)
                    XCTAssertEqual(page.slug, "test_\(idx + 1)")
                    XCTAssertEqual(page.status, .publish)
                    XCTAssertEqual(page.type, "page")
                    XCTAssertNotNil(page.title?.rendered)
                    XCTAssertNotNil(page.content?.rendered)
                    XCTAssertEqual(page.author, 1)
                    XCTAssertNotNil(page.excerpt?.rendered)
                    XCTAssertEqual(page.featured_media, 1)
                    XCTAssertEqual(page.comment_status, .open)
                    XCTAssertEqual(page.ping_status, .closed)
                    XCTAssertEqual(page.template, "")
                }
            }
        }
    }
    
    func testWPS_PageRepository_UserPage_WithCustomModel_And_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchPage(id: 1, fields: []) { (result: Result<WPCustomPageModel, Error>) in
            switch result {
            case .failure(let error):
                let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
                XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
            default:
                XCTAssertTrue(false)
            }
        }
    }
    
    func testWPS_PageRepository_UserPage_WithCustomModel_And_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_page_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchPage(id: 1, fields: []) { (result: Result<WPCustomPageModel, Error>) in
            switch result {
            case .failure(_ ):
                XCTAssertTrue(false)
            case .success(let page):
                XCTAssertEqual(page.id, 1)
                XCTAssertNotNil(page.date)
                XCTAssertNotNil(page.date_gmt)
                XCTAssertNotNil(page.guid?.rendered)
                XCTAssertEqual(page.link, "https://site.com/test_1/")
                XCTAssertNotNil(page.modified)
                XCTAssertNotNil(page.modified_gmt)
                XCTAssertEqual(page.slug, "test_1")
                XCTAssertEqual(page.status, .publish)
                XCTAssertEqual(page.type, "page")
                XCTAssertNotNil(page.title?.rendered)
                XCTAssertNotNil(page.content?.rendered)
                XCTAssertEqual(page.author, 1)
                XCTAssertNotNil(page.excerpt?.rendered)
                XCTAssertEqual(page.featured_media, 1)
                XCTAssertEqual(page.comment_status, .open)
                XCTAssertEqual(page.ping_status, .closed)
                XCTAssertEqual(page.template, "")
            }
        }
    }
    
    // MARK: - Media
    func testWPS_MediaRepository_AllMedias_With_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchMedias(filters: [], fields: []) { result in
            switch result {
            case .failure(let error):
                let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
                XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
            default:
                XCTAssertTrue(false)
            }
        }
    }
    
    func testWPS_MediaRepository_AllMedias_With_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_medias_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        wps.fetchMedias(filters: [], fields: []) { (result: Result<[WPMedia], Error>) in
            switch result {
            case .failure(_ ):
                XCTAssertTrue(false)
            case .success(let medias):
                XCTAssertEqual(medias.count, 4)
                for (idx, media) in medias.enumerated() {
                    XCTAssertEqual(media.id, idx + 1)
                    XCTAssertNotNil(media.date)
                    XCTAssertNotNil(media.date_gmt)
                    XCTAssertNotNil(media.guid?.rendered)
                    XCTAssertEqual(media.link, "https://sitio.com/test_\(idx + 1)/")
                    XCTAssertNotNil(media.modified)
                    XCTAssertNotNil(media.modified_gmt)
                    XCTAssertEqual(media.slug, "test_\(idx + 1)")
                    XCTAssertEqual(media.status, .publish)
                    XCTAssertEqual(media.type, "media")
                    XCTAssertNotNil(media.title?.rendered)
                    XCTAssertEqual(media.author, 1)
                    XCTAssertEqual(media.comment_status, .open)
                    XCTAssertEqual(media.ping_status, .closed)
                    XCTAssertEqual(media.template, "")
                    XCTAssertEqual(media.alt_text, "")
                    XCTAssertNotNil(media.caption?.rendered)
                    XCTAssertNotNil(media.description?.rendered)
                    XCTAssertEqual(media.media_type, .image)
                    XCTAssertNotNil(media.media_details)
                    XCTAssertNotNil(media.media_details?.sizes?.full)
                    XCTAssertEqual(media.post, 1)
                    XCTAssertEqual(media.source_url, "")
                }
            }
        }
    }
    
    func testWPS_MediaRepository_SpecificMedia_With_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchMedia(id: 1, fields: []) { result in
            switch result {
            case .failure(let error):
                let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
                XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
            default:
                XCTAssertTrue(false)
            }
        }
    }
    
    func testWPS_MediaRepository_SpecificMedia_With_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_media_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchMedia(id: 1, fields: []) { (result: Result<WPMedia, Error>) in
            switch result {
            case .failure(_ ):
                XCTAssertTrue(false)
            case .success(let media):
                XCTAssertEqual(media.id, 1)
                XCTAssertNotNil(media.date)
                XCTAssertNotNil(media.date_gmt)
                XCTAssertNotNil(media.guid?.rendered)
                XCTAssertEqual(media.link, "https://sitio.com/test_1/")
                XCTAssertNotNil(media.modified)
                XCTAssertNotNil(media.modified_gmt)
                XCTAssertEqual(media.slug, "test_1")
                XCTAssertEqual(media.status, .publish)
                XCTAssertEqual(media.type, "media")
                XCTAssertNotNil(media.title?.rendered)
                XCTAssertEqual(media.author, 1)
                XCTAssertEqual(media.comment_status, .open)
                XCTAssertEqual(media.ping_status, .closed)
                XCTAssertEqual(media.template, "")
                XCTAssertEqual(media.alt_text, "")
                XCTAssertNotNil(media.caption?.rendered)
                XCTAssertNotNil(media.description?.rendered)
                XCTAssertEqual(media.media_type, .image)
                XCTAssertNotNil(media.media_details)
                XCTAssertNotNil(media.media_details?.sizes?.full)
                XCTAssertEqual(media.post, 1)
                XCTAssertEqual(media.source_url, "")
            }
        }
    }
    
    func testWPS_MediaRepository_AllMedias_WithCustomModel_And_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchMedias(filters: [], fields: []) { (result: Result<[WPCustomMediaModel], Error>) in
            switch result {
            case .failure(let error):
                let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
                XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
            default:
                XCTAssertTrue(false)
            }
        }
    }
    
    func testWPS_MediaRepository_AllMedias_WithCustomModel_And_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_medias_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchMedias(filters: [], fields: []) { (result: Result<[WPCustomMediaModel], Error>) in
            switch result {
            case .failure(_ ):
                XCTAssertTrue(false)
            case .success(let medias):
                XCTAssertEqual(medias.count, 4)
                for (idx, media) in medias.enumerated() {
                    XCTAssertEqual(media.id, idx + 1)
                    XCTAssertNotNil(media.date)
                    XCTAssertNotNil(media.date_gmt)
                    XCTAssertNotNil(media.guid?.rendered)
                    XCTAssertEqual(media.link, "https://sitio.com/test_\(idx + 1)/")
                    XCTAssertNotNil(media.modified)
                    XCTAssertNotNil(media.modified_gmt)
                    XCTAssertEqual(media.slug, "test_\(idx + 1)")
                    XCTAssertEqual(media.status, .publish)
                    XCTAssertEqual(media.type, "media")
                    XCTAssertNotNil(media.title?.rendered)
                    XCTAssertEqual(media.author, 1)
                    XCTAssertEqual(media.comment_status, .open)
                    XCTAssertEqual(media.ping_status, .closed)
                    XCTAssertEqual(media.template, "")
                    XCTAssertEqual(media.alt_text, "")
                    XCTAssertNotNil(media.caption?.rendered)
                    XCTAssertNotNil(media.description?.rendered)
                    XCTAssertEqual(media.media_type, .image)
                    XCTAssertNotNil(media.media_details)
                    XCTAssertNotNil(media.media_details?.sizes?.full)
                    XCTAssertEqual(media.post, 1)
                    XCTAssertEqual(media.source_url, "")
                }
            }
        }
    }
    
    func testWPS_MediaRepository_UserMedia_WithCustomModel_And_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchMedia(id: 1, fields: []) { (result: Result<WPCustomMediaModel, Error>) in
            switch result {
            case .failure(let error):
                let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
                XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
            default:
                XCTAssertTrue(false)
            }
        }
    }
    
    func testWPS_MediaRepository_UserMedia_WithCustomModel_And_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_media_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        wps.fetchMedia(id: 1, fields: []) { (result: Result<WPCustomMediaModel, Error>) in
            switch result {
            case .failure(_ ):
                XCTAssertTrue(false)
            case .success(let media):
                XCTAssertEqual(media.id, 1)
                XCTAssertNotNil(media.date)
                XCTAssertNotNil(media.date_gmt)
                XCTAssertNotNil(media.guid?.rendered)
                XCTAssertEqual(media.link, "https://sitio.com/test_1/")
                XCTAssertNotNil(media.modified)
                XCTAssertNotNil(media.modified_gmt)
                XCTAssertEqual(media.slug, "test_1")
                XCTAssertEqual(media.status, .publish)
                XCTAssertEqual(media.type, "media")
                XCTAssertNotNil(media.title?.rendered)
                XCTAssertEqual(media.author, 1)
                XCTAssertEqual(media.comment_status, .open)
                XCTAssertEqual(media.ping_status, .closed)
                XCTAssertEqual(media.template, "")
                XCTAssertEqual(media.alt_text, "")
                XCTAssertNotNil(media.caption?.rendered)
                XCTAssertNotNil(media.description?.rendered)
                XCTAssertEqual(media.media_type, .image)
                XCTAssertNotNil(media.media_details)
                XCTAssertNotNil(media.media_details?.sizes?.full)
                XCTAssertEqual(media.post, 1)
                XCTAssertEqual(media.source_url, "")
            }
        }
    }
}

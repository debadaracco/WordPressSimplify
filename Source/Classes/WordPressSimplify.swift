//
//  WordPressSimplify.swift
//  WordPressSimplify-iOS
//
//  Created by Diego Badaracco on 21/09/2022.
//

import Foundation

public class WordPressSimplify {
    fileprivate let wpUserRepository: WPUserRepositoryProtocol
    fileprivate let wpCategoryRepository: WPCategoryRepositoryProtocol
    fileprivate let wpTagsRepository: WPTagRepositoryProtocol
    fileprivate let wpPostRepository: WPPostRepositoryProtocol
    fileprivate let wpPageRepository: WPPageRepositoryProtocol
    fileprivate let wpMediaRepository: WPMediaRepositoryProtocol
    fileprivate let wpCommentRepository: WPCommentRepositoryProtocol

    public init(
        baseURL: String,
        networkingClientStrategy: WPNetworkingClientStrategy? = nil
    ) {
        let networking = WPNetworking(
            baseURL: baseURL,
            clientStrategy: networkingClientStrategy ?? WPDefaultNetworkingClient()
        )
        self.wpUserRepository = WPUserRepository(networking: networking)
        self.wpCategoryRepository = WPCategoryRepository(networking: networking)
        self.wpTagsRepository = WPTagRepository(networking: networking)
        self.wpPostRepository = WPPostRepository(networking: networking)
        self.wpPageRepository = WPPageRepository(networking: networking)
        self.wpMediaRepository = WPMediaRepository(networking: networking)
        self.wpCommentRepository = WPCommentRepository(networking: networking)
    }
}

// MARK: - Users
extension WordPressSimplify {
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
        self.wpUserRepository.fetch(
            id: id,
            fields: fields,
            completion: completion
        )
    }

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

// MARK: - Categories
extension WordPressSimplify {
    public func fetchCategories<T: WPCategoryModel> (
        filters: [WPRequestFilter.ListCategory] = [WPRequestFilter.ListCategory](),
        fields: [WPRequestField.CategoryFields] = [WPRequestField.CategoryFields](),
        completion: @escaping (Result<[T], Error>) -> Void
    ) {
        self.wpCategoryRepository.fetch(
            filters: filters,
            fields: fields,
            completion: completion
        )
    }

    public func fetchCategory<T: WPCategoryModel>(
        id: Int,
        fields: [WPRequestField.CategoryFields] = [WPRequestField.CategoryFields](),
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        self.wpCategoryRepository.fetch(
            id: id,
            fields: fields,
            completion: completion
        )
    }

    public func fetchCategories(
        filters: [WPRequestFilter.ListCategory] = [WPRequestFilter.ListCategory](),
        fields: [WPRequestField.CategoryFields] = [WPRequestField.CategoryFields](),
        completion: @escaping (Result<[WPCategory], Error>) -> Void
    ) {
        self.wpCategoryRepository.fetch(
            filters: filters,
            fields: fields,
            completion: completion
        )
    }

    public func fetchCategory(
        id: Int,
        fields: [WPRequestField.CategoryFields] = [WPRequestField.CategoryFields](),
        completion: @escaping (Result<WPCategory, Error>) -> Void
    ) {
        self.wpCategoryRepository.fetch(id: id, fields: fields, completion: completion)
    }
}

// MARK: - Tags
extension WordPressSimplify {
    public func fetchTags<T: WPTagModel>(
        filters: [WPRequestFilter.ListTag] = [WPRequestFilter.ListTag](),
        fields: [WPRequestField.TagFields] = [WPRequestField.TagFields](),
        completion: @escaping (Result<[T], Error>) -> Void
    ) {
        self.wpTagsRepository.fetch(
            filters: filters,
            fields: fields,
            completion: completion
        )
    }

    public func fetchTag<T: WPTagModel>(
        id: Int,
        fields: [WPRequestField.TagFields] = [WPRequestField.TagFields](),
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        self.wpTagsRepository.fetch(
            id: id,
            fields: fields,
            completion: completion
        )
    }

    public func fetchTags(
        filters: [WPRequestFilter.ListTag] = [WPRequestFilter.ListTag](),
        fields: [WPRequestField.TagFields] = [WPRequestField.TagFields](),
        completion: @escaping (Result<[WPTag], Error>) -> Void
    ) {
        self.wpTagsRepository.fetch(
            filters: filters,
            fields: fields,
            completion: completion
        )
    }

    public func fetchTag(
        id: Int,
        fields: [WPRequestField.TagFields] = [WPRequestField.TagFields](),
        completion: @escaping (Result<WPTag, Error>) -> Void
    ) {
        self.wpTagsRepository.fetch(
            id: id,
            fields: fields,
            completion: completion
        )
    }
}

// MARK: - Posts
extension WordPressSimplify {
    public func fetchPosts<T: WPPostModel>(
        filters: [WPRequestFilter.ListPost] = [WPRequestFilter.ListPost](),
        fields: [WPRequestField.PostFields] = [WPRequestField.PostFields](),
        completion: @escaping (Result<[T], Error>) -> Void
    ) {
        self.wpPostRepository.fetch(
            filters: filters,
            fields: fields,
            completion: completion
        )
    }

    public func fetchPost<T: WPPostModel>(
        id: Int,
        fields: [WPRequestField.PostFields] = [WPRequestField.PostFields](),
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        self.wpPostRepository.fetch(
            id: id,
            fields: fields,
            completion: completion
        )
    }

    public func fetchPosts(
        filters: [WPRequestFilter.ListPost] = [WPRequestFilter.ListPost](),
        fields: [WPRequestField.PostFields] = [WPRequestField.PostFields](),
        completion: @escaping (Result<[WPPost], Error>) -> Void
    ) {
        self.wpPostRepository.fetch(
            filters: filters,
            fields: fields,
            completion: completion
        )
    }

    public func fetchPost(
        id: Int,
        fields: [WPRequestField.PostFields] = [WPRequestField.PostFields](),
        completion: @escaping (Result<WPPost, Error>) -> Void
    ) {
        self.wpPostRepository.fetch(
            id: id,
            fields: fields,
            completion: completion
        )
    }
}

// MARK: - Pages
extension WordPressSimplify {
    public func fetchPages<T: WPPageModel>(
        filters: [WPRequestFilter.ListPage] = [WPRequestFilter.ListPage](),
        fields: [WPRequestField.PageFields] = [WPRequestField.PageFields](),
        completion: @escaping (Result<[T], Error>) -> Void
    ) {
        self.wpPageRepository.fetch(
            filters: filters,
            fields: fields,
            completion: completion
        )
    }

    public func fetchPage<T: WPPageModel>(
        id: Int,
        fields: [WPRequestField.PageFields] = [WPRequestField.PageFields](),
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        self.wpPageRepository.fetch(
            id: id,
            fields: fields,
            completion: completion
        )
    }

    public func fetchPages(
        filters: [WPRequestFilter.ListPage] = [WPRequestFilter.ListPage](),
        fields: [WPRequestField.PageFields] = [WPRequestField.PageFields](),
        completion: @escaping (Result<[WPPage], Error>) -> Void
    ) {
        self.wpPageRepository.fetch(
            filters: filters,
            fields: fields,
            completion: completion
        )
    }

    public func fetchPage(
        id: Int,
        fields: [WPRequestField.PageFields] = [WPRequestField.PageFields](),
        completion: @escaping (Result<WPPage, Error>) -> Void
    ) {
        self.wpPageRepository.fetch(
            id: id,
            fields: fields,
            completion: completion
        )
    }
}

// MARK: - Media
extension WordPressSimplify {
    public func fetchMedias<T: WPMediaModel>(
        filters: [WPRequestFilter.ListMedia] = [WPRequestFilter.ListMedia](),
        fields: [WPRequestField.MediaFields] = [WPRequestField.MediaFields](),
        completion: @escaping (Result<[T], Error>) -> Void
    ) {
        self.wpMediaRepository.fetch(
            filters: filters,
            fields: fields,
            completion: completion
        )
    }

    public func fetchMedia<T: WPMediaModel>(
        id: Int,
        fields: [WPRequestField.MediaFields] = [WPRequestField.MediaFields](),
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        self.wpMediaRepository.fetch(
            id: id,
            fields: fields,
            completion: completion
        )
    }

    public func fetchMedias(
        filters: [WPRequestFilter.ListMedia] = [WPRequestFilter.ListMedia](),
        fields: [WPRequestField.MediaFields] = [WPRequestField.MediaFields](),
        completion: @escaping (Result<[WPMedia], Error>) -> Void
    ) {
        self.wpMediaRepository.fetch(
            filters: filters,
            fields: fields,
            completion: completion
        )
    }

    public func fetchMedia(
        id: Int,
        fields: [WPRequestField.MediaFields] = [WPRequestField.MediaFields](),
        completion: @escaping (Result<WPMedia, Error>) -> Void
    ) {
        self.wpMediaRepository.fetch(
            id: id,
            fields: fields,
            completion: completion
        )
    }
}

// MARK: - Comment
extension WordPressSimplify {
    public func fetchComments<T: WPCommentModel>(
        filters: [WPRequestFilter.ListComment] = [WPRequestFilter.ListComment](),
        fields: [WPRequestField.CommentFields] = [WPRequestField.CommentFields](),
        completion: @escaping (Result<[T], Error>) -> Void
    ) {
        self.wpCommentRepository.fetch(
            filters: filters,
            fields: fields,
            completion: completion
        )
    }

    public func fetchComment<T: WPCommentModel>(
        id: Int,
        fields: [WPRequestField.CommentFields] = [WPRequestField.CommentFields](),
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        self.wpCommentRepository.fetch(
            id: id,
            fields: fields,
            completion: completion
        )
    }

    public func fetchComments(
        filters: [WPRequestFilter.ListComment] = [WPRequestFilter.ListComment](),
        fields: [WPRequestField.CommentFields] = [WPRequestField.CommentFields](),
        completion: @escaping (Result<[WPComment], Error>) -> Void
    ) {
        self.wpCommentRepository.fetch(
            filters: filters,
            fields: fields,
            completion: completion
        )
    }

    public func fetchComment(
        id: Int,
        fields: [WPRequestField.CommentFields] = [WPRequestField.CommentFields](),
        completion: @escaping (Result<WPComment, Error>) -> Void
    ) {
        self.wpCommentRepository.fetch(
            id: id,
            fields: fields,
            completion: completion
        )
    }
}

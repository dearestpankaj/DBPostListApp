//
//  PostListInteractorTests.swift
//  DBPostListAppTests
//
//  Created by Pankaj Sachdeva on 18/09/23.
//

import XCTest
@testable import DBPostListApp
import Combine

final class PostListInteractorTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!
    
    var sut: PostListPresenterToInteractorProtocol!
    var mockPostListInteractorToRemoteProvider: PostListInteractorToRemoteProviderProtocol!
    var mockPostListInteractorToLocalProvider: PostListInteractorToLocalProviderProtocol!
    
    override func setUpWithError() throws {
        cancellables = []
        mockPostListInteractorToRemoteProvider = MockPostListRemoteProvider(posts: [PostDTO(userID: 1, id: 1, title: "title", body: "body")])
        mockPostListInteractorToLocalProvider = MockPostListLocalProvider()
        
        sut = PostListInteractor(postListRemoteProvider: mockPostListInteractorToRemoteProvider, postListLocalProvider: mockPostListInteractorToLocalProvider)
    }

    func testGetUserPosts_Success() throws {
        sut.getUserPosts(userID: 1).sink { result in } receiveValue: { posts in
            guard let posts = posts else { return }
            XCTAssert(posts.count > 0)
        }.store(in: &cancellables)

    }

    func testFavoritePosts_Success() throws {
        let posts = sut.getFavoritePosts(userID: 1)
        XCTAssert(posts.count > 0)
    }
    
    func testGetPostsFromLocalDatasource_Success() throws {
        let posts = sut.getPostsFromLocalDatasource(1)
        XCTAssert(posts.count > 0)
    }
}

//
//  PostListPresenterTests.swift
//  DBPostListAppTests
//
//  Created by Pankaj Sachdeva on 17/09/23.
//

import XCTest
@testable import DBPostListApp
import Combine

final class PostListPresenterTests: XCTestCase {

    var sut: PostListViewToPresenterProtocol!
    var viewModel: PostListViewModel!
    var mockPostListInteractor: PostListPresenterToInteractorProtocol!
    
    override func setUpWithError() throws {
        viewModel = PostListViewModel()
        mockPostListInteractor = MockPostListPresenterToInteractor(posts: [Post(id: 1, title: "title", detail: "post detail", isFavorite: false)])
        
        sut = PostListPresenter(viewModel: viewModel, interactor: mockPostListInteractor)
    }

    func testGetUserPosts_success() throws {
        sut.getUserPosts(userID: 1)
        XCTAssert(!viewModel.isLoading)
        XCTAssert(viewModel.userID > 0)
        XCTAssert(viewModel.posts.count == 1)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testGetUserPosts_nilPostList_fail() throws {
        mockPostListInteractor = MockPostListPresenterToInteractor(posts: nil)
        sut = PostListPresenter(viewModel: viewModel, interactor: mockPostListInteractor)
        
        sut.getUserPosts(userID: 1)
        XCTAssert(!viewModel.isLoading)
        XCTAssert(viewModel.userID > 0)
        XCTAssert(viewModel.posts.count == 0)
        XCTAssertNotNil(viewModel.errorMessage)
    }
    
    func testSetPostView_setSelectedIndex() {
        sut.setPostView(postType: 0)
        XCTAssert(viewModel.selectedViewType == .all)

        sut.setPostView(postType: 1)
        XCTAssert(viewModel.selectedViewType == .favorite)

        viewModel.selectedViewType = .all
        sut.setPostView(postType: 2)
        XCTAssert(viewModel.selectedViewType == .all)
        
        sut.setPostView(postType: 0)
        XCTAssert(viewModel.posts.count == 2)
        
        sut.setPostView(postType: 1)
        XCTAssert(viewModel.posts.count == 1)
    }
    
}

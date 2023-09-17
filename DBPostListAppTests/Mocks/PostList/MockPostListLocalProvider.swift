//
//  MockPostListLocalProvider.swift
//  DBPostListAppTests
//
//  Created by Pankaj Sachdeva on 18/09/23.
//

import Foundation
@testable import DBPostListApp

class MockPostListLocalProvider: PostListInteractorToLocalProviderProtocol {
    
    func getUserPosts(userID: Int) -> [PostModel] {
        [
            PostModel(userID: 1, postID: 1, title: "title", body: "body"),
            PostModel(userID: 2, postID: 1, title: "title", body: "body")
        ]
    }
    
    func getFavoritePosts(userID: Int) -> [PostModel] {
        [PostModel(userID: 1, postID: 1, title: "title", body: "body")]
    }
    
    func savePosts(posts: [PostModel]) {
        
    }
    
    func setFavoritePostStatus(postID: Int, status: Bool) {
        
    }
    
    
}

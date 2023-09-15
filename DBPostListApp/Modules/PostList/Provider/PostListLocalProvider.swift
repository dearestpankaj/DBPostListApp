//
//  PostListLocalProvider.swift
//  DBPostListApp
//
//  Created by Pankaj Sachdeva on 14/09/23.
//

import Foundation
import RealmSwift

class PostListLocalProvider: PostListInteractorToLocalProviderProtocol {
    
    func getUserPosts(userID: Int) -> [PostModel] {
        let realm = try! Realm()
        let posts = realm.objects(PostModel.self).where {
            $0.userID == userID
        }
        return Array(posts)
    }
    
    func getFavoritePosts(userID: Int) -> [PostModel] {
        let realm = try! Realm()
        
        let favoritePosts = realm.objects(PostModel.self).where { $0.isFavorite && $0.userID == userID }
        let aa = favoritePosts.map { $0 }
        return Array(aa)
    }
    
    func savePosts(userId: Int, posts: [Post]) {
        let realm = try! Realm()
        
        let postsModels = posts.map {
            PostModel(userID: userId, postID: $0.id, title: $0.title, body: $0.detail)
        }
        for post in postsModels {
            try! realm.write {
                realm.create(PostModel.self, value: post, update: .modified)
            }
        }
    }
    
    func setFavoritePostStatus(postID: Int, status: Bool) {
        let realm = try! Realm()
        let posts = realm.objects(PostModel.self)
        let post = posts.first {
            $0.postID == postID
        }
        try! realm.write {
            post?.isFavorite = status
        }
    }
}

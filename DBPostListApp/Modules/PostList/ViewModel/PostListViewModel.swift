//
//  PostListViewModel.swift
//  DBPostListApp
//
//  Created by Pankaj Sachdeva on 11/09/23.
//

import Foundation

enum PostViewType: Int {
    case all = 0
    case favorite = 1
}

class PostListViewModel: ObservableObject {
    var userID = 0
    let pageTitle = "My Posts"
    var selectedViewType: PostViewType = .all
    var posts = [Post]()
    var favoritePosts = [Post]()
}

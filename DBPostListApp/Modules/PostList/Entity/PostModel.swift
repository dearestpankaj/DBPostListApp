//
//  PostModel.swift
//  DBPostListApp
//
//  Created by Pankaj Sachdeva on 14/09/23.
//

import Foundation
import RealmSwift

class PostModel: Object {
    @Persisted var userID: Int
    @Persisted var postID: Int
    @Persisted var title: String
    @Persisted var body: String
    @Persisted var isFavorite = false
    
    override class func primaryKey() -> String? {
        return "postID"
    }
    
    convenience init(userID: Int, postID: Int, title: String, body: String) {
        self.init()
        self.userID = userID
        self.postID = postID
        self.title = title
        self.body = body
    }
}

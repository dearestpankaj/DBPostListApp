//
//  Post.swift
//  DBPostListApp
//
//  Created by Pankaj Sachdeva on 12/09/23.
//

import Foundation
//https://jsonplaceholder.typicode.com/posts?userId=2
struct PostDTO: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

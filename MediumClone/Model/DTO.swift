//
//  Responses.swift
//  MediumClone
//
//  Created by jmlb23 on 25/12/20.
//

import Foundation

// MARK: - ArticleFeed
struct ArticleFeed: Codable {
  let articles: [Article]?
  let articlesCount: Int?
}

// MARK: - ArticleDetail
struct ArticleDetail: Codable {
  let article: Article
}

// MARK: - Comments

struct Comments: Codable {
  let comments: [Comment]
}

// MARK: - Article
struct Article: Codable {
  let slug, title, description, body: String?
  let tagList: [String]?
  let createdAt, updatedAt: String?
  let favorited: Bool?
  let favoritesCount: Int?
  let author: Author?
}

// MARK: - Author
struct Author: Codable {
  let username, bio, image: String?
  let following: Bool?
}

// MARK: - Comment
struct Comment: Codable {
  let id: Int
  let createdAt: String?
  let updatedAt: String?
  let body: String?
  let author: Author?
}

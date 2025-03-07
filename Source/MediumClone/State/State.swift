//
//  State.swift
//  MediumClone
//
//  Created by jmlb23 on 24/3/21.
//

import Foundation

struct FeedState: Equatable {
  static func == (lhs: FeedState, rhs: FeedState) -> Bool {
    lhs.currentPage == rhs.currentPage
  }

  let currentPage: Int
  let articles: [Article]
}

struct DetailState: Equatable {
  static func == (lhs: DetailState, rhs: DetailState) -> Bool {
    lhs.detail?.slug == rhs.detail?.slug
      && lhs.comments.map({ $0.id }) == rhs.comments.map({ $0.id })
  }

  let detail: Article?
  let comments: [Comment]
}

struct AppState: Equatable {
  let token: String?

  let feed: FeedState

  let detail: DetailState
}

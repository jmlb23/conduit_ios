//
//  AppStore.swift
//  MediumClone
//
//  Created by jmlb23 on 26/12/20.
//

import Alamofire
import Combine
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

struct AppEnviroment {
  let articleService = ArticleServiceImp()
}

protocol Store {
  associatedtype State
  associatedtype Action
  associatedtype Enviroment

  var enviroment: Enviroment { get }

  var reducer: (AppActions, AppState) -> AppState { get }

  var middleware: ((GlobalStore, @escaping (AppActions) -> Void, AppActions) -> Void)? { get }

  var state: State { get set }

  func dispatch(_ action: Action)

}

final class GlobalStore: ObservableObject, Store {

  typealias Enviroment = AppEnviroment

  var enviroment: AppEnviroment {
    AppEnviroment()
  }

  var middleware: ((GlobalStore, @escaping (AppActions) -> Void, AppActions) -> Void)?

  typealias State = AppState

  typealias Action = AppActions

  private(set) var reducer: (AppActions, AppState) -> AppState

  init(
    reducer: @escaping (AppActions, AppState) -> AppState,
    middleware: ((GlobalStore, @escaping (AppActions) -> Void, AppActions) -> Void)? = nil,
    initialS: AppState
  ) {
    self.reducer = reducer
    self.middleware = middleware
    self.state = initialS
  }

  @Published var state: AppState

  func dispatch(_ action: AppActions) {
    let oldState = state
    switch middleware {
    case nil:
      state = reducer(action, state)
    case .some(let middleware):
      middleware(self, dispatch, action)
      state = reducer(action, state)
    }
    if state != oldState {
      objectWillChange.send()
    }
  }

}

let store = GlobalStore(
  reducer: mainReducer, middleware: callFeedMiddleware,
  initialS: AppState(
    token: nil, feed: FeedState(currentPage: 0, articles: []),
    detail: DetailState(detail: nil, comments: [])))

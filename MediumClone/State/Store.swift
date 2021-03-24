//
//  AppStore.swift
//  MediumClone
//
//  Created by jmlb23 on 26/12/20.
//

import Alamofire
import Combine
import Foundation

struct AppEnviroment {
  let articleService = ArticleServiceImp()
}

protocol Store {
  associatedtype State
  associatedtype Action
  associatedtype Enviroment

  var enviroment: Enviroment { get }

  var reducer: (AppActions, AppState) -> AppState { get }

  var middleware: [(GlobalStore, @escaping (AppActions) -> Void, AppActions) -> Void] { get }

  var state: State { get set }

  func dispatch(_ action: Action)

}

final class GlobalStore: ObservableObject, Store {

  typealias Enviroment = AppEnviroment

  typealias State = AppState

  typealias Action = AppActions

  var enviroment: AppEnviroment {
    AppEnviroment()
  }

  init(
    reducer: @escaping (AppActions, AppState) -> AppState,
    initialS: AppState,
    middleware: ((GlobalStore, @escaping (AppActions) -> Void, AppActions) -> Void)...
  ) {
    self.reducer = reducer
    self.middleware = middleware
    self.state = initialS
  }

  var middleware: [(GlobalStore, @escaping (AppActions) -> Void, AppActions) -> Void]

  private(set) var reducer: (AppActions, AppState) -> AppState

  @Published var state: AppState

  private func defaultDispatch(_ action: AppActions) {
    state = reducer(action, state)
    objectWillChange.send()
  }

  private lazy var _dispatch: (AppActions) -> Void =
    middleware
    .reversed()
    .map({ $0 })
    .reduce(
      { (a: AppActions) -> Void in self.defaultDispatch(a) },
      { acc, next in
        {
          next(self, acc, $0)
        }
      })

  func dispatch(_ action: AppActions) {
    _dispatch(action)
  }

  func selector<T>(_ select: @escaping (AppState) -> T) -> AnyPublisher<T, Never> {
    $state.map(select).eraseToAnyPublisher()
  }
}

let store = GlobalStore(
  reducer: mainReducer,
  initialS: AppState(
    token: nil,
    feed: FeedState(currentPage: 0, articles: []),
    detail: DetailState(detail: nil, comments: [])
  ),
  middleware: callFeedMiddleware, callDetailMiddleware, loggerMiddleware
)

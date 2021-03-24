//
//  Middlewares.swift
//  MediumClone
//
//  Created by jmlb23 on 27/12/20.
//

import Alamofire
import Combine
import Foundation
import os

func loggerMiddleware(
  _ store: GlobalStore, _ next: @escaping (AppActions) -> Void, action: AppActions
) {
  Logger.i("CURRENT STATE ---> \(store.state)")
  Logger.i("ACTION ---> \(action)")
  next(action)
}

func callFeedMiddleware(
  _ store: GlobalStore, _ next: @escaping (AppActions) -> Void, action: AppActions
) {
  switch action {
  case .feed(let actions):
    switch actions {
    case .getPage:
      store.enviroment.articleService.getFeed(page: store.state.feed.currentPage).subscribe(
        on: DispatchQueue.global()
      ).sink(
        receiveCompletion: { error in
          Logger.i("completed \(error)")
        },
        receiveValue: { feed in
          store.dispatch(AppActions.feed(.updateFeed(feed.articles ?? [])))
        })
    default:
      next(action)
    }
  default:
    next(action)
  }

}

func callDetailMiddleware(
  _ store: GlobalStore, _ next: @escaping (AppActions) -> Void, action: AppActions
) {
  switch action {
  case .detail(let actions):
    switch actions {
    case .loadDetail(let slug):
      store.enviroment.articleService.getFeedDetail(slug: slug).subscribe(
        on: DispatchQueue.global()
      ).sink(
        receiveCompletion: { error in
          Logger.i("completed \(error)")
        },
        receiveValue: { feed in
          store.dispatch(.detail(.refreshDetail(feed.article)))
        })
    default:
      next(action)
    }
  default:
    next(action)
  }

}

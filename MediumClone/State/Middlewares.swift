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

func callFeedMiddleware(
  _ store: GlobalStore, _ next: @escaping (AppActions) -> Void, action: AppActions
) {
  switch action {
  case .feed(let actions):
    switch actions {
    case .addPage:
      store.enviroment.articleService.getFeed(page: store.state.feed.currentPage).subscribe(
        on: DispatchQueue.global()
      ).sink(
        receiveCompletion: { error in
          Logger.i("completed \(error)")
        },
        receiveValue: { feed in
          next(AppActions.feed(.updateFeed(feed.articles ?? [])))
        })
    default:
      ()
    }
  default:
    ()
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
          next(AppActions.detail(.refreshDetail(feed.article)))
        })
      store.enviroment.articleService.getFeedComments(slug: slug).subscribe(
        on: DispatchQueue.global()
      ).sink(
        receiveCompletion: { error in
          Logger.i("completed \(error)")
        },
        receiveValue: { feed in
          next(AppActions.detail(.refreshComments(feed.comments)))
        })
    default:
      ()
    }
  default:
    ()
  }

}

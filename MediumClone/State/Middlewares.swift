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
      store.enviroment.feed.getFeed(page: store.state.feed.currentPage).subscribe(
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

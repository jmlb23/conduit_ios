//
//  Reducers.swift
//  MediumClone
//
//  Created by jmlb23 on 27/12/20.
//

import Combine
import Foundation

func mainReducer(_ action: AppActions, _ state: AppState) -> AppState {
  switch action {
  case .none:
    return state
  case .token(let t):
    return AppState(token: t, feed: state.feed)
  case .feed(let action):
    return AppState(token: state.token, feed: feedReducer(action, state.feed))
  default:
    return state
  }
}

func feedReducer(_ action: AppActions.FeedActions, _ state: FeedState) -> FeedState {
  switch action {
  case .addPage:
    return FeedState(currentPage: state.currentPage + 1, articles: state.articles)
  case .updateFeed(let articles):
    return FeedState(currentPage: state.currentPage, articles: state.articles + articles)
  }
}

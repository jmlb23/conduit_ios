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
    return AppState(token: t, feed: state.feed, detail: state.detail)
  case .feed(let action):
    return AppState(token: state.token, feed: feedReducer(action, state.feed), detail: state.detail)
  case .detail(let action):
    return AppState(
      token: state.token, feed: state.feed, detail: detailReducer(action, state.detail))
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
  default:
    return state
  }
}

func detailReducer(_ action: AppActions.DetailActions, _ state: DetailState) -> DetailState {
  switch action {
  case .refreshDetail(let article):
    return DetailState(detail: article, comments: state.comments)
  case .refreshComments(let comments):
    return DetailState(detail: state.detail, comments: comments)
  default:
    return state
  }
}

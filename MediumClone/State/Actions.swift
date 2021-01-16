//
//  Actions.swift
//  MediumClone
//
//  Created by jmlb23 on 27/12/20.
//

import Foundation

enum AppActions {

  enum FeedActions {
    case addPage
    case updateFeed([Article])
  }
  enum DetailActions {
    case loadDetail(String)
    case refreshDetail(Article)
    case refreshComments([Comment])
  }
  case token(String)
  case none
  case feed(FeedActions)
  case detail(DetailActions)
}

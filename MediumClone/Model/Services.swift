//
//  Services.swift
//  MediumClone
//
//  Created by jmlb23 on 25/12/20.
//

import Alamofire
import Combine
import Foundation
import os

protocol ArticleService {
  associatedtype Err: Error
  func getFeed(page: Int) -> AnyPublisher<ArticleFeed, Err>
  func getFeedDetail(slug: String) -> AnyPublisher<ArticleDetail, Err>
  func getFeedComments(slug: String) -> AnyPublisher<Comments, Err>
}

extension ArticleService {
  fileprivate func buildUrl(_ paths: String...) -> String {
    return "https://conduit.productionready.io/api/\(paths.joined(separator: "/"))"
  }
}

class ArticleServiceImp: ArticleService {
  func getFeedComments(slug: String) -> AnyPublisher<Comments, AFError> {
    return AF.request(
      buildUrl("comments", slug), method: .get,
      headers: [HTTPHeader(name: "Content-Type", value: "Application/json")]
    ).cURLDescription(calling: {
      Logger.i($0)
    }).publishDecodable(type: Comments.self).value()
  }

  func getFeed(page: Int) -> AnyPublisher<ArticleFeed, AFError> {
    return AF.request(
      buildUrl("articles?limit=20&offset=\(page * 20)"), method: .get,
      headers: [HTTPHeader(name: "Content-Type", value: "Application/json")]
    ).cURLDescription(calling: {
      Logger.i($0)
    }).publishDecodable(type: ArticleFeed.self).value()
  }

  func getFeedDetail(slug: String) -> AnyPublisher<ArticleDetail, AFError> {
    return AF.request(
      buildUrl("articles", slug), method: .get,
      headers: [HTTPHeader(name: "Content-Type", value: "Application/json")]
    ).cURLDescription(calling: {
      Logger.i($0)
    }).publishDecodable(type: ArticleDetail.self).value()
  }
}

//
//  FeedComponent.swift
//  MediumClone
//
//  Created by jmlb23 on 27/12/20.
//

import Foundation
import Combine

class FeedComponent : ObservableObject{
    let articleService = ArticleServiceImp()
    
    func getFeed(page: Int) -> AnyPublisher<ArticleFeed,Error>{
        articleService.getFeed(page: page).mapError({ $0 as Error}).eraseToAnyPublisher()
    }
}

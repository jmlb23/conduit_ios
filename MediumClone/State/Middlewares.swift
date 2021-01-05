//
//  Middlewares.swift
//  MediumClone
//
//  Created by jmlb23 on 27/12/20.
//

import Foundation
import os
import Combine
import Alamofire

func callFeedMiddleware(_ store: GlobalStore, _ state: AppState, action: AppActions) -> AppState {
    switch action {
    case .addPage:
        store.enviroment.feed.getFeed(page: store.state.currentPage).subscribe(on: DispatchQueue.global()).sink(receiveCompletion: { error in
            Logger.i("completed \(error)")
        }, receiveValue: { feed in
            Logger.i("info \(feed.articles?.description)")
            store.dispatch(.updateFeed(feed.articles ?? []))
        })
        return state
    default:
        return state
    }

}

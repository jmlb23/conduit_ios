//
//  AppStore.swift
//  MediumClone
//
//  Created by jmlb23 on 26/12/20.
//

import Combine
import Alamofire
import Foundation


struct FeedState: Equatable{
    static func == (lhs: FeedState, rhs: FeedState) -> Bool {
        lhs.currentPage == rhs.currentPage
    }
    
    let currentPage: Int
    let articles: [Article]
}

struct AppState: Equatable{
    let token: String?
    
    let feed: FeedState
    
}

struct AppEnviroment{
    let feed = ArticleServiceImp()
}

protocol Store {
    associatedtype State
    associatedtype Action
    associatedtype Enviroment
    
    var enviroment: Enviroment {get}
    
    var reducer: (AppActions, AppState) ->  AppState  { get }
    
    var middleware: ((Self, AppState, AppActions) -> AppState)? { get }
    
    var state: State { get set }
    
    func dispatch(_ action: Action)
    
}


final class GlobalStore: ObservableObject, Store{
    
    
    typealias Enviroment = AppEnviroment
    
    var enviroment: AppEnviroment {
        AppEnviroment()
    }
    
    var middleware: ((GlobalStore, AppState, AppActions) -> AppState)?
    
    typealias State = AppState
    
    typealias Action = AppActions
    
    private(set) var reducer: (AppActions, AppState) ->  AppState
    
    
    init(reducer: @escaping (AppActions,AppState) -> AppState, middleware:  ((GlobalStore, AppState, AppActions) -> AppState)? = nil, initialS: AppState){
        self.reducer = reducer
        self.middleware = middleware
        self.state = initialS
    }
    
    @Published var state: AppState
    
    func dispatch(_ action: AppActions) {
        let oldState = state
        switch middleware {
        case nil:
            state = reducer(action, state)
        case .some(let middleware):
            state = reducer(action, middleware(self,state,action))
        }
        if state != oldState {
            objectWillChange.send()
        }
    }
    
}

let store = GlobalStore(reducer: mainReducer, middleware: callFeedMiddleware, initialS: AppState(token: nil, feed: FeedState(currentPage: 0, articles: [])))

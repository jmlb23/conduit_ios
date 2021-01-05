//
//  Reducers.swift
//  MediumClone
//
//  Created by jmlb23 on 27/12/20.
//

import Foundation
import Combine

func mainReducer(_ action: AppActions, _ state: AppState) -> AppState{
    switch action {
    case .none:
        return state
    case .token(let t):
        return state.copy(with: t)
    case .addPage:
        return state.copy(with: state.currentPage + 1)
    case .updateFeed(let articles):
        return state.copy(with: state.articles + articles)
    default:
        return state
    }
}

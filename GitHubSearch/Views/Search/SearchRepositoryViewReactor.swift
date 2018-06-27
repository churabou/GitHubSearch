//
//  SearchRepositoryViewModel.swift
//  GitHubSearch
//
//  Created by ちゅーたつ on 2018/06/24.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import ReactorKit
import RxSwift
import RxCocoa

final class SearchRepositoryViewReactor: Reactor {
    
    enum Action {
        case updateQuery(String)
    }
    
    enum Mutation {
        case setQuery(String)
    }
    
    struct State {
        var query = ""
    }
    
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .updateQuery(let query):
            print("Actionでからmutateを作成 query:\(query)")
            return Observable.just(Mutation.setQuery(query))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state //copy old state
        
        switch mutation {
        case .setQuery(let query):
            print("MutationでStateを変更")
            newState.query = query
        }
        
        return newState
    }
}


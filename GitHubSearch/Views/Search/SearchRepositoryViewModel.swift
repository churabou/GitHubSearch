//
//  SearchRepositoryViewModel.swift
//  GitHubSearch
//
//  Created by ちゅーたつ on 2018/06/24.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import RxSwift
import RxCocoa

final class SearchRepositoryViewModel {
    
    var repositoris: BehaviorRelay<[Repository]> = BehaviorRelay(value: [])
    var selectedRepository: Observable<Repository>

    private let bag = DisposeBag()
    private var page: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    
    init(inputs: (
        cellTapped: Observable<IndexPath>,
        searchText: ControlProperty<String>,
        reachedBottom: Observable<Void>)
        ) {

        //Observable<IndexPath> と Observable<Repository>の最後をくっつける。
        //indexPathとRepostoryにアクセスできた。
        selectedRepository = inputs.cellTapped
            .withLatestFrom(repositoris.asObservable()) { $1[$0.row]  }

        let query = inputs.searchText.asObservable()
            .debounce(0.3, scheduler: MainScheduler.instance)
            .skip(1)
            .share()

        query.subscribe(onNext: { [weak self] _ in
            self?.page.accept(0)
            self?.repositoris.accept([])
        }).disposed(by: bag)

        //テーブルがそこまで引っ張られるイベント+まだ最終ページに到達していない。
        let loadMore: Observable<Bool> = inputs.reachedBottom.map { _ in true }
        //
        let initialLoad: Observable<Bool>  = query.map { !$0.isEmpty && self.page.value == 0 }

        let request: Observable<SearchRepositoryRequest> = Observable
            .merge(initialLoad, loadMore)
            .withLatestFrom(query) { SearchRepositoryRequest(query: $1, page: self.page.value) }

        let result = request.flatMapLatest { (request: SearchRepositoryRequest)  in
            GitHubClient.send(request: request)
                .observeOn(MainScheduler.instance)
                .catchErrorJustReturn(SearchResponse.empty)
        }

        result.subscribe(onNext: {
            self.repositoris.accept(self.repositoris.value + $0.items)
            self.page.accept(self.page.value+1)
        }).disposed(by: bag)
    }
}

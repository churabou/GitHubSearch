//
//  SearchRepositoryViewController.swift
//  GitHubSearch
//
//  Created by ちゅーたつ on 2018/06/24.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa


final class SearchRepositoryViewController: UIViewController, View {
    
    var disposeBag = DisposeBag()
    
    func bind(reactor: SearchRepositoryViewReactor) {
       
        print("bind reactor")
        
        searchBar.rx.text.orEmpty
            .debounce(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map { Reactor.Action.updateQuery($0) } //Observable<String> -> SearchRepositoryViewReactor.Action
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        
        reactor.state.map { $0.query }
            .subscribe(onNext: { (query) in
                print("stateの変更でViewを変更 query \(query)")
            }).disposed(by: disposeBag)
    }
    
//    typealias Reactor = SearchRepositoryViewReactor;()
    //View
    private var baseView = SearchRepositoryView()
    private var searchBar: UISearchBar { return baseView.searchBar }
    private var tableView: UITableView { return baseView.tableView }
   
    private let bag = DisposeBag()

    override func loadView() {
        view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reactor = SearchRepositoryViewReactor()
    }
}


extension Reactive where Base: UIScrollView  {
    
    var reachedBottom: Observable<Void> {
        return contentOffset
            .flatMap { [weak base] contentOffset -> Observable<CGFloat> in
                guard let scrollView = base else {
                    return Observable.empty()
                }
                
                let visibleHeight = scrollView.frame.height - scrollView.contentInset.top - scrollView.contentInset.bottom
                let y = contentOffset.y + scrollView.contentInset.top
                let threshold = max(0.0, scrollView.contentSize.height - visibleHeight)
                
                return y > threshold ? Observable.just(scrollView.contentSize.height) : Observable.empty()
            }
            .distinctUntilChanged()
            .map { _ in }
    }
}

//
//  SearchRepositoryViewController.swift
//  GitHubSearch
//
//  Created by ちゅーたつ on 2018/06/24.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchRepositoryViewController: UIViewController {
   
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
        
        let viewModel = SearchRepositoryViewModel(inputs: (
            cellTapped: tableView.rx.itemSelected.asObservable(),
            searchText: searchBar.rx.text.orEmpty,
            reachedBottom: tableView.rx.reachedBottom
        ))
        
        viewModel.repositoris
            .bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "@\(element.name)"
            }.disposed(by: bag)
        
        
        viewModel.selectedRepository.subscribe(onNext: {
            print($0.name + " 選択された。")
        }).disposed(by: bag)
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

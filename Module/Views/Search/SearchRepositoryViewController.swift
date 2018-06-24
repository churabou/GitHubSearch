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
        
        searchBar.rx.text.orEmpty
            .debounce(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { print($0) })
            .disposed(by: bag)
        
        tableView.rx.itemSelected.asDriver().drive(onNext: {
            print($0)
        }).disposed(by: bag)
        
        
        
    }
}

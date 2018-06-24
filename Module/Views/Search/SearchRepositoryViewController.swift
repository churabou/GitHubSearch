//
//  SearchRepositoryViewController.swift
//  GitHubSearch
//
//  Created by ちゅーたつ on 2018/06/24.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import UIKit

final class SearchRepositoryViewController: UIViewController {
    
    private var baseView = SearchRepositoryView()
    private var searchBar: UISearchBar { return baseView.searchBar }
    private var tableView: UITableView { return baseView.tableView }
   
    override func loadView() {
        view = baseView
    }
}

//
//  SearchRepositoryView.swift
//  GitHubSearch
//
//  Created by ちゅーたつ on 2018/06/24.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import UIKit

final class SearchRepositoryView: BaseView {
    
    private (set) var searchBar = UISearchBar()
    private (set) var tableView = UITableView()

    override func initializeView() {
        backgroundColor = .blue
        
        searchBar.tintColor = .red
        tableView.backgroundColor = .cyan
        
        addSubview(searchBar)
        addSubview(tableView)
        setNeedsUpdateConstraints()
    }
    
    override func initializeConstraints() {
       
        searchBar.chura.layout
            .top(0).left(0).right(0).height(100)
        
        tableView.chura.layout
            .top(searchBar.anchor.bottom)
            .left(0).right(0).bottom(0)
    }
}

//
//  SearchRepositoryRequest.swift
//  GitHubSearch
//
//  Created by ちゅーたつ on 2018/06/24.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import Foundation

struct SearchRepositoryRequest: RequestType {
    
    typealias ResponseType = SearchResponse
    
    private var query: String
    private var page: Int
    
    init(query: String, page: Int) {
        self.query = query
        self.page = page
        print(query)
    }
    
    var endPoint: String {
        return "https://api.github.com/search/repositories?q=\(query)&page=\(page)"
    }
}

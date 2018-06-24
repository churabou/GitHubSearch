//
//  SearchResponse.swift
//  GitHubSearch
//
//  Created by ちゅーたつ on 2018/06/24.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import Foundation

struct SearchResponse: Codable {
    var totalCount: Int = 0
    var items: [Repository] = []
    
    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
    
    static var empty: SearchResponse { return SearchResponse() }
}

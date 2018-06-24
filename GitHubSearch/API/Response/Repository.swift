//
//  Repository.swift
//  GitHubSearch
//
//  Created by ちゅーたつ on 2018/06/24.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import Foundation

struct Repository: Codable {
    var id: Int
    var name: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name = "full_name"
    }
}

//
//  RequestType.swift
//  GitHubSearch
//
//  Created by ちゅーたつ on 2018/06/24.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import Foundation

protocol RequestType {
    associatedtype ResponseType
    var endPoint: String { get }
}

extension RequestType {
    func asURLRequest() -> URLRequest {
        return URLRequest(url: URL(string: endPoint)!)
    }
}

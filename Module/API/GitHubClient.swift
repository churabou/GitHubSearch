//
//  GitHubSession.swift
//  GitHubSearch
//
//  Created by ちゅーたつ on 2018/06/24.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import RxSwift

struct GitHubClient {
    
    //APIのエラーなのか、マッピングのエラーなのかわからない・・・
    static func send<T: RequestType>(request: T) -> Observable<T.ResponseType> where T.ResponseType: Decodable {
        let response = URLSession.shared.rx.data(request: request.asURLRequest()).catchErrorJustReturn(Data())
        
        return response.flatMapLatest { (data: Data) -> Observable<T.ResponseType> in
            
            if data.isEmpty {
                return Observable.error(NSError(domain: "api erorr", code: 0, userInfo: nil))
            }
            if let json = try? JSONDecoder().decode(T.ResponseType.self, from: data) {
                return Observable.of(json)
            } else {
                return Observable.error(NSError(domain: "decode erorr", code: 0, userInfo: nil))
            }
        }
    }
}

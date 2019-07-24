//
//  Response.swift
//  NewsArticle
//
//  Created by Muhammad Waqas on 7/24/19.
//  Copyright © 2019 Muhammad Waqas. All rights reserved.
//

import Foundation

public enum NetworkErrors: Error {
    case badInput
    case noData
}

public enum Response {
    case json(_: Any)
    case data(_: Data)
    case error(_: Int?, _: Error?)
    
    init(_ response: (r: HTTPURLResponse?, d: Data?, e: Error?), for request: Request) {
        guard response.r?.statusCode == 200, response.e == nil else {
            self = .error(response.r?.statusCode, response.e)
            return
        }
        
        guard let data = response.d else {
            self = .error(response.r?.statusCode, NetworkErrors.noData)
            return
        }
        
        switch request.dataType {
            case .Data:
                self = .data(data)
            case .Json:
                self = .json(data)
        }
    }
}

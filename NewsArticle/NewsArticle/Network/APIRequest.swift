//
//  APIRequest.swift
//  NewsArticle
//
//  Created by Muhammad Waqas on 7/24/19.
//  Copyright © 2019 Muhammad Waqas. All rights reserved.
//

import Foundation

public enum APIRequest {
    case articleSections
    case articles(section : String, timePeriod: String, offset : Int)
}

extension APIRequest: Request {
    
    public var path: String {
        switch self {
        case .articleSections:
            return Configuration.apiPathArticleSections()
        case .articles(let section,let timePeriod,let offset):
            return Configuration.apiPathArticles(section: section, timePeriod: timePeriod, offset: offset)
        }
    }
    
    public var parameters: RequestParams {
        let key = Configuration.getApiKey()
        switch self {
        case .articleSections:
            return .url(["api-key": key])
        case .articles(_,_,let offset):
            return .url(["api-key": key,"offset": String(offset)])
        }
    }
    
    public var headers: [String : Any]? {
        return [:]
    }
    
    public var method: HTTPMethod {
        switch self {
        case .articleSections:
            return .get
        case .articles(_,_,_):
            return .get
        }
    }
    
    public var dataType: DataType {
        switch self {
        case .articleSections:
            return .Json
        case .articles(_,_,_):
            return .Json
        }
    }
}

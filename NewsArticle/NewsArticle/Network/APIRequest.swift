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
    case logout
}

extension APIRequest: Request {
    
    public var path: String {
        switch self {
        case .articleSections:
            return ConfigurationManager.apiPathSectionsList()
        case .articles(let section,let timePeriod,let offset):
            return ConfigurationManager.apiPathMostViewed(section: section, timePeriod: timePeriod, offset: offset)
        case .logout:
            return "/users/logout"
        }
    }
    
    public var parameters: RequestParams {
        let key = ConfigurationManager.assignApiKey()
        switch self {
        case .articleSections:
            return .url(["api-key": key])
        case .articles(_,_,let offset):
            return .url(["api-key": key,"offset": String(offset)])
        case .logout:
            return.body([:])
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
        case .logout:
            return .post
        }
    }
    
    public var dataType: DataType {
        switch self {
        case .articleSections:
            return .Json
        case .articles(_,_,_):
            return .Json
        case .logout:
            return .Json
        }
    }
}

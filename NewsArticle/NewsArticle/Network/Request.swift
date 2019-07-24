//
//  Request.swift
//  NewsArticle
//
//  Created by Muhammad Waqas on 7/24/19.
//  Copyright © 2019 Muhammad Waqas. All rights reserved.
//

import Foundation

//This defines the type of data we expect as response from server
public enum DataType {
    case Json
    case Data
}

//This defines the type of HTTP method used to perform the request
public enum HTTPMethod: String {
    case post = "POST"
    case put = "PUT"
    case get = "GET"
    case delete = "DELETE"
    case patch = "PATCH"
}

//This defines the parameters to pass along with the request
public enum RequestParams {
    case body(_ : [String: Any]?)
    case url(_ : [String: Any]?)
}

//This is the Request protocol you may implement other classes can conform
public protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: RequestParams { get }
    var headers: [String: Any]? { get }
    var dataType: DataType { get }
}

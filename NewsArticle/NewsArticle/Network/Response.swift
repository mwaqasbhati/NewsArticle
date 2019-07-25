//
//  Response.swift
//  NewsArticle
//
//  Created by Muhammad Waqas on 7/24/19.
//  Copyright © 2019 Muhammad Waqas. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(data: T)
    case failure(error: Error)
}

enum NetworkErrors: Error, LocalizedError {
    case parseUrlFail
    case notFound
    case validationError
    case serverError
    case defaultError
    case badInput

    var errorDescription: String? {
        switch self {
        case .parseUrlFail:
            return "Cannot initial URL object."
        case .notFound:
            return "Not Found"
        case .validationError:
            return "Validation Errors"
        case .serverError:
            return "Internal Server Error"
        case .defaultError:
            return "Something went wrong."
        case .badInput:
            return "Bad Input."
        }
    }
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
            self = .error(response.r?.statusCode, NetworkErrors.serverError)
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

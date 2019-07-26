//
//  Configuration.swift
//  NewsArticle
//
//  Created by Muhammad Waqas on 7/24/19.
//  Copyright © 2019 Muhammad Waqas. All rights reserved.
//

import Foundation

class Configuration {
    
    static let scheme = "https://"
    static let host = "api.nytimes.com"
    static let basePath = "/svc/mostpopular/v2"
    static let path = "/mostviewed/{section}/{time-period}.json"
    static let apiKey = "THh1U1ZNekVxWXFPTEJuSkg1RzZJYzRJNWtDVkEyZDU=" // LxuSVMzEqYqOLBnJH5G6Ic4I5kCVA2d5
    //
    /**
     Returns the API Path for Most Viewed items list.
     
     - parameter section: Section to search e.g. all-sections.
     - parameter timePeriod: Time Period e.g. 1, 7, 30.
     - parameter offset: Pagination offset for the request.
     - returns: Full URL string for Most Viewed with api key and offset params inclusive.
     */
    public static func apiPathArticles(section : String, timePeriod: String, offset : Int) -> String {
        
        if section.count == 0 || timePeriod.count == 0 {
            assertionFailure("section and time period are needed.")
        }
        
        return scheme + host + basePath + "/mostviewed/\(section)/\(timePeriod).json"
    }
    
    /**
     Returns the API Path for available section names list.
     
     - returns: Full URL string for sections list with api key inclusive.
     */
    public static func apiPathArticleSections() -> String {
        
        return scheme + host + basePath + "/viewed/sections.json"
    }
    
    /**
     Concatenates the API Key to a given url.
     
     - parameter path: Path to concatenate api key.
     
     - returns: Full URL string for given path with api key inclusive.
     */
    static  func getApiKey() -> String {
        
        let base64data = Data(base64Encoded: apiKey)
        
        let apiKeyString = String(data: base64data!, encoding: .utf8)!
        
        return apiKeyString
    }
}

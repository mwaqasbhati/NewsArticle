//
//  NetworkFactory.swift
//  NewsArticle
//
//  Created by Muhammad Waqas on 7/24/19.
//  Copyright © 2019 Muhammad Waqas. All rights reserved.
//

import Foundation

//The dispatcher is responsible to execute a Request and provide the response
public protocol Dispatcher {
    
    //Configure the dispatcher with an environment
    init(environment: Environment)
    
    //This function executes the request and provide a response
    func execute(request: Request, completion: @escaping (Any?) -> ()) throws
}

public class NetworkFactory {
    
    private var environment: Environment
    
    required public init(environment: Environment) {
        self.environment = environment
    }
    
    func makeNetworkProvider() -> Dispatcher {
        return NetworkDispatcher(environment: environment)
    }
}

private extension NetworkFactory {
    
    class NetworkDispatcher: Dispatcher {
        
        let session: URLSession
        let environment: Environment
        
        required init(environment: Environment) {
            self.session = URLSession(configuration: .default)
            self.environment = environment
        }
        
        
        func execute(request: Request, completion: @escaping (Any?) -> ()) throws {
            let request = try self.prepare(request: request)
            
            #if DEBUG
            print("Request URL: \(String(describing: request.url))")
            #endif
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
              //  let response = Response.data(data!)
                
                #if DEBUG
                print("Response: \(String(describing: String(data: data ?? Data(), encoding: .utf8)))")
                #endif
                
                completion(data!)
                }.resume()
        }
        
        func prepare(request: Request) throws -> URLRequest {
            
            //1. format the endpoint url using host url and path
            let fullUrl = "\(request.path)"
            
            //2. create an api request object with the url
            var apiRequest = URLRequest(url: URL(string: fullUrl)!)
            
            //3. set api request parameters either as body or as query params
            switch request.parameters {
            case .body(let params):
                if let params = params as? [String : String] {
                    let body = try? JSONEncoder().encode(params)
                    apiRequest.httpBody = body
                } else {
                    throw NetworkErrors.badInput
                }
                
            case .url(let params):
                if let params = params as? [String : String] {
                    let queryParams = params.map { pair  in
                        return URLQueryItem(name: pair.key, value: pair.value)
                    }
                    guard var components = URLComponents(string: fullUrl) else {
                        throw NetworkErrors.badInput
                    }
                    components.queryItems = queryParams
                    apiRequest.url = components.url
                } else {
                    throw NetworkErrors.badInput
                }
            }
            
            //4. set api request header using common enviorment header parameters and specific request parameters
            environment.headers.forEach { apiRequest.addValue($0.value as! String, forHTTPHeaderField: $0.key) }
            request.headers?.forEach { apiRequest.addValue($0.value as! String, forHTTPHeaderField: $0.key) }
            
            //5. set api request http method
            apiRequest.httpMethod = request.method.rawValue
            return apiRequest
        }
    }
}

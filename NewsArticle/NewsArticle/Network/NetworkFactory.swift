//
//  NetworkFactory.swift
//  NewsArticle
//
//  Created by Muhammad Waqas on 7/24/19.
//  Copyright © 2019 Muhammad Waqas. All rights reserved.
//

import Foundation

//The dispatcher is responsible to execute a Request and provide the response
protocol Dispatcher {
    
    //Configure the dispatcher with an environment
    init(environment: Environment)
    
    //This function executes the request and provide a response
    func execute<T: Decodable>(request: Request, decode: T.Type?, completion: @escaping (Result<T, APIError>) -> Void)
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
        
        
        func execute<T: Decodable>(request: Request, decode: T.Type?, completion: @escaping (Result<T, APIError>) -> Void) {
            
            guard Reachability.isConnectedToNetwork() else {
                completion(Result.failure(.internetError))
                return
            }
            
            guard let request = self.prepare(request: request) else {
                completion(Result.failure(.requestFailed))
                return
            }
            
            #if DEBUG
            print("Request URL: \(String(describing: request.url))")
            #endif
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
              //  let response = Response.data(data!)
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(Result.failure(.requestFailed))
                    return
                }
                
                Logger.log(message: "Response:  \(NSString(data: data ?? Data(), encoding:String.Encoding.utf8.rawValue)!)")
                
                if httpResponse.statusCode == 200 {
                    if let data = data {
                        do {
                            let genericModel = try JSONDecoder().decode(T.self, from: data)
                            completion(Result.success(genericModel))
                        } catch {
                            do {
                                let errorModel = try JSONDecoder().decode(ResponseError.self, from: data)
                                completion((Result.failure(.responseError(errorModel.message))))
                            } catch {
                                completion((Result.failure(.jsonParsingFailure)))
                            }
                        }
                    } else {
                        completion((Result.failure(.invalidData)))
                    }
                } else {
                    if let data = data {
                        do {
                            let errorModel = try JSONDecoder().decode(ResponseError.self, from: data)
                            completion((Result.failure(.responseError(errorModel.message))))
                        } catch {
                            completion((Result.failure(.jsonParsingFailure)))
                        }
                    } else {
                        completion((Result.failure(.invalidData)))
                    }
                }
                
                #if DEBUG
                print("Response: \(String(describing: String(data: data ?? Data(), encoding: .utf8)))")
                #endif
                
                
                }.resume()
        }
        
        func prepare(request: Request) -> URLRequest? {
            
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
                    return nil
                }
                
            case .url(let params):
                if let params = params as? [String : String] {
                    let queryParams = params.map { pair  in
                        return URLQueryItem(name: pair.key, value: pair.value)
                    }
                    guard var components = URLComponents(string: fullUrl) else {
                        return nil
                    }
                    components.queryItems = queryParams
                    apiRequest.url = components.url
                } else {
                    return nil
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




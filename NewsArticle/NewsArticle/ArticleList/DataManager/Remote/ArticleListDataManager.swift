//
//  PostListRemoteDataManager.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//

import Foundation

class ArticleListDataManager: ArticleListDataManagerInputProtocol {
    
    weak var remoteRequestHandler: ArticleListDataManagerOutputProtocol?
    
    func loadArticleSections() {
        
        let factory = NetworkFactory(environment: .init("", host: ""))
        let dispatcher = factory.makeNetworkProvider()
        let request = APIRequest.articleSections
        do {
            try dispatcher.execute(request: request) { (response) in
                
                let decoder = JSONDecoder()
                let response = response as! Data
                do {
                    let articles = try decoder.decode(ArticleSectionBase.self, from: response)
                    print(articles)
                    self.remoteRequestHandler?.onArticleSectionRetrieved(articles)

                } catch {
                    print("Failed to decode JSON")
                }
            }
        } catch(let error) {
            print(error)
        }
        
    }
    
    func loadArticles(section: String, timePeriod: TimePeriod, offset: Int) {
        
        let factory = NetworkFactory(environment: .init("", host: ""))
        let dispatcher = factory.makeNetworkProvider()
        let request = APIRequest.articles(section: section, timePeriod: timePeriod.rawValue, offset: offset)
        do {
            try dispatcher.execute(request: request) { (response) in
                
                let decoder = JSONDecoder()
                let response = response as! Data
                do {
                    let articles = try decoder.decode(ArticleListBase.self, from: response)
                    print(articles)
                    self.remoteRequestHandler?.onArticleRetrieved(articles)
                    
                } catch {
                    print("Failed to decode JSON")
                }
            }
        } catch(let error) {
            print(error)
        }
        
        
    }
}

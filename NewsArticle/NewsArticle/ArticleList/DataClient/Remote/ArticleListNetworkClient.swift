//
//  PostListRemoteDataManager.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//

import Foundation

class ArticleListNetworkClient: ArticleListDataManagerInputProtocol {
    
    weak var remoteRequestHandler: ArticleListDataManagerOutputProtocol?
    
    func loadArticleSections() {
        
        let factory = NetworkFactory(environment: .init("", host: ""))
        let dispatcher = factory.makeNetworkProvider()
        let request = APIRequest.articleSections
        
        dispatcher.execute(request: request, decode: ArticleSectionBase.self) { [weak self] (response) in
            guard let `self` = self else { return }
            switch response {
            case .success(let articles):
                self.remoteRequestHandler?.onArticleSectionRetrieved(articles)
            case .failure(let error):
                self.remoteRequestHandler?.onError(error)
            }
        }
    }
    
    func loadArticles(section: String, timePeriod: TimePeriod, offset: Int) {
        
        let factory = NetworkFactory(environment: .init("", host: ""))
        let dispatcher = factory.makeNetworkProvider()
        let request = APIRequest.articles(section: section, timePeriod: timePeriod.rawValue, offset: offset)
        dispatcher.execute(request: request, decode: ArticleListBase.self) { (response) in
            switch response {
            case .success(let articles):
                self.remoteRequestHandler?.onArticleRetrieved(articles)
            case .failure(let error):
                self.remoteRequestHandler?.onError(error)
            }
        }
    }
}

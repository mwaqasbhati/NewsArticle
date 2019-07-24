//
//  ArticleListInteractor.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//


class ArticleListInteractor: ArticleListInteractorInputProtocol {
    weak var presenter: ArticleListInteractorOutputProtocol?
    var dataManager: ArticleListDataManagerInputProtocol?
    
    func loadArticleSections() {
        dataManager?.loadArticleSections()
    }
    func loadArticles(section : String, timePeriod : TimePeriod, offset: Int) {
       dataManager?.loadArticles(section: section, timePeriod: timePeriod, offset: offset)
    }
        
}

extension ArticleListInteractor: ArticleListDataManagerOutputProtocol {
    func onArticleSectionRetrieved(_ articles: ArticleSectionBase)
    {
        presenter?.didArticleSectionSuccess(articles)
    }
    func onArticleRetrieved(_ articles: ArticleListBase) {
        presenter?.didArticleListSuccess(articles)
    }
    func onError(_ error: Error) {
        presenter?.onError(error)
    }
}

//
//  ArticleListInteractor.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//


class ArticleListInteractor {
    weak var presenter: ArticleListInteractorOutputProtocol?
    var dataManager: ArticleListDataManagerInputProtocol?
}

// MARK: Interactor to DataManager
extension ArticleListInteractor: ArticleListInteractorInputProtocol {
    func loadArticleSections() {
        let request = APIRequest.articleSections
        dataManager?.loadArticleSections(request)
    }
    func loadArticles(section : String, timePeriod : TimePeriod, offset: Int) {
        let request = APIRequest.articles(section: section, timePeriod: timePeriod.rawValue, offset: offset)
        dataManager?.loadArticles(request, section: section, timePeriod: timePeriod, offset: offset)
    }
}

// MARK: Interactor to Presenter
extension ArticleListInteractor: ArticleListDataManagerOutputProtocol {
    func onArticleSectionRetrieved(_ articles: ArticleSectionBase) {
        presenter?.didArticleSectionSuccess(articles)
    }
    func onArticleRetrieved(_ articles: ArticleListBase) {
        presenter?.didArticleListSuccess(articles)
    }
    func onError(_ error: Error) {
        presenter?.onError(error)
    }
}

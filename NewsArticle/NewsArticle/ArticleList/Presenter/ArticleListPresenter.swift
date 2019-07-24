//
//  ArticleListPresenter.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//


class ArticleListPresenter: ArticleListPresenterProtocol {
    weak var view: ArticleListViewProtocol?
    var interactor: ArticleListInteractorInputProtocol?
    var wireFrame: ArticleListWireFrameProtocol?
    
    func loadArticleSections() {
        view?.showLoading()
        interactor?.loadArticleSections()
    }
    func loadArticles(section : String, timePeriod : TimePeriod, offset: Int) {
        view?.showLoading()
        interactor?.loadArticles(section: section, timePeriod: timePeriod, offset: offset)
    }
    func moveToDetailView() {
        if let view = view {
            wireFrame?.presentArticleDetail(from: view)
        }
    }
}

extension ArticleListPresenter: ArticleListInteractorOutputProtocol {
    
    func didArticleSectionSuccess(_ sections: ArticleSectionBase) {
        view?.hideLoading()
        view?.showArticleSections(sections)
    }
    func didArticleListSuccess(_ articles: ArticleListBase) {
        view?.hideLoading()
        view?.showArticles(articles)
    }

    func onError(_ error: Error) {
        view?.hideLoading()
        view?.showError(error.localizedDescription)
    }
    
}



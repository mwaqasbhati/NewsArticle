//
//  ArticleListPresenter.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//


class ArticleListPresenter {
    weak var view: ArticleListViewProtocol?
    var interactor: ArticleListInteractorInputProtocol?
    var wireFrame: ArticleListWireFrameProtocol?
}

// MARK: - Presenter to Interactor
extension ArticleListPresenter: ArticleListPresenterProtocol {
    func loadArticleSections() {
        view?.showLoading()
        interactor?.loadArticleSections()
    }
    func loadArticles(section : String, timePeriod : TimePeriod, offset: Int) {
        view?.showLoading()
        interactor?.loadArticles(section: section, timePeriod: timePeriod, offset: offset)
    }
    func moveToDetailView(_ article: Article) {
        if let view = view {
            wireFrame?.presentArticleDetail(from: view, article: article)
        }
    }
}

// MARK: - Presenter to View
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



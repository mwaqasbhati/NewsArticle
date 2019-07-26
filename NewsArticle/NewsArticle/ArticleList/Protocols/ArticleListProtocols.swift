//
//  ArticleListProtocols.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//

import UIKit


protocol ArticleListViewProtocol: class {
    var presenter: ArticleListPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showArticleSections(_ articles: ArticleSectionBase)
    func showArticles(_ articles: ArticleListBase)
    func showError(_ message: String)
    func showLoading()
    func hideLoading()
}

protocol ArticleListWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    func presentArticleDetail(from view: ArticleListViewProtocol, article: Article)
}

protocol ArticleListPresenterProtocol: class {
    var view: ArticleListViewProtocol? { get set }
    var interactor: ArticleListInteractorInputProtocol? { get set }
    var wireFrame: ArticleListWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func loadArticleSections()
    func loadArticles(section : String, timePeriod : TimePeriod, offset: Int)
    func moveToDetailView(_ article: Article)
}

protocol ArticleListInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didArticleListSuccess(_ articles: ArticleListBase)
    func didArticleSectionSuccess(_ sections: ArticleSectionBase)
    func onError(_ error: Error)
}

protocol ArticleListInteractorInputProtocol: class {
    var presenter: ArticleListInteractorOutputProtocol? { get set }
    var dataManager: ArticleListDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func loadArticleSections()
    func loadArticles(section : String, timePeriod : TimePeriod, offset: Int)
}

protocol ArticleListDataManagerInputProtocol: class {
    var remoteRequestHandler: ArticleListDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> DATAMANAGER
    func loadArticleSections(_ request: Request)
    func loadArticles(_ request: Request, section : String, timePeriod : TimePeriod, offset: Int)
}

protocol ArticleListDataManagerOutputProtocol: class {
    // DATAMANAGER -> INTERACTOR
    func onArticleSectionRetrieved(_ articles: ArticleSectionBase)
    func onArticleRetrieved(_ articles: ArticleListBase)
    func onError(_ error: Error)
}


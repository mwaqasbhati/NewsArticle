//
//  ArticleDetailPresenter.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//


class ArticleDetailPresenter {
    
    var article: Article
    weak var view: ArticleDetailViewProtocol?
    var interactor: ArticleDetailInteractorInputProtocol?
    var wireFrame: ArticleDetailWireFrameProtocol?
    
    init(_ article: Article) {
        self.article = article
    }
}

extension ArticleDetailPresenter: ArticleDetailPresenterProtocol { }
extension ArticleDetailPresenter: ArticleDetailInteractorOutputProtocol { }



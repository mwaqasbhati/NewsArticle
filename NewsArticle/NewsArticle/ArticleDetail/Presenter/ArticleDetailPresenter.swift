//
//  ArticleDetailPresenter.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//


class ArticleDetailPresenter: ArticleDetailPresenterProtocol {
    
    var article: Results
    
    weak var view: ArticleDetailViewProtocol?
    var interactor: ArticleDetailInteractorInputProtocol?
    var wireFrame: ArticleDetailWireFrameProtocol?
    
    init(_ article: Results) {
        self.article = article
    }
//    func showArticleDetail() {
//        view?.showLoading()
//        view?.showArticleDetail(article)
//    }
    func goBack() {
        wireFrame?.goBack(from: view!)
    }
}

extension ArticleDetailPresenter: ArticleDetailInteractorOutputProtocol {
    
    
}



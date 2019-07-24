//
//  ArticleDetailInteractor.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//


class ArticleDetailInteractor: ArticleDetailInteractorInputProtocol {
    weak var presenter: ArticleDetailInteractorOutputProtocol?
    var dataManager: ArticleDetailDataManagerInputProtocol?
    
    func loginWithUserName(_ name: String, password: String) {
        dataManager?.verifyUser(name, password: password)
    }
        
}

extension ArticleDetailInteractor: ArticleDetailDataManagerOutputProtocol {
    func onUserRetrieved() {
        presenter?.didArticleDetailSuccess()
    }
    func onError(_ error: Error) {
        presenter?.onError(error)
    }
}

//
//  ArticleDetailInteractor.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//


class ArticleDetailInteractor: ArticleDetailInteractorInputProtocol {
    weak var presenter: ArticleDetailInteractorOutputProtocol?
    var dataManager: ArticleDetailDataManagerInputProtocol?
}

extension ArticleDetailInteractor: ArticleDetailDataManagerOutputProtocol {
    
}

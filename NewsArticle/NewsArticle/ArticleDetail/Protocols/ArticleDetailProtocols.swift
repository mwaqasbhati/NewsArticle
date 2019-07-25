//
//  ArticleDetailProtocols.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//

import UIKit


protocol ArticleDetailViewProtocol: class {
    var presenter: ArticleDetailPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    
    func showArticleDetail(_ article: Results)
    
    func showError(_ message: String)
    
    func showLoading()
    
    func hideLoading()
}

protocol ArticleDetailWireFrameProtocol: class {
   // static func createArticleDetailModule() -> UIViewController
    // PRESENTER -> WIREFRAME
    func goBack(from view: ArticleDetailViewProtocol)
}

protocol ArticleDetailPresenterProtocol: class {
    var view: ArticleDetailViewProtocol? { get set }
    var interactor: ArticleDetailInteractorInputProtocol? { get set }
    var wireFrame: ArticleDetailWireFrameProtocol? { get set }
    var article: Results {get set}
    // VIEW -> PRESENTER
   // func showArticleDetail(_ article: Results)
    func goBack()
}

protocol ArticleDetailInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
}

protocol ArticleDetailInteractorInputProtocol: class {
    var presenter: ArticleDetailInteractorOutputProtocol? { get set }
    var dataManager: ArticleDetailDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
}

protocol ArticleDetailDataManagerInputProtocol: class {
    var remoteRequestHandler: ArticleDetailDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> DATAMANAGER
}

protocol ArticleDetailDataManagerOutputProtocol: class {
    // DATAMANAGER -> INTERACTOR
}


//
//  ArticleDetailProtocols.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//

import UIKit


protocol ArticleDetailViewProtocol: class {
    var presenter: ArticleDetailPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showLoggedIn()
    
    func showError(_ message: String)
    
    func showLoading()
    
    func hideLoading()
}

protocol ArticleDetailWireFrameProtocol: class {
   // static func createArticleDetailModule() -> UIViewController
    // PRESENTER -> WIREFRAME
    func goBack(from view: ArticleDetailViewProtocol)
    func presentSignupScreen(from view: ArticleDetailViewProtocol)
    func presentHomeScreen(from view: ArticleDetailViewProtocol)
}

protocol ArticleDetailPresenterProtocol: class {
    var view: ArticleDetailViewProtocol? { get set }
    var interactor: ArticleDetailInteractorInputProtocol? { get set }
    var wireFrame: ArticleDetailWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func loginWithUserName(_ name: String, password: String)
    func moveToHomeView()
    func moveToSignupView()
    func goBack()
}

protocol ArticleDetailInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didArticleDetailSuccess()
    func onError(_ error: Error)
}

protocol ArticleDetailInteractorInputProtocol: class {
    var presenter: ArticleDetailInteractorOutputProtocol? { get set }
    var dataManager: ArticleDetailDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func loginWithUserName(_ name: String, password: String)
}

protocol ArticleDetailDataManagerInputProtocol: class {
    var remoteRequestHandler: ArticleDetailDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> DATAMANAGER
    func verifyUser(_ name: String, password: String)
}

protocol ArticleDetailDataManagerOutputProtocol: class {
    // DATAMANAGER -> INTERACTOR
    func onUserRetrieved()
    func onError(_ error: Error)
}


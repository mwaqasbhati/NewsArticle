//
//  ArticleDetailProtocols.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//

import UIKit


protocol ArticleDetailViewProtocol: class {
    var presenter: ArticleDetailPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW        
}

protocol ArticleDetailWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
}

protocol ArticleDetailPresenterProtocol: class {
    var view: ArticleDetailViewProtocol? { get set }
    var interactor: ArticleDetailInteractorInputProtocol? { get set }
    var wireFrame: ArticleDetailWireFrameProtocol? { get set }
    var article: Article {get set}
    // VIEW -> PRESENTER
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


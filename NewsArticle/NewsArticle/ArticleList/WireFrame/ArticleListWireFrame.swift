//
//  ArticleListWireFrame.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//

import UIKit

class ArticleListWireFrame: ArticleListWireFrameProtocol {
    
    /**
     Setup Article List Module.
     
     This method create article list view all elements like presenter, interactor, wireframe etc and return it if it is successfully initialized.
     */
    
    static func createArticleListModule() -> UIViewController? {
        if let rootViewController = Storyboard.ArticleList.controller as? ArticleListView {
            let presenter = ArticleListPresenter()
            let interactor = ArticleListInteractor()
            let wireFrame = ArticleListWireFrame()
            let dispatcher = NetworkDispatcher(configuration: URLSession(configuration: .default))
            let dataClient = ArticleListNetworkClient(dispatcher)
            
            dataClient.remoteRequestHandler = interactor
            interactor.presenter = presenter
            interactor.dataManager = dataClient
            presenter.interactor = interactor
            presenter.wireFrame = wireFrame
            presenter.view = rootViewController
            rootViewController.presenter = presenter
            let navController = UINavigationController(rootViewController: rootViewController)
            return navController
        }
        return nil
    }
    
    /**
     Create and present article detail view to current view hierarchy
     
     
     - parameter view: view object on which we want to present detail.
     - parameter article: Article object which will be assigned to UI.

     This methods accepts article data object which will be assigner to UI elements e.g title, description.
     */
    
    func presentArticleDetail(from view: ArticleListViewProtocol, article: Article) {
        
        if let view = view as? UIViewController, let controller = ArticleDetailWireFrame.createArticleDetailModule(article) {
            view.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

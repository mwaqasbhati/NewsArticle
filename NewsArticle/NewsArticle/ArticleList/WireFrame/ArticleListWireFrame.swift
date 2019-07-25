//
//  ArticleListWireFrame.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//

import UIKit


class ArticleListWireFrame: ArticleListWireFrameProtocol {
    
    static func createArticleListModule()->UIViewController? {
        if let rootViewController = mainStoryboard.instantiateViewController(withIdentifier: "ArticleListView") as? ArticleListView {
        let presenter = ArticleListPresenter()
        let interactor = ArticleListInteractor()
        let wireFrame = ArticleListWireFrame()
        let dataClient = ArticleListNetworkClient()
        
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
    func presentArticleDetail(from view: ArticleListViewProtocol, article: Article) {
        
        if let view = view as? UIViewController, let controller = ArticleDetailWireFrame.createArticleDetailModule(article) {
            view.navigationController?.pushViewController(controller, animated: true)
        }
    }
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }

    
}

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
        let dataManager = ArticleListDataManager()
        
        dataManager.remoteRequestHandler = interactor
        interactor.presenter = presenter
        interactor.dataManager = dataManager
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        presenter.view = rootViewController
        rootViewController.presenter = presenter
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.isNavigationBarHidden = true
            return navController
        }
        return nil
    }
    func presentArticleDetail(from view: ArticleListViewProtocol) {
        
    }
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }

    
}

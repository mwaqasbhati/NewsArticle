//
//  ArticleDetailWireFrame.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//

import UIKit


class ArticleDetailWireFrame {
    
    /**
     Setup Article detail Module.
     
     - parameter article: accepts article object.

     This method creates article detail view all business elements like presenter, interactor, wireframe etc and return it if it is successfully initialized.
     */
    
    static func createArticleDetailModule(_ article: Article) -> UIViewController? {
        if let articleDetail = Storyboard.ArticleDetail.controller as? ArticleDetailView {
        let presenter = ArticleDetailPresenter(article)
        let interactor = ArticleDetailInteractor()
        let wireFrame = ArticleDetailWireFrame()
        let dataManager = ArticleDetailDataManager()
        
        dataManager.remoteRequestHandler = interactor
        interactor.presenter = presenter
        interactor.dataManager = dataManager
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        presenter.view = articleDetail
        articleDetail.presenter = presenter
        return articleDetail
        
        }
        return nil
    }
}

extension ArticleDetailWireFrame: ArticleDetailWireFrameProtocol {}

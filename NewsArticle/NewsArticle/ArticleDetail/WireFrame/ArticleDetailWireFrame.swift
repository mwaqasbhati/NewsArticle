//
//  ArticleDetailWireFrame.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//

import UIKit


class ArticleDetailWireFrame: ArticleDetailWireFrameProtocol {
    
    func goBack(from view: ArticleDetailViewProtocol) {
        if let view = view as? UIViewController {
            view.navigationController?.popViewController(animated: true)
        }
    }
    static func createArticleDetailModule()->UIViewController? {
        if let loginVC = mainStoryboard.instantiateViewController(withIdentifier: "ArticleDetailView") as? ArticleDetailView {
        let presenter = ArticleDetailPresenter()
        let interactor = ArticleDetailInteractor()
        let wireFrame = ArticleDetailWireFrame()
        let dataManager = ArticleDetailDataManager()
        
        dataManager.remoteRequestHandler = interactor
        interactor.presenter = presenter
        interactor.dataManager = dataManager
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        presenter.view = loginVC
        loginVC.presenter = presenter
            return loginVC
        }
        return nil
    }
    func presentSignupScreen(from view: ArticleDetailViewProtocol) {

    }
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    func presentHomeScreen(from view: ArticleDetailViewProtocol) {
        

    }
    
}

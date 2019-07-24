//
//  ArticleDetailPresenter.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//


class ArticleDetailPresenter: ArticleDetailPresenterProtocol {
    weak var view: ArticleDetailViewProtocol?
    var interactor: ArticleDetailInteractorInputProtocol?
    var wireFrame: ArticleDetailWireFrameProtocol?
    
    func loginWithUserName(_ name: String, password: String) {
        view?.showLoading()
        interactor?.loginWithUserName(name, password: password)
    }
    func goBack() {
        wireFrame?.goBack(from: view!)
    }
    func moveToSignupView() {
        wireFrame?.presentSignupScreen(from: view!)
    }
    func moveToHomeView() {
         wireFrame?.presentHomeScreen(from: view!)
    }
}

extension ArticleDetailPresenter: ArticleDetailInteractorOutputProtocol {
    
    func didArticleDetailSuccess() {
        view?.hideLoading()
        view?.showLoggedIn()
    }
    func onError(_ error: Error) {
        view?.hideLoading()
        view?.showError(error.localizedDescription)
    }
    
}



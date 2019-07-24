//
//  ArticleDetailView.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//

import UIKit
import PKHUD

class ArticleDetailView: UIViewController {
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var buttonArticleDetailWithGoogle: UIButton!
    
    var presenter: ArticleDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        buttonArticleDetailWithGoogle.addShadow()
    }
    private func doArticleDetailWith(_ name: String, password: String) {
        presenter?.loginWithUserName(name, password: password)
    }

}

extension ArticleDetailView: ArticleDetailViewProtocol {
    
    func showLoggedIn() {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.presenter?.moveToHomeView()
        }
    }
    
    func showError(_ message: String) {
        DispatchQueue.main.async {
            HUD.flash(.label(message), delay: 2.0)
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            HUD.show(.progress)
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            HUD.hide()
        }
    }
    
}


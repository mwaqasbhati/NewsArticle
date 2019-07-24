//
//  ArticleListView.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//

import UIKit
import PKHUD

class ArticleListView: UIViewController {
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var buttonArticleListWithGoogle: UIButton!
    
    var presenter: ArticleListPresenterProtocol?
    var articles: ArticleListBase?
    
    let searchBar = UISearchBar()
   // var menu : AZDropdownMenu?
    
  //  var sections : [SectionsResults]? = nil
    var defaultSection = "all-sections"
    var defaultTimePeriod = TimePeriod.Week { didSet {
     //   refreshControl?.attributedTitle = NSAttributedString(string: self.getFetchingMessage())
        
        } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doLoadArticleSections()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    private func doLoadArticleSections() {
       // presenter?.loadArticleSections()
        presenter?.loadArticles(section: defaultSection, timePeriod: defaultTimePeriod, offset: 20)
    }
}

extension ArticleListView: ArticleListViewProtocol {
    
    func showArticleSections(_ articles: ArticleSectionBase) {
        //
    }
    func showArticles(_ articles: ArticleListBase) {
        self.articles = articles
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
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


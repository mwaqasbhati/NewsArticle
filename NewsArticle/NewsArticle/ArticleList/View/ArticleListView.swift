//
//  ArticleListView.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//

import UIKit
import PKHUD

class ArticleListView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
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
            self.tableView.reloadData()
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

extension ArticleListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles?.results?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleListTableViewCell.cellId) as? ArticleListTableViewCell else {
            return UITableViewCell()
        }
        if let article = articles?.results?[indexPath.row] {
            cell.setArticle(article)
        }
        return cell
    }
    
}

extension ArticleListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let article = articles?.results?[indexPath.row] {
            presenter?.moveToDetailView(article)
        }
    }
    
}

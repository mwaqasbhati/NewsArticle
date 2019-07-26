//
//  ArticleListView.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//

import UIKit
import PKHUD
import Dropdowns

class ArticleListView: UIViewController {
    
    // MARK: - Constants

    private enum Constants {
        static let allSections = "all-sections"
        static let cancel = "Cancel"
        static let popularItemsTitle = "See most popular items for"
        static let all = "All"
    }
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Instance Variables
    
    private let searchBar = UISearchBar()
    private let refreshControl = UIRefreshControl()
    private var articles = [Article]()
    private var sections = [String]()
    private var filteredArticles = [Article]()
    private var currentOffset = 0
    private var searchMode = false
    private var totalResults = 0
    private var selectedSection: String?
    private var defaultSection = Constants.allSections
    private var defaultTimePeriod = TimePeriod.Week
    var presenter: ArticleListPresenterProtocol?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchArticles()
        fetchArticleSections()
        setup()
    }
    
    // MARK: - Helper Methods
    
    /**
     setup will initialize basic UI elements.
     
     This method initializes basic UI elements
     */
    
    private func setup() {
        // Configure Search Bar
        searchBar.showsCancelButton = true
        searchBar.returnKeyType = UIReturnKeyType.done
        searchBar.delegate = self
        
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(ArticleListView.refresh), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
        
        // Configure Table View
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
    }
    
    /**
     It fetches article categories from Network API.
     
     
     This method fetches all article categories like entertainment, music etc.
     */
    
    private func fetchArticleSections() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let `self` = self else { return }
            self.presenter?.loadArticleSections()
        }
    }
    
    /**
     It fetches article data from Network API..
     
     
     This method fetches article based on section, time and offset.
     */
    
    private func fetchArticles() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let `self` = self else { return }
            self.presenter?.loadArticles(section: self.defaultSection, timePeriod: self.defaultTimePeriod, offset: self.currentOffset)
        }
    }
    
    /**
     It reset all article data filters and fetches all sections from Network API.
     
     
     This method refreshed article data.
     */
    
    @objc func refresh(sender:AnyObject) {
         defaultSection = Constants.allSections
         resetFiltersAndLoad()
    }
    
    /**
     It reset article offset to 0 and fetches articles.
     
    */
    
    private func resetFiltersAndLoad() {
        currentOffset = 0
        articles.removeAll()
        presenter?.loadArticles(section: defaultSection, timePeriod: defaultTimePeriod, offset: currentOffset)
    }
    private func showTimePeriodFilters() {
        let alert = UIAlertController(title: Constants.popularItemsTitle, message: nil, preferredStyle: .actionSheet)
        for timePeriod in TimePeriod.names {
            let timePeriodAction = UIAlertAction(title: getDisplayNameForTimePeriod(timePeriod: timePeriod),
                                                 style: .default, handler: { action in
                                                    self.defaultTimePeriod = timePeriod
                                                    self.fetchArticles()
            })
            alert.addAction(timePeriodAction)
        }
        let cancelAction = UIAlertAction(title: Constants.cancel,
                                         style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func getDisplayNameForTimePeriod(timePeriod: TimePeriod) -> String {
        var displayName = timePeriod.name
        if defaultTimePeriod == timePeriod {
            displayName = "✓ " + displayName
        }
        return displayName
    }
    // MARK: - IBActions

    @IBAction func searchButtonPressed(_ sender: Any) {
        if searchMode {
            searchBarCancelButtonClicked(searchBar)
            return
        }
        filteredArticles = articles
        searchMode = true
        tableView.tableHeaderView = searchBar
        searchBar.sizeToFit()
        searchBar.becomeFirstResponder()
    }
    
    @IBAction func rightButtonPressed(_ sender: Any) {
        showTimePeriodFilters()
    }
}

// MARK: - ArticleListViewProtocol

extension ArticleListView: ArticleListViewProtocol {
    
    func showArticleSections(_ articles: ArticleSectionBase) {
        sections = [defaultSection]
        sections.append(contentsOf: (articles.results ?? [ArticleSectionResults]()).map({ $0.name ?? "" }))
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self, let navC = self.navigationController else { return }
            if let titleView = TitleView(navigationController: navC, title: Constants.all, items: self.sections) {
                self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleView)
                titleView.action = { [weak self] index in
                    guard let `self` = self else { return }
                    self.defaultSection = self.sections[index]
                    self.resetFiltersAndLoad()
                }
            }
        }
    }
    func showArticles(_ articles: ArticleListBase) {
        self.articles.append(contentsOf: articles.results ?? [Article]())
        totalResults = articles.num_results ?? 0
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
            self.tableView.scrollToRow(at: IndexPath(row: self.currentOffset, section: 0), at: .bottom, animated: false)
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

// MARK: - UITableView DataSource & Delegate
extension ArticleListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchMode {
            return filteredArticles.count
        } else {
            return articles.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleListTableViewCell.cellId) as? ArticleListTableViewCell else {
            return UITableViewCell()
        }
        let count = searchMode ? filteredArticles.count : articles.count
        if indexPath.row < count {
            let article = searchMode ? filteredArticles[indexPath.row] : articles[indexPath.row]
            cell.setArticle(article)
        }
        return cell
    }
}

extension ArticleListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        presenter?.moveToDetailView(article)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let offsetNumber = indexPath.row + 1
        if (offsetNumber % 20 == 0 && offsetNumber > currentOffset && articles.count <= totalResults) {
            currentOffset = offsetNumber
            fetchArticles()
        }
    }
}

// MARK: - Search Bar Delegate
extension ArticleListView: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchMode = false
        searchBar.resignFirstResponder()
        tableView.tableHeaderView = nil
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredArticles = BusinessLogicHelper.filterBySearchKeywords(searchKeyword: searchText, resultsArray: articles)
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

//
//  ArticleListView.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//

import UIKit
import PKHUD

class ArticleListView: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var pickerView: UIPickerView!

    // MARK: - Instance Variables
    
    private let searchBar = UISearchBar()
    private let refreshControl = UIRefreshControl()
    private var articles = [Article]()
    private var sections = [ArticleSectionResults]()
    private var filteredArticles = [Article]()
    private var currentOffset = 0
    private var searchMode = false
    private var totalResults = 0
    private var selectedSection: String?
    private var defaultSection = "all-sections"
    private var defaultTimePeriod = TimePeriod.Week
    var presenter: ArticleListPresenterProtocol?

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doLoadArticleSections()
        setup()
    }
    
    // MARK: - Helper Methods
    
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
    private func doLoadArticleSections() {
        presenter?.loadArticleSections()
        presenter?.loadArticles(section: defaultSection, timePeriod: defaultTimePeriod, offset: currentOffset)
    }
    @objc func refresh(sender:AnyObject) {
        currentOffset = 0
        articles.removeAll()
        presenter?.loadArticles(section: "all-sections", timePeriod: defaultTimePeriod, offset: currentOffset)
    }
    
    private func showTimePeriodFilters() {
        let alert = UIAlertController(title: "See most popular items for", message: nil, preferredStyle: .actionSheet)
        for timePeriod in TimePeriod.names {
            let timePeriodAction = UIAlertAction(title: getDisplayNameForTimePeriod(timePeriod: timePeriod),
                                                 style: .default, handler: { action in
                                                    self.defaultTimePeriod = timePeriod
                                                    self.doLoadArticleSections()
            })
            alert.addAction(timePeriodAction)
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func getDisplayNameForTimePeriod(timePeriod: TimePeriod) -> String {
        
        var displayName = timePeriod.getDisplayName()
        
        if defaultTimePeriod == timePeriod {
            displayName = "✓ " + displayName
        }
        
        return displayName
    }
    // MARK: - IBActions

    @IBAction func doneButtonPressed(_ sender: Any) {
        bottomConstraint.constant = -246.0
        if let section = selectedSection {
            defaultSection = section
            articles.removeAll()
            doLoadArticleSections()
        }
    }
    @IBAction func cancelButtonPressed(_ sender: Any) {
        bottomConstraint.constant = -246.0
    }
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
    @IBAction func leftButtonPressed(_ sender: Any) {
        bottomConstraint.constant = 0.0
    }
    
    
    
    
}

// MARK: - ArticleListViewProtocol

extension ArticleListView: ArticleListViewProtocol {
    
    func showArticleSections(_ articles: ArticleSectionBase) {
        sections = articles.results ?? [ArticleSectionResults]()
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.pickerView.reloadAllComponents()
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
            doLoadArticleSections()
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

//MARK:- PickerView Delegate & DataSource
extension ArticleListView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sections.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedSection = sections[row].name ?? ""
    }
}

extension ArticleListView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let sectionName = sections[row].name {
            return sectionName
        }
        return nil
    }
}

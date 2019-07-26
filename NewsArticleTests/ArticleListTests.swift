//
//  ArticleListTests.swift
//  NewsArticleTests
//
//  Created by macadmin on 7/25/19.
//  Copyright © 2019 Muhammad Waqas. All rights reserved.
//

import UIKit
import XCTest
@testable import NewsArticle

class ArticleListTests: XCTestCase {

    private var promise: XCTestExpectation!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testArticleListViewInitializing() {
        XCTAssertNotNil(ArticleListWireFrame.createArticleListModule(), "Error Initializing Article List View")
    }
    func testArticleListFetchingService() {
        promise = expectation(description: "Article Listing API Test")
        let dispatcher = NetworkDispatcher(configuration: URLSession(configuration: .default))
        let dataManager = ArticleListNetworkClient(dispatcher)
        dataManager.remoteRequestHandler = self
        let request = APIRequest.articles(section: "all-sections", timePeriod: TimePeriod.Week.rawValue, offset:20)
        dataManager.loadArticles(request, section: "all-sections", timePeriod: TimePeriod.Week, offset: 20)
        waitForExpectations(timeout: 60.0) { (error) in
            XCTAssertNil(error, "Error")
        }

    }
    
    func testArticleSectionFetchingService() {
        promise = expectation(description: "Article Sections API Test")
        let dispatcher = NetworkDispatcher(configuration: URLSession(configuration: .default))
        let dataManager = ArticleListNetworkClient(dispatcher)
        dataManager.remoteRequestHandler = self
        let request = APIRequest.articleSections
        dataManager.loadArticleSections(request)
        waitForExpectations(timeout: 60.0) { (error) in
            XCTAssertNil(error, "Error")
        }
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
}

extension ArticleListTests: ArticleListDataManagerOutputProtocol {
    
    func onArticleSectionRetrieved(_ articles: ArticleSectionBase) {
        XCTAssertTrue(true, "Success")
        promise.fulfill()
    }
    func onArticleRetrieved(_ articles: ArticleListBase) {
        XCTAssertTrue(true, "Success")
        promise.fulfill()
    }
    func onError(_ error: Error) {
        XCTAssertThrowsError(error)
        promise.fulfill()
    }
    
}


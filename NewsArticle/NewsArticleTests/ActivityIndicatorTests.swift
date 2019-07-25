//
//  ActivityIndicator.swift
//  NewsArticleTests
//
//  Created by macadmin on 7/25/19.
//  Copyright © 2019 Muhammad Waqas. All rights reserved.
//

import UIKit
import XCTest
@testable import NewsArticle

class ActivityIndicatorTests: XCTestCase, Showable {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testActivityIndicatorShow() {
         XCTAssertNoThrow(showProgress(), "Successfully called")
    }
    func testActivityIndicatorHide() {
        XCTAssertNoThrow(hideProgress(), "Successfully called")
    }
    func testActivityIndicatorError() {
        XCTAssertNoThrow(showError(""), "Successfully called")
    }
}

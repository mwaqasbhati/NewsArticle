//
//  GeneralTests.swift
//  NewsArticleTests
//
//  Created by macadmin on 7/25/19.
//  Copyright © 2019 Muhammad Waqas. All rights reserved.
//

import UIKit
import XCTest
@testable import NewsArticle

class GeneralTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAPIErrors() {
        let error = APIError.requestFailed
        XCTAssert(error.localizedDescription != "", "API Error enum not handle this case")
    }
}

//
//  NewsArticleTests.swift
//  NewsArticleTests
//
//  Created by Muhammad Waqas on 7/24/19.
//  Copyright © 2019 Muhammad Waqas. All rights reserved.
//

import XCTest
@testable import NewsArticle

class ArticleDetailTests: XCTestCase {

    private let articleList = Data("""
                                            {
                                            "url":"https:www.nytimes.com",
                                            "adx_keywords":"Medina, Julia Isabel Amparo;Immigration Detention;Citizenship and Naturalization;San Ysidro (Calif);Tijuana (Mexico);Customs and Border Protection (US);Immigration and Emigration;Trump, Donald J;United States Politics and Government",
                                            "column":null,
                                            "section":"U.S.",
                                            "byline":"By MATT STEVENS",
                                            "type":"Article",
                                            "title":"9-Year-Old Girl Was Detained at Border for 30 Hours Despite Being a U.S. Citizen",
                                            "abstract":"A government spokesman said the girl had 201cprovided inconsistent information 201d while crossing during her daily commute to school and was detained while her identity was verified.",
                                            "published_date":"2019-03-22",
                                            "source":"The New York Times",
                                            "id":100000006423892,
                                            "asset_id":100000006423892,
                                            "views":1,
                                            "des_facet":[
                                            "IMMIGRATION DETENTION",
                                            "IMMIGRATION AND EMIGRATION",
                                            "UNITED STATES POLITICS AND GOVERNMENT"
                                            ],
                                            "org_facet":[
                                            "CITIZENSHIP AND NATURALIZATION",
                                            "CUSTOMS AND BORDER PROTECTION (US)"
                                            ],
                                            "per_facet":[
                                            "MEDINA, JULIA ISABEL AMPARO",
                                            "TRUMP, DONALD J"
                                            ],
                                            "geo_facet":[
                                            "SAN YSIDRO (CALIF)",
                                            "TIJUANA (MEXICO)"
                                            ],
                                            "media":[
                                            {
                                            "type":"image",
                                            "subtype":"photo",
                                            "caption":"Julia Isabel Amparo Medina with her mother and brother. She and her brother were detained on their way to school in California.",
                                            "copyright":"NBC 7 San Diego",
                                            "approved_for_syndication":1,
                                            "media-metadata":[
                                            {
                                            "url":"https:",
                                            "format":"square320",
                                            "height":320,
                                            "width":320
                                            }
                                            ]
                                            }
                                            ]
                                            }
                                            """.utf8)
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testArticleListModel() throws {
        let result = parseArticleList()
        if (result.0 != nil) {
            XCTAssertTrue(true)
        } else if let error = result.1 {
            XCTFail("Error while converting to model \(error.localizedDescription)")
        }
    }
    func testArticleDetailViewInitializing() {
        let result = parseArticleList()
        if let article = result.0 {
            XCTAssertNotNil(ArticleDetailWireFrame.createArticleDetailModule(article), "Error Initializing Article Detail View")
        }
    }

    private func parseArticleList()->(Article?, Error?) {
        do {
            let result = try JSONDecoder().decode(Article.self, from: articleList)
            return (result,nil)
        } catch let error {
            return (nil,error)
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    

}

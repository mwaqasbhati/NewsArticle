//
//  StoryboardRouter.swift
//  NewsArticle
//
//  Created by Muhammad Waqas on 7/26/19.
//  Copyright © 2019 Muhammad Waqas. All rights reserved.
//

import UIKit

protocol StoryboardRouter {
    var name: String {get}
    var controller: UIViewController? {get}
}

enum Storyboard: StoryboardRouter {
    case ArticleList
    case ArticleDetail
    
    var name: String {
        switch self {
        case .ArticleList:
            return "Main"
        case . ArticleDetail:
            return "Main"
        }
    }
    
    var controller: UIViewController? {
        switch self {
        case .ArticleList:
            return UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: "ArticleListView")
        case . ArticleDetail:
            return UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: "ArticleDetailView")
        }
    }
    
    
}

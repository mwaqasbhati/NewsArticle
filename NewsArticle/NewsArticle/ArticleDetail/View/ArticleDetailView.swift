//
//  ArticleDetailView.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//

import UIKit
import PKHUD
import SDWebImage

class ArticleDetailView: UIViewController {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSection: UILabel!
    @IBOutlet weak var labelByLine: UILabel!
    @IBOutlet weak var labelPublishDate: UILabel!
    
    @IBOutlet weak var buttonMoreDetails: UIButton!
    @IBOutlet weak var imageViewPreview: UIImageView!
    
    @IBOutlet weak var labelAbstract: UILabel!
    @IBOutlet weak var labelKeywords: UILabel!
    var presenter: ArticleDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let article = presenter?.article {
            setData(article)
        }
    }
    private func setData(_ article: Results) {
        labelTitle.text = article.title
        labelSection.text = article.section
        labelByLine.text = article.byline
        labelPublishDate.text = article.published_date
        labelAbstract.text = article.abstract
        labelKeywords.text = article.adx_keywords
        
        if  let media = article.media?.first, let metadata = media.mediaMetadata?.first?.url, let url = URL(string: metadata) {
            SDWebImageManager.shared.imageLoader.requestImage(with: url, options: .continueInBackground, context: nil, progress: nil, completed: { [weak self] (image:UIImage?, data:Data?, error:Error?, finished:Bool) in
                
                guard let weakSelf = self else { return }
                if image != nil {
                    weakSelf.imageViewPreview.image = image
                    weakSelf.imageViewPreview.contentMode = .scaleAspectFill
                } else {
                    weakSelf.imageViewPreview.image = UIImage(named: "placeholder")
                }
            })
        }
    }
    @IBAction func moreDetailButtonPressed(_ sender: Any) {
        
    }
    
}

extension ArticleDetailView: ArticleDetailViewProtocol {
    
    func showArticleDetail(_ article: Results) {
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


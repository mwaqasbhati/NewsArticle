//
//  ArticleDetailView.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//

import UIKit
import PKHUD
import SDWebImage

class ArticleDetailView: UIViewController {
    
    // MARK: - Constants

    enum Constants {
        static let placeHolder = "placeholder"
        static let error = "Error"
        static let close = "Close"
        static let alertMessage = "There was a problem when trying to open"
    }
    
    // MARK: - IBOutlets

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSection: UILabel!
    @IBOutlet weak var labelByLine: UILabel!
    @IBOutlet weak var labelPublishDate: UILabel!
    @IBOutlet weak var labelAbstract: UILabel!
    @IBOutlet weak var labelKeywords: UILabel!
    @IBOutlet weak var buttonMoreDetails: UIButton!
    @IBOutlet weak var imageViewPreview: UIImageView!
    
    // MARK: - Instance Variables

    var presenter: ArticleDetailPresenterProtocol?
    private var article: Article?
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        if let article = presenter?.article {
            self.article = article
            setData(article)
        }
    }
    
    // MARK: - Helper Methods

    /**
     Set Data will assign article to UI elements.
     
     
     - parameter article: article data object from Network API.
     
     This method accepts article object which will be mapped to particular UI elements
     */
    
    private func setData(_ article: Article) {
        labelTitle.text = article.title
        labelSection.text = article.section
        labelByLine.text = article.byline
        labelAbstract.text = article.abstract
        labelKeywords.text = article.adx_keywords
        if let date = article.published_date {
            labelPublishDate.text = "🗓 \(date)"
        }
        if  let media = article.media?.first, let metadata = media.mediaMetadata?.first?.url, let url = URL(string: metadata) {
            SDWebImageManager.shared.imageLoader.requestImage(with: url, options: .continueInBackground, context: nil, progress: nil, completed: { [weak self] (image:UIImage?, data:Data?, error:Error?, finished:Bool) in
                
                guard let weakSelf = self else { return }
                if image != nil {
                    weakSelf.imageViewPreview.image = image
                    weakSelf.imageViewPreview.contentMode = .scaleAspectFill
                } else {
                    weakSelf.imageViewPreview.image = UIImage(named: Constants.placeHolder)
                }
            })
        }
    }
    
    
    @IBAction func moreDetailButtonPressed(_ sender: Any) {
        
        if let urlStr = article?.url, let url = URL(string: urlStr) {
            
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                let alert = UIAlertController(title: Constants.error, message: "\(Constants.alertMessage) \(url)", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: Constants.close, style: UIAlertAction.Style.cancel, handler: nil))
                
                present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
}

// MARK: - Presenter to View

extension ArticleDetailView: ArticleDetailViewProtocol { }


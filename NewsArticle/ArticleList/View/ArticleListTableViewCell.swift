//
//  ArticleListTableViewCell.swift
//  NewsArticle
//
//  Created by macadmin on 7/25/19.
//  Copyright © 2019 Muhammad Waqas. All rights reserved.
//

import UIKit
import SDWebImage

class ArticleListTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var imageviewThumbnail: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    static let cellId = "ArticleListCell"
    
    // MARK: - Cell Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageviewThumbnail.layer.masksToBounds = true
        imageviewThumbnail.layer.cornerRadius = 37.5
        imageviewThumbnail.contentMode = .scaleAspectFill
    }
    
    // MARK: - Helper Methods

    /**
     Set Article to a particlur UITableviewcell.
     
     
     - parameter article: Article object which will be assigned to UI.
     
     This methods accepts article data object which will be assigner to UI elements e.g title, description.
     */
    
    func setArticle(_ article: Article) {
        labelTitle.text = article.title
        labelDescription.text = article.byline
        if let date = article.published_date {
            labelDate.text = "🗓 \(date)"
        }
        if  let media = article.media?.first, let metadata = media.mediaMetadata?.first?.url, let url = URL(string: metadata) {
            imageviewThumbnail.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), options: .transformAnimatedImage, progress: nil, completed: nil)
        }
    }
}

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

    @IBOutlet weak var imageviewThumbnail: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    static let cellId = "ArticleListCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setArticle(_ article: Article) {
        labelTitle.text = article.title
        labelDescription.text = article.byline
        if let date = article.published_date {
            labelDate.text = "🗓 \(date)"
        }
        if  let media = article.media?.first, let metadata = media.mediaMetadata?.first?.url, let url = URL(string: metadata) {
            SDWebImageManager.shared.imageLoader.requestImage(with: url, options: .continueInBackground, context: nil, progress: nil, completed: { [weak self] (image:UIImage?, data:Data?, error:Error?, finished:Bool) in
                
                guard let weakSelf = self else { return }
                if image != nil {
                    weakSelf.imageviewThumbnail.image = image
                    weakSelf.imageviewThumbnail.contentMode = .scaleAspectFill
                    weakSelf.imageviewThumbnail.layer.masksToBounds = true
                    weakSelf.imageviewThumbnail.layer.cornerRadius = 37.5
                } else {
                    weakSelf.imageviewThumbnail.image = UIImage(named: "placeholder")
                }
            })
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

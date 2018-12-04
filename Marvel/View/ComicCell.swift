//
//  ComicCell.swift
//  Marvel
//
//  Created by Bruno Silva on 04/12/2018.
//

import UIKit

class ComicCell: UICollectionViewCell, ModelPresenterCell {
    
    var model: Result?  {
        didSet {
            guard let model = self.model else { return }
            
            self.coverImageView.loadImageUsingUrlString(urlString: model.thumbnail.getImageUrl(size: .medium))
            self.titleLabel.text = model.title
            if let issueNumber = model.issueNumber {
                self.issueNumberLabel.text = "Issue number #\(issueNumber)"
            } else {
                self.issueNumberLabel.text = ""
            }
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var issueNumberLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView! {
        didSet {
            self.coverImageView.contentMode = .scaleAspectFill
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

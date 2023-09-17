//
//  PostListTableViewCell.swift
//  DBPostListApp
//
//  Created by Pankaj Sachdeva on 13/09/23.
//

import UIKit

protocol PostListTableViewCellDelegate: AnyObject {
    func favoriteButtonAction(viewModel: Post)
}

class PostListTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var detailLabel: UILabel?
    @IBOutlet weak var favoriteButton: UIButton?
    
    weak var delegate: PostListTableViewCellDelegate?
    var postDetail: Post?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func set(viewModel: Post) {
        postDetail = viewModel
        titleLabel?.text = viewModel.title
        detailLabel?.text = viewModel.detail
        
        favoriteButton?.setBackgroundImage(favoriteButtonIcon(), for: .normal)
    }
    
    @IBAction func favoritButtonAction(sender: UIButton) {
        guard var postDetail = postDetail else { return }
        postDetail.isFavorite = postDetail.isFavorite ? false : true
        sender.setBackgroundImage(favoriteButtonIcon(), for: .normal)
        delegate?.favoriteButtonAction(viewModel: postDetail)
    }
    
    func favoriteButtonIcon() -> UIImage? {
        let imageName = "suit.heart" + ((postDetail?.isFavorite ?? false) ? ".fill" : "")
        return UIImage(systemName: imageName)
    }
}

//
//  PostListTableViewCell.swift
//  DBPostListApp
//
//  Created by Pankaj Sachdeva on 13/09/23.
//

import UIKit

class PostListTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var detailLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func set(viewModel: Post) {
        titleLabel?.text = viewModel.title
        detailLabel?.text = viewModel.detail
    }
}

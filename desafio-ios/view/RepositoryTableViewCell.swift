//
//  RepositoryTableViewCell.swift
//  desafio-ios
//
//  Created by Felipe Marino on 2/24/17.
//  Copyright © 2017 Felipe Marino. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {

    @IBOutlet weak var repositoryName: UILabel!
    @IBOutlet weak var repositoryDesc: UILabel!
    @IBOutlet weak var forksCount: UILabel!
    @IBOutlet weak var starsCount: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var nameAndLastName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

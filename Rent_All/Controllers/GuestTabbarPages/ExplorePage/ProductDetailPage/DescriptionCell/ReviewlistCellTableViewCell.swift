//
//  ReviewlistCellTableViewCell.swift
//  Rent_All
//
//  Created by RadicalStart on 10/07/20.
//  Copyright © 2020 RADICAL START. All rights reserved.
//

import UIKit

class ReviewlistCellTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var profileImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

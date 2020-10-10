//
//  InboxContentCell.swift
//  Rent_All
//
//  Created by RadicalStart on 10/06/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class InboxContentCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var nextarrowimage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var approvedLabel: UILabel!
    @IBOutlet weak var nameLAbel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.nextarrowimage.image = self.nextarrowimage.image?.withRenderingMode(.alwaysTemplate)
        self.nextarrowimage.tintColor = UIColor.darkGray
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

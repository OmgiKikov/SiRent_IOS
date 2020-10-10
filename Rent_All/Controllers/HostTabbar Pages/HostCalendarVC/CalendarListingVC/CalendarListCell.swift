//
//  CalendarListCell.swift
//  Rent_All
//
//  Created by RadicalStart on 05/08/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class CalendarListCell: UITableViewCell {

    @IBOutlet weak var tickImage: UIImageView!
    @IBOutlet weak var entireLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var listimage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.tickImage.image = self.tickImage.image?.withRenderingMode(.alwaysTemplate)
        self.tickImage.tintColor = Theme.PRIMARY_COLOR
        listimage.layer.cornerRadius = 6.0
        listimage.layer.masksToBounds = true
        entireLabel.textColor = Theme.ENTIRE_COLOR
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

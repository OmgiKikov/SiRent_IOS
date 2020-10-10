//
//  ContactheaderCell.swift
//  Rent_All
//
//  Created by RadicalStart on 17/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Cosmos

class ContactheaderCell: UITableViewCell {

    @IBOutlet weak var listBtn: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var listImage: UIImageView!
    
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var entireLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        listImage.layer.cornerRadius = 6.0
        listImage.layer.masksToBounds = true
        ratingView.settings.filledBorderColor = Theme.PRIMARY_COLOR
        ratingView.settings.filledColor = Theme.PRIMARY_COLOR
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

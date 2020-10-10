//
//  ItenaryImageCell.swift
//  Rent_All
//
//  Created by RadicalStart on 31/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import  Cosmos

class ItenaryImageCell: UITableViewCell {
    @IBOutlet weak var listImage: UIImageView!
    
    @IBOutlet weak var ratingcountLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var listLocationLabel: UILabel!
    @IBOutlet weak var listTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        ratingView.settings.filledBorderColor = Theme.PRIMARY_COLOR
        ratingView.settings.filledColor = Theme.PRIMARY_COLOR
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

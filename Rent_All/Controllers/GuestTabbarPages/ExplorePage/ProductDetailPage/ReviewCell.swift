//
//  ReviewCell.swift
//  Rent_All
//
//  Created by RadicalStart on 15/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import  Cosmos
class ReviewCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var readallBtn: UIButton!
    //@IBOutlet weak var readheight: NSLayoutConstraint!
    @IBOutlet weak var reviewTitleLabel: UILabel!
   // @IBOutlet weak var readmoreBtn: UIButton!
    @IBOutlet weak var verifyLabel: UILabel!
    @IBOutlet weak var reviewRateView: CosmosView!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var reviewDateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        verifyLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"verifyrentall"))!)"
        reviewTitleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"review"))!)"
        
        reviewRateView.settings.filledColor = Theme.PRIMARY_COLOR
        reviewRateView.settings.filledBorderColor = Theme.PRIMARY_COLOR
        profileImg.layer.cornerRadius = profileImg.layer.frame.size.width/2
        profileImg.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

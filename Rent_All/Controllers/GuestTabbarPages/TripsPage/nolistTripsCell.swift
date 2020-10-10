//
//  nolistTripsCell.swift
//  Rent_All
//
//  Created by RadicalStart on 05/06/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class nolistTripsCell: UITableViewCell {

    @IBOutlet weak var nolistLabel: UILabel!
    @IBOutlet weak var contactSupportBtn: UIButton!
    @IBOutlet weak var approvedLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        approvedLabel.layer.cornerRadius = 6.0
        approvedLabel.layer.masksToBounds = true
        contactSupportBtn.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
//        contactSupportBtn.setTitle("Contact support", for: .normal)
//        nolistLabel.text = "No list found"
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

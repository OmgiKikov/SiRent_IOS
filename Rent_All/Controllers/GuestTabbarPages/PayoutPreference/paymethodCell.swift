//
//  paymethodCell.swift
//  Rent_All
//
//  Created by RadicalStart on 19/08/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class paymethodCell: UITableViewCell {

    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var processLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var paypalLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        paypalLabel.textColor = Theme.PRIMARY_COLOR
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

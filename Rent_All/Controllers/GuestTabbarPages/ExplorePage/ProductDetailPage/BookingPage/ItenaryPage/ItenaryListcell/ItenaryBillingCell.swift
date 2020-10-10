//
//  ItenaryBillingCell.swift
//  Rent_All
//
//  Created by RadicalStart on 31/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class ItenaryBillingCell: UITableViewCell {

    @IBOutlet weak var billingTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var stayLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
         billingTitleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"billing"))!)"
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

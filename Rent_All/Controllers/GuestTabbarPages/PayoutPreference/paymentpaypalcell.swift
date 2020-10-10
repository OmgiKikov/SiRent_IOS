//
//  paymentpaypalcell.swift
//  Rent_All
//
//  Created by RadicalStart on 19/08/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class paymentpaypalcell: UITableViewCell {

    @IBOutlet weak var paydescriptionLabel: UILabel!
    @IBOutlet weak var paypalLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        paypalLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"paypal"))!)"
        paydescriptionLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"paypaldescription"))!)"
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  RentpaymentReceiptCell.swift
//  Rent_All
//
//  Created by RadicalStart on 03/06/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class RentpaymentReceiptCell: UITableViewCell {

    @IBOutlet weak var payemntdescriptionLabel: UILabel!
    @IBOutlet weak var paymentreceiveLAbel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var paymentDateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        payemntdescriptionLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"payment_accept_info"))!)"
        
        paymentreceiveLAbel.text = "\((Utility.shared.getLanguage()?.value(forKey:"paymentreceive"))!)"
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

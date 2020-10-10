//
//  customerReceiptCell.swift
//  Rent_All
//
//  Created by RadicalStart on 03/06/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class customerReceiptCell: UITableViewCell {

    @IBOutlet weak var customerReceiptLabel: UILabel!
    @IBOutlet weak var confirmCodeLAbel: UILabel!
    @IBOutlet weak var receiptNumberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        customerReceiptLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"customerReceipt"))!)"
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

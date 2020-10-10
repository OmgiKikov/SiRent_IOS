//
//  ItenaryListCell.swift
//  Rent_All
//
//  Created by RadicalStart on 31/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class ItenaryListCell: UITableViewCell {

    @IBOutlet weak var viewReceiptBtn: UIButton!
    @IBOutlet weak var reservationCodeLAbel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewReceiptBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"viewreceipt"))!)", for:.normal)
        viewReceiptBtn.setTitleColor(Theme.TERTIARY_COLOR, for: .normal)
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  contactcheckCell.swift
//  Rent_All
//
//  Created by RadicalStart on 17/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class contactcheckCell: UITableViewCell {

   
    @IBOutlet weak var checkguestLabel: UILabel!
    @IBOutlet weak var checkoutLabel: UILabel!
    @IBOutlet weak var checkinLabel: UILabel!
    @IBOutlet weak var guestLabel: UIButton!
    @IBOutlet weak var addDateinLabel: UIButton!
    @IBOutlet weak var addOutDateLabel: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        checkinLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"checkin"))!)"
        checkoutLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"checkout"))!)"
        checkguestLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"guest"))!)"
        addDateinLabel.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
         addOutDateLabel.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
         guestLabel.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

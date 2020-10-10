//
//  CancellationCell.swift
//  Rent_All
//
//  Created by RadicalStart on 17/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class CancellationCell: UITableViewCell {
    @IBOutlet weak var checkLabel: UILabel!
    
    @IBOutlet weak var cancelTitleLabel: UILabel!
    @IBOutlet weak var checkoutLabel: UILabel!
    @IBOutlet weak var fullviewDetailBtn: UIButton!
    @IBOutlet weak var checkoutTimeLabel: UILabel!
    @IBOutlet weak var checkinTimeLabel: UILabel!
    @IBOutlet weak var flexibleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        checkoutLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"checkoutt"))!)"
        checkLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"checkinn"))!)"
        cancelTitleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"cancellations"))!)"
        checkinTimeLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"fri"))!), \((Utility.shared.getLanguage()?.value(forKey:"jun"))!) 09 3:00 PM"
            checkoutTimeLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"mon"))!), \((Utility.shared.getLanguage()?.value(forKey:"jun"))!) 12 11:00 AM"
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

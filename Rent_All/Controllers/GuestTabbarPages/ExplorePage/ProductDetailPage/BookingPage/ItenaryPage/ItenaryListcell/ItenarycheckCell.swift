//
//  ItenarycheckCell.swift
//  Rent_All
//
//  Created by RadicalStart on 31/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class ItenarycheckCell: UITableViewCell {
    @IBOutlet weak var checkouttimeLabel: UILabel!
    @IBOutlet weak var outcheckLabel: UILabel!
    
    @IBOutlet weak var checkLabel: UILabel!
    @IBOutlet weak var checkinTimeLabel: UILabel!
    @IBOutlet weak var checkinLabel: UILabel!
    @IBOutlet weak var checkoutLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        checkLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"checkin"))!)"
        outcheckLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"checkout"))!)"
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

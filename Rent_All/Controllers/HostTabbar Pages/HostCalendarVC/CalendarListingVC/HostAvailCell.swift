//
//  HostAvailCell.swift
//  Rent_All
//
//  Created by RadicalStart on 07/08/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class HostAvailCell: UITableViewCell {

    @IBOutlet weak var availabilityLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        availabilityLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"availability"))!)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

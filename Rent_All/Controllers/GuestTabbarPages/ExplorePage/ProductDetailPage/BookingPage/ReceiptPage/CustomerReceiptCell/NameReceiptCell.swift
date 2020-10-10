//
//  NameReceiptCell.swift
//  Rent_All
//
//  Created by RadicalStart on 03/06/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class NameReceiptCell: UITableViewCell {

    @IBOutlet weak var accomadationTitleLabel: UILabel!
    @IBOutlet weak var durationTitleLAbel: UILabel!
    @IBOutlet weak var travelLabel: UILabel!
    @IBOutlet weak var nameLAbel: UILabel!
    @IBOutlet weak var accomadationLabel: UILabel!
    @IBOutlet weak var durationLbel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLAbel.text = "\((Utility.shared.getLanguage()?.value(forKey:"name"))!)"
        travelLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"traveldestination"))!)"
        durationTitleLAbel.text = "\((Utility.shared.getLanguage()?.value(forKey:"duration"))!)"
        accomadationTitleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"accommodationtype"))!)"
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

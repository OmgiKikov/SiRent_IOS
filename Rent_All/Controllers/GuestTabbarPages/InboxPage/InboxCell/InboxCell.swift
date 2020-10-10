//
//  InboxCell.swift
//  Rent_All
//
//  Created by RadicalStart on 10/06/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class InboxCell: UITableViewCell {

    @IBOutlet weak var inboxTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        inboxTitleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"inbox"))!)"
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

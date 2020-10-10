//
//  AgreetermsCell.swift
//  Rent_All
//
//  Created by RadicalStart on 30/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class AgreetermsCell: UITableViewCell {

    @IBOutlet weak var agreeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        agreeLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"agreeterm"))!)"
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

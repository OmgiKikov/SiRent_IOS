//
//  AmenitiesCell.swift
//  Rent_All
//
//  Created by RADICAL START on 28/03/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class AmenitiesCell: UITableViewCell {
    @IBOutlet var amenitiesTitleLabel: UILabel!
    
    @IBOutlet var amenitieslistTile: UILabel!
    
    @IBOutlet var showAllBtn: UIButton!

    @IBOutlet var checkBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

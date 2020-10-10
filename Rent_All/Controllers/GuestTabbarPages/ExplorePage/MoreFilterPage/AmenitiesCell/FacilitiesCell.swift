//
//  FacilitiesCell.swift
//  Rent_All
//
//  Created by RadicalStart on 26/04/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class FacilitiesCell: UITableViewCell {
    
    @IBOutlet var amenitieslistTile: UILabel!
    
   
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

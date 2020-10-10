//
//  HometypeCell.swift
//  Rent_All
//
//  Created by RADICAL START on 28/03/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class HometypeCell: UITableViewCell {
    //MARK:************************************************ IBOUTLET CONNECTIONS **************************************************>
    
    @IBOutlet var homeTypeLabel: UILabel!
    
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

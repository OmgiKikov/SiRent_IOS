//
//  PriceRangeCell.swift
//  Rent_All
//
//  Created by RADICAL START on 28/03/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import RangeSeekSlider

class PriceRangeCell: UITableViewCell {
    //MARK:************************************************ IBOUTLET CONNECTIONS **************************************************>
    
    @IBOutlet var priceLabel: UILabel!
    
    
    
    @IBOutlet var sliderView: RangeSeekSlider!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sliderView.colorBetweenHandles = Theme.PRIMARY_COLOR
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

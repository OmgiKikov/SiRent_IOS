//LOTAnimationView
//  InstantBookCell.swift
//  Rent_All
//
//  Created by RADICAL START on 28/03/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Lottie
class InstantBookCell: UITableViewCell {
     //MARK:************************************************ IBOUTLET CONNECTIONS **************************************************>
    
    @IBOutlet var instantbookLabel: UILabel!
    
    @IBOutlet  var lottieSwitch: AirbnbSwitch!
    
    @IBOutlet var lotSwitch: UISwitch!
    @IBOutlet var lottieView: LOTAnimationView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  DescriptionCell.swift
//  Rent_All
//
//  Created by RadicalStart on 04/04/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class DescriptionCell: UITableViewCell {
    //MARK:****************************************************** IBOUTLET CONNECTIONS *******************************************************>
    

    @IBOutlet weak var bedroomLabel: UILabel!
    @IBOutlet weak var privateBathLabel: UILabel!
    @IBOutlet weak var bedLabel: UILabel!
    @IBOutlet weak var guestLabel: UILabel!
    @IBOutlet weak var readmoreBtn: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        readmoreBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"readmore"))!)", for: .normal)
        readmoreBtn.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

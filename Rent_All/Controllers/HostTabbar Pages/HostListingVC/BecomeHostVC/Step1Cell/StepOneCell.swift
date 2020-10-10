//
//  StepOneCell.swift
//  Rent_All
//
//  Created by RadicalStart on 26/07/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class StepOneCell: UITableViewCell {

    @IBOutlet weak var bedsbathroomsLabel: UILabel!
    @IBOutlet weak var step1Label: UILabel!
    @IBOutlet weak var becomeahostLabel: UILabel!
    @IBOutlet weak var verifiedImage: UIImageView!
    @IBOutlet weak var changeBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        step1Label.text = "\((Utility.shared.getLanguage()?.value(forKey:"step1"))!)"
        becomeahostLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"becomehost"))!)"
        bedsbathroomsLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"beds_desc"))!)"
        changeBtn.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

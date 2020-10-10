//
//  TripsCell.swift
//  Rent_All
//
//  Created by RadicalStart on 05/06/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class TripsCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var titleBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var receiptBtn: UIButton!
    @IBOutlet weak var itenaryBtn: UIButton!
    @IBOutlet weak var messageBtn: UIButton!
    @IBOutlet weak var addressLAbel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var approvedLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        approvedLabel.layer.cornerRadius = 6.0
        approvedLabel.layer.masksToBounds = true
        
        messageBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"message"))!)", for:.normal)
        itenaryBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"itinerary"))!)", for:.normal)
        receiptBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"receipt"))!)", for:.normal)
        cancelBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"cancel"))!)", for:.normal)
        messageBtn.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
         itenaryBtn.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
         receiptBtn.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
         cancelBtn.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
       titleBtn.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

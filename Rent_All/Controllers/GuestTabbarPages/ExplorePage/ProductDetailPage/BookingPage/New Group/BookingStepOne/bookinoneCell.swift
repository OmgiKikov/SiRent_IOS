//
//  bookinoneCell.swift
//  Rent_All
//
//  Created by RadicalStart on 28/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class bookinoneCell: UITableViewCell {

    @IBOutlet weak var outLabel: UILabel!
    @IBOutlet weak var checkLabel: UILabel!
    @IBOutlet weak var bookstayLabel: UILabel!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var thingsLabel: UILabel!
    @IBOutlet weak var checkoutLabel: UILabel!
    @IBOutlet weak var checkinLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        checkinLabel.layer.cornerRadius = 5.0
        checkinLabel.layer.masksToBounds = true
        checkoutLabel.layer.cornerRadius = 5.0
        checkoutLabel.layer.masksToBounds = true
        bookstayLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"bookstay"))!)"
        checkLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"checkinn"))!)"
        
        outLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"checkoutt"))!)"
        
        thingsLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"thingskeep"))!)"
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

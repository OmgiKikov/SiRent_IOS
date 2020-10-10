//
//  NomessageCell.swift
//  Rent_All
//
//  Created by RadicalStart on 13/06/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class NomessageCell: UITableViewCell {

    @IBOutlet weak var messagehostLabel: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        loginBtn.setBorder(color: Theme.PRIMARY_COLOR)
        loginBtn.layer.cornerRadius = 6.0
        loginBtn.layer.masksToBounds = true
        messagehostLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"nomessage"))!)"
        loginBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"login_string"))!)", for:.normal)
        loginBtn.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

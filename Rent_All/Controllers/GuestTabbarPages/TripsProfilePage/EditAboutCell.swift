//
//  EditAboutCell.swift
//  Rent_All
//
//  Created by RadicalStart on 06/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class EditAboutCell: UITableViewCell {

    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var rightArrowimg: UIImageView!
    @IBOutlet weak var editLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        editLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"edit"))!)"
        editLabel.textColor = Theme.PRIMARY_COLOR
        phoneLabel.textColor = Theme.PRIMARY_COLOR
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

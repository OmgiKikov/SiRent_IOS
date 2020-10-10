//
//  StepTwoCell.swift
//  Rent_All
//
//  Created by RadicalStart on 26/07/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class StepTwoCell: UITableViewCell {
    @IBOutlet weak var stepLabel: UILabel!
    
    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var verifyImage: UIImageView!
    @IBOutlet weak var changeBtn: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        changeBtn.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

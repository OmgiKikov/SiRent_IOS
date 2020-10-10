//
//  BookingFourCell.swift
//  Rent_All
//
//  Created by RadicalStart on 30/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class BookingFourCell: UITableViewCell {

    @IBOutlet weak var listBtn: UIButton!
    @IBOutlet weak var listImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var listnameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stepLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        titleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey: "review_pay"))!)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

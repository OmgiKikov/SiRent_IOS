//
//  RequestBookcellTableViewCell.swift
//  Rent_All
//
//  Created by RadicalStart on 27/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class RequestBookcellTableViewCell: UITableViewCell {

    @IBOutlet weak var specialImage: UIButton!
//    @IBOutlet weak var specialImage: UIImageView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var lineTwoLabel: UILabel!
    @IBOutlet weak var lineOneLabel: UILabel!
    @IBOutlet weak var discountPriceLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var servicefeeLabel: UILabel!
    @IBOutlet weak var cleaningpriceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceLeftLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

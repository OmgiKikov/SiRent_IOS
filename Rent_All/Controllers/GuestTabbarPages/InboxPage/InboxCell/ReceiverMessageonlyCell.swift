//
//  ReceiverMessageonlyCell.swift
//  Rent_All
//
//  Created by RadicalStart on 13/06/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class ReceiverMessageonlyCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var profileimage: UIImageView!
    @IBOutlet weak var receiverView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        receiverView.layer.cornerRadius = 6.0
        receiverView.layer.masksToBounds = true
        profileimage.layer.cornerRadius = profileimage.frame.size.width/2
        profileimage.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

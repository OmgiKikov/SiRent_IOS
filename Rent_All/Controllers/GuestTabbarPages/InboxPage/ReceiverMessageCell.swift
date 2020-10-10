//
//  ReceiverMessageCell.swift
//  Rent_All
//
//  Created by RadicalStart on 11/06/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class ReceiverMessageCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var receiverDateLabel: UILabel!
    @IBOutlet weak var receiverMsgLabel: UILabel!
    @IBOutlet weak var receiverView: UIView!
    @IBOutlet weak var dateLAbel: UILabel!
    @IBOutlet weak var requestLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        receiverView.layer.cornerRadius = 6.0
        receiverView.layer.masksToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

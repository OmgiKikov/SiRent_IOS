//
//  sendCell.swift
//  Rent_All
//
//  Created by RadicalStart on 11/06/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class sendCell: UITableViewCell {
    @IBOutlet var curvegreen: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var messageLAbel: UILabel!
    @IBOutlet weak var messageDateLabel: UILabel!
    @IBOutlet weak var senderView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        senderView.layer.cornerRadius = 6.0
        senderView.layer.masksToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.layer.masksToBounds = true
        senderView.backgroundColor = Theme.PRIMARY_COLOR
        curvegreen.image = curvegreen.image?.withRenderingMode(.alwaysTemplate)
        curvegreen.tintColor = Theme.PRIMARY_COLOR
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

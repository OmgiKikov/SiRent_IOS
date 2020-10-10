//
//  PayoutCell.swift
//  Rent_All
//
//  Created by RadicalStart on 16/08/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class PayoutCell: UITableViewCell {

    @IBOutlet weak var defaultBtn: UIButton!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var payoutLAbel: UILabel!
    @IBOutlet weak var payView: UIView!
    @IBOutlet weak var verifyInfoicon:UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        if(IS_IPHONE_XR || IS_IPHONE_X || IS_IPHONE_XS_MAX || IS_IPHONE_PLUS)
        {
            self.payView.frame.size.width = FULLWIDTH-40
        }
        payView.layer.cornerRadius = 4.0
        payView.layer.masksToBounds = true
        defaultBtn.layer.cornerRadius = 4.0
        defaultBtn.layer.masksToBounds = true
        let shadowSize : CGFloat = 4.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.payView.frame.size.width + shadowSize,
                                                   height: self.payView.frame.size.height + shadowSize))
        
        self.payView.layer.masksToBounds = false
        self.payView.layer.shadowColor = TextLightColor.cgColor
        self.payView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.payView.layer.shadowOpacity = 0.3
        self.payView.layer.shadowPath = shadowPath.cgPath
        payoutLAbel.textColor = Theme.PRIMARY_COLOR
        defaultBtn.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
        
        self.defaultBtn.layer.borderWidth = 1.5
        self.defaultBtn.layer.borderColor = Theme.PRIMARY_COLOR.cgColor
        self.defaultBtn.layer.cornerRadius = 5.0
        self.defaultBtn.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

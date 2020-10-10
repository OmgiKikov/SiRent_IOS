//
//  EmailGoogleFBTableViewCell.swift
//  Rent_All
//
//  Created by RadicalStart on 08/11/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class EmailGoogleFBTableViewCell: UITableViewCell {
    @IBOutlet var NewView: UIView!
    @IBOutlet var title_label: UILabel!
    @IBOutlet var logo_imageView: UIImageView!
    @IBOutlet var des_text_label: UILabel!
    @IBOutlet var action_Button: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        title_label.textColor = Theme.PRIMARY_COLOR
        action_Button.setTitleColor(Theme.PRIMARY_COLOR, for:.normal)
        
        // Initialization code
        
//        NewView.layer.cornerRadius = 4.0
//        NewView.layer.masksToBounds = true
//        action_Button.layer.cornerRadius = 4.0
//        action_Button.layer.masksToBounds = true
//        let shadowSize : CGFloat = 4.0
//        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
//                                                   y: -shadowSize / 2,
//                                                   width: self.NewView.frame.size.height + shadowSize,
//                                                   height: self.NewView.frame.size.height + shadowSize))
//
//        self.NewView.layer.masksToBounds = false
//        self.NewView.layer.shadowColor = TextLightColor.cgColor
//        self.NewView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        self.NewView.layer.shadowOpacity = 0.3
//        self.NewView.layer.shadowPath = shadowPath.cgPath
        
        NewView.dropShadow(scale: true)
        
        self.action_Button.layer.borderWidth = 1.5
        self.action_Button.layer.borderColor = Theme.PRIMARY_COLOR.cgColor
        self.action_Button.layer.cornerRadius = 5.0
        self.action_Button.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

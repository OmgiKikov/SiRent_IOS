//
//  InProgressCell.swift
//  Rent_All
//
//  Created by RadicalStart on 25/07/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class InProgressCell: UITableViewCell {

    @IBOutlet weak var inprogressView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var updateDateLabel: UILabel!
    @IBOutlet weak var listImage: UIImageView!
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var nextLabel: UIImageView!
    @IBOutlet weak var completeStateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        if(IS_IPHONE_XR || IS_IPHONE_PLUS)
        {
            self.inprogressView.frame.size.width = FULLWIDTH-40
        }
        else if IS_IPHONE_5
        {
          self.inprogressView.frame.size.width = FULLWIDTH - 40
        }
      progressBar.transform = progressBar.transform.scaledBy(x: 1, y:2)
        
        let shadowSize : CGFloat = 4.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.inprogressView.frame.size.width + shadowSize,
                                                   height: self.inprogressView.frame.size.height + shadowSize))
        
        self.inprogressView.layer.masksToBounds = false
        self.inprogressView.layer.shadowColor = TextLightColor.cgColor
        self.inprogressView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.inprogressView.layer.shadowOpacity = 0.3
        self.inprogressView.layer.shadowPath = shadowPath.cgPath
        self.listImage.layer.cornerRadius = 4.0
        self.listImage.layer.masksToBounds = true
        
        self.nextLabel.image = self.nextLabel.image?.withRenderingMode(.alwaysTemplate)
        self.nextLabel.tintColor = UIColor.lightGray
        progressBar.progressTintColor = Theme.PRIMARY_COLOR
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

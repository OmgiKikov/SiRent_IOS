//
//  CompletedCell.swift
//  Rent_All
//
//  Created by RadicalStart on 25/07/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class CompletedCell: UITableViewCell {
    @IBOutlet weak var completeView: UIView!
    
    @IBOutlet weak var nextimage: UIImageView!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var updateDateLabel: UILabel!
    @IBOutlet weak var listImage: UIImageView!
    @IBOutlet weak var progressBarView: UIProgressView!
    @IBOutlet weak var publishBtn: UIButton!
    @IBOutlet weak var listingprogressLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var previewBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if(IS_IPHONE_XR || IS_IPHONE_PLUS)
        {
            self.completeView.frame.size.width = FULLWIDTH - 40
        }
        else if IS_IPHONE_5
        {
            self.completeView.frame.size.width = FULLWIDTH - 40
        }
         progressBarView.transform = progressBarView.transform.scaledBy(x: 1, y:2)
        let shadowSize : CGFloat = 4.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.completeView.frame.size.width + shadowSize,
                                                   height: self.completeView.frame.size.height + shadowSize))
        
        self.completeView.layer.masksToBounds = false
        self.completeView.layer.shadowColor = TextLightColor.cgColor
        self.completeView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.completeView.layer.shadowOpacity = 0.3
        self.completeView.layer.shadowPath = shadowPath.cgPath
        self.listImage.layer.cornerRadius = 4.0
        self.listImage.layer.masksToBounds = true
        self.publishBtn.layer.cornerRadius = 4.0
        self.publishBtn.layer.masksToBounds = true
        self.previewBtn.layer.borderWidth = 1.0
        self.previewBtn.layer.borderColor = Theme.PRIMARY_COLOR.cgColor
        self.previewBtn.layer.cornerRadius = 4.0
        self.previewBtn.layer.masksToBounds = true
        self.nextimage.image = self.nextimage.image?.withRenderingMode(.alwaysTemplate)
        self.nextimage.tintColor = UIColor.lightGray
         previewBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"previewlist"))!)", for:.normal)
        progressBarView.progressTintColor = Theme.PRIMARY_COLOR
        publishBtn.backgroundColor = Theme.PRIMARY_COLOR
        previewBtn.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

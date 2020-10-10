//
//  FloatCollectionCell.swift
//  Rent_All
//
//  Created by RadicalStart on 01/04/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Cosmos

class FloatCollectionCell: UICollectionViewCell {
    
    //MARK:************************************** IBOUTLET CONNECTIONS *******************************************>
    
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var instantView: UIImageView!
    @IBOutlet var homeImage: UIImageView!
    
    @IBOutlet weak var selectedItem: UILabel!
    
    @IBOutlet var transparentView: UIView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var entirehomeLabel: UILabel!
    
    @IBOutlet var ratingView: CosmosView!

    override func awakeFromNib() {
        super.awakeFromNib()
        instantView.frame = CGRect(x:82, y: 172, width: 10, height: 12)
        
        
        entirehomeLabel.textColor = Theme.ENTIRE_COLOR
        ratingView.settings.filledColor = Theme.PRIMARY_COLOR
        ratingView.settings.filledBorderColor = Theme.PRIMARY_COLOR
        selectedItem.backgroundColor = Theme.PRIMARY_COLOR
        // Initialization code
    }

}

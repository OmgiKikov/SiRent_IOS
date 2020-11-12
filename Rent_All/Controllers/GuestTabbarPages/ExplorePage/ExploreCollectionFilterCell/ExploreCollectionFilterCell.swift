//
//  ExploreCollectionFilterCell.swift
//  Rent_All
//
//  Created by RADICAL START on 26/03/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import AARatingBar
import Cosmos
import ISPageControl


class ExploreCollectionFilterCell: UICollectionViewCell,ImageScrollerDelegate {
    
    func pageChanged(index: Int, indexpath: Int) {
        Pagecontrol.currentPage = index
    }
    
    
    //MARK:************************************** IBOUTLET CONNECTIONS *******************************************>
    
    @IBOutlet var homeImage: UIImageView!
    @IBOutlet weak var Pagecontrol: ISPageControl!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var instantImg: UIImageView!
    @IBOutlet weak var imageScroller: ImageScroller!
    @IBOutlet var transparentView: UIView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var entirehomeLabel: UILabel!
    @IBOutlet var ratingView: CosmosView!
    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        instantImg.frame = CGRect(x:78, y:241, width: 10, height: 12)
        imageScroller.delegate = self
        titleLabel.numberOfLines = 3
        titleLabel.lineBreakMode = .byWordWrapping
        entirehomeLabel.textColor = Theme.ENTIRE_COLOR
        ratingView.settings.filledColor = Theme.PRIMARY_COLOR
        ratingView.settings.filledBorderColor = Theme.PRIMARY_COLOR
        // Initialization code
    }

    
}

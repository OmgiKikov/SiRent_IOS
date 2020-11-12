//
//  ExploreCollectioncell.swift
//  Rent_All
//
//  Created by RADICAL START on 23/03/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Cosmos

class ExploreCollectioncell: UICollectionViewCell {
  
  @IBOutlet var homeImage: UIImageView!
  @IBOutlet weak var likeBtn: UIButton!
  @IBOutlet var priceLabel: UILabel!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var entirehomeLabel: UILabel!
  @IBOutlet weak var thunderImage: UIImageView!
  @IBOutlet weak var countLabel: UILabel!
  @IBOutlet var ratingView: CosmosView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    entirehomeLabel.textColor = Theme.ENTIRE_COLOR
    ratingView.settings.filledColor = Theme.PRIMARY_COLOR
    ratingView.settings.filledBorderColor = Theme.PRIMARY_COLOR
  }
  
}

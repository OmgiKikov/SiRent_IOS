//
//  EditImageCell.swift
//  Rent_All
//
//  Created by RadicalStart on 06/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class EditImageCell: UITableViewCell {

    @IBOutlet weak var editProfileimage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
//        if IS_IPHONE_5{
            editProfileimage.frame = CGRect(x: FULLWIDTH/2-140, y: 0, width: 280, height: 280)
      //  }
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

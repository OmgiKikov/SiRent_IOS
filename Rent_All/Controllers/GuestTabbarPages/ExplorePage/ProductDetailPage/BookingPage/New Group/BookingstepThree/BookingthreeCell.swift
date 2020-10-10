//
//  BookingthreeCell.swift
//  Rent_All
//
//  Created by RadicalStart on 30/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class BookingthreeCell: UITableViewCell {

    @IBOutlet weak var addprofilecontentLabel: UILabel!
    @IBOutlet weak var addprofileLAbel: UILabel!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var uploadBTn: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        uploadBTn.layer.cornerRadius = 6.0
        uploadBTn.layer.masksToBounds = true
        addprofileLAbel.text = "\((Utility.shared.getLanguage()?.value(forKey:"addprofile"))!)"
        addprofilecontentLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"profilecontent"))!)"
        uploadBTn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"uploadphoto"))!)", for:.normal)
        uploadBTn.backgroundColor = Theme.TERTIARY_COLOR
        
        // Initialization code
    }
  
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

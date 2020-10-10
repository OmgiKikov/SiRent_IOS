//
//  addPhotosCell.swift
//  Rent_All
//
//  Created by RadicalStart on 27/07/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class addPhotosCell: UITableViewCell {

    
    //MARK: - IBOUTLETS
    
    @IBOutlet weak var addphotosTitleLabel: UILabel!
    
    @IBOutlet weak var photosdescLabel: UILabel!
    @IBOutlet weak var addphotoBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        addphotoBtn.layer.cornerRadius = 4.0
        addphotoBtn.layer.masksToBounds = true
        
        addphotoBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"addphotos"))!)", for:.normal)
        
        addphotosTitleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"addphotolist"))!)"
         photosdescLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"photolist_desc"))!)"
        addphotoBtn.backgroundColor = Theme.PRIMARY_COLOR
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

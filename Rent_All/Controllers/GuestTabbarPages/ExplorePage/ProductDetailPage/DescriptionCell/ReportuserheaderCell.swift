//
//  ReportuserheaderCell.swift
//  Rent_All
//
//  Created by RadicalStart on 28/11/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class ReportuserheaderCell: UITableViewCell {

    @IBOutlet var followLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"doyoureport"))!)"
        followLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"choosereasons"))!)"
      
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

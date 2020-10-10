//
//  ShareListCell.swift
//  Rent_All
//
//  Created by RadicalStart on 05/04/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class ShareListCell: UITableViewCell {
    @IBOutlet weak var shareImg: UIImageView!
    
    @IBOutlet weak var shareTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  bookingsteptwoCell.swift
//  Rent_All
//
//  Created by RadicalStart on 29/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class bookingsteptwoCell: UITableViewCell {

    @IBOutlet weak var hostcontentLabel: UILabel!
    @IBOutlet weak var tellhostLabel: UILabel!
    @IBOutlet weak var stepLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        tellhostLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"tellhost"))!)"
        hostcontentLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"tellhost_content"))!)"
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

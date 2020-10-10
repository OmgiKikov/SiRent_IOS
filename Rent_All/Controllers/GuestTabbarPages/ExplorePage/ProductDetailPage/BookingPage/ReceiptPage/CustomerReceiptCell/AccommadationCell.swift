//
//  AccommadationCell.swift
//  Rent_All
//
//  Created by RadicalStart on 03/06/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class AccommadationCell: UITableViewCell {
    @IBOutlet weak var listName: UILabel!
    
    @IBOutlet weak var accommodationhostLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var accomadationaddressLabel: UILabel!
    @IBOutlet weak var hostnameLabel: UILabel!
    @IBOutlet weak var addressLAbel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        accomadationaddressLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"accommadationaddress"))!)"
        
        accommodationhostLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"accommodationhost"))!)"
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

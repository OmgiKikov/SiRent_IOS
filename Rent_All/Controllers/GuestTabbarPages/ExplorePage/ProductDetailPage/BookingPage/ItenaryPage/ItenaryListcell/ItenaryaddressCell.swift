//
//  ItenaryaddressCell.swift
//  Rent_All
//
//  Created by RadicalStart on 31/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class ItenaryaddressCell: UITableViewCell {

    @IBOutlet weak var addressTitleLabel: UILabel!
    @IBOutlet weak var viewListingBtn: UIButton!
    @IBOutlet weak var addressLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
         addressTitleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"address"))!)"
        viewListingBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"viewlisting"))!)", for:.normal)
        viewListingBtn.setTitleColor(Theme.TERTIARY_COLOR, for: .normal)
        
         
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  tripscancellCell.swift
//  Rent_All
//
//  Created by RadicalStart on 07/06/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class tripscancellCell: UITableViewCell {

    @IBOutlet weak var travellingwithLabel: UILabel!
    @IBOutlet weak var stayingLabel: UILabel!
    @IBOutlet weak var startinLabel: UILabel!
    @IBOutlet weak var cancelTitleLabel: UILabel!
    @IBOutlet weak var tellLabel: UILabel!
    @IBOutlet weak var travellingLabel: UILabel!
    @IBOutlet weak var nightsLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        cancelTitleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"canceltrip"))!)"
        startinLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"startin"))!)"
        stayingLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"stayingfor"))!)"
        travellingwithLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"travellingwith"))!)"
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

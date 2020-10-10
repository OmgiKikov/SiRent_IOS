//
//  ItenaryHostCell.swift
//  Rent_All
//
//  Created by RadicalStart on 31/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class ItenaryHostCell: UITableViewCell {

    @IBOutlet weak var hosttitleLAbel: UILabel!
    @IBOutlet weak var messageHostBtn: UIButton!
    @IBOutlet weak var hostImage: UIImageView!
    @IBOutlet weak var hostNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        hosttitleLAbel.text = "\((Utility.shared.getLanguage()?.value(forKey:"host"))!)"
        messageHostBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"messagehost"))!)", for:.normal)
       messageHostBtn.setTitleColor(Theme.TERTIARY_COLOR, for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

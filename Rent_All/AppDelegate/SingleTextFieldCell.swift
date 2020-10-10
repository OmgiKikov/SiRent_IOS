//
//  SingleTextFieldCell.swift
//  Rent_All
//
//  Created by RadicalStart on 25/07/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class SingleTextFieldCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}

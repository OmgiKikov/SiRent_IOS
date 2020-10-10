//
//  SpecialTextFieldCell.swift
//  Rent_All
//
//  Created by RadicalStart on 07/08/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
protocol SpecialTextFieldCellDelegate: class {
    func didChangeText(text: String?, cell: SpecialTextFieldCell)
}

class SpecialTextFieldCell: UITableViewCell,UITextFieldDelegate {

    @IBOutlet weak var specialpricingLabel: UILabel!
    @IBOutlet weak var specialTF: UITextField!
    var delegate:SpecialTextFieldCellDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        specialTF.delegate = self
        specialTF.placeholder = "$245 \((Utility.shared.getLanguage()?.value(forKey:"pernight"))!)"
         specialpricingLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"specialpricing"))!)"
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func textFieldDidChange(_ textField: UITextField) {
     
        delegate?.didChangeText(text:textField.text, cell: self)
        
    }
}

//
//  TextFieldCell.swift
//  Rent_All
//
//  Created by RadicalStart on 24/07/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class TextFieldCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var stepnumberLbl: UILabel!
    @IBOutlet weak var queryTitleLbl: UILabel!
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var step1Height: NSLayoutConstraint!
    
    //MARK: - ViewController Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        stepnumberLbl.text = Utility.shared.getLanguage()?.value(forKey: "step1") as? String
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

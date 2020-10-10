//
//  checkTextviewCell.swift
//  Rent_All
//
//  Created by RadicalStart on 17/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
protocol checkTextviewCellDelegate: class {
    func didChangeText(text: String?, cell: checkTextviewCell)
}

class checkTextviewCell: UITableViewCell,UITextViewDelegate {

    
    @IBOutlet weak var messageLabel: UILabel!
    weak var delegate: checkTextviewCellDelegate?
    var placeholderLabel : UILabel!
    @IBOutlet weak var checkTxtview: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        checkTxtview.delegate = self
        checkTxtview.isEditable = true
        checkTxtview.text = ""
        checkTxtview.isScrollEnabled = true
        checkTxtview.autocorrectionType = UITextAutocorrectionType.no
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = false
        
        placeholderLabel = UILabel()
        placeholderLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"writemessage"))!)"
        placeholderLabel.font = checkTxtview.font
        placeholderLabel.numberOfLines = 0
        placeholderLabel.sizeToFit()
        checkTxtview.addSubview(placeholderLabel)
        placeholderLabel.frame = CGRect(x:5, y: 0, width:checkTxtview.frame.size.width-20, height:30)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !checkTxtview.text.isEmpty
        messageLabel.text =  "\((Utility.shared.getLanguage()?.value(forKey:"yourmessage"))!)"
        
        // Initialization code
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
        delegate?.didChangeText(text: textView.text, cell: self)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(!Utility.shared.checkEmptyWithString(value:textView.text!)) {
           // IQKeyboardManager.shared.enable = true
            //IQKeyboardManager.shared.enableAutoToolbar = true
            
        }

        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
       // IQKeyboardManager.shared.enable = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  CancelTextviewCell.swift
//  Rent_All
//
//  Created by RadicalStart on 07/06/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

protocol CancelTextviewCellDelegate: class {
    func didChangeText(text: String?, cell: CancelTextviewCell)
    func textendEditing(text:String?, cell:CancelTextviewCell)
}
class CancelTextviewCell: UITableViewCell,UITextViewDelegate {
weak var delegate: CancelTextviewCellDelegate?
    @IBOutlet weak var checkTxtView: UITextView!
    
    @IBOutlet weak var borderView: UIView!
    
     var placeholderLabel : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        checkTxtView.delegate = self
        checkTxtView.isEditable = true
        checkTxtView.isScrollEnabled = true
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = false
        placeholderLabel = UILabel()
      //  placeholderLabel.text = "A personal note can help Kayal understand why you want to cancel your reservation"
        placeholderLabel.font = checkTxtView.font
        placeholderLabel.numberOfLines = 0
        placeholderLabel.sizeToFit()
        checkTxtView.addSubview(placeholderLabel)
        placeholderLabel.frame = CGRect(x:5, y:0, width:checkTxtView.frame.size.width-20, height:checkTxtView.frame.size.height)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !checkTxtView.text.isEmpty
        // Initialization code
    }
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
        delegate?.didChangeText(text: textView.text, cell: self)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        delegate?.textendEditing(text: textView.text, cell: self)
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            IQKeyboardManager.shared.enable = true
            IQKeyboardManager.shared.enableAutoToolbar = true
            textView.resignFirstResponder()
            return false
        }
        return true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

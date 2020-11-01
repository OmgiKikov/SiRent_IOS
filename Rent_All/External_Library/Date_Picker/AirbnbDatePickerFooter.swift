//
//  AirbnbDatePickerFooter.swift
//  airbnb-datepicker
//
//  Created by Yonas Stephen on 24/2/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import UIKit

protocol AirbnbDatePickerFooterDelegate {
    func didSave()
}

class AirbnbDatePickerFooter: UIView {
    
    var delegate: AirbnbDatePickerFooterDelegate?
    var isSaveEnabled: Bool? {
        didSet {
            if let enabled = isSaveEnabled, enabled {
                saveButton.isEnabled = true
                saveButton.alpha = 1
            } else {
                saveButton.isEnabled = false
                saveButton.alpha = 0.5
            }
        }
    }
    
    lazy var minimumbookLabel: UILabel = {
        let label = UILabel()
            
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        if(Utility.shared.minimumstay != 0)
        {
            label.text = "\((Utility.shared.getLanguage()?.value(forKey:"minimumstay"))!) \(Utility.shared.minimumstay) \((Utility.shared.getLanguage()?.value(forKey:"night"))!)\((Utility.shared.minimumstay) > 1 ? "" : "")"
        }
        else{
         label.text = ""
        }
        label.font = UIFont.boldSystemFont(ofSize:11.5)
        label.textColor = UIColor.white
        
        label.numberOfLines = 4
        return label
    }()
    
    lazy var saveButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = Theme.SECONDARY_COLOR
        
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"save"))!)", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(AirbnbDatePickerFooter.handleSave), for: .touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = Theme.PRIMARY_DARK_COLOR
        
        if(Utility.shared.isfromcheckingPage)
        {
        addSubview(minimumbookLabel)
            if(IS_IPHONE_XR || IS_IPHONE_PLUS)
            {
        minimumbookLabel.centerXAnchor.constraint(equalTo: centerXAnchor,constant:-100).isActive = true
            }
            else
            {
              minimumbookLabel.centerXAnchor.constraint(equalTo: centerXAnchor,constant:-80).isActive = true
            }
        minimumbookLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        minimumbookLabel.heightAnchor.constraint(equalTo: heightAnchor, constant: -10).isActive = true
        minimumbookLabel.widthAnchor.constraint(equalTo: widthAnchor, constant:-160).isActive = true
        minimumbookLabel.layer.cornerRadius = minimumbookLabel.frame.size.width/2
        minimumbookLabel.layer.masksToBounds = true
        addSubview(saveButton)
        
        saveButton.centerXAnchor.constraint(equalTo: centerXAnchor,constant: 100).isActive = true
        saveButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        saveButton.heightAnchor.constraint(equalTo: heightAnchor, constant: -50).isActive = true
        saveButton.widthAnchor.constraint(equalTo: widthAnchor, constant: -240).isActive = true
        }
        else{
            addSubview(saveButton)
            
            saveButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            saveButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            saveButton.heightAnchor.constraint(equalTo: heightAnchor, constant: -50).isActive = true
            saveButton.widthAnchor.constraint(equalTo: widthAnchor, constant: -30).isActive = true
        }
        
        saveButton.layer.cornerRadius = 6.0
       saveButton.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleSave() {
        if let del = delegate {
            del.didSave()
        }
    }
}

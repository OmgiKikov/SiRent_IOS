//
//  SearchPageVC.swift
//  Rent_All
//
//  Created by RADICAL START on 26/03/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class SearchPalceCell: UITableViewCell {
    @IBOutlet var iconImage: UIImageView!
    
    @IBOutlet var locationLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configCell(locationDict:NSDictionary) {
        locationLbl.text = locationDict.value(forKey: "address_full") as? String
        locationLbl.font = UIFont(name: "Circular-book", size:16)
        locationLbl.textColor = UIColor.black
        //iconImage.image = 
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

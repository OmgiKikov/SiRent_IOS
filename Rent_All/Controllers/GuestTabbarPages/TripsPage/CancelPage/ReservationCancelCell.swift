//
//  ReservationCancelCell.swift
//  Rent_All
//
//  Created by RadicalStart on 07/06/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class ReservationCancelCell: UITableViewCell {

    @IBOutlet weak var reservationcancelTitleLabel: UILabel!
    @IBOutlet weak var nonrefundableLabel: UILabel!
    @IBOutlet weak var hostnightLabel: UILabel!
    @IBOutlet weak var missedearningsLabel: UILabel!
    @IBOutlet weak var inLabel: UILabel!
    @IBOutlet weak var aboveCostLAbel: UILabel!
    @IBOutlet weak var cancelReservationBtn: UIButton!
    @IBOutlet weak var keepReservationBtn: UIButton!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var priceLAbel: UILabel!
    @IBOutlet weak var Listimage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
           reservationcancelTitleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"reserveCancel"))!)"
           missedearningsLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"missedearnings"))!)"
        keepReservationBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"keepreservation"))!)", for: .normal)
        cancelReservationBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"cancelreservation"))!)", for: .normal)
          nonrefundableLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"nonrefundable"))!)"
        inLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"refundable"))!)"
        
        
           aboveCostLAbel.text = "\((Utility.shared.getLanguage()?.value(forKey:"refundcost"))!)"
        
        titleLabel.textColor = Theme.PRIMARY_COLOR
        keepReservationBtn.setTitleColor(Theme.TERTIARY_COLOR, for: .normal)
         cancelReservationBtn.backgroundColor = Theme.TERTIARY_COLOR
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

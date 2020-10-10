//
//  AddphotoCell.swift
//  Rent_All
//
//  Created by RadicalStart on 27/07/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Lottie

class AddphotoCell: UICollectionViewCell {

    @IBOutlet weak var closebtn: UIButton!
    @IBOutlet weak var coverLabel: UILabel!
    @IBOutlet weak var addphotoimage: UIImageView!
    var lottieView: LOTAnimationView!
    var coverbutton = UIButton()
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        lottieView = LOTAnimationView.init(name:"animation")
        self.coverLabel.layer.cornerRadius = 4.0
        self.coverLabel.layer.masksToBounds = true
        self.closebtn.layer.cornerRadius = 4.0
        self.closebtn.layer.masksToBounds = true
        self.addphotoimage.layer.cornerRadius = 6.0
        self.addphotoimage.layer.masksToBounds = true
        self.coverbutton.frame = CGRect(x: coverLabel.frame.origin.x, y: coverLabel.frame.origin.y, width: coverLabel.frame.size.width, height: coverLabel.frame.size.height)
        self.contentView.addSubview(coverbutton)
        self.contentView.bringSubviewToFront(coverbutton)
        
         coverLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"coverphoto"))!)"
        // Initialization code
    }

    
    func lottieAnimation(){
        lottieView = LOTAnimationView.init(name:"animation")
        lottieView.isHidden = false
        self.lottieView.frame = CGRect(x:self.addphotoimage.frame.size.width/2-60, y:50, width:100, height:100)
        self.contentView.addSubview(self.lottieView)
        self.lottieView.backgroundColor = UIColor.clear
        self.lottieView.layer.cornerRadius = 6.0
        self.lottieView.clipsToBounds = true
        self.lottieView.play()
        Timer.scheduledTimer(timeInterval:0.3, target: self, selector: #selector(autoscroll), userInfo: nil, repeats: true)
    }
    @objc func autoscroll()
    {
        self.lottieView.play()
    }


}

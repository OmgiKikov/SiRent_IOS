//
//  WhishlistCell.swift
//  Rent_All
//
//  Created by RadicalStart on 03/07/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Lottie
class WhishlistCell: UICollectionViewCell {

    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var whishImage: UIImageView!
    
    var lottieView1: LOTAnimationView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        
    }
    func lottieAnimationView(){
        lottieView1 = LOTAnimationView.init(name:"animation")
        lottieView1.isHidden = false
        self.lottieView1.frame = CGRect(x:(self.whishImage.frame.size.width)/2-45, y:(self.whishImage.frame.size.height)/2-45, width:100, height:100)
        self.contentView.addSubview(self.lottieView1)
        self.lottieView1.backgroundColor = UIColor.clear
        self.lottieView1.layer.cornerRadius = 6.0
        self.lottieView1.clipsToBounds = true
        self.likeImage.isHidden = true
        self.lottieView1.play()
        Timer.scheduledTimer(timeInterval:0.3, target: self, selector: #selector(autoscroll), userInfo: nil, repeats: true)
    }
    @objc func autoscroll()
    {
        self.lottieView1.play()
    }
    
    
   

}

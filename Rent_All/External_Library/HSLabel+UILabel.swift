//
//  HSLabel+UILabel.swift
//  HSTaxiUserApp
//
//  Created by APPLE on 10/03/18.
//  Copyright © 2018 APPLE. All rights reserved.
//

import Foundation
import UIKit

extension UILabel{
 
    //MARK: configure label
    public func config(color:UIColor,size:CGFloat, align:NSTextAlignment, text:String){
        self.textColor = color
        self.textAlignment = align
     
    }
    
  
    
    //round corner
    func cornerRadius() {
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
    //specific corner size
    func lblMinimumCornerRadius() {
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
    }
    
        
    private struct AssociatedKeys {
        static var padding = UIEdgeInsets()
    }
    
    public var padding: UIEdgeInsets? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.padding) as? UIEdgeInsets
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.padding, newValue as UIEdgeInsets?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    
    
    
}

//
//  AirbnbOccupantFilterController.swift
//  airbnb-occupant-filter
//
//  Created by Yonas Stephen on 4/4/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import UIKit

protocol AirbnbOccupantFilterControllerDelegate {
    func occupantFilterController(_ occupantFilterController: AirbnbOccupantFilterController, didSaveAdult adult: Int, children: Int, infant: Int, pet: Bool)
}

class AirbnbOccupantFilterController: UIViewController {
    
    var delegate: AirbnbOccupantFilterControllerDelegate?
    
    var adultCount: Int?
    var childrenCount: Int?
    var infantCount: Int?
    var hasPet: Bool?
    
    var humanCount: Int {
        return (adultCount ?? 0) + (childrenCount ?? 0)
    }
    var maxHumanCount: Int {
        if(Utility.shared.isfromcheckingPage)
        {
        return Utility.shared.maximum_Count_for_booking - humanCount
        }
        else{
        return  Utility.shared.maximum_guest_count - humanCount
        }
    }
    
    lazy var adultCounter: AirbnbCounter = {
        let view = AirbnbCounter()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.fieldID = "adult"
        view.delegate = self
        view.maxCount = self.maxHumanCount
        view.minCount = 1
        //if(view.count == 1){
            view.caption = "\((Utility.shared.getLanguage()?.value(forKey:"guest"))!)"
//        }
//        else{
//            view.caption = "Guests"
//        }
        return view
    }()
    
    /*lazy var childrenCounter: AirbnbCounter = {
        let view = AirbnbCounter()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.fieldID = "child"
        view.delegate = self
        view.caption = "Children"
        view.subCaption = "Ages 2 - 12"
        view.maxCount = self.maxHumanCount
        view.minCount = 0
        return view
    }()
    
    var infantCounter: AirbnbCounter = {
        let view = AirbnbCounter()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.caption = "Infants"
        view.subCaption = "2 & under"
        view.maxCount = 5
        view.minCount = 0
        return view
    }()
    
    var petSwitch: AirbnbSwitch = {
        let view = AirbnbSwitch()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.caption = "Pet"
        return view
    }()
 */
    
    lazy var dismissButton: UIBarButtonItem = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setImage(UIImage(named: "close-black", in: Bundle(for: AirbnbOccupantFilter.self), compatibleWith: nil), for: .normal)
        btn.frame = CGRect(x: 5, y: 5, width: 15, height: 15)
        btn.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        btn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        btn.addTarget(self, action: #selector(AirbnbOccupantFilterController.handleDismiss), for: .touchUpInside)
        let barBtn = UIBarButtonItem(customView: btn)
        return barBtn
    }()
    
    
    var footerSeparator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = TextLightColor
        let shadowSize : CGFloat = 3.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: view.frame.size.width+40 + shadowSize,
                                                   height: view.frame.size.height + shadowSize))
        
        view.layer.masksToBounds = false
        view.layer.shadowColor = TextLightColor.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view.layer.shadowOpacity = 0.3
        view.layer.shadowPath = shadowPath.cgPath
        
        return view
    }()
    
    lazy var saveButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = Theme.PRIMARY_COLOR
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"save"))!)", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.addTarget(self, action: #selector(AirbnbOccupantFilterController.handleSave), for: .touchUpInside)
        return btn
    }()
    
    convenience init(adultCount: Int?, childrenCount: Int?, infantCount: Int?, hasPet: Bool?) {
        self.init()
        
        self.adultCount = adultCount
        self.childrenCount = childrenCount
        self.infantCount = infantCount
        self.hasPet = hasPet
        
        adultCounter.count = self.adultCount ?? 1
//        childrenCounter.count = self.childrenCount ?? 0
//        infantCounter.count = self.infantCount ?? 0
//        petSwitch.state = self.hasPet ?? false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupViews()
    }
    
    func setupViews() {
        
        //view.backgroundColor = Theme.PRIMARY_COLOR
        view.backgroundColor = UIColor.white
        
        view.addSubview(adultCounter)
        
        adultCounter.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        adultCounter.heightAnchor.constraint(equalToConstant: 50).isActive = true
        adultCounter.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        adultCounter.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true

//        view.addSubview(childrenCounter)
//
//        childrenCounter.topAnchor.constraint(equalTo: adultCounter.bottomAnchor, constant: 50).isActive = true
//        childrenCounter.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        childrenCounter.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        childrenCounter.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
//
//        view.addSubview(infantCounter)
//
//        infantCounter.topAnchor.constraint(equalTo: childrenCounter.bottomAnchor, constant: 50).isActive = true
//        infantCounter.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        infantCounter.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        infantCounter.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
//
//        view.addSubview(petSwitch)
//
//        petSwitch.topAnchor.constraint(equalTo: infantCounter.bottomAnchor, constant: 50).isActive = true
//        petSwitch.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        petSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        petSwitch.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true

        setupFooterView()
        
    }
    
    
    func setupFooterView() {
        view.addSubview(saveButton)
        
        saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(footerSeparator)
        
        footerSeparator.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -10).isActive = true
        footerSeparator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        footerSeparator.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        footerSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        self.navigationItem.setLeftBarButton(dismissButton, animated: true)
    }
    
    @objc func handleDismiss() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSave() {
        if let del = delegate {
            
            adultCount = adultCounter.count
//            childrenCount = childrenCounter.count
//            infantCount = infantCounter.count
//            hasPet = petSwitch.state
            
            let guest = adultCount! + childrenCount!
            
            let guests = [
                "guest": "\(guest)",
                "children": "\(childrenCount!)",
                "adults": "\(adultCount!)",
                "infants": "\(infantCount!)"
            ]
            NotificationCenter.default.post(name: Notification.Name("Guest"), object: nil, userInfo: guests as? [AnyHashable : Any])
            del.occupantFilterController(self, didSaveAdult: adultCount ?? 1, children: childrenCount ?? 0, infant: infantCount ?? 0, pet: hasPet ?? false)
            
            dismiss(animated: true, completion: nil)
        }
    }
}

extension AirbnbOccupantFilterController: AirbnbCounterDelegate {
    func counter(_ counter: AirbnbCounter, didUpdate count: Int) {
        if counter.fieldID == adultCounter.fieldID {
            adultCount = count
             let view = AirbnbCounter()
            updtaecaptionLabel()
            updateHumanMaxCount()
        }
//        else if counter.fieldID == childrenCounter.fieldID {
//            childrenCount = count
//            updateHumanMaxCount()
//        }
    }
    
    func updateHumanMaxCount() {
        adultCounter.maxCount = maxHumanCount + (adultCount ?? 0)
       // childrenCounter.maxCount = maxHumanCount + (childrenCount ?? 0)
    }
    func updtaecaptionLabel()
    {
        if(adultCount ?? 0 > 1){
            
            adultCounter.caption  = "\((Utility.shared.getLanguage()?.value(forKey:"guests"))!)"
        }
        else{
            adultCounter.caption = "\((Utility.shared.getLanguage()?.value(forKey:"guest"))!)"
        }
        
    }
}

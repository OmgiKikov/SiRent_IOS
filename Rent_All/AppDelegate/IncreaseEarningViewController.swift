//
//  IncreaseEarningViewController.swift
//  Rent_All
//
//  Created by RadicalStart on 08/08/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Lottie

class IncreaseEarningViewController: BaseHostTableviewController {
    
    @IBOutlet weak var retryBtn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var saveandExit: UIButton!
    @IBOutlet weak var imagearrowBtn: UIImageView!
    
    @IBOutlet weak var offlineUIView: UIView!
    var currencyDataArray = [GetCurrenciesListQuery.Data.GetCurrency.Result]()
    
    var weeklydiscountvalue = ""
    var monthlydiscountvalue = ""
    
    var lottieView1: LOTAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
        retryBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
        saveandExit.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"saveexit"))!)", for:.normal)
        saveandExit.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
        nextBtn.backgroundColor = Theme.PRIMARY_COLOR
        // Do any additional setup after loading the view.
    }
    
    
    override func setUpUI() {
        offlineUIView.isHidden = true
        callListingSettingsAPI(oflineView: offlineUIView, nextButton: nextBtn)
        tableView.isHidden = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
          nextBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"next"))!)", for: .normal)
        nextBtn.layer.cornerRadius = 5
        nextBtn.clipsToBounds = true
        imagearrowBtn.image = imagearrowBtn.image?.withRenderingMode(.alwaysTemplate)
        imagearrowBtn.tintColor = UIColor.white
        if(Utility.shared.step3_Edit)
        {
            self.saveandExit.isHidden = false
        }
        else{
            self.saveandExit.isHidden = true
        }
        if(Utility.shared.step3ValuesInfo["bookingType"] != nil)
        {
            
        }
        else
        {
        Utility.shared.step3ValuesInfo.updateValue("instant", forKey: "bookingType")
        }
    }
    
    override func setDropdownList() {
        
        tableView.reloadData()
    }
    

    
    override func registerCells() {
        tableView.register(UINib(nibName: "AmenitiesCell", bundle: nil), forCellReuseIdentifier: "AmenitiesCell")
    }
    
    //MARK: - Progress Indicator
    
    override func addLottieViewAsSubview()
    {
        self.view.addSubview(self.lottieView)
    }
    
    //IBActions
    
    func lottieViewanimation()
    {
        saveandExit.setTitle("", for:.normal)
        lottieView1 = LOTAnimationView.init(name: "animation")
        self.lottieView1.isHidden = false
        self.lottieView1.frame = CGRect(x:80, y:-35, width:100, height:100)
        self.saveandExit.addSubview(self.lottieView1)
        self.view.bringSubviewToFront(self.lottieView1)
        self.lottieView1.backgroundColor = UIColor.clear
        self.lottieView1.play()
        Timer.scheduledTimer(timeInterval:0.3, target: self, selector: #selector(autoscrolling), userInfo: nil, repeats: true)
    }
    @objc func autoscrolling()
    {
        self.lottieView1.play()
    }
    func offlineviewShow()
    {
        self.offlineUIView.isHidden = false
        let shadowSize2 : CGFloat = 3.0
        let shadowPath2 = UIBezierPath(rect: CGRect(x: -shadowSize2 / 2,
                                                    y: -shadowSize2 / 2,
                                                    width: self.offlineUIView.frame.size.width + shadowSize2,
                                                    height: self.offlineUIView.frame.size.height + shadowSize2))
        
        self.offlineUIView.layer.masksToBounds = false
        self.offlineUIView.layer.shadowColor = TextLightColor.cgColor
        self.offlineUIView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.offlineUIView.layer.shadowOpacity = 0.3
        self.offlineUIView.layer.shadowPath = shadowPath2.cgPath
        if IS_IPHONE_X || IS_IPHONE_XR{
            offlineUIView.frame = CGRect.init(x: 0, y: FULLHEIGHT-130, width: FULLWIDTH, height: 55)
        }else{
            offlineUIView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
        }
    }
    @IBAction func retryBtnTapped(_ sender: Any) {
        
        if Utility().isConnectedToNetwork(){
            self.offlineUIView.isHidden = true
        }
    }
    
    @IBAction func RedirectNextPage(_ sender: Any) {
         if Utility().isConnectedToNetwork(){
       // Utility.shared.step3ValuesInfo.updateValue("request", forKey: "bookingType")
        Utility.shared.step3ValuesInfo.updateValue(Utility.shared.createId, forKey: "id")
        let amenities = LawAndTaxViewController()
        self.view.window?.backgroundColor = UIColor.white
        amenities.modalPresentationStyle = .fullScreen
        self.present(amenities, animated: false, completion: nil)
        }
        else
         {
            self.offlineviewShow()
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
         if Utility().isConnectedToNetwork(){
            //self.view.layer.add(dismissrightAnimation()!, forKey: kCATransition)
            self.dismiss(animated:false, completion: nil)
        }
        else
         {
            self.offlineviewShow()
        }
    }
    
    @IBAction func saveandexitAction(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            //Utility.shared.step3ValuesInfo.updateValue("request", forKey: "bookingType")
            Utility.shared.step3ValuesInfo.updateValue(Utility.shared.createId, forKey: "id")
            self.lottieViewanimation()
            super.updateStep3ListingAPICall()
        }
        else
        {
            self.offlineviewShow()
        }
    }
    
    //MARK: - UITAbleViewDatasource and UITableViewDelegates
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0
        {
            return "\((Utility.shared.getLanguage()?.value(forKey:"increaseearnings"))!)"
        }else {
            return "\((Utility.shared.getLanguage()?.value(forKey:"whobook"))!)"
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0)
        {
            return 90
        }
        if Utility.shared.getAppLanguageCode() == "en" || Utility.shared.getAppLanguageCode() == "En"{
             return 70
        }else{
             return 90
        }
       
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0)
        {
            return 70
        }
        return 70
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0
        {
            return 1
        }
        else {
            return 3
        }
        
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerLabel = UILabel(frame: CGRect(x:15, y: 8, width:FULLWIDTH-40, height: 100))
        
        headerLabel.font =  UIFont(name: "Circular-Medium", size:25)
        headerLabel.addCharacterSpacing()
        headerLabel.textColor = UIColor.black
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        headerLabel.numberOfLines = 0
        headerLabel.sizeToFit()
        
        let headerView = UIView(frame: CGRect(x:15, y: 8, width: tableView.bounds.size.width - 20, height: 100))
        headerView.backgroundColor = UIColor.white
        headerView.addSubview(headerLabel)
        return headerView
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0
        {
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            cell.textLabel?.text = "\((Utility.shared.getLanguage()?.value(forKey:"instantbook_desc"))!)"
          
            cell.textLabel?.font = UIFont(name: "Circular-Book", size:18)
            cell.textLabel?.textColor = UIColor.darkGray
            cell.textLabel?.numberOfLines = 0
            return cell
        }else {
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            cell.tag = indexPath.row + 2000
            
            if indexPath.row == 0
            {
                cell.textLabel?.font = UIFont(name: "Circular-Book", size:15)
                cell.textLabel?.text = "\((Utility.shared.getLanguage()?.value(forKey:"choosebookavailable"))!)"
                
                cell.textLabel?.textColor = UIColor.darkGray
                cell.textLabel?.numberOfLines = 0
            }
            else if indexPath.row == 1
            {
                cell.imageView?.image = #imageLiteral(resourceName: "profile_Verify_Tick")
                if((Utility.shared.step3ValuesInfo["bookingType"]as? String) == "instant")
                {
                cell.imageView?.image = #imageLiteral(resourceName: "profile_Verify_Tick")
                }
                else
                {
                 cell.imageView?.image = #imageLiteral(resourceName: "price_unclick")
                }
                cell.textLabel?.text = "\((Utility.shared.getLanguage()?.value(forKey:"guestmeet"))!)"
              //                cell.detailTextLabel!.text = "Anyone else must send a reservation request."
                cell.detailTextLabel?.textColor = UIColor.lightGray
                cell.textLabel?.font = UIFont(name: "Circular-Book", size:17)
                cell.textLabel?.numberOfLines = 0
                
            }else if indexPath.row == 2
            {
                if((Utility.shared.step3ValuesInfo["bookingType"]as? String) == "request")
                {
                    cell.imageView?.image = #imageLiteral(resourceName: "profile_Verify_Tick")
                }
                else
                {
                    cell.imageView?.image = #imageLiteral(resourceName: "price_unclick")
                }
                cell.textLabel?.text = "\((Utility.shared.getLanguage()?.value(forKey:"noreservationrequest"))!)"
            
                cell.textLabel?.font = UIFont(name: "Circular-Book", size:17)
                cell.textLabel?.numberOfLines = 0
            }
            return cell
        }

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1
        {
           let cell = view.viewWithTag(indexPath.row + 2000) as? UITableViewCell
            if(indexPath.row == 1)
            {
                if cell?.imageView?.image == #imageLiteral(resourceName: "profile_Verify_Tick")
            {
                cell?.imageView?.image = #imageLiteral(resourceName: "price_unclick")
            }
            else if cell?.imageView?.image == #imageLiteral(resourceName: "price_unclick")
            {
                Utility.shared.step3ValuesInfo.updateValue("instant", forKey: "bookingType")
                cell?.imageView?.image = #imageLiteral(resourceName: "profile_Verify_Tick")
            }
            }
            else
            {
                if cell?.imageView?.image == #imageLiteral(resourceName: "profile_Verify_Tick")
            {
                cell?.imageView?.image = #imageLiteral(resourceName: "price_unclick")
            }
            else if cell?.imageView?.image == #imageLiteral(resourceName: "price_unclick")
            {
                Utility.shared.step3ValuesInfo.updateValue("request", forKey: "bookingType")
                cell?.imageView?.image = #imageLiteral(resourceName: "profile_Verify_Tick")
                
            }
        }
    }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0)
        {
            if Utility.shared.getAppLanguageCode() == "en" || Utility.shared.getAppLanguageCode() == "En" || Utility.shared.getAppLanguageCode() == "it" || Utility.shared.getAppLanguageCode() == "It" {
                 return 120
            }else{
                 return 160
            }
           
        }
        else
        {
            if(indexPath.row == 1)
            {
               return 80
            }
            else if(indexPath.row == 2)
            {
              return 110
            }
        }
        return 65
    }
    
    
    
}

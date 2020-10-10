//
//  AddressListingViewController.swift
//  Rent_All
//
//  Created by RadicalStart on 31/07/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import MapKit
import Lottie
import IQKeyboardManagerSwift

class AddressListingViewController: BaseHostTableviewController, CountryDelegate {
   
    

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var nextarrow: UIImageView!
    @IBOutlet weak var offlineUIView: UIView!
    @IBOutlet weak var saveandExit: UIButton!
    @IBOutlet weak var retryButn: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    //This Property
    var countryPlaceHolder = ""
    var countryValue = ""
    var selectedCountryCode = ""
    var countryArr = [String]()
    var isSaveandExitEnabled = Bool()
    var address = ""
    var street = ""
    var buildingName = ""
    var city = ""
    var state = ""
    var pincode = ""
    var createResults = CreateListingMutation.Data.CreateListing.Result()
      var lottieView1: LOTAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.enable = true
        saveandExit.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"saveexit"))!)", for:.normal)
        errorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
        retryButn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
        nextBtn.backgroundColor = Theme.PRIMARY_COLOR
        saveandExit.setTitleColor(Theme.PRIMARY_COLOR, for:.normal)
    }
    override func viewWillAppear(_ animated: Bool) {
        nextarrow.isHidden = false
        nextBtn.setTitle("\(Utility.shared.getLanguage()?.value(forKey: "next")as! String)", for:.normal)
    }
    
    override func setUpUI() {
       if(Utility.shared.step1_inactivestatus == "inactive" || Utility.shared.step1_inactivestatus == "")
        {
            saveandExit.isHidden = true
            isSaveandExitEnabled = false
        }
        else {
            saveandExit.isHidden = false
        isSaveandExitEnabled = true
        }
        offlineUIView.isHidden = true
        callListingSettingsAPI(oflineView: offlineUIView, nextButton: nextBtn)
        tableView.isHidden = false
        // tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
       nextBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey: "next"))!)", for: .normal)
        nextBtn.layer.cornerRadius = 5
        nextBtn.clipsToBounds = true
        nextarrow.image = nextarrow.image?.withRenderingMode(.alwaysTemplate)
        nextarrow.tintColor = UIColor.white
        lottieView1 = LOTAnimationView.init(name: "animation")
    }
    
    override func setDropdownList() {
        
        for country in Utility.shared.countrylist
        {
            countryArr.append(country.countryName!)
        }
        if countryArr.count > 0
        {
            countryPlaceHolder = countryArr.first!
        }
        
        if Utility.shared.step1ValuesInfo["country"] != nil
        {
            address = Utility.shared.step1ValuesInfo["country"] as! String
            countryValue = Utility.shared.step1ValuesInfo["country"] as! String
        }
        if Utility.shared.step1ValuesInfo["street"] != nil
        {
           // address = address + "" + ((Utility.shared.step1ValuesInfo["street"] as? String)!) + ","
            street = (Utility.shared.step1ValuesInfo["street"] as? String)!
        }
        if Utility.shared.step1ValuesInfo["city"] != nil
        {
            //address = address + "" + (Utility.shared.step1ValuesInfo["city"] as! String) + ","
            city = (Utility.shared.step1ValuesInfo["city"] as? String)!
        }
        if Utility.shared.step1ValuesInfo["state"] != nil
        {
            //address = address + "" + (Utility.shared.step1ValuesInfo["state"] as! String) + ","
            state = (Utility.shared.step1ValuesInfo["state"] as? String)!
        }
        if Utility.shared.step1ValuesInfo["zipcode"] != nil
        {
            address = address + "" + (Utility.shared.step1ValuesInfo["zipcode"] as! String)
            pincode = (Utility.shared.step1ValuesInfo["zipcode"] as? String)!
        }
        tableView.reloadData()
    }
    
   
    
    func offlineViewShow()
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
    
    func lottienextanimation()
    {
        nextarrow.isHidden = true
        nextBtn.setTitle("", for:.normal)
        lottieView1 = LOTAnimationView.init(name: "animation_white")
        self.lottieView1.isHidden = false
        self.lottieView1.frame = CGRect(x:15, y:-25, width:100, height:100)
        self.nextBtn.addSubview(self.lottieView1)
        self.view.bringSubviewToFront(self.lottieView1)
        self.lottieView1.backgroundColor = UIColor.clear
        self.lottieView1.play()
        Timer.scheduledTimer(timeInterval:0.3, target: self, selector: #selector(autoscroll1), userInfo: nil, repeats: true)
    }
    @objc func autoscroll1()
    {
        self.lottieView1.play()
    }
    func createListingAPICall()
    {
        nextBtn.isHidden = false
        
        if Utility.shared.isConnectedToNetwork()
        {
            let createlist = CreateListingMutation(listId: nil,
                                                   roomType: "\(Utility.shared.step1ValuesInfo["roomType"] ?? "")",
                houseType: "\(Utility.shared.step1ValuesInfo["houseType"] ?? "")" ,
                residenceType: "\(Utility.shared.step1ValuesInfo["residenceType"] ?? "")",
                bedrooms: "\(Utility.shared.step1ValuesInfo["bedrooms"] ?? "")" ,
                buildingSize: "\(Utility.shared.step1ValuesInfo["buildingSize"] ?? "")",
                bedType: "\(Utility.shared.step1ValuesInfo["bedType"] ?? "")" ,
                beds: Utility.shared.step1ValuesInfo["beds"] as? Int,
                personCapacity: Utility.shared.step1ValuesInfo["personCapacity"] as? Int,
                bathrooms:(Utility.shared.step1ValuesInfo["bathrooms"] as? Double),
                bathroomType: "\(Utility.shared.step1ValuesInfo["bathroomType"] ?? "")",
                country: "\(Utility.shared.step1ValuesInfo["country"] ?? "")",
                street: "\(Utility.shared.step1ValuesInfo["street"] ?? "")",
                buildingName: "\(Utility.shared.step1ValuesInfo["buildingName"] ?? "")",
                city: "\(Utility.shared.step1ValuesInfo["city"] ?? "")",
                state: "\(Utility.shared.step1ValuesInfo["state"] ?? "")",
                zipcode: "\(Utility.shared.step1ValuesInfo["zipcode"] ?? "")",
                lat: (Utility.shared.step1ValuesInfo["lat"] as! Double),
                lng: (Utility.shared.step1ValuesInfo["lng"] as! Double),
                bedTypes: "\(Utility.shared.step1ValuesInfo["bedTypes"] ?? "")" ,
                isMapTouched: Utility.shared.step1ValuesInfo["isMapTouched"] as? Bool,
                amenities: [] ,
                safetyAmenities: [] ,
                spaces: [])
            apollo_headerClient.perform(mutation: createlist){ (result,error) in
                
                if(result?.data?.createListing?.status == 200)
                {
                    
                    self.lottieView1.isHidden = true
                    self.nextBtn.setTitle("Next", for:.normal)
                    self.nextarrow.isHidden = false
                    self.createResults = (result?.data?.createListing?.results)!
                    Utility.shared.createId = (result?.data?.createListing?.id)!
                    self.manageListingSteps(listId: "\((result?.data?.createListing?.id)!)", currentStep: 1)
                    

                }
                else{
                    self.lottieView1.isHidden = true
                    self.nextBtn.setTitle("Next", for:.normal)
                    self.nextarrow.isHidden = false
                    self.view.makeToast("Invalid Address")
                
                }
            }
        }else {
            self.lottieView1.isHidden = true
            self.nextBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey: "next"))!)", for:.normal)
            self.nextarrow.isHidden = false
            super.lottieView.isHidden = true
            nextBtn.isHidden = true
            offlineUIView.isHidden = false
            let shadowSize2 : CGFloat = 3.0
            let shadowPath2 = UIBezierPath(rect: CGRect(x: -shadowSize2 / 2,
                                                        y: -shadowSize2 / 2,
                                                        width: UIScreen.main.bounds.size.width + shadowSize2,
                                                        height: offlineUIView.frame.size.height + shadowSize2))
            
            offlineUIView.layer.masksToBounds = false
            offlineUIView.layer.shadowColor = TextLightColor.cgColor
            offlineUIView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            offlineUIView.layer.shadowOpacity = 0.3
            offlineUIView.layer.shadowPath = shadowPath2.cgPath
            if IS_IPHONE_X || IS_IPHONE_XR {
                offlineUIView.frame = CGRect.init(x: 0, y: FULLHEIGHT-85, width: UIScreen.main.bounds.size.width, height: 55)
            }else{
                offlineUIView.frame = CGRect.init(x: 0, y: FULLHEIGHT-55, width: UIScreen.main.bounds.size.width, height: 55)
            }
        }
        
    }
    
    func manageListingSteps(listId:String,currentStep:Int)
    {
        let manageListingStepsMutation = ManageListingStepsMutation(listId:listId, currentStep:currentStep)
        apollo_headerClient.perform(mutation: manageListingStepsMutation){ (result,error) in
            
            if(result?.data?.manageListingSteps?.status == 200)
            {
                print("steps updated")
                self.lottieView1.isHidden = true
                let becomeHostObj = MapLocateVC()
                if(Utility.shared.isfrombecomehoststep1Edit)
                {
                 Utility.shared.step1_inactivestatus = "completed"
                }
                else
                {
                Utility.shared.step1_inactivestatus = ((result?.data?.manageListingSteps?.results?.step3!)!)
                }
                self.view.window?.backgroundColor = UIColor.white
                becomeHostObj.modalPresentationStyle = .fullScreen
                self.present(becomeHostObj, animated:false, completion: nil)
            }
        }
    }
    
    //MARK: - Register Cells
    override func registerCells() {
        tableView.register(UINib(nibName: "TextFieldCell", bundle: nil), forCellReuseIdentifier: "textfieldcell")
    }
    
    //MARK: - Progress Indicator
    
    override func addLottieViewAsSubview()
    {
       // self.view.addSubview(self.lottieView)
    }
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
        Timer.scheduledTimer(timeInterval:0.3, target: self, selector: #selector(autoscroll), userInfo: nil, repeats: true)
    }
    @objc func autoscroll()
    {
        self.lottieView1.play()
    }
    
    //IBActions
    
    @IBAction func retryBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            self.offlineUIView.isHidden = true
        }
    }
    @IBAction func RedirectNextPage(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
        if self.countryValue.isEmpty || self.street.isEmpty || self.city.isEmpty || self.state.isEmpty || self.pincode.isEmpty {
            if self.countryValue.isEmpty{
                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey: "enter_country"))!)")
                return
            }
            if self.street.isEmpty{
                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey: "enter_street"))!)")
                return
            }
            if self.city.isEmpty {
                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey: "entercity"))!)")
                return
            }
            if self.state.isEmpty {
                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey: "enterstate"))!)")
                return
            }
            if self.pincode.isEmpty {
                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey: "enterzipcode"))!)")
                return
            }
        }else{
            if(("\(Utility.shared.createId)" != "0") && ("\(Utility.shared.createId)" != ""))
            {
                
                self.lottienextanimation()
                if(address != "")
                {
                let geoCoder = CLGeocoder()
                    geoCoder.geocodeAddressString(address) { (placemarks, error) in
                    guard
                        let placemarks = placemarks,
                        let location = placemarks.first?.location else {
                            
                            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey: "wrong_location"))!)")
                            self.lottieView1.isHidden = true
                            self.nextBtn.setTitle("\(Utility.shared.getLanguage()?.value(forKey: "next")as! String)", for:.normal)
                            self.nextarrow.isHidden = false
                            return
                    }
                    Utility.shared.step1ValuesInfo.updateValue(Double(location.coordinate.latitude), forKey: "lat")
                    Utility.shared.step1ValuesInfo.updateValue(Double(location.coordinate.longitude), forKey: "lng")
                    
                    DispatchQueue.main.async {
                        self.manageListingSteps(listId:"\(Utility.shared.createId)", currentStep: 1)
                    }

                    }
                }
                else
                {
                    DispatchQueue.main.async {
                        self.manageListingSteps(listId:"\(Utility.shared.createId)", currentStep: 1)
                    }
                }
                //Utility.shared.step1_inactivestatus = "completed"

            }else {
                self.lottienextanimation()
                let geoCoder = CLGeocoder()
                geoCoder.geocodeAddressString(address) { (placemarks, error) in
                    guard
                        let placemarks = placemarks,
                        let location = placemarks.first?.location
                        else {
                            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey: "wrong_location"))!)")
                            self.lottieView1.isHidden = true
                            self.nextBtn.setTitle("\(Utility.shared.getLanguage()?.value(forKey: "next")as! String)", for:.normal)
                            self.nextarrow.isHidden = false
                            return
                    }
                    Utility.shared.step1ValuesInfo.updateValue(Double(location.coordinate.latitude), forKey: "lat")
                    Utility.shared.step1ValuesInfo.updateValue(Double(location.coordinate.longitude), forKey: "lng")
                    Utility.shared.step1ValuesInfo.updateValue(true, forKey: "isMapTouched")
                    
                    DispatchQueue.main.async {
                    self.createListingAPICall()
                    }
                }
            }
            
        }
        }
        else
        {
            self.offlineViewShow()
        }
        
    }
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
       
            
        
       // self.view.layer.add(dismissrightAnimation()!, forKey: kCATransition)
//         if isSaveandExitEnabled{
//        if self.countryValue.isBlank || self.street.isBlank || self.city.isBlank || self.state.isBlank || self.pincode.isBlank {
//            if self.countryValue.isBlank{
//                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey: "enter_country"))!)")
//                return
//            }
//            if self.street.isBlank{
//                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey: "enter_street"))!)")
//                return
//            }
//            if self.city.isBlank {
//                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey: "entercity"))!)")
//                return
//            }
//            if self.state.isBlank {
//                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey: "enterstate"))!)")
//                return
//            }
//            if self.pincode.isBlank {
//                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey: "enterzipcode"))!)")
//                return
//            }}
//        }else{
            self.dismiss(animated: true, completion: nil)
       // }
        //self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func saveAndExitAction(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            if self.countryValue.isBlank || self.street.isBlank || self.city.isBlank || self.state.isBlank || self.pincode.isBlank {
                if self.countryValue.isBlank{
                    self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey: "enter_country"))!)")
                    return
                }
                if self.street.isBlank{
                    self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey: "enter_street"))!)")
                    return
                }
                if self.city.isBlank {
                    self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey: "entercity"))!)")
                    return
                }
                if self.state.isBlank {
                    self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey: "enterstate"))!)")
                    return
                }
                if self.pincode.isBlank {
                    self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey: "enterzipcode"))!)")
                    return
                }
            }else{
                if Utility.shared.step1ValuesInfo.keys.contains("lat") && Utility.shared.step1ValuesInfo.keys.contains("lng")
                {
                    self.lottieViewanimation()
                    super.updateListingAPICall()
                }else {
                    let geoCoder = CLGeocoder()
                    
                    geoCoder.geocodeAddressString(address) { (placemarks, error) in
                        guard
                            let placemarks = placemarks,
                            let location = placemarks.first?.location
                            else {
                                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey: "wrong_location"))!)")
                                self.lottieView1.isHidden = true
                                self.nextBtn.setTitle("\(Utility.shared.getLanguage()?.value(forKey: "next")as! String)", for:.normal)
                                self.nextarrow.isHidden = false
                                return
                        }
                        Utility.shared.step1ValuesInfo.updateValue(Double(location.coordinate.latitude), forKey: "lat")
                        Utility.shared.step1ValuesInfo.updateValue(Double(location.coordinate.longitude), forKey: "lng")
                        Utility.shared.step1ValuesInfo.updateValue(true, forKey: "isMapTouched")
                        self.lottieViewanimation()
                        super.updateListingAPICall()
                    }
                }
                
            }
       
        }
        else
        {
         self.offlineViewShow()
        }
    }
    //MARK: - UITAbleViewDatasource and UITableViewDelegates
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\((Utility.shared.getLanguage()?.value(forKey: "Where_place"))!)"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldcell", for: indexPath) as? TextFieldCell
            cell?.step1Height.constant = 0
            cell?.stepnumberLbl.isHidden = true
            let toolBar = UIToolbar().ToolbarPikerSelect(mySelect: #selector(dismissPicker))
            cell?.txtField.inputAccessoryView = toolBar
            
            if indexPath.row == 0
            {
                cell?.queryTitleLbl.text = "\((Utility.shared.getLanguage()?.value(forKey: "country_OR_region"))!)"
                cell?.txtField.attributedPlaceholder = NSAttributedString(string: countryPlaceHolder.isEmpty ? "Afghanistan" : countryPlaceHolder,
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                if Utility.shared.step1ValuesInfo.keys.contains("country"){
                    for i in 0..<Utility.shared.countrylist.count{
                        if Utility.shared.countrylist[i].countryCode == Utility.shared.step1ValuesInfo["country"] as? String
                        {
                            cell?.txtField.text = Utility.shared.countrylist[i].countryName
                        }
                    }
                    countryValue = (cell?.txtField.text)!
                }else{
//                    cell?.txtField.text = countryValue.isEmpty ? "" : countryValue
                }
                cell?.txtField.isUserInteractionEnabled = false
                cell?.txtField.tag = indexPath.row

            }else if indexPath.row == 1
            {
                cell?.queryTitleLbl.text = "\((Utility.shared.getLanguage()?.value(forKey: "street"))!)"
                cell?.txtField.attributedPlaceholder = NSAttributedString(string: "\((Utility.shared.getLanguage()?.value(forKey: "street_placeholder"))!)",
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                if Utility.shared.step1ValuesInfo.keys.contains("street"){
                    cell?.txtField.text = Utility.shared.step1ValuesInfo["street"] as? String
                    street = (cell?.txtField.text)!
                }else{
                    cell?.txtField.text = street.isEmpty ? "" : street
                }
                cell?.txtField.tag = indexPath.row

            }else if indexPath.row == 2
            {
                cell?.queryTitleLbl.text = "\((Utility.shared.getLanguage()?.value(forKey: "Apt_suite_optional"))!)"
                cell?.txtField.attributedPlaceholder = NSAttributedString(string: "\((Utility.shared.getLanguage()?.value(forKey: "Apt_suite_placeholder"))!)",
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                cell?.txtField.tag = indexPath.row
                if Utility.shared.step1ValuesInfo.keys.contains("buildingName"){
                    cell?.txtField.text = Utility.shared.step1ValuesInfo["buildingName"] as? String
                    buildingName = (cell?.txtField.text)!
                }else{
                    cell?.txtField.text = buildingName.isEmpty ? "" : buildingName
                }

            }else if indexPath.row == 3
            {
                cell?.queryTitleLbl.text = "\((Utility.shared.getLanguage()?.value(forKey: "city"))!)"
                cell?.txtField.attributedPlaceholder = NSAttributedString(string: "\((Utility.shared.getLanguage()?.value(forKey: "city_placeholder"))!)",
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                if Utility.shared.step1ValuesInfo.keys.contains("city"){
                    cell?.txtField.text = Utility.shared.step1ValuesInfo["city"] as? String
                    city = (cell?.txtField.text)!
                }else{
                    cell?.txtField.text = city.isEmpty ? "" : city
                }
                cell?.txtField.tag = indexPath.row

            }else if indexPath.row == 4
            {
                cell?.queryTitleLbl.text = "\((Utility.shared.getLanguage()?.value(forKey: "state"))!)"
                cell?.txtField.attributedPlaceholder = NSAttributedString(string: "\((Utility.shared.getLanguage()?.value(forKey: "state_placeholder"))!)",
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                if Utility.shared.step1ValuesInfo.keys.contains("state"){
                    cell?.txtField.text = Utility.shared.step1ValuesInfo["state"] as? String
                    state = (cell?.txtField.text)!
                }else{
                    cell?.txtField.text = state.isEmpty ? "" : state
                }
                cell?.txtField.tag = indexPath.row

            }else if indexPath.row == 5
            {
                cell?.queryTitleLbl.text = "\((Utility.shared.getLanguage()?.value(forKey: "zip_OR_postal"))!)"
                cell?.txtField.attributedPlaceholder = NSAttributedString(string: "\((Utility.shared.getLanguage()?.value(forKey: "zip_Placeholder"))!)",
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                if Utility.shared.step1ValuesInfo.keys.contains("zipcode"){
                    cell?.txtField.text = Utility.shared.step1ValuesInfo["zipcode"] as? String
                    pincode = cell?.txtField.text ?? ""
                }else{
                    cell?.txtField.text = pincode.isEmpty ? "" : pincode
                }
                cell?.txtField.tag = indexPath.row

            }
            cell?.txtField.tintColor = UIColor.black
            cell?.selectionStyle = .none
            cell?.txtField.delegate = self
            return cell!
            
        }
        return UITableViewCell()
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0
        {
            let countryListObj = CountrycodeVC()
            Utility.shared.isPhonenumberCountrycode = false
            countryListObj.titleForHeader = "\((Utility.shared.getLanguage()?.value(forKey: "selectcountry"))!)"
            countryListObj.delegate = self
            countryListObj.modalPresentationStyle = .fullScreen
            self.present(countryListObj, animated:false, completion: nil)
        }
        
    }
    
    func setSelectedCountry(selectedCountry: String, selectedcountryCode : String, selectdialcode: String) {
        countryValue = selectedCountry
        self.selectedCountryCode = selectedcountryCode
        Utility.shared.step1ValuesInfo.updateValue(selectedCountryCode, forKey: "country")
        self.tableView.reloadData()
    }
    
    override func textFieldDidEndEditing(_ textField: UITextField) {
        
        

        if textField.tag == 1
        {
            let textValue = textField.text!.trimmingCharacters(in:.whitespaces)
            Utility.shared.step1ValuesInfo.updateValue(textValue, forKey: "street")
            street = textValue
         //   address = address + textValue
        }
        if textField.tag == 2
        {
             let textValue = textField.text!.trimmingCharacters(in:.whitespaces)
            Utility.shared.step1ValuesInfo.updateValue(textValue, forKey: "buildingName")
            buildingName = textValue
        }
        if textField.tag == 3
        {
            let textValue = textField.text!.trimmingCharacters(in:.whitespaces)
            Utility.shared.step1ValuesInfo.updateValue(textValue, forKey: "city")
            city = textValue
            //address = address + textValue
        }
        if textField.tag == 4
        {
            let textValue = textField.text!.trimmingCharacters(in:.whitespaces)
            Utility.shared.step1ValuesInfo.updateValue(textValue, forKey: "state")
            state = textValue
            //address = address + textValue
        }
        if textField.tag == 5
        {
            let textValue = textField.text!.trimmingCharacters(in:.whitespaces)
            Utility.shared.step1ValuesInfo.updateValue(textValue, forKey: "zipcode")
            pincode = textValue
            address = countryValue
            address = address + textValue
        }
        
    }
    
    @objc func dismissPicker() {
        view.endEditing(true)
        
    }
}

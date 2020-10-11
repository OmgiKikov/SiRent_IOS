
//  BaseHostTableviewController.swift
//  Rent_All

//  Created by RadicalStart on 22/07/19.
//  Copyright © 2019 RADICAL START. All rights reserved.


import UIKit
import Apollo
import Lottie

class BaseHostTableviewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate,PlaceListingViewControllerDelegate{
    
    
   
    // Function are here
    
    func total_guest_change(guestcount: String) {
         let listSettings = (Utility.shared.getListSettingsArray.roomType?.listSettings!)!
        _ = listSettings.filter({ (item) -> Bool in
            if (Utility.shared.step1ValuesInfo["roomType"]! as? Int) == item?.id
            {
                placeLabel = (item?.itemName!)!
                return true
            }else{
                return false
            }
        })
        if !placeLabel.isEmpty
        {
            let index = itemNameArray.index(where: { (item) -> Bool in
                item == placeLabel
            })
            listValuePicker.selectRow(index!, inComponent: 0, animated: true)
        }
        if((Utility.shared.step1ValuesInfo["personCapacity"]!as! Int) <= 1)
        {
        guestLabel = ("\(Utility.shared.getLanguage()?.value(forKey: "Cap_for")as! String) \(Utility.shared.step1ValuesInfo["personCapacity"]!) \(Utility.shared.getLanguage()?.value(forKey: "guest")as! String)")
        }
        else
        {
         guestLabel = ("\(Utility.shared.getLanguage()?.value(forKey: "Cap_for")as! String) \(Utility.shared.step1ValuesInfo["personCapacity"]!) \(Utility.shared.getLanguage()?.value(forKey: "guest")as! String)s")
        }

        hostTable.reloadData()
        
    }
    
    func guestroom_detail(roomdetail: String) {
//      self.setRoomType()
//        hostTable.reloadData()
    }
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var retryButton: UIButton!
     @IBOutlet weak var errorLAbel: UILabel!
    
    @IBOutlet weak var hostTable: UITableView!
    @IBOutlet weak var nextRedirectBtn: UIButton!
    @IBOutlet weak var offlineView: UIView!
    @IBOutlet weak var nextArrowImage: UIImageView!
    
    //MARK: - This Property
    
    var apollo_headerClient: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
        
        let url = URL(string:graphQLEndpoint)!
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()
    var getListSettingsArray = GetListingSettingQuery.Data.GetListingSetting.Result()
    var itemNameArray = [String]()
    var guestArrayCount = Int()
    var guestsDropdownArray = [String]()
    var itemNameTouched = false
    var guestLabel = ""
    var placeLabel = ""
    
    let listInputView = UIView()
    let listValuePicker = UIPickerView()
    var tappedIndexPathRow = 0
    var selectedTextfield = Int()
    var lottieView: LOTAnimationView!

    //MARK: - ViewController Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //nextRedirectBtn.backgroundColor = Theme.PRIMARY_COLOR
       // self.lottieAnimation()
       // self.GetListSettingAPICall()
        lottieView = LOTAnimationView.init(name:"animation")
        setdropdown()
        registerCells()
        setUpUI()
        self.setDropdownList()
 
    }

    
    //MARK: - ConfigureItemName for Property Type
    func GetListSettingAPICall()
    {
        let getlistsettingsquery = GetListingSettingQuery()
        apollo_headerClient.fetch(query: getlistsettingsquery){(result,error) in
            
            guard (result?.data?.getListingSettings?.results) != nil else{
                return
            }
            self.getListSettingsArray = (result?.data?.getListingSettings?.results)!
            
            self.lottieView.isHidden = true
            self.lottieView.stop()
        }
    }
    
    func callListingSettingsAPI(oflineView : UIView, nextButton : UIButton)
    {
        nextButton.isHidden = false
            //self.lottieAnimation()
            self.GetListSettingAPICall()
    }
    
    //MARK: - Update Listing Step3
    
    func updateStep3ListingAPICall()
    {
        var weekprice = String()
        var monthprice = String()
        if(Utility.shared.step3ValuesInfo["weeklyDiscount"] != nil)
        {
         weekprice = "\(Utility.shared.step3ValuesInfo["weeklyDiscount"]!)"
        }
        else
        {
            weekprice = "0"
        }
        if(Utility.shared.step3ValuesInfo["monthlyDiscount"] != nil)
        {
        monthprice  = ("\(Utility.shared.step3ValuesInfo["monthlyDiscount"]!)")
        }
        else
        {
            monthprice = "0"
        }
      
    
        let updatelist = UpdateListingStep3Mutation(id: Utility.shared.step3ValuesInfo["id"] as? Int,
                                                    houseRules: Utility.shared.step3ValuesInfo["houseRules"] as? [Int],
                                                    bookingNoticeTime: "\(Utility.shared.step3ValuesInfo["bookingNoticeTime"] ?? "")",
            checkInStart: "\(Utility.shared.step3ValuesInfo["checkInStart"] ?? "")",
            checkInEnd: "\(Utility.shared.step3ValuesInfo["checkInEnd"] ?? "")",
            maxDaysNotice: "\(Utility.shared.step3ValuesInfo["maxDaysNotice"] ?? "")",
            minNight: Utility.shared.step3ValuesInfo["minNight"] as? Int,
            maxNight: Utility.shared.step3ValuesInfo["maxNight"] as? Int,
            basePrice: Utility.shared.host_basePrice,
            cleaningPrice:Utility.shared.host_cleanPrice,
            currency: "\(Utility.shared.step3ValuesInfo["currency"] ?? "")",
            weeklyDiscount:Int(weekprice),
            monthlyDiscount:Int(monthprice),
            bookingType: "\(Utility.shared.step3ValuesInfo["bookingType"] ?? "")",
            cancellationPolicy: Utility.shared.step3ValuesInfo["cancellationPolicy"] as? Int)
        apollo_headerClient.perform(mutation: updatelist){ (result,error) in
            
            if(result?.data?.updateListingStep3?.status == 200)
            {
                self.lottieView.isHidden = true

                self.manageListingStepsvalue(listId: "\(Utility.shared.step3ValuesInfo["id"]!)", currentStep: 3)
                
                
            }
            else{
                self.view.makeToast("\(Utility.shared.getLanguage()?.value(forKey: "somethingwrong")as! String)")
            }
            
            
        }
    }
    
    func manageListingStepsvalue(listId:String,currentStep:Int)
    {
        let manageListingStepsMutation = ManageListingStepsMutation(listId:listId, currentStep:currentStep)
        apollo_headerClient.perform(mutation: manageListingStepsMutation){ (result,error) in
            
            if(result?.data?.manageListingSteps?.status == 200)
            {
                let becomeHost = BecomeHostVC()
                becomeHost.listID = "\(Utility.shared.createId)"
                becomeHost.showListingStepsAPICall(listID:"\(Utility.shared.createId)")
              //  self.view.window!.layer.add(presentrightAnimation()!, forKey: kCATransition)
                becomeHost.modalPresentationStyle = .fullScreen
                self.present(becomeHost, animated:false, completion: nil)
                
            }
        }
    }
    
    
    
    //MARK: - Update Listing Step 1
    func updateListingAPICall()
    {
        
        var bedtypeInfoArr = [[String : Any]]()
        if let bedTypeInfo = Utility.shared.step1ValuesInfo["bedTypes"] as? [Any]
        {
            
            for i in 0..<bedTypeInfo.count
            {
                if let userBedTypes = bedTypeInfo[i] as? GetStep1ListingDetailsQuery.Data.GetListingDetail.Result.UserBedsType
                {
                    
                    var bedTypeInfo = [String : Any]()
                    bedTypeInfo.updateValue((userBedTypes.bedType)!, forKey: "bedType")
                    Utility.shared.step1ValuesInfo.updateValue(userBedTypes.bedType!, forKey: "bedType")
                    bedTypeInfo.updateValue(userBedTypes.bedCount!, forKey: "bedCount")
                    bedtypeInfoArr.append(bedTypeInfo)
                   
                }
                
            }
            let data = try? JSONSerialization.data(withJSONObject: bedtypeInfoArr, options: .prettyPrinted)
            let bedtypes = String(data: data!, encoding: String.Encoding.utf8)!
            var bedTypeString = ""
            if !bedtypes.isEmpty {
                let bedTypesArr = bedtypes.components(separatedBy: "\n")
                for str in bedTypesArr{
                    bedTypeString = bedTypeString + str
                }
            }
            Utility.shared.step1ValuesInfo.updateValue(bedTypeString.trimmingCharacters(in: .whitespaces), forKey: "bedTypes")
        }

       
        
        let createlist = CreateListingMutation(listId: Utility.shared.createId,
                                               roomType: "\(Utility.shared.step1ValuesInfo["roomType"] ?? "")",
            houseType: "\(Utility.shared.step1ValuesInfo["houseType"] ?? "")" ,
            residenceType: "\(Utility.shared.step1ValuesInfo["residenceType"] ?? "")",
            bedrooms: "\(Utility.shared.step1ValuesInfo["bedrooms"] ?? "")" ,
            buildingSize: "\(Utility.shared.step1ValuesInfo["buildingSize"] ?? "")",
            bedType: "\(Utility.shared.step1ValuesInfo["bedType"] ?? "")" ,
            beds: Utility.shared.step1ValuesInfo["beds"] as? Int,
            personCapacity: Utility.shared.step1ValuesInfo["personCapacity"] as? Int,
            bathrooms: (Utility.shared.step1ValuesInfo["bathrooms"] as? Double),
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
            amenities: Utility.shared.step1ValuesInfo["amenities"] as? [Int?] ,
            safetyAmenities: Utility.shared.step1ValuesInfo["safetyAmenities"] as? [Int?],
            spaces: Utility.shared.step1ValuesInfo["spaces"] as? [Int?])
        apollo_headerClient.perform(mutation: createlist){(result,error) in
            
            if(result?.data?.createListing?.status == 200)
            {
                self.lottieView.isHidden = true
                Utility.shared.createId = (result?.data?.createListing?.id)!
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    let becomeHost = BecomeHostVC()
                    becomeHost.listID = "\(Utility.shared.createId)"
                    becomeHost.showListingStepsAPICall(listID:"\(Utility.shared.createId)")
                   // self.view.window!.layer.add(presentrightAnimation()!, forKey: kCATransition)
                    becomeHost.modalPresentationStyle = .fullScreen
                    self.present(becomeHost, animated:false, completion: nil)
                }
            }
            else{
                self.lottieView.isHidden = true
                self.view.makeToast("\(Utility.shared.getLanguage()?.value(forKey: "somethingwrong") as! String)")
            }
        }
    }
    
    func setUpUI()
    {
        self.offlineView.isHidden = true
       // self.callListingSettingsAPI(oflineView: self.offlineView, nextButton: self.nextRedirectBtn)
        hostTable.isHidden = false
        hostTable.separatorStyle = .none
        hostTable.rowHeight = UITableView.automaticDimension
        hostTable.estimatedRowHeight = UITableView.automaticDimension
        nextRedirectBtn.setTitle("\(Utility.shared.getLanguage()?.value(forKey: "next")as! String)", for: .normal)
        nextRedirectBtn.layer.cornerRadius = 5
        nextRedirectBtn.clipsToBounds = true
        nextRedirectBtn.tintColor = UIColor.white
        nextArrowImage.image = nextArrowImage.image?.withRenderingMode(.alwaysTemplate)
        nextArrowImage.tintColor = UIColor.white
    }
    
    func registerCells()
    {
        hostTable.register(UINib(nibName: "TextFieldCell", bundle: nil), forCellReuseIdentifier: "textfieldcell")
        hostTable.register(UINib(nibName: "SingleTextFieldCell", bundle: nil), forCellReuseIdentifier: "singletextfieldcell")
    }
    
    func setdropdown()
    {
        listInputView.frame = CGRect(x: 0, y: FULLHEIGHT-200, width: FULLWIDTH, height: 200)
        listValuePicker.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height: 200)
        listInputView.addSubview(listValuePicker)
        listValuePicker.delegate = self
        listValuePicker.tintColor = Theme.PRIMARY_COLOR
        listValuePicker.backgroundColor = UIColor.white
        listValuePicker.reloadAllComponents()
    }
    
    func setDropdownList()
    {
        setRoomType()
        setPersonCapacity()
        hostTable.reloadData()
    }
    
    func setRoomType()
    {
        if(Utility.shared.getListSettingsArray.roomType != nil)
        {
        let listSettings = (Utility.shared.getListSettingsArray.roomType?.listSettings!)!
        for item in listSettings
        {
            itemNameArray.append((item?.itemName)!)
        }
            if !Utility.shared.step1ValuesInfo.keys.contains("roomType") && itemNameArray.count > 0
        {
            placeLabel = itemNameArray.first!
            listValuePicker.selectRow(0, inComponent: 0, animated: true)
            
            Utility.shared.step1ValuesInfo.updateValue((listSettings[0]?.id!)!, forKey: "roomType")
        }else{
            _ = listSettings.filter({ (item) -> Bool in
                if (Utility.shared.step1ValuesInfo["roomType"]! as? Int) == item?.id
                {
                    placeLabel = (item?.itemName!)!
                    return true
                }else{
                    return false
                }
            })
            if !placeLabel.isEmpty
            {
                let index = itemNameArray.index(where: { (item) -> Bool in
                    item == placeLabel
                })
                listValuePicker.selectRow(index!, inComponent: 0, animated: true)
            }
        }
        }
    }
    
    func setPersonCapacity()
    {
        if(Utility.shared.getListSettingsArray.personCapacity != nil)
        {
        if let guestcountStartValue = Utility.shared.getListSettingsArray.personCapacity?.listSettings![0]?.startValue, let guestcountEndValue = Utility.shared.getListSettingsArray.personCapacity?.listSettings![0]?.endValue {
           // guestArrayCount = guestcountEndValue - guestcountStartValue
            guestArrayCount = guestcountEndValue
        }
        
        var guestWord = ""
        if Utility.shared.getListSettingsArray.personCapacity?.listSettings![0]?.startValue == 1
        {
            guestWord = "\(Utility.shared.getLanguage()?.value(forKey: "guest")as! String)"
        }else{
            guestWord = "\( Utility.shared.getLanguage()?.value(forKey: "guests")as! String)"
        }
        
        var incrVal = 0
        for i in 0...guestArrayCount
        {
            if i == 0
            {
                incrVal = (Utility.shared.getListSettingsArray.personCapacity?.listSettings![0]?.startValue!)!
                guestsDropdownArray.insert("\(Utility.shared.getLanguage()?.value(forKey: "Cap_for")as! String) \(getListSettingsArray.personCapacity?.listSettings![0]?.startValue ?? 0) \(Utility.shared.getLanguage()?.value(forKey: "guest")as! String)\(incrVal > 1 ? "s" : "")" , at: i)
            }else {
                incrVal = (incrVal + 1)
                guestsDropdownArray.insert("\(Utility.shared.getLanguage()?.value(forKey: "Cap_for")as! String) \(incrVal) \(Utility.shared.getLanguage()?.value(forKey: "guest")as! String)\(incrVal > 1 ? "s" : "")" , at: i)
            }
        }
        if !Utility.shared.step1ValuesInfo.keys.contains("personCapacity")
        {
            guestLabel = guestsDropdownArray.first!
            listValuePicker.selectRow(0, inComponent: 0, animated: true)
            Utility.shared.step1ValuesInfo.updateValue((Utility.shared.getListSettingsArray.personCapacity?.listSettings![0]?.startValue!)!, forKey: "personCapacity")
        }else{
            if((Utility.shared.step1ValuesInfo["personCapacity"]!as! Int) <= 1)
            {
                guestLabel = ("\(Utility.shared.getLanguage()?.value(forKey: "Cap_for")as! String) \(Utility.shared.step1ValuesInfo["personCapacity"]!) \(Utility.shared.getLanguage()?.value(forKey: "guest")as! String)")
            }
            else
            {
                guestLabel = ("\(Utility.shared.getLanguage()?.value(forKey: "Cap_for")as! String) \(Utility.shared.step1ValuesInfo["personCapacity"]!) \(Utility.shared.getLanguage()?.value(forKey: "guests")as! String)")
            }
            //guestLabel = "\(Utility.shared.step1ValuesInfo["personCapacity"]!)"
            if !guestLabel.isEmpty
            {
                let index = guestsDropdownArray.index(where: { (item) -> Bool in
                    item == guestLabel
                })
                listValuePicker.selectRow(index!, inComponent: 0, animated: true)
            }
        }
        }
    }
    
    //MARK: - Progress Indicator
    
//    func lottieAnimation(){
//
//        lottieView = LOTAnimationView.init(name:"animation")
//        lottieView.isHidden = false
//        self.lottieView.frame = CGRect(x:FULLWIDTH/2-40, y: FULLHEIGHT/2-40, width:100, height:100)
//        self.view.addSubview(self.lottieView)
//        self.lottieView.backgroundColor = UIColor.clear
//        self.lottieView.layer.cornerRadius = 6.0
//        self.lottieView.clipsToBounds = true
//        self.lottieView.play()
//       // Timer.scheduledTimer(timeInterval:0.2, target: self, selector: #selector(autoscroll_base), userInfo: nil, repeats: true)
//    }
    
    func addLottieViewAsSubview()
    {
       // self.hostTable.isHidden = true
       // self.view.addSubview(self.lottieView)
    }
    
    @objc func autoscroll_base()
    {
        self.lottieView.play()
    }
    
    //MARK: - IBActions

    @IBAction func dismissViewController(_ sender: Any) {
        //self.view?.layer.add(dismissrightAnimation()!, forKey: kCATransition)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func redirectToNextPage(_ sender: Any) {
        
        let placeListing = PlaceListingViewController()
        placeListing.delegate = self
        self.view.window?.backgroundColor = UIColor.white
        //self.view?.layer.add(presentrightAnimation()!, forKey: kCATransition)
        placeListing.modalPresentationStyle = .fullScreen
        self.present(placeListing, animated: false, completion: nil)
    }
    
    //MARK: - UITableViewDelegate and Datasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(Utility.shared.getLanguage()?.value(forKey: "lets_become_host")as! String)"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerLabel = UILabel(frame: CGRect(x: 20, y: 8, width:FULLWIDTH - 40, height: 100))
        headerLabel.font = UIFont(name: "Circular-Medium", size: 23)
        headerLabel.addCharacterSpacing()
        headerLabel.textColor = UIColor.black
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        headerLabel.numberOfLines = 0
        headerLabel.sizeToFit()
        
        let headerView = UIView(frame: CGRect(x: 20, y: 8, width: tableView.bounds.size.width, height: 100))
        headerView.backgroundColor = UIColor.white
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0
        {
            if indexPath.row == 0
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldcell", for: indexPath) as? TextFieldCell
                cell?.queryTitleLbl.text = "\(Utility.shared.getLanguage()?.object(forKey: "Place_kind")as! String)"
                cell?.txtField.attributedPlaceholder = NSAttributedString(string: placeLabel,
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkText])
                cell?.selectionStyle = .none
                let toolBar = UIToolbar().ToolbarPikerSelect(mySelect: #selector(dismissgenderPicker))
                cell?.txtField.inputAccessoryView = toolBar
                cell?.txtField.tintColor = UIColor.clear
                cell?.txtField.inputView = listInputView
                cell?.txtField.tag = 1
                cell?.txtField.delegate = self
                return cell!
                
            }else if indexPath.row == 1
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldcell", for: indexPath) as? TextFieldCell
                cell?.queryTitleLbl.text = "\(Utility.shared.getLanguage()?.value(forKey: "No_of_guestAccommodated")as! String)"
                cell?.txtField.attributedPlaceholder = NSAttributedString(string: guestLabel,
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkText])
                cell?.isHidden = true
                cell?.selectionStyle = .none
                let toolBar = UIToolbar().ToolbarPikerSelect(mySelect: #selector(dismissgenderPicker))
                cell?.txtField.inputAccessoryView = toolBar
                cell?.txtField.inputView = listInputView
                cell?.txtField.tintColor = UIColor.clear
                cell?.txtField.tag = 2
                cell?.txtField.delegate = self
                cell?.step1Height.constant = 0
                cell?.stepnumberLbl.isHidden = true
                return cell!
            }
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0
        {
            selectedTextfield = 1
            if !placeLabel.isEmpty
            {
                let index = itemNameArray.index(where: { (item) -> Bool in
                    item == placeLabel
                })
                listValuePicker.selectRow(index!, inComponent: 0, animated: true)
            }
        }else if indexPath.row == 1
        {
            selectedTextfield = 2
            if !guestLabel.isEmpty
            {
                let index = guestsDropdownArray.index(where: { (item) -> Bool in
                    item == guestLabel
                })
                listValuePicker.selectRow(index!, inComponent: 0, animated: true)
            }
        }
        listValuePicker.reloadAllComponents()
    }
    
    @objc func dismissgenderPicker(text:Int) {

        view.endEditing(true)
    }
    
    //MARK: - UIPickerViewDelegate and Datasource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(selectedTextfield == 1)
        {
            return itemNameArray.count
        }
        else{
            return guestArrayCount
        }
    }
    
    func pickerView( _ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        var titleData = ""
        
        if(selectedTextfield == 1)
        {
            titleData = itemNameArray[row]
        }else{
            titleData = guestsDropdownArray[row]
        }
        let myTitle = NSAttributedString(string: titleData , attributes: [NSAttributedString.Key.font:UIFont(name: "Circular-Book", size: 15.0)!,NSAttributedString.Key.foregroundColor:Theme.PRIMARY_COLOR])
        return myTitle
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent  component: Int) {
        
        if(selectedTextfield == 1)
        {
            placeLabel = itemNameArray[row]
            listValuePicker.selectRow(row, inComponent: component, animated: true)
            Utility.shared.step1ValuesInfo.updateValue((Utility.shared.getListSettingsArray.roomType?.listSettings![row]?.id!)!, forKey: "roomType")
        }else{
            guestLabel = guestsDropdownArray[row]
            listValuePicker.selectRow(row, inComponent: component, animated: true)
            let stringArray = guestLabel.components(separatedBy: CharacterSet.decimalDigits.inverted)
            for item in stringArray {
                if let number = Int(item) {
                    Utility.shared.step1ValuesInfo.updateValue(number, forKey: "personCapacity")
                }
            }
        }
    }
    
    //MARK: - UITextFieldDelegates
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        selectedTextfield = textField.tag
        if selectedTextfield == 1
        {
            if !placeLabel.isEmpty
            {
                let index = itemNameArray.index(where: { (item) -> Bool in
                    item == placeLabel
                })
                listValuePicker.selectRow(index!, inComponent: 0, animated: true)
            }
        }else if selectedTextfield == 2
        {
            if !guestLabel.isEmpty
            {
                let index = guestsDropdownArray.index(where: { (item) -> Bool in
                    item == guestLabel
                
                })
                listValuePicker.selectRow(index!, inComponent: 0, animated: true)
            }
        }
        listValuePicker.reloadAllComponents()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        selectedTextfield = textField.tag
        hostTable.reloadData()
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

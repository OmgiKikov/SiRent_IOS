
//  PlaceListingViewController.swift
//  Rent_All

//  Created by RadicalStart on 26/07/19.
//  Copyright © 2019 RADICAL START. All rights reserved.


import UIKit
import Lottie


protocol PlaceListingViewControllerDelegate {
    func total_guest_change(guestcount:String)
    func guestroom_detail(roomdetail:String)
}

class PlaceListingViewController: BaseHostTableviewController,GuestListingViewControllerDelegate {
    func toatalguests(guest: String) {
        total_guest_count = guest
    }
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var nextBtnArow: UIImageView!
    @IBOutlet weak var offlineUIView: UIView!
    @IBOutlet weak var saveAndExit: UIButton!
    @IBOutlet weak var retryButn: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    //MARK: - This Property
    var houseLabel = String()
    var roomTypeLbl = String()
    var buildingSizeLbl = String()
    var personalType = String()
    var houseTypeArray = [String]()
    var roomTypeArray = [String]()
    var buildingSizeArray = [String]()
    var staticArray = [String]()
    var inputPickerView = UIView()
    var pickerView = UIPickerView()
    var lottieView1: LOTAnimationView!
    var total_guest_count = String()
    var buildidArray = [String]()
    
    var delegate:PlaceListingViewControllerDelegate!
    
    //MARK: - Viewcontroller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.backgroundColor = Theme.PRIMARY_COLOR
        saveAndExit.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
      
        
    }
    
    override func setUpUI() {
        if(Utility.shared.step1_inactivestatus == "inactive" || Utility.shared.step1_inactivestatus == "")
        {
            saveAndExit.isHidden = true
        }
        else {
            saveAndExit.isHidden = false
        }
        offlineUIView.isHidden = true
        callListingSettingsAPI(oflineView: offlineUIView, nextButton: nextBtn)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        nextBtn.setTitle("\(Utility.shared.getLanguage()?.value(forKey: "next")as! String)", for: .normal)
        nextBtn.layer.cornerRadius = 5
        nextBtn.clipsToBounds = true
        nextBtnArow.image = nextBtnArow.image?.withRenderingMode(.alwaysTemplate)
        nextBtnArow.tintColor = UIColor.white
        self.tableView.isHidden = false
        lottieView1 = LOTAnimationView.init(name: "animation")
        saveAndExit.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"saveexit"))!)", for:.normal)
        
        errorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
        retryButn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
    }
   
    override func setDropdownList() {
        
        setHouseType()
        setRoomType()
        setbuildingSize()
        setResidenceType()
        
        tableView.reloadData()
    }
    
    func setHouseType()
    {
        let listSettings = (Utility.shared.getListSettingsArray.houseType?.listSettings!)!
        for item in listSettings
        {
            houseTypeArray.append((item?.itemName)!)
        }
        if !Utility.shared.step1ValuesInfo.keys.contains("houseType")
        {
            houseLabel = houseTypeArray.first!
            pickerView.selectRow(0, inComponent: 0, animated: true)
            Utility.shared.step1ValuesInfo.updateValue((listSettings[0]?.id!)!, forKey: "houseType")
        }else {
            _ = listSettings.filter({ (item) -> Bool in
                if (Utility.shared.step1ValuesInfo["houseType"]! as? Int) == item?.id
                {
                    houseLabel = (item?.itemName!)!
                    return true
                }else{
                    return false
                }
            })
            if !houseLabel.isEmpty
            {
                let index = houseTypeArray.index(where: { (item) -> Bool in
                    item == houseLabel
                })
                pickerView.selectRow(index!, inComponent: 0, animated: true)
            }
        }
    }
    
    override func setRoomType() {
        let roomTypeListSettings = (Utility.shared.getListSettingsArray.roomType?.listSettings!)!
        for item in roomTypeListSettings
        {
            roomTypeArray.append((item?.itemName)!)
        }
        if !Utility.shared.step1ValuesInfo.keys.contains("roomType")
        {
            roomTypeLbl = roomTypeArray.first!
            pickerView.selectRow(0, inComponent: 0, animated: true)
            Utility.shared.step1ValuesInfo.updateValue((roomTypeListSettings[0]?.id!)!, forKey: "roomType")
        }else {
            for item in roomTypeListSettings{
                if let type = (Utility.shared.step1ValuesInfo["roomType"]! as? Int)
                {
                    if type == item?.id
                    {
                        roomTypeLbl = (item?.itemName!)!
                    }
                }
            }
            if !roomTypeLbl.isEmpty
            {
                let index = roomTypeArray.index(where: { (item) -> Bool in
                    item == roomTypeLbl
                })
                pickerView.selectRow(index!, inComponent: 0, animated: true)
            }
        }
    }
    @IBAction func retryBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            self.offlineUIView.isHidden = true
        }
    }
    
    func setbuildingSize()
    {
        let buildingSizeListings = (Utility.shared.getListSettingsArray.buildingSize?.listSettings!)!
        
        for item in buildingSizeListings
        {
            buildingSizeArray.append((item?.itemName)!)
            buildidArray.append("\((item?.id)!)")
        }
        if !Utility.shared.step1ValuesInfo.keys.contains("buildingSize")
        {
            buildingSizeLbl = buildingSizeArray.first!
          //  let buildingSize = buildingSizeLbl.components(separatedBy: "-")
           // let buildingsizearr = buildingSize[1].components(separatedBy: " ")
            Utility.shared.step1ValuesInfo.updateValue(buildidArray[0], forKey: "buildingSize")
            pickerView.selectRow(0, inComponent: 0, animated: true)
        }else {
            for item in buildingSizeListings{
//                if let type = (Utility.shared.step1ValuesInfo["buildingSize"]! as? Int)!
//                {
                 let build = "\(Utility.shared.step1ValuesInfo["buildingSize"]!)"
                    if (item?.id == Int(build)!)
                    {
                        buildingSizeLbl = (item?.itemName!)!
                    }
                //}
            }
            if !buildingSizeLbl.isEmpty
            {
                let index = buildingSizeArray.index(where: { (item) -> Bool in
                    item == buildingSizeLbl
                })
                pickerView.selectRow(index!, inComponent: 0, animated: true)
            }
            
        }
    }
    
    func setResidenceType()
    {
        staticArray.append("Yes")
        staticArray.append("No")
        if !Utility.shared.step1ValuesInfo.keys.contains("residenceType")
        {
            personalType = staticArray.first!
            pickerView.selectRow(0, inComponent: 0, animated: true)
            Utility.shared.step1ValuesInfo.updateValue("1", forKey: "residenceType")
        }else {
            personalType = (Utility.shared.step1ValuesInfo["residenceType"]! as? String) == "1" ? "Yes" : "No"
            if personalType == "Yes"
            {
                pickerView.selectRow(0, inComponent: 0, animated: true)
                Utility.shared.step1ValuesInfo.updateValue("1", forKey: "residenceType")
            }else if personalType == "No"
            {
                pickerView.selectRow(1, inComponent: 0, animated: true)
                Utility.shared.step1ValuesInfo.updateValue("0", forKey: "residenceType")
            }
        }
    }
    
    override func setdropdown()
    {
        inputPickerView.frame = CGRect(x: 0, y: FULLHEIGHT-200, width: FULLWIDTH, height: 200)
        pickerView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height: 200)
        inputPickerView.addSubview(pickerView)
        pickerView.delegate = self
        pickerView.tintColor = Theme.PRIMARY_COLOR
        pickerView.backgroundColor = UIColor.white
        pickerView.reloadAllComponents()
    }
    
    override func registerCells() {
        tableView.register(UINib(nibName: "TextFieldCell", bundle: nil), forCellReuseIdentifier: "textfieldcell")
    }
    
    //MARK: - Progress Indicator
    
    override func addLottieViewAsSubview()
    {
     //   self.view.addSubview(self.lottieView)
    }
    
    //IBActions
    
    @IBAction func RedirectNextPage(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
        let guestListing = GuestListingViewController()
        guestListing.delegate = self
        self.view.window?.backgroundColor = UIColor.white
//        self.view?.layer.add(presentrightAnimation()!, forKey: kCATransition)
        guestListing.modalPresentationStyle = .fullScreen
        self.present(guestListing, animated: false, completion: nil)
        }
        else
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
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        delegate?.guestroom_detail(roomdetail:"\(Utility.shared.step1ValuesInfo["roomType"]!)")
        delegate?.total_guest_change(guestcount:total_guest_count)
//        self.view.layer.add(dismissrightAnimation()!, forKey: kCATransition)
        self.dismiss(animated: true, completion: nil)
    }
    func lottieanimation()
    {
        saveAndExit.setTitle("", for:.normal)
        lottieView1 = LOTAnimationView.init(name: "animation")
        self.lottieView1.isHidden = false
        self.lottieView1.frame = CGRect(x:80, y:-35, width:100, height:100)
        self.saveAndExit.addSubview(self.lottieView1)
        self.view.bringSubviewToFront(self.lottieView1)
        self.lottieView1.backgroundColor = UIColor.clear
        self.lottieView1.play()
        Timer.scheduledTimer(timeInterval:0.3, target: self, selector: #selector(autoscroll), userInfo: nil, repeats: true)
    }
    @objc func autoscroll()
    {
        self.lottieView1.play()
    }
    @IBAction func saveAndExitAction(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            let bedsCount = Utility.shared.step1ValuesInfo["beds"] as? Int
            if(Utility.shared.bedcount>bedsCount!)
            {
                self.view.makeToast("Chosen bed count is exceeded than bed for guest count")
            }
            else
            {
            self.lottieanimation()
      
        super.updateListingAPICall()
            }
        }
        else
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
    }
    
       //MARK: - UITAbleViewDatasource and UITableViewDelegates
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(Utility.shared.getLanguage()?.value(forKey: "place_listings")as! String)"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 75
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 75
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0
        {
            let cell = tableView
                .dequeueReusableCell(withIdentifier: "textfieldcell", for: indexPath) as? TextFieldCell
            if indexPath.row == 0
            {
                cell?.queryTitleLbl.text = "\(Utility.shared.getLanguage()?.value(forKey: "property_type")as! String)"
                
                cell?.txtField.attributedPlaceholder = NSAttributedString(string: houseLabel,
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkText])
                cell?.txtField.tag = 0

            }else if indexPath.row == 1
            {
                cell?.queryTitleLbl.text = "\(Utility.shared.getLanguage()?.value(forKey: "What_guest_have")as! String)"
                cell?.txtField.attributedPlaceholder = NSAttributedString(string: roomTypeLbl,
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkText])
                cell?.txtField.tag = 1

            }else if indexPath.row == 2
            {
                cell?.queryTitleLbl.text = "\(Utility.shared.getLanguage()?.value(forKey: "Rooms_in_property")as! String)"
                cell?.txtField.attributedPlaceholder = NSAttributedString(string: buildingSizeLbl,
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkText])
                cell?.txtField.tag = 2

            }else if indexPath.row == 3
            {
                cell?.queryTitleLbl.text = "\(Utility.shared.getLanguage()?.value(forKey: "Personal_Home")as! String)"
                cell?.txtField.attributedPlaceholder = NSAttributedString(string: personalType,
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkText])
                cell?.txtField.tag = 3

            }else if indexPath.row == 4
            {
                let hintcell = UITableViewCell()
                hintcell.selectionStyle = .none
                hintcell.textLabel?.frame.origin.x = 30
                hintcell.textLabel?.textColor = UIColor.lightGray
                hintcell.textLabel?.text = "\(Utility.shared.getLanguage()?.value(forKey: "guest_personal_belongings")as! String)"
                hintcell.textLabel?.numberOfLines = 0
                hintcell.textLabel?.font = UIFont(name: "Circular-Book", size:14)
                return hintcell
            }
            cell?.txtField.textColor = UIColor.darkText
            cell?.step1Height.constant = 0
            cell?.stepnumberLbl.isHidden = true
            cell?.selectionStyle = .none
            let toolBar = UIToolbar().ToolbarPikerSelect(mySelect: #selector(dismissgenderPicker))
            cell?.txtField.inputAccessoryView = toolBar
            cell?.txtField.inputView = pickerView
            cell?.txtField.delegate = self
            return cell!
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0
        {
            selectedTextfield = 0
            if !houseLabel.isEmpty
            {
                let index = houseTypeArray.index(where: { (item) -> Bool in
                    item == houseLabel
                })
                pickerView.selectRow(index!, inComponent: 0, animated: true)
            }
        }else if indexPath.row == 1
        {
            selectedTextfield = 1
            if !roomTypeLbl.isEmpty
            {
                let index = roomTypeArray.index(where: { (item) -> Bool in
                    item == roomTypeLbl
                })
                pickerView.selectRow(index!, inComponent: 0, animated: true)
            }
        }else if indexPath.row == 2
        {
            selectedTextfield = 2
            if !buildingSizeLbl.isEmpty
            {
                let index = buildingSizeArray.index(where: { (item) -> Bool in
                    item == buildingSizeLbl
                })
                pickerView.selectRow(index!, inComponent: 0, animated: true)
            }
        }else if indexPath.row == 3 {
            selectedTextfield = 3
            if personalType == "Yes"
            {
                pickerView.selectRow(0, inComponent: 0, animated: true)
            }else if personalType == "No"
            {
                pickerView.selectRow(1, inComponent: 0, animated: true)
            }
        }
        listValuePicker.reloadAllComponents()
        
    }
    
    //MARK: - UIPickerViewDelegate and Datasource
    
    override func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (selectedTextfield == 0)
        {
            return houseTypeArray.count
        }else if selectedTextfield == 1
        {
            return roomTypeArray.count
        }else if selectedTextfield == 2
        {
            return buildingSizeArray.count
        }
        else if selectedTextfield == 3{
            return staticArray.count
        }
        return 0
    }
    
    override func pickerView( _ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var titleData = ""
        
        if (selectedTextfield == 0)
        {
            if(houseTypeArray.count > row)
            {
            titleData = houseTypeArray[row]
            }
        }else if selectedTextfield == 1
        {
            if(roomTypeArray.count > row)
            {
            titleData = roomTypeArray[row]
            }
        }else if selectedTextfield == 2
        {
            if(buildingSizeArray.count > row)
            {
            titleData = buildingSizeArray[row]

            }
        }
        else if selectedTextfield == 3 {
            if(staticArray.count > row)
            {
            titleData = staticArray[row]
            }
        }
        
        let myTitle = NSAttributedString(string: titleData , attributes: [NSAttributedString.Key.font:UIFont(name: "Circular-Book", size: 15.0)!,NSAttributedString.Key.foregroundColor:Theme.PRIMARY_COLOR])
        return myTitle
    }
    
    override func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent  component: Int) {
        
        if (selectedTextfield == 0)
        {
            houseLabel = houseTypeArray[row]
            pickerView.selectRow(row, inComponent: component, animated: true)
            Utility.shared.step1ValuesInfo.updateValue((Utility.shared.getListSettingsArray.houseType?.listSettings![row]?.id!)!, forKey: "houseType")
        }else if selectedTextfield == 1
        {
            roomTypeLbl = roomTypeArray[row]
            pickerView.selectRow(row, inComponent: component, animated: true)
            Utility.shared.step1ValuesInfo.updateValue((Utility.shared.getListSettingsArray.roomType?.listSettings![row]?.id!)!, forKey: "roomType")
        }else if selectedTextfield == 2
        {
            buildingSizeLbl = buildingSizeArray[row]
            pickerView.selectRow(row, inComponent: component, animated: true)
            Utility.shared.step1ValuesInfo.updateValue(buildidArray[row], forKey: "buildingSize")
        }
        else if selectedTextfield == 3{
            personalType = staticArray[row]
            pickerView.selectRow(row, inComponent: component, animated: true)
            Utility.shared.step1ValuesInfo.updateValue(personalType == "Yes" ? "1" : "0", forKey: "residenceType")
        }
//        tableView.reloadData()
       
    }
    
    //MARK: - UITextFieldDelegates
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        
        selectedTextfield = textField.tag
        if selectedTextfield == 0
        {
            if !houseLabel.isEmpty
            {
                let index = houseTypeArray.index(where: { (item) -> Bool in
                    item == houseLabel
                })
                pickerView.selectRow(index!, inComponent: 0, animated: true)
            }
        }else if selectedTextfield == 1
        {
            if !roomTypeLbl.isEmpty
            {
                let index = roomTypeArray.index(where: { (item) -> Bool in
                    item == roomTypeLbl
                })
                pickerView.selectRow(index!, inComponent: 0, animated: true)
            }
        }else if selectedTextfield == 2
        {
            if !buildingSizeLbl.isEmpty
            {
                let index = buildingSizeArray.index(where: { (item) -> Bool in
                    item == buildingSizeLbl
                })
                pickerView.selectRow(index!, inComponent: 0, animated: true)
            }
        }else if selectedTextfield == 3{
            if personalType == "Yes"
            {
                pickerView.selectRow(0, inComponent: 0, animated: true)
            }else if personalType == "No"
            {
                pickerView.selectRow(1, inComponent: 0, animated: true)
            }
        }
        pickerView.reloadAllComponents()
    }
    
    override func textFieldDidEndEditing(_ textField: UITextField) {
        tableView.reloadData()
        view.endEditing(true)
    }
    
}

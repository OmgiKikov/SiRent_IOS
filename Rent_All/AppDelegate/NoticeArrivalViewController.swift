//
//  NoticeArrivalViewController.swift
//  Rent_All
//
//  Created by RadicalStart on 07/08/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Lottie

class NoticeArrivalViewController: BaseHostTableviewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var nextBtnArow: UIImageView!
    @IBOutlet weak var offLineView: UIView!
    
    @IBOutlet weak var retrBtn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var saveandExit: UIButton!
    var lottieView1: LOTAnimationView!
    //MARK: - This Property
    var bookingNoticeTimeLbl = String()
    var bookingNoticeIdArray = [String]()
    var fromTime = String()
    var toTime = String()
    var bookingNoticeTimeArr = [String]()
    var inputPickerView = UIView()
    var pickerView = UIPickerView()
    
    
    var fromTimeArray = [String]()
    var toTimeArray = [String]()
    var fromoptionsArray = [String]()
    var tooptionsArray = [String]()
    
    //MARK: - Viewcontroller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
        retrBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
        saveandExit.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"saveexit"))!)", for:.normal)
        saveandExit.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
        nextBtn.backgroundColor = Theme.PRIMARY_COLOR
        
      
    }
    
    override func setUpUI() {
        offLineView.isHidden = true
        callListingSettingsAPI(oflineView: offLineView, nextButton: nextBtn)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        nextBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"next"))!)", for: .normal)
        nextBtn.layer.cornerRadius = 5
        nextBtn.clipsToBounds = true
        nextBtnArow.image = nextBtnArow.image?.withRenderingMode(.alwaysTemplate)
        nextBtnArow.tintColor = UIColor.white
        self.tableView.isHidden = false
        if(Utility.shared.step3_Edit)
        {
            self.saveandExit.isHidden = false
        }
        else{
            self.saveandExit.isHidden = true
        }
        fromTimeArray = ["Flexible","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25"]
        toTimeArray = ["Flexible","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26"]
        fromoptionsArray = ["Flexible","8:00","9:00","10:00","11:00","12:00(noon)","13:00","14:00","15:00","16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00","14:00 (mid night)","01:00 (next day)"]
        tooptionsArray = ["Flexible","9:00","10:00","11:00","12:00(noon)","13:00","14:00","15:00","16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00","24:00 (mid night)","01:00 (next day)","02:00 (next day)"]
    }
    
    override func setDropdownList() {
        let listSettings = (Utility.shared.getListSettingsArray.bookingNoticeTime?.listSettings!)!
        for item in listSettings
        {
            bookingNoticeTimeArr.append((item?.itemName)!)
            bookingNoticeIdArray.append("\((item?.id)!)")
        }
        
        if(Utility.shared.step3ValuesInfo["bookingNoticeTime"] != nil)
        {
            for i in listSettings
            {
                if("\((i?.id!)!)" == (Utility.shared.step3ValuesInfo["bookingNoticeTime"] as? String)!)
                {
                    bookingNoticeTimeLbl = (i?.itemName)!
                }
            }
        }
        else
        {
        bookingNoticeTimeLbl = bookingNoticeTimeArr.first!
        }
        
        if !bookingNoticeTimeLbl.isEmpty
        {
            let index = bookingNoticeTimeArr.index(where: { (item) -> Bool in
                item == bookingNoticeTimeLbl
            })
            pickerView.selectRow(index!, inComponent: 0, animated: true)
        }
       
        Utility.shared.step3ValuesInfo.updateValue(bookingNoticeIdArray[0], forKey: "bookingNoticeTime")
        
     
        if(Utility.shared.step3ValuesInfo["checkInStart"] != nil && ((Utility.shared.step3ValuesInfo["checkInStart"]as? String) != "Flexible"))
        {
            let index = fromTimeArray.index(where: { (item) -> Bool in
                item == "\(Utility.shared.step3ValuesInfo["checkInStart"]!)"
            })
            fromTime = fromoptionsArray[index!]
           // fromTime = self.convert24hrTo12hr(hour:Utility.shared.step3ValuesInfo["checkInStart"] as! String)
            
        }
        else
        {
         fromTime = fromTimeArray.first!
        Utility.shared.step3ValuesInfo.updateValue("Flexible", forKey: "checkInStart")
        }
        if !fromTime.isEmpty
        {

           
            let index = fromoptionsArray.index(where: { (item) -> Bool in
                item == fromTime
            })
            pickerView.selectRow(index!, inComponent: 0, animated: true)
        }
        
        
       
        tableView.reloadData()
        if(Utility.shared.step3ValuesInfo["checkInEnd"] != nil && ((Utility.shared.step3ValuesInfo["checkInEnd"]as? String) != "Flexible"))
        {
            
            let index = toTimeArray.index(where: { (item) -> Bool in
                item == "\(Utility.shared.step3ValuesInfo["checkInEnd"]!)"
            })
            toTime = tooptionsArray[index!]
            //toTime = self.convert24hrTo12hr(hour:Utility.shared.step3ValuesInfo["checkInEnd"] as! String)
            
        }
        else
        {
           toTime = toTimeArray.first!
            Utility.shared.step3ValuesInfo.updateValue("Flexible", forKey: "checkInEnd")
        }
        if !toTime.isEmpty
        {

            let index = tooptionsArray.index(where: { (item) -> Bool in
                item == toTime
            })
            pickerView.selectRow(index!, inComponent: 0, animated: true)
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
        self.view.addSubview(self.lottieView)
    }
    
    //IBActions
    
    @IBAction func retryBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            self.offLineView.isHidden = true
        }
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
        Timer.scheduledTimer(timeInterval:0.3, target: self, selector: #selector(autoscrolling), userInfo: nil, repeats: true)
    }
    @objc func autoscrolling()
    {
        self.lottieView1.play()
    }
    func offlineviewShow()
    {
        self.offLineView.isHidden = false
        let shadowSize2 : CGFloat = 3.0
        let shadowPath2 = UIBezierPath(rect: CGRect(x: -shadowSize2 / 2,
                                                    y: -shadowSize2 / 2,
                                                    width: self.offLineView.frame.size.width + shadowSize2,
                                                    height: self.offLineView.frame.size.height + shadowSize2))
        
        self.offLineView.layer.masksToBounds = false
        self.offLineView.layer.shadowColor = TextLightColor.cgColor
        self.offLineView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.offLineView.layer.shadowOpacity = 0.3
        self.offLineView.layer.shadowPath = shadowPath2.cgPath
        if IS_IPHONE_X || IS_IPHONE_XR{
            offLineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-130, width: FULLWIDTH, height: 55)
        }else{
            offLineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
        }
    }
    
    
    @IBAction func RedirectNextPage(_ sender: Any) {
         if Utility().isConnectedToNetwork(){
             self.view.endEditing(true)

        if(toTime != "Flexible" && fromTime != "Flexible") && !(fromTime == "12PM" && toTime == "12AM") && !(fromTime == "12PM" && toTime == "1AM") && !(fromTime == "1PM" && toTime == "1AM") && !(fromTime == "12PM" && toTime == "2AM") && !(fromTime == "2PM" && toTime == "2AM") && (fromTime != nil && toTime != nil){
            let index = tooptionsArray.index(where: { (item) -> Bool in
                item == toTime
            })
            let index1 = fromoptionsArray.index(where: { (item) -> Bool in
                item == fromTime
            })
            if(index1 != nil && index != nil)
            {
            let from:Int = Int(fromTimeArray[index1!])!
            let to:Int = Int(toTimeArray[index!])!

                if(from >= to)
                {
                   
                self.view.makeToast( "\((Utility.shared.getLanguage()?.value(forKey:"fromtimealert"))!)")
                }
                else
                {
                    let guestListing = BookingWindowViewController()
                    self.view.window?.backgroundColor = UIColor.white
                   // self.view.layer.add(presentrightAnimation()!, forKey: kCATransition)
                    guestListing.modalPresentationStyle = .fullScreen
                    self.present(guestListing, animated: false, completion: nil)
                }
            }
            }
            else
            {
            let guestListing = BookingWindowViewController()
            self.view.window?.backgroundColor = UIColor.white
            //self.view.layer.add(presentrightAnimation()!, forKey: kCATransition)
                guestListing.modalPresentationStyle = .fullScreen
            self.present(guestListing, animated: false, completion: nil)
            }
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
    
    @IBAction func saveandExitAction(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            self.view.endEditing(true)

            if(toTime != "Flexible" && fromTime != "Flexible") && !(fromTime == "12PM" && toTime == "12AM") && !(fromTime == "12PM" && toTime == "1AM") && !(fromTime == "1PM" && toTime == "1AM") && !(fromTime == "12PM" && toTime == "2AM") && !(fromTime == "2PM" && toTime == "2AM") && (fromTime != nil && toTime != nil)
            {
                
                let index = tooptionsArray.index(where: { (item) -> Bool in
                    item == toTime
                })
                let index1 = fromoptionsArray.index(where: { (item) -> Bool in
                    item == fromTime
                })
                let from:Int = Int(fromTimeArray[index1!])!
                let to:Int = Int(toTimeArray[index!])!

            if(from >= to)
            {
                self.view.makeToast( "\((Utility.shared.getLanguage()?.value(forKey:"fromtimealert"))!)")
            }
            
            else
            {
        self.lottieViewanimation()
        super.updateStep3ListingAPICall()
            }
            }
            else if((Utility.shared.step3ValuesInfo["minNight"] as? Int) != nil && (Utility.shared.step3ValuesInfo["maxNight"] as? Int) != nil)
            {
                let minNight:Int  = (Utility.shared.step3ValuesInfo["minNight"] as? Int)!
                let maxNight:Int = (Utility.shared.step3ValuesInfo["maxNight"] as? Int)!
                if minNight > maxNight
                {
                    
                    self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"minimumnights"))!)")
                    return
                }
                else if (Utility.shared.step3ValuesInfo["basePrice"] != nil &&  Utility.shared.step3ValuesInfo["basePrice"] as? String == "0")
                {
                    self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"invalidbaseprice"))!)")
                    return
                }
                else if (Utility.shared.step3ValuesInfo["cleaningPrice"] != nil &&  Utility.shared.step3ValuesInfo["cleaningPrice"] as? String == "0")
                    
                {
                    self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"invalidcleaning"))!)")
                    return
                }
                else
                {
                    self.lottieViewanimation()
                    super.updateStep3ListingAPICall()
                }
            }
            else
            {
                self.lottieViewanimation()
                super.updateStep3ListingAPICall()
            }
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
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerLabel = UILabel(frame: CGRect(x: 20, y: 8, width:FULLWIDTH-40, height: 100))
        if section == 0
        {
            
            headerLabel.font =  UIFont(name: "Circular-Medium", size:25)
        }else{
            headerLabel.font =  UIFont(name: "Circular-Medium", size:21)
        }
        headerLabel.addCharacterSpacing()
        headerLabel.textColor = UIColor.black
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        headerLabel.numberOfLines = 0
        headerLabel.sizeToFit()
        
        let headerView = UIView(frame: CGRect(x: 20, y: 8, width: tableView.bounds.size.width - 20, height: 100))
        headerView.backgroundColor = UIColor.white
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       if section == 0
        {
            return "\((Utility.shared.getLanguage()?.value(forKey:"howmuchnotice"))!)"
      }
        else {
           
        return ""
        //return "\((Utility.shared.getLanguage()?.value(forKey:"bookingwindow"))!)"
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0
        {
             if Utility.shared.getAppLanguageCode() == "en" || Utility.shared.getAppLanguageCode() == "EN"  {
            return 60
             }else{
                return 80
            }
        }else {
            return 0
        }
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        if section == 0
        {
            if Utility.shared.getAppLanguageCode() == "en" || Utility.shared.getAppLanguageCode() == "EN"  {
            return 60
             }else{
                return 80
            }
        }else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1{
            return 3
        }else {
            return 0
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1
        {
            let cell = tableView
                .dequeueReusableCell(withIdentifier: "textfieldcell", for: indexPath) as? TextFieldCell
            if indexPath.row == 0
            {
                cell?.stepnumberLbl.isHidden = false
                cell?.step1Height.constant = 21
                cell?.stepnumberLbl.text = "Advance Notice"
                cell?.queryTitleLbl.text = "\((Utility.shared.getLanguage()?.value(forKey:"guestarrivenotice"))!)"
                cell?.txtField.attributedPlaceholder = NSAttributedString(string: bookingNoticeTimeLbl,
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkText])
                cell?.txtField.tag = indexPath.row
                cell?.stepnumberLbl.font = UIFont(name: "Circular-Book", size:18)
                cell?.stepnumberLbl.textColor = UIColor.black
                cell?.queryTitleLbl.font =  UIFont(name: "Circular-Book", size:18)
                cell?.txtField.font =  UIFont(name: "Circular-Book", size:18)
                
            }else if indexPath.row == 1
            {
               
                cell?.queryTitleLbl.text = "\((Utility.shared.getLanguage()?.value(forKey:"from"))!)"
                cell?.stepnumberLbl.text = "\((Utility.shared.getLanguage()?.value(forKey:"whencanguest"))!)"
                cell?.stepnumberLbl.isHidden = false
                cell?.step1Height.constant = 21
                
                cell?.stepnumberLbl.font =  UIFont(name: "Circular-Book", size:18)
                cell?.queryTitleLbl.font =  UIFont(name: "Circular-Book", size:18)
                cell?.txtField.font =  UIFont(name: "Circular-Book", size:18)
                cell?.stepnumberLbl.textColor = UIColor.black
                if(fromTime == "")
                {
                cell?.txtField.text = fromTimeArray.first
                }
                else
                {
//                    if(fromTime == "12PM")
//                    {
//                        fromTime = "12PM(noon)"
//                    }
//
//                    if(fromTime == "12AM")
//                    {
//                        fromTime = "12AM(mid night)"
//                    }
//
//                    if(fromTime == "1AM")
//                    {
//                        fromTime = "1AM(next day)"
//
//                    }
                  cell?.txtField.text = fromTime
                }
                cell?.txtField.tag = indexPath.row
                
            }else if indexPath.row == 2
            {
                cell?.queryTitleLbl.text = "\((Utility.shared.getLanguage()?.value(forKey:"to"))!)"
                cell?.stepnumberLbl.text = ""
                cell?.step1Height.constant = 0
                cell?.stepnumberLbl.isHidden = true
                if(toTime == "")
                {
                cell?.txtField.text = toTimeArray.first
                }
                else{
//                    if(toTime == "12PM" )
//                    {
//                        toTime = "12PM(noon)"
//                    }
//                    if(toTime == "1AM")
//                    {
//                        toTime = "1AM(next day)"
//                    }
//                    if(toTime == "12AM")
//                    {
//                        toTime = "12AM(mid night)"
//                    }
//                    if(toTime == "2AM" )
//                    {
//                        toTime = "2AM(next day)"
//                    }
                   cell?.txtField.text = toTime
                }
                cell?.txtField.tag = indexPath.row
                cell?.queryTitleLbl.font =  UIFont(name: "Circular-Book", size:18)
                cell?.txtField.font =  UIFont(name: "Circular-Book", size:18)
            }
            cell?.txtField.textColor = UIColor.darkText
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
        if(selectedTextfield == 1)
        {
//            if(fromTime == "12PM" )
//            {
//                fromTime = "12PM(noon)"
//            }
//            if(fromTime == "1AM")
//            {
//                fromTime = "1AM(next day)"
//            }
//            if(fromTime == "12AM")
//            {
//                fromTime = "12AM(mid night)"
//            }
//            if(fromTime == "2AM" )
//            {
//                fromTime = "2AM(next day)"
//            }
            let index = fromoptionsArray.index(where: { (item) -> Bool in
                item == fromTime
            })
            pickerView.selectRow(index!, inComponent: 0, animated: true)
        }
        if(selectedTextfield == 2)
        {
            if(toTime == "12PM")
            {
                toTime = "12PM(noon)"
            }
            
            if(toTime == "12AM")
            {
                toTime = "12AM(mid night)"
            }
            
            if(toTime == "1AM")
            {
                toTime = "1AM(next day)"
                
            }
            if(toTime == "2AM" )
            {
                toTime = "2AM(next day)"
            }
            let index = tooptionsArray.index(where: { (item) -> Bool in
                item == toTime
            })
            pickerView.selectRow(index!, inComponent: 0, animated: true)
        }
        
        listValuePicker.reloadAllComponents()
        
    }
    
    //MARK: - UIPickerViewDelegate and Datasource
    
    override func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (selectedTextfield == 0)
        {
            return bookingNoticeTimeArr.count
        }else if selectedTextfield == 1
        {
            return fromoptionsArray.count
        }else
        {
            return tooptionsArray.count
        }
    }
    
    override func pickerView( _ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var titleData = ""
        
        if (selectedTextfield == 0)
        {
            titleData = bookingNoticeTimeArr[row]
        }else if selectedTextfield == 1
        {
            titleData = fromoptionsArray[row]
        }else if selectedTextfield == 2
        {
            titleData = tooptionsArray[row]
        }
        
        let myTitle = NSAttributedString(string: titleData , attributes: [NSAttributedString.Key.font:UIFont(name: "Circular-Book", size: 15.0)!,NSAttributedString.Key.foregroundColor:Theme.PRIMARY_COLOR])
        return myTitle
    }
    
    override func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent  component: Int) {
        
        if (selectedTextfield == 0)
        {
            bookingNoticeTimeLbl = bookingNoticeTimeArr[row]
            pickerView.selectRow(row, inComponent: component, animated: true)
            Utility.shared.step3ValuesInfo.updateValue(bookingNoticeIdArray[row], forKey: "bookingNoticeTime")
        }else if selectedTextfield == 1
        {
            fromTime = fromoptionsArray[row]
            pickerView.selectRow(row, inComponent: component, animated: true)
            if(fromTime == "Flexible")
            {
              Utility.shared.step3ValuesInfo.updateValue("Flexible", forKey: "checkInStart")
            }
            else
            {

                let index = fromoptionsArray.index(where: { (item) -> Bool in
                    item == fromTime
                })
                Utility.shared.step3ValuesInfo.updateValue(fromTimeArray[index!], forKey: "checkInStart")
            }
            
        }else if selectedTextfield == 2
        {
            toTime = tooptionsArray[row]
            
            if(toTime == "Flexible")
            {
            Utility.shared.step3ValuesInfo.updateValue("Flexible", forKey: "checkInEnd")
            }
            else{
                
                let index = tooptionsArray.index(where: { (item) -> Bool in
                    item == toTime
                })
                
                 Utility.shared.step3ValuesInfo.updateValue(toTimeArray[index!], forKey: "checkInEnd")
                
               //Utility.shared.step3ValuesInfo.updateValue(convert12HrTo24Hr(hour: toTime), forKey: "checkInEnd")
            }
        }
    }
    
    func convert12HrTo24Hr(hour:String) -> String
    {
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ha"
        
        let date = dateFormatter.date(from: hour)
        dateFormatter.dateFormat = "HH"
        
        let Date24 = dateFormatter.string(from: date!)
        
        return Date24
    }
    
    func convert24hrTo12hr(hour:String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        
        let date = dateFormatter.date(from: hour)
        dateFormatter.dateFormat = "ha"
        let Date12 = dateFormatter.string(from: date!)
        return Date12
    }
    
    //MARK: - UITextFieldDelegates
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        selectedTextfield = textField.tag
        pickerView.reloadAllComponents()
        
        if (selectedTextfield == 0)
        {
            if !bookingNoticeTimeLbl.isEmpty
            {
                let index = bookingNoticeTimeArr.index(where: { (item) -> Bool in
                    item == bookingNoticeTimeLbl
                })
                pickerView.selectRow(index!, inComponent: 0, animated: true)
            }
        }else if selectedTextfield == 1
        {
//            if(fromTime == "12PM")
//            {
//                fromTime = "12PM(noon)"
//            }
//            if(fromTime == "12AM")
//            {
//               fromTime = "12AM(mid night)"
//            }
//            if(fromTime == "1AM")
//            {
//                fromTime = "1AM(next day)"
//            }
//            if(fromTime == "2AM")
//            {
//                fromTime = "2AM(next day)"
//            }
            if !fromTime.isEmpty
            {
                let index = fromoptionsArray.index(where: { (item) -> Bool in
                    item == fromTime
                })
                pickerView.selectRow(index!, inComponent: 0, animated: true)
            }
        }else if selectedTextfield == 2
        {
//            if(toTime == "12PM")
//            {
//                toTime = "12PM(noon)"
//            }
//            if(toTime == "12AM")
//            {
//                toTime = "12AM(mid night)"
//            }
//            if(toTime == "1AM")
//            {
//                toTime = "1AM(next day)"
//            }
//            if(toTime == "2AM")
//            {
//                toTime = "2AM(next day)"
//            }
            if !toTime.isEmpty
            {
                let index = tooptionsArray.index(where: { (item) -> Bool in
                    item == toTime
                })
                pickerView.selectRow(index!, inComponent: 0, animated: true)
            }
        }
    }
    
    override func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField.tag > 1)
        {
//        if(toTime != "Flexible" && fromTime != "Flexible")
//        {
//            if(fromTime == "12PM(noon)")
//            {
//                fromTime = "12PM"
//            }
//
//            if(toTime == "12PM(noon)")
//            {
//                toTime = "12PM"
//            }
//            if(fromTime == "12AM(mid night)")
//            {
//                fromTime = "12AM"
//            }
//            if(toTime == "12AM(mid night)")
//            {
//                toTime = "12AM"
//            }
//
//            if(fromTime == "1AM(next day)")
//            {
//                fromTime = "1AM"
//
//            }
//            if(toTime == "1AM(next day)")
//            {
//                toTime = "1AM"
//            }
//            if(toTime == "2AM(next day)")
//            {
//                toTime = "2AM"
//            }
//
//            let index1 = fromoptionsArray.index(where: { (item) -> Bool in
//                item == fromTime
//            })
//            let index = tooptionsArray.index(where: { (item) -> Bool in
//                item == toTime
//            })
//            let from = fromoptionsArray[index1!]
//
//            let to = toTimeArray[index!]
////        let from = Int(convert12HrTo24Hr(hour: fromTime))
////        let to = Int(convert12HrTo24Hr(hour: toTime))
//        if(from >= to)
//        {
//           // self.view.makeToast("From time should be earlier To time")
//        }
//        else
//        {
//        tableView.reloadData()
//        view.endEditing(true)
//        }
//            }
            tableView.reloadData()
            view.endEditing(true)
        }
        else
        {
            tableView.reloadData()
            view.endEditing(true)
        }
    }
    
}

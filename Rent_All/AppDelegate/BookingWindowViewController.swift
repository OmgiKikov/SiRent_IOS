//
//  BookingWindowViewController.swift
//  Rent_All
//
//  Created by RadicalStart on 07/08/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Lottie

class BookingWindowViewController: BaseHostTableviewController {
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var nextBtnArow: UIImageView!
    @IBOutlet weak var saveandExitBtn: UIButton!
    @IBOutlet weak var offlineUIView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var retryBtn: UIButton!
    
    //MARK: - This Property
    var futureDateLbl = String()
    var cancellationLbl = String()
    var cancel_id = Int()
    var futureDatesArr = [String]()
    var futures_Date_Array_without_String = [String]()
    var future_array = [String]()
    var staticArray = [String]()
    var inputPickerView = UIView()
    var pickerView = UIPickerView()
    
     var lottieView1: LOTAnimationView!
    
    //MARK: - Viewcontroller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
        retryBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
        saveandExitBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"saveexit"))!)", for:.normal)
        saveandExitBtn.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
        nextBtn.backgroundColor = Theme.PRIMARY_COLOR
    }
    
    override func setUpUI() {
        offlineUIView.isHidden = true
        callListingSettingsAPI(oflineView: offlineUIView, nextButton: nextBtn)
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
            self.saveandExitBtn.isHidden = false
        }
        else{
            self.saveandExitBtn.isHidden = true
        }
    }
    
    override func setDropdownList() {
        
       
        self.setBookingStatus()
        self.setStaticArray()
        
        tableView.reloadData()
    }
    func setBookingStatus()
    {
        let listSettings = (Utility.shared.getListSettingsArray.maxDaysNotice?.listSettings!)!

        futureDatesArr = ["\((Utility.shared.getLanguage()?.value(forKey:"datesunavailable"))!)","3 \((Utility.shared.getLanguage()?.value(forKey:"monthsintofuture"))!)","6 \((Utility.shared.getLanguage()?.value(forKey:"monthsintofuture"))!)","9 \((Utility.shared.getLanguage()?.value(forKey:"monthsintofuture"))!)","12 \((Utility.shared.getLanguage()?.value(forKey:"monthsintofuture"))!)","\((Utility.shared.getLanguage()?.value(forKey:"Allfuturedates"))!)"]
        futures_Date_Array_without_String = ["unavailable","3months","6months","9months","12months","available"]
        future_array = ["Dates unavailable by default","3months into the future","6months into the future","9months into the future","12months into the future","All future dates"]
  
        if(Utility.shared.step3ValuesInfo["maxDaysNotice"] != nil && (("\(Utility.shared.step3ValuesInfo["maxDaysNotice"]!)") == "available"))
        {
            futureDateLbl = "\((Utility.shared.getLanguage()?.value(forKey:"Allfuturedates"))!)"
            Utility.shared.step3ValuesInfo.updateValue("available", forKey: "maxDaysNotice")
        }
        if(Utility.shared.step3ValuesInfo["maxDaysNotice"] != nil && ("\(Utility.shared.step3ValuesInfo["maxDaysNotice"]!)" == "unavailable"))
        {
            futureDateLbl = "\((Utility.shared.getLanguage()?.value(forKey:"datesunavailable"))!)"
            Utility.shared.step3ValuesInfo.updateValue("unavailable", forKey: "maxDaysNotice")
        }
        if(Utility.shared.step3ValuesInfo["maxDaysNotice"] != nil && (("\(Utility.shared.step3ValuesInfo["maxDaysNotice"]!)") != "available"))
        {
            if (Utility.shared.step3ValuesInfo["maxDaysNotice"]! as? String) == "unavailable"
            {
                futureDateLbl = "\((Utility.shared.getLanguage()?.value(forKey:"datesunavailable"))!)"

            }else{
                let index = futures_Date_Array_without_String.index(where: { (item) -> Bool in
                    item == "\(Utility.shared.step3ValuesInfo["maxDaysNotice"]!)"
                })
                futureDateLbl = futureDatesArr[index!]
                
                //futureDateLbl = ("\(Utility.shared.step3ValuesInfo["maxDaysNotice"]!) into the future")

            }
            Utility.shared.step3ValuesInfo.updateValue("\(Utility.shared.step3ValuesInfo["maxDaysNotice"]!)", forKey: "maxDaysNotice")
        }
        else
        {
            futureDateLbl = futureDatesArr.last!
            Utility.shared.step3ValuesInfo.updateValue("available", forKey: "maxDaysNotice")
        }
        
        if !futureDateLbl.isEmpty
        {
            let index = futureDatesArr.index(where: { (item) -> Bool in
                item == futureDateLbl
            })
            if index != nil
            {
                pickerView.selectRow(index!, inComponent: 0, animated: true)
            }
        }
    }
    
    func setStaticArray()
    {
       
        staticArray.append("\((Utility.shared.getLanguage()?.value(forKey:"flexible"))!)")
        staticArray.append("\((Utility.shared.getLanguage()?.value(forKey:"moderate"))!)")
        staticArray.append("\((Utility.shared.getLanguage()?.value(forKey:"strict"))!)")
        if(Utility.shared.step3ValuesInfo["cancellationPolicy"] != nil)
        {
            if((Utility.shared.step3ValuesInfo["cancellationPolicy"] as? Int)! == 1)
            {
             cancellationLbl = staticArray[0]
            cancel_id = 1
            }
            else if((Utility.shared.step3ValuesInfo["cancellationPolicy"] as? Int)! == 2)
            {
             cancellationLbl = staticArray[1]
                cancel_id = 2
            }
            else if((Utility.shared.step3ValuesInfo["cancellationPolicy"] as? Int)! == 3)
            {
                cancellationLbl = staticArray[2]
                cancel_id = 3
            }
        }
        else
        {
            cancellationLbl = staticArray.first!
            cancel_id = 1
        }
        
        pickerView.selectRow(cancel_id-1, inComponent: 0, animated: true)
       
        
        Utility.shared.step3ValuesInfo.updateValue(cancel_id, forKey: "cancellationPolicy")

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
        tableView.register(UINib(nibName: "SingleTextFieldCell", bundle: nil), forCellReuseIdentifier: "singletextfieldcell")

    }
    
    //MARK: - Progress Indicator
    
    override func addLottieViewAsSubview()
    {
        self.view.addSubview(self.lottieView)
    }
    
    
    func lottieViewanimation()
    {
        saveandExitBtn.setTitle("", for:.normal)
        lottieView1 = LOTAnimationView.init(name: "animation")
        self.lottieView1.isHidden = false
        self.lottieView1.frame = CGRect(x:80, y:-35, width:100, height:100)
        self.saveandExitBtn.addSubview(self.lottieView1)
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
    //IBActions
    
    @IBAction func RedirectNextPage(_ sender: Any) {
         if Utility().isConnectedToNetwork(){
        let guestListing = TripLengthViewController()
      //  self.view.layer.add(presentrightAnimation()!, forKey: kCATransition)
        guestListing.modalPresentationStyle = .fullScreen
        self.present(guestListing, animated: false, completion: nil)
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
    
    @IBAction func saveandExit(_ sender: Any) {
        
          if Utility().isConnectedToNetwork(){
            if((Utility.shared.step3ValuesInfo["minNight"] as? Int) != nil && (Utility.shared.step3ValuesInfo["maxNight"] as? Int) != nil)
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
    
    
    @IBAction func retryBtnTapped(_ sender: Any) {
        
          if Utility().isConnectedToNetwork(){
           self.offlineUIView.isHidden = true
        }
    }
    //MARK: - UITAbleViewDatasource and UITableViewDelegates
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "\((Utility.shared.getLanguage()?.value(forKey:"bookingwindow"))!)"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 65
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 65
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0
        {
            
//            let cell = tableView
//                .dequeueReusableCell(withIdentifier: "singletextfieldcell", for: indexPath) as? SingleTextFieldCell
            if indexPath.row == 0
            {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldcell", for: indexPath) as? TextFieldCell
               
                cell?.queryTitleLbl.text = "\((Utility.shared.getLanguage()?.value(forKey:"bookingpreference"))!)"
                cell?.queryTitleLbl.font = UIFont(name: "Circular-Book", size:18)
                cell?.txtField.text = futureDateLbl
                cell?.txtField.attributedPlaceholder = NSAttributedString(string: futureDateLbl,
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkText])
                cell?.selectionStyle = .none
                let toolBar = UIToolbar().ToolbarPikerSelect(mySelect: #selector(dismissgenderPicker))
                cell?.txtField.inputAccessoryView = toolBar
                cell?.txtField.inputView = pickerView
                cell?.txtField.tag = 0
                cell?.txtField.delegate = self
                cell?.step1Height.constant = 0
                cell?.txtField.textColor = UIColor.darkText
                cell?.stepnumberLbl.isHidden = true
                cell?.txtField.tintColor = .clear
                return cell!
                
            }else if indexPath.row == 1
            {
                let cell1 = tableView.dequeueReusableCell(withIdentifier: "textfieldcell", for: indexPath) as? TextFieldCell
                cell1?.step1Height.constant = 0
                cell1?.stepnumberLbl.isHidden = true
                cell1?.selectionStyle = .none
                
                cell1?.queryTitleLbl.text = "\((Utility.shared.getLanguage()?.value(forKey:"cancellationPolicy"))!)"
                
                cell1?.queryTitleLbl.font = UIFont(name: "Circular-Book", size:18)
                let toolBar = UIToolbar().ToolbarPikerSelect(mySelect: #selector(dismissgenderPicker))
                cell1?.txtField.inputAccessoryView = toolBar
                cell1?.txtField.inputView = pickerView
                cell1?.txtField.tintColor = .clear
                cell1?.txtField.delegate = self
                cell1?.txtField.textColor = UIColor.darkText
                cell1?.txtField.text = cancellationLbl
                cell1?.selectionStyle = .none
                cell1?.txtField.tag = 1
                return cell1!

            }
            
            
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 0)
        {
            if !futureDateLbl.isEmpty
            {
                let index = futureDatesArr.index(where: { (item) -> Bool in
                    item == futureDateLbl
                })
                pickerView.selectRow(index!, inComponent: 0, animated: true)
            }
        }
        else
        {
            if !cancellationLbl.isEmpty
            {
                let index = staticArray.index(where: { (item) -> Bool in
                    item == cancellationLbl
                })
                pickerView.selectRow(index!, inComponent: 0, animated: true)
            }
            
        }
        pickerView.reloadAllComponents()
    }
    
    //MARK: - UIPickerViewDelegate and Datasource
    
    override func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (selectedTextfield == 0)
        {
            return futureDatesArr.count
        }else
        {
            return staticArray.count
        }
    }
    
    override func pickerView( _ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var titleData = ""
        
        if (selectedTextfield == 0)
        {
            titleData = futureDatesArr[row]
        }else
        {
            titleData = staticArray[row]
        }
        
        let myTitle = NSAttributedString(string: titleData , attributes: [NSAttributedString.Key.font:UIFont(name: "Circular-Book", size: 15.0)!,NSAttributedString.Key.foregroundColor:Theme.PRIMARY_COLOR])
        return myTitle
    }
    
    override func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent  component: Int) {
        
        if (selectedTextfield == 0)
        {
            futureDateLbl = futureDatesArr[row]
            
            pickerView.selectRow(row, inComponent: component, animated: true)
            Utility.shared.step3ValuesInfo.updateValue(futures_Date_Array_without_String[row], forKey:"maxDaysNotice")
        }else if selectedTextfield == 1
        {
            cancellationLbl = staticArray[row]
            pickerView.selectRow(row, inComponent: component, animated: true)
            Utility.shared.step3ValuesInfo.updateValue(row+1, forKey: "cancellationPolicy")

        }        
    }
    
    //MARK: - UITextFieldDelegates
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        selectedTextfield = textField.tag
        pickerView.reloadAllComponents()
        if(textField.tag == 0)
        {
            if !futureDateLbl.isEmpty
            {
                let index = futureDatesArr.index(where: { (item) -> Bool in
                    item == futureDateLbl
                })

                pickerView.selectRow(index!, inComponent: 0, animated: true)
            }
        }
        if(textField.tag == 1)
        {
            if !cancellationLbl.isEmpty
            {
                let index = staticArray.index(where: { (item) -> Bool in
                    item == cancellationLbl
                })
                pickerView.selectRow(index!, inComponent: 0, animated: true)
            }
        }
        
    }
    
    override func textFieldDidEndEditing(_ textField: UITextField) {
        tableView.reloadData()
        view.endEditing(true)
    }
    
}

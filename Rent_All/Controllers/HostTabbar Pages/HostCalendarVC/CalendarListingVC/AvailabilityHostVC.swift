//
//  AvailabilityHostVC.swift
//  Rent_All
//
//  Created by RadicalStart on 07/08/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Apollo
import IQKeyboardManagerSwift

protocol AvailabilityHostVCDelegate {
     // func manageListingAPICall()
     func BlockedlistAPICall(listId:Int)
     func APICall(listImage:String,title:String,entireTitle:String,listId:Int)
    
}


class AvailabilityHostVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,SpecialTextFieldCellDelegate {
    
    
   
    
    @IBOutlet weak var nextImg: UIImageView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var offlineView: UIView!
    @IBOutlet weak var errorLabel : UILabel!
     @IBOutlet weak var retryBtn: UIButton!
    
    @IBOutlet weak var calenadarAvailableTable: UITableView!
    @IBOutlet weak var topView: UIView!
    var listId = Int()
    var listImage = String()
    var title_val = String()
    var entireTitle = String()
    var titleArray = NSMutableArray()
    var selected:Bool = false
    var specialPrice = Double()
    var startDate = String()
    var endDate = String()
    var special = String()
    let characterset = NSCharacterSet(charactersIn: "0123456789.")
    var apollo_headerClient: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
        
        let url = URL(string:graphQLEndpoint)!
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()
    var delegate:AvailabilityHostVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()

        // Do any additional setup after loading the view.
    }
    
    func initialSetup()
    {
        calenadarAvailableTable.register(UINib(nibName:"BlockCalendarCell", bundle: nil), forCellReuseIdentifier: "BlockCalendarCell")
        calenadarAvailableTable.register(UINib(nibName: "SpecialTextFieldCell", bundle: nil), forCellReuseIdentifier: "SpecialTextFieldCell")
        calenadarAvailableTable.register(UINib(nibName: "HostAvailCell", bundle: nil), forCellReuseIdentifier: "HostAvailCell")
        titleArray = ["\((Utility.shared.getLanguage()?.value(forKey:"available"))!)","\((Utility.shared.getLanguage()?.value(forKey:"blocked"))!)"]
        nextBtn.layer.cornerRadius = 6.0
        nextBtn.backgroundColor = Theme.PRIMARY_COLOR
        self.nextImg.image = self.nextImg.image?.withRenderingMode(.alwaysTemplate)
        self.nextImg.tintColor = UIColor.white
       // NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
       // NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.offlineView.isHidden = true
        
        if IS_IPHONE_XR || IS_IPHONE_PLUS
        {
            self.nextBtn.frame = CGRect(x:FULLWIDTH-160, y:self.calenadarAvailableTable.frame.size.height-40, width: 100, height: 45)
           
        }else if IS_IPHONE_678 {
             self.nextBtn.frame = CGRect(x:FULLWIDTH-130, y:self.calenadarAvailableTable.frame.size.height-30, width: 100, height: 45)
        }
        else {
            self.nextBtn.frame = CGRect(x:FULLWIDTH-130, y:self.calenadarAvailableTable.frame.size.height-80, width: 100, height: 45)
           
        }
        IQKeyboardManager.shared.enable = true
       
        errorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
        retryBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
        nextBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"save"))!)", for:.normal)
        
        
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        let info = sender.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        
        //  self.GoBtn.frame.origin.y -= keyboardFrame.height
        self.nextBtn.frame.origin.y = keyboardFrame.origin.y - 55
        self.nextImg.frame.origin.y = keyboardFrame.origin.y - 40
        
        
    }
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
        self.view.endEditing(true)
        if(( special == "." || special.rangeOfCharacter(from: characterset.inverted) != nil ) && !selected)
        {
             if(special == "." || special.rangeOfCharacter(from: characterset.inverted) != nil)
             {
                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"valid_special"))!)")
            }else{
                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"specialpricealert"))!)")
            }
            
        }
        else{
        
        if(!selected)
        {
            if(specialPrice == 0.0){
                SaveAPICall(listid: listId, blockedDates: Utility.shared.host_selected_dates_Array as! [String], calendarStatus: "available")
            }else{
            SaveAPICall(listid: listId, blockedDates:Utility.shared.host_selected_dates_Array as! [String], calendarStatus: "available",isSpecialPrice:specialPrice)
            }
             //self.delegate?.BlockedlistAPICall(listId: self.listId)
        }
      else{
            SaveAPICall(listid: listId, blockedDates:Utility.shared.host_selected_dates_Array as! [String], calendarStatus: "blocked", isSpecialPrice:0.0)
            
            
        }
        
        }
        }
        else{
            self.offlineView.isHidden = false
            let shadowSize2 : CGFloat = 3.0
            let shadowPath2 = UIBezierPath(rect: CGRect(x: -shadowSize2 / 2,
                                                        y: -shadowSize2 / 2,
                                                        width: self.offlineView.frame.size.width + shadowSize2,
                                                        height: self.offlineView.frame.size.height + shadowSize2))
            
            self.offlineView.layer.masksToBounds = false
            self.offlineView.layer.shadowColor = TextLightColor.cgColor
            self.offlineView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            self.offlineView.layer.shadowOpacity = 0.3
            self.offlineView.layer.shadowPath = shadowPath2.cgPath
            if IS_IPHONE_X || IS_IPHONE_XR {
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-85, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-55, width: FULLWIDTH, height: 55)
            }
            if(IS_IPHONE_XR || IS_IPHONE_PLUS)
            {
                self.nextBtn.frame = CGRect(x:FULLWIDTH-150, y:FULLHEIGHT-185, width: 100, height: 100)
            }
        }
    }
    
    func SaveAPICall(listid:Int,blockedDates:[String],calendarStatus:String,isSpecialPrice:Double)
    {
       let updateSpecialPriceMutation = UpdateSpecialPriceMutation(listId: listid, blockedDates: blockedDates, calendarStatus: calendarStatus, isSpecialPrice: isSpecialPrice)
        apollo_headerClient.perform(mutation: updateSpecialPriceMutation){(result,error) in
            if(result?.data?.updateSpecialPrice?.status == 200)
            {
                Utility.shared.isfrom_availability_calendar_date = true
                Utility.shared.isfrom_availability_calendar = true
                self.delegate?.BlockedlistAPICall(listId: self.listId)
                self.delegate?.APICall(listImage: self.listImage, title: self.title_val, entireTitle: self.entireTitle, listId: self.listId)
                self.dismiss(animated: true, completion: nil)

            }
            
        }
    }
    func SaveAPICall(listid:Int,blockedDates:[String],calendarStatus:String)
       {
          let updateSpecialPriceMutation = UpdateSpecialPriceMutation(listId: listid, blockedDates: blockedDates, calendarStatus: calendarStatus, isSpecialPrice: nil)
           apollo_headerClient.perform(mutation: updateSpecialPriceMutation){(result,error) in
               if(result?.data?.updateSpecialPrice?.status == 200)
               {
                   Utility.shared.isfrom_availability_calendar_date = true
                   Utility.shared.isfrom_availability_calendar = true
                   self.delegate?.BlockedlistAPICall(listId: self.listId)
                   self.delegate?.APICall(listImage: self.listImage, title: self.title_val, entireTitle: self.entireTitle, listId: self.listId)
                   self.dismiss(animated: true, completion: nil)

               }
               
           }
       }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        let info = sender.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        self.nextBtn.frame.origin.y = FULLHEIGHT - 90
        self.nextImg.frame.origin.y = FULLHEIGHT - 75
        
//        if(!((Utility.shared.checkEmptyWithString(value:titleTF.text!)))) {
//            self.configureNextBtn(enable: true)
//
//        }
//        else{
//            self.configureNextBtn(enable: false)
//        }
        
    }


    @IBAction func closeBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            Utility.shared.isfrom_availability_calendar_date = true
            Utility.shared.isfrom_availability_calendar = true
            self.delegate?.BlockedlistAPICall(listId: self.listId)
            self.delegate?.APICall(listImage: self.listImage, title: self.title_val, entireTitle: self.entireTitle, listId: self.listId)
        self.dismiss(animated: true, completion: nil)
        }
        else
        {
        self.offlineView.isHidden = false
        let shadowSize2 : CGFloat = 3.0
        let shadowPath2 = UIBezierPath(rect: CGRect(x: -shadowSize2 / 2,
                                                    y: -shadowSize2 / 2,
                                                    width: self.offlineView.frame.size.width + shadowSize2,
                                                    height: self.offlineView.frame.size.height + shadowSize2))
        
        self.offlineView.layer.masksToBounds = false
        self.offlineView.layer.shadowColor = TextLightColor.cgColor
        self.offlineView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.offlineView.layer.shadowOpacity = 0.3
        self.offlineView.layer.shadowPath = shadowPath2.cgPath
        if IS_IPHONE_X || IS_IPHONE_XR {
            offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-85, width: FULLWIDTH, height: 55)
        }else{
            offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-55, width: FULLWIDTH, height: 55)
        }
        }
    }
    @IBAction func retryBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            self.offlineView.isHidden = true
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        if(selected == true)
        {
            return 2
        }
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(selected == true)
        {
            if(section == 0){return 1}
            if(section == 1){return 2}
        }
        else{
            if(section == 0){return 1}
            if(section == 1){return 2}
            if(section == 2){return 1}
           
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(selected == true)
        {
            if(indexPath.section == 0){return 150}
            if(indexPath.section == 1){return 75}
        }
        else{
            if(indexPath.section == 0){return 150}
            if(indexPath.section == 1){return 75}
            if(indexPath.section == 2){return 125}
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HostAvailCell", for: indexPath) as! HostAvailCell
            cell.selectionStyle = .none
            cell.dateLabel.text = "\(startDate) - \(endDate)"
            return cell
        }
        else if(indexPath.section == 1)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BlockCalendarCell", for: indexPath) as! BlockCalendarCell
            cell.selectionStyle = .none
            cell.titleLabel.text = (titleArray[indexPath.row] as! String)
            if(indexPath.row == 0){
                if(selected == true)
                {
              cell.verifyImg.image = #imageLiteral(resourceName: "price_unclick")
                }
                else
                {
                  cell.verifyImg.image = #imageLiteral(resourceName: "profile_Verify_Tick")
                }
            }
            else
            {
                if(selected == true)
                {
              cell.verifyImg.image = #imageLiteral(resourceName: "profile_Verify_Tick")
                }
                else{
                   cell.verifyImg.image = #imageLiteral(resourceName: "price_unclick")
                }
            }
            return cell
        
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SpecialTextFieldCell", for:indexPath) as! SpecialTextFieldCell
            cell.selectionStyle = .none
            cell.delegate = self
            cell.specialTF.autocorrectionType = UITextAutocorrectionType.no
            cell.specialTF.addTarget(self, action: #selector(specialPricing(field:)), for: .editingDidEnd)
            let toolBar = UIToolbar().ToolbarPikerSelect(mySelect: #selector(dismissgenderPicker))
            cell.specialTF.inputAccessoryView = toolBar
            cell.specialTF.delegate = self
            return cell
        }
        
        }
    @objc func dismissgenderPicker() {
        view.endEditing(true)
        
    }
    @objc func specialPricing(field: UITextField){
        
        if ((field.text?.containsNonEnglishNumbersChecking) != nil) {
            field.text = field.text?.english.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if(field.text == "." || field.text?.rangeOfCharacter(from: characterset.inverted) != nil || field.text?.containsNothing == true)
            {
               self.view.endEditing(true)
                
            }else{
                specialPrice = Double(field.text!) as! Double
            }
            
            print(field.text as Any)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 1)
        {
            if(indexPath.row == 0)
            {
              selected = false
               // SaveAPICall(listid: listId, blockedDates:Utility.shared.host_blockedDates_Array as! [String], calendarStatus: "blocked", isSpecialPrice:0.0)
            }
            else{
                selected = true
                //SaveAPICall(listid: listId, blockedDates:Utility.shared.host_blockedDates_Array as! [String], calendarStatus: "blocked", isSpecialPrice:specialPrice)
            }
        }
        calenadarAvailableTable.reloadData()
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        special = textField.text!
        if(textField.text == "")
        {
            specialPrice = 0.0
        }
        else{
            if(textField.text != ".")
            {
                
                if textField.text!.rangeOfCharacter(from: characterset.inverted) != nil || textField.text!.isEmpty{
                    
                    if textField.text!.isEmpty{
                        self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"specialpricealert"))!)")
                    }else{
                        self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"valid_special"))!)")
                    }
                    
                }else{
                    specialPrice = Double("\(textField.text!)") as! Double
                }
                
             
            }
            else
            {
               self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"valid_special"))!)")
            }
            
           
        }
    }
    
    func didChangeText(text: String?, cell: SpecialTextFieldCell) {
        if(text == "")
        {
            specialPrice = 0.0
        }
        else{
            if text!.rangeOfCharacter(from: characterset.inverted) != nil || text!.isEmpty{
                

                
            }else{
                 specialPrice = Double("\(text!)") as! Double
            }
           
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentCharacterCount = textField.text?.count ?? 0
           //if
        if(textField.text!.contains(".") && string == ".") || range.length + range.location > currentCharacterCount
        {
            return false
        }
        else
            
        {
            let newlength = currentCharacterCount + string.count - range.length
            return newlength <= 6
           // return true
        }
    }
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

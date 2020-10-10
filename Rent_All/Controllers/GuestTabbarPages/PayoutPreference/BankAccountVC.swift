//
//  BankAccountVC.swift
//  Rent_All
//
//  Created by RadicalStart on 19/08/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Apollo
import Lottie


class BankAccountVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,WebviewVCDelegate,UIPickerViewDelegate, UIPickerViewDataSource{
    
    
  
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var retryBtn: UIButton!
    @IBOutlet weak var offlineView: UIView!
    @IBOutlet weak var finishBtn: UIButton!
    @IBOutlet weak var bankaccountTable: UITableView!
    @IBOutlet weak var topView: UIView!
    var bankaccount_field_Array = [String]()
    var bankaccount_Dict = [String:Any]()
    var accountID = String()
    var account_typeArray = [String]()
     var selectedTextfield = Int()
    var accountypeLabel = String()
    var companyTypeArray = [String]()
    var apollo_headerClient: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
        
        let url = URL(string:graphQLEndpoint)!
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()
    var lottieView: LOTAnimationView!
    
    var lottieWholeView = UIView()
       var lottieView1 =  LOTAnimationView()
    var inputPickerView = UIView()
    var pickerView = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialsetup()
        setdropdown()

        // Do any additional setup after loading the view.
    }
    func setdropdown()
    {
        inputPickerView.frame = CGRect(x: 0, y: FULLHEIGHT-200, width: FULLWIDTH, height: 200)
        pickerView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height: 200)
        inputPickerView.addSubview(pickerView)
        pickerView.delegate = self
        pickerView.tintColor = Theme.PRIMARY_COLOR
        pickerView.backgroundColor = UIColor.white
        pickerView.reloadAllComponents()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.finishBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"finish"))!)", for: .normal)
    }

    @IBAction func finishBtnTapped(_ sender: Any) {
         if Utility().isConnectedToNetwork(){
        self.view.endEditing(true)
        if(accountypeLabel == "Company")
        {
        bankaccount_Dict.updateValue("", forKey: "lastname")
        }
        if((bankaccount_Dict["accounttype"]) == nil || ((bankaccount_Dict["accounttype"]as! String) == ""))
        {
        self.view.makeToast("Please choose Account type")
        }
        else if((bankaccount_Dict["firstname"]) == nil || ((bankaccount_Dict["firstname"]as! String) == ""))
        {
            if(accountypeLabel == "Company")
            {
            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"enter_CompanyName"))!)")
            }
            else
            {
            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"firstnamealert"))!)")
            }
        }
        else if(((bankaccount_Dict["lastname"]) == nil || ((bankaccount_Dict["lastname"]as? String) == "")) && accountypeLabel == "Individual")
        {
            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"lastnamealert"))!)")
        }
        else if((bankaccount_Dict["routingnum"]) == nil || ((bankaccount_Dict["routingnum"]as? String) == ""))
        {
            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"rooutingnumberalert"))!)")
        }
        else if(((bankaccount_Dict["routingnum"]as? String)!.count) < 9)
        {
           self.view.makeToast("Invalid Routing number")
        }
        else if(((bankaccount_Dict["routingnum"]as? String)!.count) > 9)
        {
            self.view.makeToast("Invalid Routing number")
        }
        else if((bankaccount_Dict["accnum"]) == nil || ((bankaccount_Dict["accnum"]as? String) == ""))
        {
            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"accountnumberalert"))!)")
        }
        else if((bankaccount_Dict["confirmnum"]) == nil || ((bankaccount_Dict["confirmnum"]as? String) == ""))
        {
            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"confirmaccountalert"))!)")
        }
//        else if((bankaccount_Dict["ssn"]) == nil || ((bankaccount_Dict["ssn"]as! String) == ""))
//        {
//            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"ssnnumberalert"))!)")
//        }
            
        else{
            self.lottieanimation()
            self.finishAPICall()
        }
        }
        else
         {
            self.offlineView.isHidden = false
            self.finishBtn.isHidden = true
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
            if IS_IPHONE_X || IS_IPHONE_XR{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-85, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-55, width: FULLWIDTH, height: 55)
            }
        }
    }
    @IBAction func retryBtnTapped(_ sender: Any) {
         if Utility().isConnectedToNetwork(){
            self.finishBtn.isHidden = false
             self.offlineView.isHidden = true
        }
        
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func lottieanimation()
    {
        finishBtn.setTitle("", for:.normal)
        lottieView = LOTAnimationView.init(name: "animation_white")
        
        self.lottieView.isHidden = false
        self.lottieView.frame = CGRect(x:finishBtn.frame.size.width/2-60, y:-25, width:100, height:100)
        self.finishBtn.addSubview(self.lottieView)
        self.lottieView.backgroundColor = UIColor.clear
        self.lottieView.play()
        // animation_white.json
        Timer.scheduledTimer(timeInterval:0.3, target: self, selector: #selector(autoscroll), userInfo: nil, repeats: true)
    }
    
    func lottiewholeAnimation()
    {
        self.lottieView1.isHidden = false
        self.lottieWholeView.isHidden = false
         lottieView1 = LOTAnimationView.init(name: "loading_qwe")
        self.lottieWholeView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height: FULLHEIGHT)
        self.lottieWholeView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.view.addSubview(lottieWholeView)
        self.lottieView1.frame = CGRect(x:FULLWIDTH/2-50, y: FULLHEIGHT/2-50, width: 100, height: 100)
        self.lottieWholeView.addSubview(self.lottieView1)
        self.lottieView1.backgroundColor = UIColor.white
        self.lottieView1.layer.cornerRadius = 6.0
        self.lottieView1.clipsToBounds = true
        self.lottieView1.play()
         Timer.scheduledTimer(timeInterval:0.3, target: self, selector: #selector(autoscroll), userInfo: nil, repeats: true)
    }
    
    func setPayoutCall(accountid:String)
    {
        self.lottiewholeAnimation()
        
        let setPayoutMutation = ConfirmPayoutMutation(currentAccountId:accountid)
        apollo_headerClient.perform(mutation:setPayoutMutation){(result,error) in
                if(result?.data?.confirmPayout?.status == 200)
                {
                    self.lottieWholeView.isHidden = true
                    self.lottieView1.isHidden = true
                                    let payoutObj = PayoutPreferenceVC()
                                                    Utility.shared.isfrom_payoutcurrency = true
                                                     payoutObj.modalPresentationStyle = .fullScreen
                                                    self.present(payoutObj, animated: true, completion: nil)
                }
                else
                {
                    self.lottieWholeView.isHidden = true
                    self.lottieView1.isHidden = true
                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"somethingwrong"))!)")
                }
            }
            
            
        }
    
    @objc func autoscroll()
    {
        self.lottieView.play()
        self.lottieView1.play()
    }
    func initialsetup()
    {
        
        bankaccountTable.register(UINib(nibName: "PayoutTextfieldCell", bundle: nil), forCellReuseIdentifier: "PayoutTextfieldCell")
        
        self.finishBtn.layer.cornerRadius = 6.0
        self.finishBtn.layer.masksToBounds = true
        finishBtn.backgroundColor = Theme.PRIMARY_COLOR
        self.companyTypeArray = ["Account Type","Company Name","\((Utility.shared.getLanguage()?.value(forKey:"routingnumber"))!)","\((Utility.shared.getLanguage()?.value(forKey:"accountnumber"))!)","\((Utility.shared.getLanguage()?.value(forKey:"confirmaccountnumber"))!)"]
        
        self.bankaccount_field_Array = ["Account Type","\((Utility.shared.getLanguage()?.value(forKey:"FirstName"))!)","\((Utility.shared.getLanguage()?.value(forKey:"LastName"))!)","\((Utility.shared.getLanguage()?.value(forKey:"routingnumber"))!)","\((Utility.shared.getLanguage()?.value(forKey:"accountnumber"))!)","\((Utility.shared.getLanguage()?.value(forKey:"confirmaccountnumber"))!)"]
        
       // NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.account_typeArray = ["Individual","Company"]
     //   accountypeLabel = account_typeArray.first!
        self.offlineView.isHidden = true
        self.finishBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"finish"))!)", for: .normal)
        
        errorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
        retryBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
        
    }
    
    func finishAPICall()
    {
        if(Utility.shared.getEmail() == nil)
        {
            Utility.shared.setEmail(email: "demo@radicalstart.com")
        }
        let addpayoutmutation = AddPayoutMutation(methodId: 2, payEmail:"\(Utility.shared.getEmail())", address1:"\(Utility.shared.payout_Address_Dict["address1"]!)", address2:"\(Utility.shared.payout_Address_Dict["address2"])", city:Utility.shared.payout_Address_Dict["city"] as! String, state:Utility.shared.payout_Address_Dict["state"] as! String, country:Utility.shared.selected_Countrycode_Payout, zipcode:Utility.shared.payout_Address_Dict["zipcode"] as! String, currency:"USD", firstname: bankaccount_Dict["firstname"] as! String, lastname: bankaccount_Dict["lastname"] as! String, accountNumber: bankaccount_Dict["accnum"] as! String, routingNumber: bankaccount_Dict["routingnum"] as! String,businessType:bankaccount_Dict["accounttype"] as! String)
        
        apollo_headerClient.perform(mutation: addpayoutmutation){(result,error) in
            if(result?.data?.addPayout?.status == 200)
            {
                self.lottieView.isHidden = true
                let webviewObj = WebviewVC()
                webviewObj.delegate = self
                webviewObj.webstring = (result?.data?.addPayout?.connectUrl)!
                webviewObj.modalPresentationStyle = .fullScreen
                webviewObj.succesURL = (result?.data?.addPayout?.successUrl)!
                webviewObj.failureURL = (result?.data?.addPayout?.failureUrl)!
                webviewObj.webviewRedirection(webviewString:(result?.data?.addPayout?.connectUrl!)!)
                webviewObj.accountID = (result?.data?.addPayout?.stripeAccountId!)!
                self.accountID = (result?.data?.addPayout?.stripeAccountId!)!
                self.present(webviewObj, animated: true, completion: nil)
//                let payoutObj = PayoutPreferenceVC()
//                Utility.shared.isfrom_payoutcurrency = true
//                 payoutObj.modalPresentationStyle = .fullScreen
//                self.present(payoutObj, animated: true, completion: nil)
               
            }
            else
            {
            self.lottieView.isHidden = true
            self.finishBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"finish"))!)", for: .normal)
            self.view.makeToast(result?.data?.addPayout?.errorMessage!)
            }
        
    }
    }
    @objc func keyboardWillShow(sender: NSNotification) {
        let info = sender.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        
        //  self.GoBtn.frame.origin.y -= keyboardFrame.height
        self.finishBtn.frame.origin.y = keyboardFrame.origin.y - 60
        
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        let info = sender.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        self.finishBtn.frame.origin.y = FULLHEIGHT - 70
        
        
    }
    func tableView( _ tableView : UITableView,  titleForHeaderInSection section: Int)->String?
    {
        if(section == 0){
            return "\((Utility.shared.getLanguage()?.value(forKey:"bankpayoutdetails"))!)"
        }
        return ""
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        
        let lineLabel = UILabel(frame: CGRect(x:25, y: 0, width:
            tableView.bounds.size.width-30, height: 1.0))
        lineLabel.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        //headerView.addSubview(lineLabel)
        
        let headerLabel = UILabel(frame: CGRect(x:20, y:15, width:
            tableView.bounds.size.width, height: 60))
        headerLabel.font = UIFont(name: "Circular-Medium",size:25)
        headerLabel.addCharacterSpacing(kernValue: 1.3)
        headerLabel.textColor = UIColor.black
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0)
        {
            return 60
            
        }
        return CGFloat.leastNormalMagnitude
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(accountypeLabel == "" || accountypeLabel == "Individual" || accountypeLabel == "individual")
        {
        return bankaccount_field_Array.count
        }
        else
        {
        return companyTypeArray.count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PayoutTextfieldCell", for: indexPath)as! PayoutTextfieldCell
        cell.selectionStyle = .none
        cell.payoutTF.autocorrectionType = UITextAutocorrectionType.no
        cell.payoutTF.delegate = self
        cell.payoutTF.tag = indexPath.row
        let toolBar = UIToolbar().ToolbarPikerSelect(mySelect: #selector(dismissgenderPicker))
        cell.payoutTF.inputAccessoryView = toolBar
        cell.tag = indexPath.row + 2000
        
       
        if(accountypeLabel == "" || accountypeLabel == "Individual" || accountypeLabel == "individual")
        {
            cell.payoutTF.placeholder = bankaccount_field_Array[indexPath.row]
        if(indexPath.row == 0)
               {
                   if(accountypeLabel == "")
                   {
                   cell.payoutTF.attributedPlaceholder = NSAttributedString(string:bankaccount_field_Array[indexPath.row],
                                                                                                attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                   }
                   else
                   {
                   cell.payoutTF.attributedPlaceholder = NSAttributedString(string: accountypeLabel,
                                                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkText])
                   }
                   cell.payoutTF.inputView = pickerView
                   cell.payoutTF.delegate = self
               }
               else
               {
                   cell.payoutTF.inputView = nil
               }
        if((indexPath.row == 1) || (indexPath.row == 2))
        {
            
            cell.payoutTF.keyboardType = .default
        }
        else if(indexPath.row == 3){
            if(accountypeLabel != "" )
            {
            cell.payoutTF.text = ""
                bankaccount_Dict.updateValue("", forKey: "routingnum")
            }
             cell.payoutTF.keyboardType = .decimalPad
        }
        else{
            
            cell.payoutTF.keyboardType = .decimalPad
        }
        }
        else
        {
            if(companyTypeArray.count <= 5)
            {
            cell.payoutTF.placeholder = companyTypeArray[indexPath.row]
            }
            if(indexPath.row == 0)
                   {
                       if(accountypeLabel == "")
                       {
                       cell.payoutTF.attributedPlaceholder = NSAttributedString(string:bankaccount_field_Array[indexPath.row],
                                                                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                       }
                       else
                       {
                       cell.payoutTF.attributedPlaceholder = NSAttributedString(string: accountypeLabel,
                                                                                                attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkText])
                       }
                       cell.payoutTF.inputView = pickerView
                       cell.payoutTF.delegate = self
                   }
            else if(indexPath.row == 3){
                 if(accountypeLabel != "" )
                           {
                           cell.payoutTF.text = ""
                               bankaccount_Dict.updateValue("", forKey: "routingnum")
                           }
                
            }
                   else
                   {
                       cell.payoutTF.inputView = nil
                   }
            if((indexPath.row == 1))
            {
                
                cell.payoutTF.keyboardType = .default
            }
            else{
                
                cell.payoutTF.keyboardType = .decimalPad
            }
        }
        return cell
    }
    
    @objc func dismissgenderPicker() {
        view.endEditing(true)
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row == 0
    {
        selectedTextfield = 0
        if !accountypeLabel.isEmpty
        {
            let index = account_typeArray.index(where: { (item) -> Bool in
                item == accountypeLabel
            })
            pickerView.selectRow(index!, inComponent: 0, animated: true)
        }
       
    }
        pickerView.reloadAllComponents()
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
    
    selectedTextfield = textField.tag
    pickerView.reloadAllComponents()
    if selectedTextfield == 0
    {
        
        if !accountypeLabel.isEmpty
        {
            let index = account_typeArray.index(where: { (item) -> Bool in
                item == accountypeLabel
            })
            pickerView.selectRow(index!, inComponent: 0, animated: true)
        }
       
    }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       if(accountypeLabel == "" || accountypeLabel == "Individual" || accountypeLabel == "individual")
        {
        if(textField.tag == 3 && Utility.shared.selected_Countrycode_Payout == "CA")
        {
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            if textField.text?.count == 5 && updatedText.count == 6 {
                textField.text = textField.text! + "-" + string
                return false
            }
            if textField.text?.count == 7 && updatedText.count == 6 {
                let text = textField.text!
                textField.text = String(text.prefix(3))
                return false
            }
//            if textField.text!.count == 9 && updatedText.count == 10 {
//
//                self.view.makeToast("Invalid Routing number")
//                self.view.endEditing(true)
//
//                return true
//                 //return false
//            }
        }
        return true
            
        }else{
            if(textField.text!.contains(".") && string == ".")
            {
                return false
            }
            return true
        }
        }
       else{
        
       if(textField.tag == 2 && Utility.shared.selected_Countrycode_Payout == "CA")
              {
              if let text = textField.text, let textRange = Range(range, in: text) {
                  let updatedText = text.replacingCharacters(in: textRange, with: string)
                  if textField.text?.count == 5 && updatedText.count == 6 {
                      textField.text = textField.text! + "-" + string
                      return false
                  }
                  if textField.text?.count == 7 && updatedText.count == 6 {
                      let text = textField.text!
                      textField.text = String(text.prefix(3))
                      return false
                  }
//                   if textField.text!.count == 9 && updatedText.count == 10 {
//
//                      self.view.makeToast("Invalid Routing number")
//                    //self.view.endEditing(true)
//                    return true
//                       //return false
//                  }
              }
              return true
                  
              }else{
                  if(textField.text!.contains(".") && string == ".")
                  {
                      return false
                  }
                  return true
              }
        }
        }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let textValue = textField.text!.trimmingCharacters(in:.whitespacesAndNewlines)
       
        
        if(accountypeLabel == "" || accountypeLabel == "Individual" || accountypeLabel == "individual")
        {
        if(textField.tag == 0)
        {
            accountypeLabel = "Individual"
            bankaccount_Dict.updateValue("individual", forKey: "accounttype")
            bankaccountTable.reloadData()
            view.endEditing(true)
        }
        
        if(textField.tag == 1)
        {
            bankaccount_Dict.updateValue(textValue, forKey: "firstname")
        }
        if(textField.tag == 2)
        {
            
           bankaccount_Dict.updateValue(textValue, forKey: "lastname")
        }
        else if(textField.tag == 3)
        {
            bankaccount_Dict.updateValue(textValue, forKey: "routingnum")
            
        }
        else if(textField.tag == 4)
        {
            bankaccount_Dict.updateValue(textValue, forKey: "accnum")
            
        }
        else if(textField.tag == 5)
        {
            bankaccount_Dict.updateValue(textValue, forKey: "confirmnum")
            
        }
//        else if(textField.tag == 6)
//        {
//            bankaccount_Dict.updateValue(textValue, forKey: "ssn")
//
//        }
        }
        else
        {
            if(textField.tag == 0)
            {
                bankaccount_Dict.updateValue("company", forKey: "accounttype")
                bankaccountTable.reloadData()
                view.endEditing(true)
            }
            if(textField.tag == 1)
            {
                bankaccount_Dict.updateValue(textValue, forKey: "firstname")
            }
            else if(textField.tag == 2)
            {
                bankaccount_Dict.updateValue(textValue, forKey: "routingnum")
                
            }
            else if(textField.tag == 3)
            {
                bankaccount_Dict.updateValue(textValue, forKey: "accnum")
                
            }
            else if(textField.tag == 4)
            {
                bankaccount_Dict.updateValue(textValue, forKey: "confirmnum")
                
            }
//            else if(textField.tag == 5)
//            {
//                bankaccount_Dict.updateValue(textValue, forKey: "ssn")
//
//            }
        }
        
        
        
        //
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: - UIPickerViewDelegate and Datasource
    
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (selectedTextfield == 0)
        {
            return account_typeArray.count
            
        }
        return 0
    }
    
     func pickerView( _ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var titleData = ""
        
        if (selectedTextfield == 0)
        {
            if(account_typeArray.count > row)
            {
                titleData = account_typeArray[row]
            }
           
        }
        let myTitle = NSAttributedString(string: titleData , attributes: [NSAttributedString.Key.font:UIFont(name: "Circular-Book", size: 15.0)!,NSAttributedString.Key.foregroundColor:Theme.PRIMARY_COLOR])
        return myTitle
    }
    
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent  component: Int) {
        
        if (selectedTextfield == 0)
        {
            accountypeLabel = account_typeArray[row]
            pickerView.selectRow(row, inComponent: component, animated: true)
          
        }

       
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
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

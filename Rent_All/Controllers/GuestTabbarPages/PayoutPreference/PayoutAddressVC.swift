//
//  PayoutAddressVC.swift
//  Rent_All
//
//  Created by RadicalStart on 19/08/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class PayoutAddressVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var offlineView: UIView!
    
    @IBOutlet weak var nextImage: UIImageView!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var payoutAddressTable: UITableView!
    var countryText = String()
    var payout_TF_Array = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialsetup()
        // Do any additional setup after loading the view.
    }
    
    func initialsetup()
    {
        payoutAddressTable.register(UINib(nibName: "PayoutTextfieldCell", bundle: nil), forCellReuseIdentifier: "PayoutTextfieldCell")
        payout_TF_Array = ["\((Utility.shared.getLanguage()?.value(forKey:"country"))!)","\((Utility.shared.getLanguage()?.value(forKey:"addressline1"))!)","\((Utility.shared.getLanguage()?.value(forKey:"addressline2"))!)","\((Utility.shared.getLanguage()?.value(forKey:"city"))!)","\((Utility.shared.getLanguage()?.value(forKey:"stateprovince"))!)","\((Utility.shared.getLanguage()?.value(forKey:"zipcode"))!)"]
        self.continueBtn.layer.cornerRadius = 22.0
        self.continueBtn.layer.masksToBounds = true
        self.nextImage.image = self.nextImage.image?.withRenderingMode(.alwaysTemplate)
        continueBtn.backgroundColor = Theme.PRIMARY_COLOR
        self.nextImage.tintColor = .white
        payoutAddressTable.rowHeight = UITableView.automaticDimension
        payoutAddressTable.estimatedRowHeight = 70
       // NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.offlineView.isHidden = true
        Utility.shared.payout_Address_Dict["city"] = ""
        Utility.shared.payout_Address_Dict["state"] = ""
        Utility.shared.payout_Address_Dict["zipcode"] = ""
        IQKeyboardManager.shared.enableAutoToolbar = false
        continueBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"next"))!)", for:.normal)
        
        
    }

    @IBAction func continuebtnTapped(_ sender: Any) {
          if Utility().isConnectedToNetwork(){
            self.view.endEditing(true)
           
        if((Utility.shared.payout_Address_Dict["address1"]) == nil || ((Utility.shared.payout_Address_Dict["address1"]as! String) == ""))
        {
        self.view.makeToast("Please enter Address")
        }
//        else if((Utility.shared.payout_Address_Dict["address2"]) == nil || ((Utility.shared.payout_Address_Dict["address2"]as! String) == ""))
//        {
//            self.view.makeToast("Please enter Address2")
//        }
        else if((Utility.shared.payout_Address_Dict["city"]) == nil || ((Utility.shared.payout_Address_Dict["city"]as! String) == ""))
        {
            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"entercity"))!)")
        }
         else if((Utility.shared.payout_Address_Dict["state"]) == nil || ((Utility.shared.payout_Address_Dict["state"]as! String) == ""))
        {
            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"enterstate"))!)")
        }
        else if((Utility.shared.payout_Address_Dict["zipcode"]) == nil || ((Utility.shared.payout_Address_Dict["zipcode"]as! String) == ""))
        {
            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"enterzipcode"))!)")
        }
        else{
            
            let paymethodObj = PaymentMethodVC()
             paymethodObj.modalPresentationStyle = .fullScreen
            self.present(paymethodObj, animated: true, completion: nil)
        }
        }
        else
          {
            self.view.endEditing(true)
            self.continueBtn.isHidden = true
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
            if IS_IPHONE_X || IS_IPHONE_XR{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-85, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-55, width: FULLWIDTH, height: 55)
            }
        }
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func retryBtnTapped(_ sender: Any) {
           if Utility().isConnectedToNetwork(){
            self.continueBtn.isHidden = false
            self.offlineView.isHidden = true
        }
    }
    
    func tableView( _ tableView : UITableView,  titleForHeaderInSection section: Int)->String?
    {
        if(section == 0){
            return "\((Utility.shared.getLanguage()?.value(forKey:"enterpayoutaddress"))!)"
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        
        
        let headerLabel = UILabel(frame: CGRect(x:20, y:0, width:
            tableView.bounds.size.width-40, height: 80))
        headerLabel.font = UIFont(name: "Circular-Medium",size:25)
        headerLabel.addCharacterSpacing(kernValue: 1.3)
        headerLabel.numberOfLines = 2
        headerLabel.textColor = UIColor.black
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0)
        {
            return 90
            
        }
        return CGFloat.leastNormalMagnitude
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payout_TF_Array.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PayoutTextfieldCell", for: indexPath)as! PayoutTextfieldCell
        cell.selectionStyle = .none
        cell.payoutTF.placeholder = payout_TF_Array[indexPath.row]
        cell.payoutTF.autocorrectionType = UITextAutocorrectionType.no
        cell.payoutTF.delegate = self
        cell.payoutTF.tag = indexPath.row
        cell.tag = indexPath.row + 2000
        let toolBar = UIToolbar().ToolbarPikerSelect(mySelect: #selector(dismissgenderPicker))
        cell.payoutTF.inputAccessoryView = toolBar
        
        if(indexPath.row == 0)
        {
            cell.payoutTF.isUserInteractionEnabled = false
            cell.payoutTF.text = countryText
        }
        else if(indexPath.row == 1)
        {
            
        }
        else if(indexPath.row == 2)
        {
            
        }
        else if(indexPath.row == 3)
        {
            
        }
        else if(indexPath.row == 4)
        {
            
        }
        else if(indexPath.row == 5)
        {
            
        //cell.payoutTF.keyboardType = .decimalPad
            
        }
        return cell
    }
    @objc func dismissgenderPicker() {
        view.endEditing(true)
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField.text!.contains(".") && string == ".")
        {
            return false
        }
        return true
    }
    @objc func keyboardWillShow(sender: NSNotification) {
        let info = sender.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        
        //  self.GoBtn.frame.origin.y -= keyboardFrame.height
          self.continueBtn.frame.origin.y = keyboardFrame.origin.y - 60
         self.nextImage.frame.origin.y = keyboardFrame.origin.y - 45
        
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        let info = sender.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        self.continueBtn.frame.origin.y = FULLHEIGHT - 70
        self.nextImage.frame.origin.y = FULLHEIGHT - 55
//
//        if ((emailTF.text?.isValidEmail())! && ((passwordTF.text?.count)! > 6)) {
//            self.configureNextBtn(enable: true)
//
//        }
//        else{
//            self.configureNextBtn(enable: false)
//        }
        
    }
    
    
    // MARK: - TextFieldDelegate Methods
    
    
    
    

    func textFieldDidEndEditing(_ textField: UITextField) {
         let textvalue = textField.text!.trimmingCharacters(in: .whitespaces)
        if(textField.tag == 0)
        {
            Utility.shared.payout_Address_Dict.updateValue(countryText, forKey: "country")
        }
        if(textField.tag == 1)
        {
           
            
            Utility.shared.payout_Address_Dict.updateValue(textvalue, forKey: "address1")
        }
        else if(textField.tag == 2)
        {
            Utility.shared.payout_Address_Dict.updateValue(textvalue, forKey: "address2")
            
        }
        else if(textField.tag == 3)
        {
            Utility.shared.payout_Address_Dict.updateValue(textvalue, forKey: "city")
            
        }
        else if(textField.tag == 4)
        {
            Utility.shared.payout_Address_Dict.updateValue(textvalue, forKey: "state")
            
        }
        else if(textField.tag == 5)
        {
            Utility.shared.payout_Address_Dict.updateValue(textvalue, forKey: "zipcode")
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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

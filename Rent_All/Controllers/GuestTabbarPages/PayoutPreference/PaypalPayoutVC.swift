//
//  PaypalPayoutVC.swift
//  Rent_All
//
//  Created by RadicalStart on 19/08/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Apollo
import Lottie
import IQKeyboardManagerSwift

class PaypalPayoutVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,LanguageVCDelegate {
    
   
    
    @IBOutlet weak var offlineView: UIView!
    
    @IBOutlet weak var retryBtn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var finishBtn: UIButton!
    @IBOutlet weak var paypalTable: UITableView!
    @IBOutlet weak var topview: UIView!
    var payemail = String()
    var gettingCurrencyString = String()
    var currencycode = String()
    var apollo_headerClient: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
        
        let url = URL(string:graphQLEndpoint)!
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()
    var paypal_Array = [String]()
    var lottieView: LOTAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialsetup()

        // Do any additional setup after loading the view.
    }

    @IBAction func backbtnTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func retryBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
             self.finishBtn.isHidden = false
            self.offlineView.isHidden = true
        }
    }
    @IBAction func finishBtnTapped(_ sender: Any) {
         if Utility().isConnectedToNetwork(){
                self.view.endEditing(true)
                if(payemail == "")
                {
                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"enteremailplease"))!)")
                }
                else
                {
                if(!(payemail.isValidEmail()))
                {
                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"validemailenter"))!)")
                }
                else
                {
                    self.lottieanimation()
                    self.finishAPICall()
                }
                }
        }
        else
         {
            self.view.endEditing(true)
            self.finishBtn.isHidden = true
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
    func initialsetup()
    {
        paypalTable.register(UINib(nibName: "paymentpaypalcell", bundle: nil), forCellReuseIdentifier: "paymentpaypalcell")
        paypalTable.register(UINib(nibName: "TextFieldCell", bundle: nil), forCellReuseIdentifier: "textfieldcell")
        
        finishBtn.backgroundColor = Theme.PRIMARY_COLOR
        self.finishBtn.layer.cornerRadius = 6.0
        self.finishBtn.layer.masksToBounds = true
        currencycode = "USD"
        gettingCurrencyString = currencycode
        self.paypal_Array = ["\((Utility.shared.getLanguage()?.value(forKey:"emailaddress"))!)","\((Utility.shared.getLanguage()?.value(forKey:"currency"))!)"]
        
       // NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
       // NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.offlineView.isHidden = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        
        errorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
        retryBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
        finishBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"finish"))!)", for:.normal)
        
        
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
    @objc func autoscroll()
    {
        self.lottieView.play()
    }
    
    func finishAPICall()
    {
        let addpayoutmutation = AddPayoutMutation(methodId: 1, payEmail: payemail, address1: Utility.shared.payout_Address_Dict["address1"] as? String ?? "", address2: Utility.shared.payout_Address_Dict["address2"] as? String ?? "", city: Utility.shared.payout_Address_Dict["city"] as? String ?? "", state: Utility.shared.payout_Address_Dict["state"] as? String ?? "", country: Utility.shared.selected_Countrycode_Payout, zipcode: Utility.shared.payout_Address_Dict["zipcode"] as? String ?? "", currency: currencycode)
        apollo_headerClient.perform(mutation: addpayoutmutation){(result,error) in
            if(result?.data?.addPayout?.status == 200)
            {
                self.lottieView.isHidden = true
                let payoutObj = PayoutPreferenceVC()
                Utility.shared.isfrom_payoutcurrency = true
                payoutObj.modalPresentationStyle = .fullScreen
                self.present(payoutObj, animated: true, completion: nil)
            }
            else
            {
                self.lottieView.isHidden = true
                self.view.makeToast(result?.data?.addPayout?.errorMessage!)
            }
            
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0)
        {
            return 1
        }
        else
        {
            return 2
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0)
        {
            return 170
        }
        else{
            return 110
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "paymentpaypalcell", for: indexPath)as! paymentpaypalcell
            cell.selectionStyle = .none
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldcell", for: indexPath)as! TextFieldCell


            cell.queryTitleLbl.font = UIFont(name: "Circular-Medium", size:20)
            cell.txtField.placeholder = paypal_Array[indexPath.row]
            cell.txtField.textColor = UIColor.darkText
            if(indexPath.row == 0)
            {
            cell.queryTitleLbl.text = "\((Utility.shared.getLanguage()?.value(forKey:"payemail"))!)"
            
            }
            else
            {
            cell.queryTitleLbl.text = "\((Utility.shared.getLanguage()?.value(forKey:"paycurrency"))!)"
            cell.txtField.attributedPlaceholder = NSAttributedString(string: "\(currencycode)",
                                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkText])
            //cell.txtField.text = "\(currencycode)"
            }
            
            cell.selectionStyle = .none
            let toolBar = UIToolbar().ToolbarPikerSelect(mySelect: #selector(dismissgenderPicker))
            cell.txtField.inputAccessoryView = toolBar
            cell.txtField.tag = indexPath.row
            cell.txtField.delegate = self
            cell.step1Height.constant = 0
            cell.txtField.textColor = UIColor.darkText
            cell.stepnumberLbl.isHidden = true
           
            return cell
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if(textField.tag == 1)
        {
            textField.resignFirstResponder()
            let languageObj = LanguageVC()
            Utility.shared.isfromLanguage = false
            Utility.shared.isfromCurrency = false
            languageObj.payout_currency_symbol = currencycode
            Utility.shared.isfrom_payoutcurrency = true
            languageObj.delegate = self
            languageObj.modalPresentationStyle = .fullScreen
            self.present(languageObj, animated: true, completion: nil)
        }
        
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
        
    }
    @objc func dismissgenderPicker() {
        view.endEditing(true)
        
    }
 
    
     func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField.tag == 0)
        {
           payemail = textField.text!
        }
        if(textField.tag == 1)
        {
            currencycode = gettingCurrencyString
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func getcurrencycode(code: String) {
        currencycode = code
        gettingCurrencyString = code
        paypalTable.reloadData()
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

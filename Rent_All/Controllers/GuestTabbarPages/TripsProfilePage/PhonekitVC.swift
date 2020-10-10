//
//  PhonekitVC.swift
//  Rent_All
//
//  Created by RadicalStart on 09/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Apollo
import Lottie

class PhonekitVC: UIViewController,UITextFieldDelegate,CountryDelegate{
    func setSelectedCountry(selectedCountry: String, selectedcountryCode: String, selectdialcode: String) {
        countryBtn.setTitle(selectdialcode, for: .normal)
    }
    

    @IBOutlet weak var closeBtn: UIButton!
    
    @IBOutlet weak var phonedescLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var phoneView: UIView!
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var confirmphoneLabel: UILabel!
    @IBOutlet weak var countryBtn: UIButton!
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var phoneTF: UITextField!
    var userphonekitArray = GetProfileQuery.Data.UserAccount.Result()
     
    let apollo_headerClient: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
        
        let url = URL(string:graphQLEndpoint)!
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()
    var lottieView1: LOTAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(Utility.shared.selectedphoneNumber != "")
        {
        phoneTF.text = Utility.shared.selectedphoneNumber
        Utility.shared.isfromPhonePage = true
        }
        else {
        if(userphonekitArray.phoneNumber != nil)
        {
        phoneTF.text = userphonekitArray.phoneNumber!
        Utility.shared.isfromPhonePage = true
        }
        }
        let toolBar = UIToolbar().ToolbarPikerSelect(mySelect: #selector(dismissPicker))
        phoneTF.inputAccessoryView = toolBar
        phoneTF.delegate = self
        phoneTF.keyboardType = .numberPad
        phoneTF.becomeFirstResponder()
        confirmphoneLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"confirmphone"))!)"
         phonedescLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"phonedesc"))!)"
         phoneLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"phonenumber"))!)"
        nextBtn.layer.cornerRadius = 6.0
        lottieView1 = LOTAnimationView.init(name: "animation_white")
        nextBtn.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.lottieView1.isHidden = true
        self.nextBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"next"))!)", for: .normal)
    }
    @objc func dismissPicker()
    {
        
            view.endEditing(true)
           
//            Utility.shared.selectedphoneNumber = phoneTF.text!
//            Utility.shared.isfromPhoneVC = true
//            self.EditProfileAPICall(fieldName: "phoneNumber", fieldValue:phoneTF.text!)
//            self.dismiss(animated: true, completion: nil)
       
        
        
    }
    func lottienextanimation()
      {
         
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
    
    
   
    func initialSetup()
    {
        self.topView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height: 70)
        self.closeBtn.frame = CGRect(x: 8, y: 32, width: 45, height: 45)
    
        self.phoneView.frame = CGRect(x: 0, y:70, width: FULLWIDTH, height: FULLHEIGHT-70)
        nextBtn.layer.cornerRadius = 3.0
        nextBtn.layer.masksToBounds = true
    }

    @IBAction func nextBtnTapped(_ sender: Any) {
         if Utility().isConnectedToNetwork(){
            if(phoneTF.text!.count < 10)
            {
                phoneTF.resignFirstResponder()
                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"phonealert"))!)")
                
            }
            else if(phoneTF.text!.count > 10)
            {
                phoneTF.resignFirstResponder()
                // phoneTF.isUserInteractionEnabled = false
                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"phoneexceedalert"))!)")
            }
            else if(phoneTF.text!.count == 10)
            {
        self.lottienextanimation()
         self.addPhonenumberCall()
            }
        }
        else
         {
          self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)")
        }
        
//       Utility.shared.selectedphoneNumber = phoneTF.text!
//         self.EditProfileAPICall(fieldName: "phoneNumber", fieldValue:phoneTF.text!)
//        self.dismiss(animated: true, completion: nil)
        
    
        
    }
    func addPhonenumberCall()
    {
        let addphonenumberMutation = AddPhoneNumberMutation(countryCode:(countryBtn.titleLabel?.text!)!, phoneNumber: phoneTF.text!)
        apollo_headerClient.perform(mutation: addphonenumberMutation){(result,error) in
            if(result?.data?.addPhoneNumber?.status == 200)
            {
                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"sentOTP"))!)")
                DispatchQueue.main.asyncAfter(deadline:.now() + 1) {
                    let otpPageObj = VerifyOTPPage()
                    otpPageObj.EditProfileArray = self.userphonekitArray
                    otpPageObj.countrycode = self.countryBtn.titleLabel!.text!
                    otpPageObj.phoneno = self.phoneTF.text!
                        otpPageObj.modalPresentationStyle = .fullScreen
                                  self.present(otpPageObj, animated: false, completion: nil)
                }
               
              
            }
            else
            {
                self.lottieView1.isHidden = true
                self.nextBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"next"))!)", for:.normal)
                self.view.makeToast("\((result?.data?.addPhoneNumber?.errorMessage!)!)")
            }
        }
    }
    func EditProfileAPICall(fieldName:String,fieldValue:String)
    {
        Utility.shared.isfromPhonePage = true
        let editprofileMutation = EditProfileMutation(userId: (Utility.shared.getCurrentUserID()! as String), fieldName: fieldName, fieldValue: fieldValue, deviceType: "iOS", deviceId:Utility.shared.pushnotification_devicetoken)
        apollo_headerClient.perform(mutation: editprofileMutation){ (result,error) in
            
            if(result?.data?.userUpdate?.status == 200)
            {
                print("success")
               
            }
            else {
                
            }
        }
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
//        if(phoneTF.text!.count < 1)
//        {
//            phoneTF.resignFirstResponder()
//            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"phonerequire"))!)")
//
//        }
//        else if(phoneTF.text!.count < 10)
//        {
//            phoneTF.resignFirstResponder()
//            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"phonealert"))!)")
//
//        }
//        else if(phoneTF.text!.count > 10)
//        {
//            phoneTF.resignFirstResponder()
//            // phoneTF.isUserInteractionEnabled = false
//            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"phoneexceedalert"))!)")
//        }
//        else if(phoneTF.text!.count == 10)
//        {
//            view.endEditing(true)
//            Utility.shared.selectedphoneNumber = phoneTF.text!
//            Utility.shared.isfromPhoneVC = true
//            self.EditProfileAPICall(fieldName: "phoneNumber", fieldValue:phoneTF.text!)
//            self.dismiss(animated: true, completion: nil)
//        }
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func phoneBtnTapped(_ sender: Any) {
        let countrycodeObj = CountrycodeVC()
        Utility.shared.isPhonenumberCountrycode = true
        countrycodeObj.delegate = self
         countrycodeObj.modalPresentationStyle = .fullScreen
        self.present(countrycodeObj, animated: true, completion: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    
//    func textFieldDidBeginEditing(_ textField: UITextField)
//    {
//       phoneTF.isUserInteractionEnabled = true
//    }
//
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let charsLimit = 10
        
        let startingLength = textField.text?.count ?? 0
        let lengthToAdd = string.count
        let lengthToReplace =  range.length
        let newLength = startingLength + lengthToAdd - lengthToReplace
        
        return newLength <= charsLimit
    }
    func textFieldDidEndEditing(_ textField: UITextField){
 
    }
}
extension String {
    
    var isPhoneNumber: Bool {
        
        let charcter  = NSCharacterSet(charactersIn: "+0123456789").inverted
        var filtered:NSString!
        let inputString:NSArray = self.components(separatedBy: charcter) as NSArray
        filtered = inputString.componentsJoined(by: "") as NSString
        return (filtered != nil)
        
    }
}

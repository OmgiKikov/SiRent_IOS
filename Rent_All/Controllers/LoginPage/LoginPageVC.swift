//
//  LoginPageVC.swift
//  Rent_All
//
//  Created by RADICAL START on 19/03/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Lottie
import Apollo

class LoginPageVC: UIViewController {
    
    
    //Mark:*********************************  Outlet Connections   ********************************************************>
    
    @IBOutlet var emailTF: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var logintitleLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var invalidLabel: UILabel!
    @IBOutlet var passwordTF: UITextField!
    
    @IBOutlet weak var retryBtn: UIButton!
    @IBOutlet var nextView: UIView!
    @IBOutlet var emailtickImg: UIImageView!
    
    @IBOutlet var passwordtickImg: UIImageView!
    
    @IBOutlet var signinView: UIView!
    @IBOutlet var GoBtn: UIButton!
    
    @IBOutlet var lottieView: LOTAnimationView!
    @IBOutlet var showBtn: UIButton!
    @IBOutlet weak var invalidcredentialView: UIView!
    

    @IBOutlet weak var showpasswordBtn: UIButton!

    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    @IBOutlet weak var offelineView: UIView!
    var lottieWholeView = UIView()
    var pasteEmail = String()
    var pastePassword = String()
    //Mark: ***************************** Global Variable Declaration *********************************************************>
    
    var passwordShow = true
    
    var Gobtn_Constraints = NSLayoutConstraint()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        passwordTF.clearsOnBeginEditing = false
        let rightToLeftTransition = CATransition()
        
        rightToLeftTransition.type = CATransitionType.push
        rightToLeftTransition.subtype = CATransitionSubtype.fromRight
        rightToLeftTransition.duration = 0.2
        rightToLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        rightToLeftTransition.fillMode = CAMediaTimingFillMode.removed
        
        
        if #available(iOS 11.0, *) {
            Gobtn_Constraints = GoBtn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        } else {
            // Fallback on earlier versions
        }
        print("Button Constraints \(Gobtn_Constraints)")
        Gobtn_Constraints.isActive = true
        //self.signinView.layer.add(rightToLeftTransition, forKey: "rightToLeftTransition")
   
        //self.signinView.applyGradient(colours:PRIMARY_COLOR)
        view.applyGradient(colours: PRIMARY_COLOR)
        self.signinView.applyGradient(colours:PRIMARY_COLOR)
        self.view.applyGradient(colours: PRIMARY_COLOR)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.initialSetup()
        self.lottieView.isHidden = true
        self.lottieWholeView.isHidden = true
        self.pasteEmail = ""
        

       
    }

    
    //Mark:******************************** Button Actions ***********************************************************************>
    
    @IBAction func retryTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
        self.offelineView.isHidden = true
        self.lottieWholeView.isHidden = false
            
        self.lottieWholeView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height: FULLHEIGHT)
        self.lottieWholeView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.signinView.addSubview(lottieWholeView)
        self.lottieView.isHidden = false
        self.lottieView.frame = CGRect(x:FULLWIDTH/2-40, y: FULLHEIGHT/2-40, width: 80, height: 80)
        self.signinView.addSubview(self.lottieView)
        self.lottieView.backgroundColor = UIColor.white
        self.lottieView.layer.cornerRadius = 6.0
        self.lottieView.clipsToBounds = true
        self.lottieView.play()
        self.checkLoginAPI()
        }
    }
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        
    if Utility().isConnectedToNetwork(){
        self.lottieWholeView.isHidden = false
        self.lottieWholeView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height: FULLHEIGHT)
        self.lottieWholeView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.signinView.addSubview(lottieWholeView)
        self.offelineView.isHidden = true
        self.lottieView.isHidden = false
        self.lottieView.frame = CGRect(x:FULLWIDTH/2-40, y: FULLHEIGHT/2-40, width: 80, height: 80)
        self.lottieWholeView.addSubview(self.lottieView)
        self.lottieView.backgroundColor = UIColor.white
        self.lottieView.layer.cornerRadius = 6.0
        self.lottieView.clipsToBounds = true
        self.lottieView.play()
        self.checkLoginAPI()
        }
        else{
            self.offelineView.isHidden = false
            if IS_IPHONE_X || IS_IPHONE_XR {
                self.offelineView.frame = CGRect(x: 0, y: FULLHEIGHT-80, width: FULLWIDTH, height: 60)
                
            }
            else{
                self.offelineView.frame = CGRect(x: 0, y: FULLHEIGHT-60, width: FULLWIDTH, height: 60)
            }
            let shadowSize2 : CGFloat = 3.0
            let shadowPath2 = UIBezierPath(rect: CGRect(x: -shadowSize2 / 2,
                                                        y: -shadowSize2 / 2,
                                                        width: self.offelineView.frame.size.width + shadowSize2,
                                                        height: self.offelineView.frame.size.height + shadowSize2))
            
            self.offelineView.layer.masksToBounds = false
            self.offelineView.layer.shadowColor = TextLightColor.cgColor
            self.offelineView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            self.offelineView.layer.shadowOpacity = 0.3
            self.offelineView.layer.shadowPath = shadowPath2.cgPath
            self.passwordTF.resignFirstResponder()
            self.emailTF.resignFirstResponder()
            
        }
    }
    
    @IBAction func forgotBtnAction(_ sender: Any) {
        let forgotObj = ForgotPasswordVC()
        forgotObj.modalPresentationStyle = .fullScreen
        self.present(forgotObj, animated: false, completion: nil)
       // self.navigationController?.pushViewController(forgotObj, animated: true)
    }
    
    
    @IBAction func backBtnAction(_ sender: Any) {
 
        let welcomeObj = WelcomePageVC()
        welcomeObj.modalPresentationStyle = .fullScreen
        self.present(welcomeObj, animated:false, completion: nil)
       // self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func showBtnAction(_ sender: Any) {
        if(passwordShow){
            showBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"hide"))!)", for: .normal)
            showBtn.titleLabel?.font =  UIFont(name: "Circular-Medium", size:17)
            showpasswordBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"hidePassword"))!)", for: .normal)
            passwordTF.isSecureTextEntry = false
        }
        else {
            showBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"show"))!)", for: .normal)
            showBtn.titleLabel?.font =  UIFont(name: "Circular-Medium", size:17)
            showpasswordBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"showpassword"))!)", for: .normal)
            passwordTF.isSecureTextEntry = true
            passwordTF.clearsOnBeginEditing = false
        }
        passwordShow = !passwordShow
        if passwordTF!.isFirstResponder {
           self.becomeFirstResponder()
        }
    }
    override func becomeFirstResponder() -> Bool {
        
        let success = super.becomeFirstResponder()
       
        if passwordTF.isSecureTextEntry, let text = passwordTF.text {
            passwordTF.text?.removeAll()
            passwordTF.insertText(text)
        }
        return success
    }
    
    @IBAction func showPasswordAction(_ sender: Any) {
        if(passwordShow){
            showBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"hide"))!)", for: .normal)
            showBtn.titleLabel?.font =  UIFont(name: "Circular-Medium", size:17)
            showpasswordBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"hidePassword"))!)", for: .normal)
            passwordTF.isSecureTextEntry = false
        }
        else {
            showBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"show"))!)", for: .normal)
            showBtn.titleLabel?.font = UIFont(name: "Circular-Medium", size:17)
            showpasswordBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"showpassword"))!)", for: .normal)
            passwordTF.isSecureTextEntry = true
            passwordTF.clearsOnBeginEditing = false
        }
        passwordShow = !passwordShow
        if passwordTF!.isFirstResponder {
           becomeFirstResponder()
        }
    }
    
    func initialSetup()
    {
        signinView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height: FULLHEIGHT)
        emailtickImg.isHidden = true
        passwordtickImg.isHidden = true
        self.invalidcredentialView.isHidden = true
        self.offelineView.isHidden = true
        emailTF.text = ""
        passwordTF.text = ""
        GoBtn.layer.cornerRadius = GoBtn.frame.size.width/2
        GoBtn.clipsToBounds = true
        emailTF.becomeFirstResponder()
        self.lottieView.isHidden = true
        
        forgotPasswordButton.frame = CGRect(x: FULLWIDTH-210, y: 47, width: 200, height: 30)
        
        if (!((Utility.shared.checkEmptyWithString(value: emailTF.text!)) && (Utility.shared.checkEmptyWithString(value: passwordTF.text!)))) {
            self.configureNextBtn(enable: true)
            
        }
        else{
            self.configureNextBtn(enable: false)
        }
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        self.lottieView = LOTAnimationView.init(name: "loading_qwe")
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        emailTF.autocorrectionType = UITextAutocorrectionType.no
        passwordTF.autocorrectionType = UITextAutocorrectionType.no
        if passwordTF!.isFirstResponder {
            self.becomeFirstResponder()
        }
        emailTF.addTarget(self, action: #selector(EmailPageVC.textFieldDidChange(_:)),
                          for: UIControl.Event.editingChanged)
        passwordTF.addTarget(self, action: #selector(EmailPageVC.textFieldDidChange(_:)),
                          for: UIControl.Event.editingChanged)
        logintitleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"login_string"))!)"
         emailLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"email_address"))!)"
         passwordLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"password"))!)"
         logintitleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"login_string"))!)"
         errorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
         invalidLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"invalid_credentials"))!)"
        showBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"show"))!)", for:.normal)
        showpasswordBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"showpassword"))!)", for:.normal)
        retryBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
        forgotPasswordButton.setTitle("\((Utility.shared.getLanguage()?.value(forKey: "Forgot_password"))!)", for: .normal)
        
        
    }
    func configureNextBtn(enable:Bool){
        if(enable){
            self.GoBtn.isUserInteractionEnabled = true
            self.GoBtn.alpha = 1.0
        }
        else {
            self.GoBtn.isUserInteractionEnabled = false
            self.GoBtn.alpha = 0.7
        }
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func checkLoginAPI()
    {
        let loginquery = LoginQuery(email: emailTF.text!, password: passwordTF.text!, deviceType:"iOS", deviceDetail: "", deviceId:Utility.shared.pushnotification_devicetoken)
        let apollo = ApolloClient(url: URL(string:graphQLEndpoint)!)
        apollo.fetch(query: loginquery,cachePolicy:.fetchIgnoringCacheData) { (result,error) in
            if(result?.data?.userLogin?.status == 200) {
                
                Utility.shared.logindataArray.removeAll()
                if(result?.data?.userLogin?.result?.user?.preferredCurrency != nil)
                {
                Utility.shared.setPreferredCurrency(currency_rate: (result?.data?.userLogin?.result?.user?.preferredCurrency as AnyObject) as! String)
                }
                else
                {
                Utility.shared.setPreferredCurrency(currency_rate:"USD")
                 Utility.shared.selectedCurrency = "USD"
                }
                Utility.shared.setopenTabbar(iswhichtabbar:false)
                Utility.shared.setUserToken(userID:(result?.data?.userLogin?.result?.userToken as AnyObject) as! NSString)
                
                Utility.shared.setUserID(userid: (result?.data?.userLogin?.result?.userId as AnyObject)as! NSString)
                Utility.shared.setPassword(password: self.passwordTF!.text! as NSString)
                Utility.shared.logindataArray.append(result?.data?.userLogin?.result?.userToken as AnyObject)  //Usertoken
                Utility.shared.logindataArray.append(result?.data?.userLogin?.result?.userId as AnyObject)  //Userid
                Utility.shared.logindataArray.append("\(result?.data?.userLogin?.result?.user?.firstName)" + "" + "\(result?.data?.userLogin?.result?.user?.lastName)" as AnyObject)  //Profilename
                Utility.shared.logindataArray.append(result?.data?.userLogin?.result?.user?.picture as AnyObject)  // Picture
                Utility.shared.logindataArray.append(result?.data?.userLogin?.result?.user?.createdAt as AnyObject)  //createdDate
                Utility.shared.logindataArray.append(result?.data?.userLogin?.result?.user?.verification?.isPhoneVerified as AnyObject) //Phoneverification
                Utility.shared.logindataArray.append(result?.data?.userLogin?.result?.user?.verification?.isEmailConfirmed as AnyObject)  //Email
                Utility.shared.logindataArray.append(result?.data?.userLogin?.result?.user?.verification?.isIdVerification as AnyObject) //idVerification
                Utility.shared.logindataArray.append(result?.data?.userLogin?.result?.user?.verification?.isGoogleConnected as AnyObject) //GoogleVerification
                Utility.shared.logindataArray.append(result?.data?.userLogin?.result?.user?.verification?.isFacebookConnected as AnyObject) //FacebookConnected
                Utility.shared.user_token = (result?.data?.userLogin?.result?.userToken)!
                Utility.shared.locationfromSearch = ""
                Utility.shared.isfromsearchLocationFilter = false
                Utility.shared.isfromfloatmap_Page = false
                Utility.shared.isfromGuestProfile = false
                if(Utility.shared.searchLocationDict.count > 0)
                {
                    Utility.shared.searchLocationDict.setValue(nil, forKey: "lat")
                    Utility.shared.searchLocationDict.setValue(nil, forKey: "lon")
                }
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                Utility.shared.setTab(index: 0)

//                appDelegate.GuestaddingElementsToObjects()
//                appDelegate.GuestsettingRootViewControllerFunction()

                self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)

                appDelegate.GuestTabbarInitialize(initialView: CustomTabbar())
               
            }else if result?.data?.userLogin?.status == 500 {
                self.lottieView.isHidden = true
                self.lottieWholeView.isHidden = true
               // self.GoBtn.isHidden = true
                self.emailTF.resignFirstResponder()
                self.passwordTF.resignFirstResponder()
                Utility.shared.showAlert(msg: "\((result?.data?.userLogin?.errorMessage)!)")
                
            }
            else{
                //Utility.shared.showAlert(msg:((result?.data?.userLogin?.errorMessage)!))
                self.lottieView.isHidden = true
                self.lottieWholeView.isHidden = true
                self.GoBtn.isHidden = true
                self.passwordTF.resignFirstResponder()
                self.emailTF.resignFirstResponder()
                self.invalidcredentialView.isHidden = false
                if IS_IPHONE_X || IS_IPHONE_XR {
                    self.invalidcredentialView.frame = CGRect(x: 0, y: FULLHEIGHT-80, width: FULLWIDTH, height: 60)
                    
                }
                else{
                    self.invalidcredentialView.frame = CGRect(x: 0, y: FULLHEIGHT-60, width: FULLWIDTH, height: 60)
                }
            }
        }
    }
    
    //Mark: ************************************ Keyboard show/Hide **********************************************>
    
    
    @objc func keyboardWillShow(sender: NSNotification) {
        let info = sender.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
      
        
      //  self.GoBtn.frame.origin.y -= keyboardFrame.height
         //self.GoBtn.frame.origin.y = keyboardFrame.origin.y - 60
        let keyboardHeight = keyboardFrame.height
        Gobtn_Constraints.constant = -5-keyboardHeight
        
        let animationDuration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        let info = sender.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
     
        //self.GoBtn.frame.origin.y = FULLHEIGHT - 100
       Gobtn_Constraints.constant = -35
       
        let animationDuration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
        
       if ((emailTF.text?.isValidEmail())! && ((passwordTF.text?.count)! > 6)) {
            self.configureNextBtn(enable: true)
          
        }
        else{
             self.configureNextBtn(enable: false)
        }
        
    }
    
    fileprivate func emailValidation () {
        
        
        if(pasteEmail.isValidEmail())
        {
            self.emailtickImg.image = nil
            self.emailtickImg.isHidden = false
            let expandTransform:CGAffineTransform = CGAffineTransform(scaleX: 1.15, y: 1.15)
            UIView.transition(with: self.emailtickImg, duration:0.2, options: [.transitionCrossDissolve], animations: {
                self.emailtickImg.image = #imageLiteral(resourceName: "right_white")
                self.emailtickImg.transform = expandTransform
            },
                              completion: {(finished: Bool) in
                                UIView.animate(withDuration: 0.5,
                                               delay:0.0,
                                               usingSpringWithDamping:0.40,
                                               initialSpringVelocity:0.2,
                                               options:UIView.AnimationOptions.curveEaseOut,
                                               animations: {
                                                self.emailtickImg.transform = expandTransform.inverted()
                                }, completion:nil)
            })
        }
        else if (emailTF.text?.isValidEmail())! {
            
            if self.emailtickImg.isHidden {
                
                self.emailtickImg.image = nil
                self.emailtickImg.isHidden = false
                let expandTransform:CGAffineTransform = CGAffineTransform(scaleX: 1.15, y: 1.15)
                UIView.transition(with: self.emailtickImg, duration:0.2, options: [.transitionCrossDissolve], animations: {
                    self.emailtickImg.image = #imageLiteral(resourceName: "right_white")
                    self.emailtickImg.transform = expandTransform
                },
                                  completion: {(finished: Bool) in
                                    UIView.animate(withDuration: 0.5,
                                                   delay:0.0,
                                                   usingSpringWithDamping:0.40,
                                                   initialSpringVelocity:0.2,
                                                   options:UIView.AnimationOptions.curveEaseOut,
                                                   animations: {
                                                    self.emailtickImg.transform = expandTransform.inverted()
                                    }, completion:nil)
                })
                
                
            }
            
        }else {
            
            if !self.emailtickImg.isHidden {
                
                UIView.animate(withDuration: 0.2, delay: 0, options: [.transitionCrossDissolve], animations: {
                    
                    self.emailtickImg.alpha = 0
                    self.GoBtn.isUserInteractionEnabled = false
                    self.GoBtn.alpha = 0.7
                   
                }, completion: { (comp) in
                    
                    self.emailtickImg.isHidden = true
                    self.emailtickImg.alpha = 1
                    self.emailtickImg.image = nil
                    self.configureNextBtn(enable: false)
                   
                })
                
            }
            else if (emailTF.text?.isValidEmail())! {
            
                self.view.endEditing(true)
               self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"email_validalert"))!)")
            }
            
        }
        
    }
    
    
    
    
    fileprivate func passwordValidation () {
        
        if (self.passwordTF.text?.count)! > 6{
            
            if self.passwordtickImg.isHidden {
                
                self.passwordtickImg.image = nil
                self.passwordtickImg.isHidden = false
                let expandTransform:CGAffineTransform = CGAffineTransform(scaleX: 1.15, y: 1.15)
                UIView.transition(with: self.passwordtickImg, duration:0.2, options: [.transitionCrossDissolve], animations: {
                    self.passwordtickImg.image = #imageLiteral(resourceName: "right_white")
                    self.passwordtickImg.transform = expandTransform
                },
                                  completion: {(finished: Bool) in
                                    UIView.animate(withDuration: 0.5,
                                                   delay:0.0,
                                                   usingSpringWithDamping:0.40,
                                                   initialSpringVelocity:0.2,
                                                   options:UIView.AnimationOptions.curveEaseOut,
                                                   animations: {
                                                    self.passwordtickImg.transform = expandTransform.inverted()
                                    }, completion:nil)
                })
                
                
            }
            
        }else {
            
            
            if !self.passwordtickImg.isHidden {
                
                UIView.animate(withDuration: 0.2, delay: 0, options: [.transitionCrossDissolve], animations: {
                    
                    self.passwordtickImg.alpha = 0
                    self.GoBtn.isUserInteractionEnabled = false
                    self.GoBtn.alpha = 0.7
                   
                }, completion: { (comp) in
                    
                    self.passwordtickImg.isHidden = true
                    self.passwordtickImg.alpha = 1
                    self.passwordtickImg.image = nil
                    self.configureNextBtn(enable: false)
                })
                
            }
        }
        
    }
    
    func goLogin()
    {
        
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
//Mark: ****************************************************** Textfield Delegate Methods *************************************************************>

extension LoginPageVC:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.endEditing(true)
        
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.GoBtn.isHidden = false
        self.invalidcredentialView.isHidden = true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        
        if textField == emailTF {
            if string.count > 1{
            
                pasteEmail = string
               //emailTF.text = string
            }
            else if(string.count == 0)
            {
                pasteEmail = textField.text!
            }
           
              self.emailValidation()
            self.passwordTF.resignFirstResponder()
            
            
        }else if textField == passwordTF {
            if string.count > 1{
                pastePassword = string
            }
            else if(string.count == 0)
            {
                pastePassword = textField.text!
            }
                self.passwordValidation()
            self.emailTF.resignFirstResponder()
        }
        if ((emailTF.text?.isValidEmail())! && ((passwordTF.text?.count)! > 6)) {
            
            self.GoBtn.isUserInteractionEnabled = true
            self.GoBtn.alpha = 1.0
            
        }else {
            
            self.GoBtn.isUserInteractionEnabled = false
            self.GoBtn.alpha = 0.7
        }
        return true
    }
    
     @objc func textFieldDidChange(_ textField: UITextField) {
        
        if textField == emailTF {
            
            self.emailValidation()
        }
        else
        {
            self.passwordValidation()
        }
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if Utility.shared.isConnectedToNetwork(){
            if textField == emailTF {
                if !(emailTF.text?.isValidEmail())!{
                    self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"email_validalert"))!)")
                }
            }
        }else{
            self.offelineView.isHidden = false
            if IS_IPHONE_X || IS_IPHONE_XR {
                self.offelineView.frame = CGRect(x: 0, y: FULLHEIGHT-80, width: FULLWIDTH, height: 60)
            }
            else{
                self.offelineView.frame = CGRect(x: 0, y: FULLHEIGHT-60, width: FULLWIDTH, height: 60)
            }
            let shadowSize2 : CGFloat = 3.0
            let shadowPath2 = UIBezierPath(rect: CGRect(x: -shadowSize2 / 2,
                                                        y: -shadowSize2 / 2,
                                                        width: self.offelineView.frame.size.width + shadowSize2,
                                                        height: self.offelineView.frame.size.height + shadowSize2))
            self.offelineView.layer.masksToBounds = false
            self.offelineView.layer.shadowColor = TextLightColor.cgColor
            self.offelineView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            self.offelineView.layer.shadowOpacity = 0.3
        }
    }
}

//
//  ResetPasswordVC.swift
//  Rent_All
//
//  Created by RadicalStart on 12/04/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Lottie
import IQKeyboardManagerSwift

class ResetPasswordVC: UIViewController {
//Mark:*********************************  Outlet Connections   ********************************************************>
    @IBOutlet weak var resetPasswordView: UIView!
    @IBOutlet weak var confirmTick: UIImageView!
    @IBOutlet weak var newtick: UIImageView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var lottieView: LOTAnimationView!
    @IBOutlet weak var offlineView: UIView!
    
    @IBOutlet var reset_title_label: UILabel!
    @IBOutlet var error_Label: UILabel!
    @IBOutlet var reset_titleDes_Label: UILabel!
    @IBOutlet var newPassword_label: UILabel!
    @IBOutlet var confirmpassword_label: UILabel!
    @IBOutlet var newShow_button: UIButton!
    @IBOutlet var confirmShow_button: UIButton!
    
    @IBOutlet var retry_button: UIButton!
    
    //Mark: ***************************** Global Variable Declaration *********************************************************>
    var newpasswordShow = true
    var confirmpasswordShow = true
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.initialSetup()
        if Utility.shared.isConnectedToNetwork() {
            offlineView.isHidden = true
        }
        
        self.setupToHideKeyboardOnTapOnView()
        // Do any additional setup after loading the view.
    }
//Mark:******************************** Button Actions ***********************************************************************>
    @IBAction func confirmshowTapped(_ sender: Any) {
        if(confirmpasswordShow){
            confirmPasswordTF.isSecureTextEntry = false
            confirmShow_button.setTitle("\((Utility.shared.getLanguage()?.value(forKey: "hide"))!)", for: .normal)
            confirmShow_button.titleLabel?.font =  UIFont(name:"Circular-Book", size:14)!
        }
        else {
            confirmPasswordTF.isSecureTextEntry = true
            confirmShow_button.setTitle("\((Utility.shared.getLanguage()?.value(forKey: "show"))!)", for: .normal)
            confirmShow_button.titleLabel?.font =  UIFont(name:"Circular-Book", size:14)!
        }
        confirmpasswordShow = !confirmpasswordShow
    }
    
    @IBAction func retryTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            self.offlineView.isHidden = true
        }
        
    }
    @IBAction func newshowTapped(_ sender: Any) {
        
        if(newpasswordShow){
            newPasswordTF.isSecureTextEntry = false
            newShow_button.setTitle("\((Utility.shared.getLanguage()?.value(forKey: "hide"))!)", for: .normal)
            newShow_button.titleLabel?.font =  UIFont(name:"Circular-Book", size:14)!
        }
        else {
            newPasswordTF.isSecureTextEntry = true
            newShow_button.setTitle("\((Utility.shared.getLanguage()?.value(forKey: "show"))!)", for: .normal)
            newShow_button.titleLabel?.font =  UIFont(name:"Circular-Book", size:14)!
        }
        newpasswordShow = !newpasswordShow
    }
    func initialSetup()
    {
        resetPasswordView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height: FULLHEIGHT)
        newtick.isHidden = true
        confirmTick.isHidden = true
        lottieView.isHidden = true
        
        self.resetPasswordView.applyGradient(colours:PRIMARY_COLOR)
        self.view.applyGradient(colours: PRIMARY_COLOR)
        newPasswordTF.text = ""
        confirmPasswordTF.text = ""
        nextBtn.layer.cornerRadius = nextBtn.frame.size.width/2
        nextBtn.clipsToBounds = true
        newPasswordTF.becomeFirstResponder()

        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        newPasswordTF.autocorrectionType = UITextAutocorrectionType.no
        newPasswordTF.autocorrectionType = UITextAutocorrectionType.no
        confirmPasswordTF.autocorrectionType = UITextAutocorrectionType.no
        confirmPasswordTF.autocorrectionType = UITextAutocorrectionType.no
        
        newPasswordTF.keyboardType = .asciiCapable
        confirmPasswordTF.keyboardType = .asciiCapable
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        lottieView = LOTAnimationView.init(name: "loading")
        self.bottomView.frame.origin.y = FULLHEIGHT - 85
        
        
        error_Label.text = "\((Utility.shared.getLanguage()?.value(forKey: "error_field"))!)"
        retry_button.setTitle("\((Utility.shared.getLanguage()?.value(forKey: "retry"))!)", for: .normal)
        reset_title_label.text = "\((Utility.shared.getLanguage()?.value(forKey: "reset_title"))!)"
        reset_titleDes_Label.text = "\((Utility.shared.getLanguage()?.value(forKey: "reset_des"))!)"
        reset_titleDes_Label.textColor = .white
        newPassword_label.text = "\((Utility.shared.getLanguage()?.value(forKey: "new_password"))!)"
        confirmpassword_label.text = "\((Utility.shared.getLanguage()?.value(forKey: "confirm_password"))!)"
        newShow_button.setTitle("\((Utility.shared.getLanguage()?.value(forKey: "show"))!)", for: .normal)
        confirmShow_button.setTitle("\((Utility.shared.getLanguage()?.value(forKey: "show"))!)", for: .normal)
        
        
        
        
    }
    func configureNextBtn(enable:Bool){
        if(enable){
            self.nextBtn.isUserInteractionEnabled = true
            self.nextBtn.alpha = 1.0
        }
        else {
            self.nextBtn.isUserInteractionEnabled = false
            self.nextBtn.alpha = 0.7
        }
        
    }
    //Mark: ************************************ Keyboard show/Hide **********************************************>
    
    
    @objc func keyboardWillShow(sender: NSNotification) {
        let info = sender.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        
        //  self.GoBtn.frame.origin.y -= keyboardFrame.height
      //  self.bottomView.frame.origin.y = keyboardFrame.origin.y - 68
        
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        let info = sender.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
      //  self.bottomView.frame.origin.y = FULLHEIGHT - 85
        
        if (!((Utility.shared.checkEmptyWithString(value: newPasswordTF.text!)) && (Utility.shared.checkEmptyWithString(value: confirmPasswordTF.text!)))) {
            self.configureNextBtn(enable: true)
            
        }
        else{
            self.configureNextBtn(enable: false)
        }
        
    }
    
    fileprivate func passwordValidation () {
        
        if ((self.newPasswordTF.text?.count)! >= 7) {
            
            if self.newtick.isHidden {
                
                self.newtick.image = nil
                self.newtick.isHidden = false
                let expandTransform:CGAffineTransform = CGAffineTransform(scaleX: 1.15, y: 1.15)
                UIView.transition(with: self.newtick, duration:0.2, options: [.transitionCrossDissolve], animations: {
                    self.newtick.image = #imageLiteral(resourceName: "right_white")
                    self.newtick.transform = expandTransform
                },
                                  completion: {(finished: Bool) in
                                    UIView.animate(withDuration: 0.5,
                                                   delay:0.0,
                                                   usingSpringWithDamping:0.40,
                                                   initialSpringVelocity:0.2,
                                                   options:UIView.AnimationOptions.curveEaseOut,
                                                   animations: {
                                                    self.newtick.transform = expandTransform.inverted()
                                    }, completion:nil)
                })
                
                
            }
            
        }else {
            
            
            if !self.newtick.isHidden {
                
                UIView.animate(withDuration: 0.2, delay: 0, options: [.transitionCrossDissolve], animations: {
                    
                    self.newtick.alpha = 0
                    self.nextBtn.isUserInteractionEnabled = false
                    self.nextBtn.alpha = 0.7
                    
                }, completion: { (comp) in
                    
                    self.newtick.isHidden = true
                    self.newtick.alpha = 1
                    self.newtick.image = nil
                    self.configureNextBtn(enable: false)
                })
                
            }
        }
        
    }
    
    
    fileprivate func confirmpasswordValidation () {
        
        if ((self.confirmPasswordTF.text?.count)! >= 7) {
            
            if self.confirmTick.isHidden {
                
                self.confirmTick.image = nil
                self.confirmTick.isHidden = false
                let expandTransform:CGAffineTransform = CGAffineTransform(scaleX: 1.15, y: 1.15)
                UIView.transition(with: self.confirmTick, duration:0.2, options: [.transitionCrossDissolve], animations: {
                    self.confirmTick.image = #imageLiteral(resourceName: "right_white")
                    self.confirmTick.transform = expandTransform
                },
                                  completion: {(finished: Bool) in
                                    UIView.animate(withDuration: 0.5,
                                                   delay:0.0,
                                                   usingSpringWithDamping:0.40,
                                                   initialSpringVelocity:0.2,
                                                   options:UIView.AnimationOptions.curveEaseOut,
                                                   animations: {
                                                    self.confirmTick.transform = expandTransform.inverted()
                                    }, completion:nil)
                })
                
                
            }
            
        }else {
            
            
            if !self.confirmTick.isHidden || confirmPasswordTF.text?.count == 0{
                
                UIView.animate(withDuration: 0.2, delay: 0, options: [.transitionCrossDissolve], animations: {
                    
                    self.confirmTick.alpha = 0
                    self.nextBtn.isUserInteractionEnabled = false
                    self.nextBtn.alpha = 0.7
                    
                }, completion: { (comp) in
                    
                    self.confirmTick.isHidden = true
                    self.confirmTick.alpha = 1
                    self.confirmTick.image = nil
                    self.configureNextBtn(enable: false)
                })
                
            }
        }
        
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        
        if ((Utility.shared.getCurrentUserToken()) == nil || (Utility.shared.getCurrentUserToken()) == ""){
            let WelcomeVc = WelcomePageVC()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.setInitialViewController(initialView: WelcomeVc)
            
        }else{
               self.dismiss(animated: true, completion: nil)
        }
      
      //  self.navigationController?.popViewController(animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func nextButton_Tapped(_ sender: Any) {
        if Utility.shared.isConnectedToNetwork(){
            
            
            if newPasswordTF.text!.count >= 8 && confirmPasswordTF.text!.count >= 3{
                
                if newPasswordTF.text == confirmPasswordTF.text {
                    let resetpass = ResetPasswordMutation(email: Utility.shared.deepLinkEmail, password: newPasswordTF.text!, token: Utility.shared.deepLinkToken)
                    apollo.perform(mutation: resetpass){ (result,error)in
                        print(result?.data?.updateForgotPassword?.status == 200)
                        if result?.data?.updateForgotPassword?.status == 200 {
                            
                            let alert = UIAlertController(title: "\((Utility.shared.getLanguage()?.value(forKey: "success"))!)", message: "\((Utility.shared.getLanguage()?.value(forKey: "Password_reset"))!)", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "\((Utility.shared.getLanguage()?.value(forKey: "okay"))!)", style: .default, handler: { (NavigatingtoLogin) in
                                let logpage = LoginPageVC()
                                logpage.modalPresentationStyle = .fullScreen
                                self.present(logpage, animated: false, completion: nil)
                                
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }else{
                            
                            

                            let alert = UIAlertController(title: "\((Utility.shared.getLanguage()?.value(forKey: "oops"))!)", message: "\((result?.data?.updateForgotPassword?.errorMessage)!)", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "\((Utility.shared.getLanguage()?.value(forKey: "okay"))!)", style: .default, handler: { (NavigatingtoLogin) in
                                let welcomeObj = WelcomePageVC()
                                welcomeObj.modalPresentationStyle = .fullScreen
                                self.present(welcomeObj, animated:false, completion: nil)
                                
                            }))
                            self.present(alert, animated: true, completion: nil)
                           // self.view.makeToast("\(String(describing: result?.data?.updateForgotPassword?.errorMessage))")
                        }
                    }
                    
                }else{
                    self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey: "mismatch_password"))!)")
                }
                
            }else{
                
                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey: "passcode_count"))!)")
            }

        }else{
            offlineView.isHidden = false
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
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-75, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-55, width: FULLWIDTH, height: 55)
            }
        }
        
    }
    
}
//Mark: ****************************************************** Textfield Delegate Methods *************************************************************>
extension ResetPasswordVC
{
    func setupToHideKeyboardOnTapOnView()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(ResetPasswordVC.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
extension ResetPasswordVC:UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        newPasswordTF.autocorrectionType = UITextAutocorrectionType.no
        newPasswordTF.autocorrectionType = UITextAutocorrectionType.no
        confirmPasswordTF.autocorrectionType = UITextAutocorrectionType.no
        confirmPasswordTF.autocorrectionType = UITextAutocorrectionType.no
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        
        
        
        if textField == newPasswordTF {
            
            
            self.passwordValidation()
            
        }else if textField == confirmPasswordTF {
            
            
            self.confirmpasswordValidation()
            
        }
        if (((newPasswordTF.text?.count)! >= 7) && ((confirmPasswordTF.text?.count)! >= 7)){
            
            self.nextBtn.isUserInteractionEnabled = true
            self.nextBtn.alpha = 1.0
            
        }else {
            
            self.nextBtn.isUserInteractionEnabled = false
            self.nextBtn.alpha = 0.7
        }
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                print("Backspace was pressed")
                if textField == newPasswordTF {
                    
                    if ((newPasswordTF.text?.count)! <= 7) {
                        self.newtick.isHidden = true
                        self.newtick.alpha = 1
                        self.newtick.image = nil
                    }
                    

                    
                }else if textField == confirmPasswordTF {
                    if ((confirmPasswordTF.text?.count)! <= 7){
                        
                        self.confirmTick.isHidden = true
                        self.confirmTick.alpha = 1
                        self.confirmTick.image = nil
                    }

                    
                }
            }
        }
        
        return true
        
    }
    
    
    
}

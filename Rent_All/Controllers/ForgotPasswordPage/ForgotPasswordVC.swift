//
//  ForgotPasswordVC.swift
//  Rent_All
//
//  Created by RADICAL START on 20/03/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Lottie

class ForgotPasswordVC: UIViewController {
    
    //Mark:******************************************* Outlet Connections **************************************************>
    
    @IBOutlet var forgotView: UIView!
    @IBOutlet var nextbtn: UIButton!
    @IBOutlet var forgotTF: UITextField!
    
   
    @IBOutlet var lottieView: LOTAnimationView!
    @IBOutlet var forgotTickImg: UIImageView!
    @IBOutlet var backBtn: UIButton!
    
    @IBOutlet var forgot_label: UILabel!
    
    @IBOutlet var forgot_description_label: UILabel!
    
    @IBOutlet var email_label: UILabel!
    
    @IBOutlet weak var Offline_View: UIView!
    
    @IBOutlet weak var retry_Btn: UIButton!
    @IBOutlet weak var Error_label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        if Utility.shared.isConnectedToNetwork() {
            Offline_View.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    //Mark:******************************************* Button Actions ******************************************************>
    
    @IBAction func backBtnTapped(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
        //self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextActionTapped(_ sender: Any) {
        forgotView.resignFirstResponder()
        lottieView.isHidden = false
        lottieView.frame = CGRect(x:FULLWIDTH/2-40, y: FULLHEIGHT/2-40, width: 80, height: 80)
        forgotView.addSubview(lottieView)
         lottieView.backgroundColor = UIColor.white
        lottieView.layer.cornerRadius = 6.0
        lottieView.clipsToBounds = true
       // self.view.bringSubviewToFront(self.lottieView)
       self.view.endEditing(true)
        lottieView.play()
        
        self.sendEmail()
       // self.navigationController?.popViewController(animated: true)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func initialSetup()
    {
        forgotView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height: FULLHEIGHT)
         forgotTF.autocorrectionType = UITextAutocorrectionType.no
        forgotTickImg.isHidden = true
        nextbtn.layer.cornerRadius = nextbtn.frame.size.width/2
        nextbtn.clipsToBounds = true
        forgotTF.becomeFirstResponder()
        lottieView.isHidden = true
        
        if (!(Utility.shared.checkEmptyWithString(value: forgotTF.text!))) {
            self.configureNextBtn(enable: true)
            
        }
        else{
            self.configureNextBtn(enable: false)
        }
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        lottieView = LOTAnimationView.init(name: "loading")
       
        
        forgotTF.addTarget(self, action: #selector(ForgotPasswordVC.textFieldDidChange(_:)),
                          for: UIControl.Event.editingChanged)
       // lottieView.frame = CGRect(x: 100, y: 300, width: 80, height: 80)
        
        
        forgot_label.text = "\((Utility.shared.getLanguage()?.value(forKey: "Forgot_password"))!)"
        forgot_description_label.text = "\((Utility.shared.getLanguage()?.value(forKey: "forgot_description"))!)"
        email_label.text = "\((Utility.shared.getLanguage()?.value(forKey: "email_address"))!)"
        Error_label.text = "\((Utility.shared.getLanguage()?.value(forKey: "error_field"))!)"
        retry_Btn.setTitle("\((Utility.shared.getLanguage()?.value(forKey: "retry"))!)", for: .normal)
        
      //  Offline_View.isHidden = false
        let shadowSize2 : CGFloat = 3.0
        let shadowPath2 = UIBezierPath(rect: CGRect(x: -shadowSize2 / 2,
                                                    y: -shadowSize2 / 2,
                                                    width: self.Offline_View.frame.size.width + shadowSize2,
                                                    height: self.Offline_View.frame.size.height + shadowSize2))
        
        self.Offline_View.layer.masksToBounds = false
        self.Offline_View.layer.shadowColor = TextLightColor.cgColor
        self.Offline_View.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.Offline_View.layer.shadowOpacity = 0.3
        self.Offline_View.layer.shadowPath = shadowPath2.cgPath
        if IS_IPHONE_X || IS_IPHONE_XR{
            Offline_View.frame = CGRect.init(x: 0, y: FULLHEIGHT-75, width: FULLWIDTH, height: 55)
        }else{
            Offline_View.frame = CGRect.init(x: 0, y: FULLHEIGHT-55, width: FULLWIDTH, height: 55)
        }
        
        self.forgotView.applyGradient(colours:PRIMARY_COLOR)
        self.view.applyGradient(colours: PRIMARY_COLOR)
        
    }
    func configureNextBtn(enable:Bool){
        if(enable){
            self.nextbtn.isUserInteractionEnabled = true
            self.nextbtn.alpha = 1.0
        }
        else {
            self.nextbtn.isUserInteractionEnabled = false
            self.nextbtn.alpha = 0.7
        }
        
    }
    
    //Mark: ************************************ Keyboard show/Hide *************************************************************>
    @IBAction func retry_Tapped(_ sender: Any) {
        
        if Utility().isConnectedToNetwork(){
            self.Offline_View.isHidden = true
        }
    }
    
    
    @objc func keyboardWillShow(sender: NSNotification) {
        let info = sender.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        
        //  self.GoBtn.frame.origin.y -= keyboardFrame.height
        self.nextbtn.frame.origin.y = keyboardFrame.origin.y - 60
        
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        let info = sender.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        self.nextbtn.frame.origin.y = FULLHEIGHT - 100
        
        if (!(Utility.shared.checkEmptyWithString(value: forgotTF.text!))) {
            self.configureNextBtn(enable: true)
            
        }
        else{
            self.configureNextBtn(enable: false)
        }
        
    }
    
    fileprivate func emailValidation () {
        
        if (forgotTF.text?.isValidEmail())! {
            
            if self.forgotTickImg.isHidden {
                
                self.forgotTickImg.image = nil
                self.forgotTickImg.isHidden = false
                let expandTransform:CGAffineTransform = CGAffineTransform(scaleX: 1.15, y: 1.15)
                UIView.transition(with: self.forgotTickImg, duration:0.2, options: [.transitionCrossDissolve], animations: {
                    self.forgotTickImg.image = #imageLiteral(resourceName: "right_white")
                    self.forgotTickImg.transform = expandTransform
                },
                                  completion: {(finished: Bool) in
                                    UIView.animate(withDuration: 0.5,
                                                   delay:0.0,
                                                   usingSpringWithDamping:0.40,
                                                   initialSpringVelocity:0.2,
                                                   options:UIView.AnimationOptions.curveEaseOut,
                                                   animations: {
                                                    self.forgotTickImg.transform = expandTransform.inverted()
                                    }, completion:nil)
                })
                
                
            }
            
        }else {
            
            if !self.forgotTickImg.isHidden {
                
                UIView.animate(withDuration: 0.2, delay: 0, options: [.transitionCrossDissolve], animations: {
                    
                    self.forgotTickImg.alpha = 0
                    self.nextbtn.isUserInteractionEnabled = false
                    self.nextbtn.alpha = 0.7
                    
                }, completion: { (comp) in
                    
                    self.forgotTickImg.isHidden = true
                    self.forgotTickImg.alpha = 1
                    self.forgotTickImg.image = nil
                    self.configureNextBtn(enable: false)
                    
                })
                
            }
            else if (forgotTF.text?.isValidEmail())! {
                
                self.view.endEditing(true)
                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"email_validalert"))!)")
            }
            
        }
        
    }
    
    func sendEmail()
    {
        if Utility.shared.isConnectedToNetwork(){
            
            self.Offline_View.isHidden = true
            let forgotmutation = ForgotPasswordMutation(email:forgotTF.text!)
            apollo.perform(mutation: forgotmutation){(result,error) in
                print(result?.data?.userForgotPassword?.status as Any)
                if result?.data?.userForgotPassword?.status == 200 {
                    print(result?.data?.userForgotPassword?.resultMap)
                    self.lottieView.isHidden = true

                    let alert = UIAlertController(title: "\((Utility.shared.getLanguage()?.value(forKey: "success"))!)", message: "\((Utility.shared.getLanguage()?.value(forKey: "email_sent_success"))!)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "\((Utility.shared.getLanguage()?.value(forKey: "okay"))!)", style: .default, handler: { (NavigatingtoLogin) in
                        let logpage = LoginPageVC()
                        logpage.modalPresentationStyle = .fullScreen
                        self.present(logpage, animated: false, completion: nil)
                        
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
                    
                    
                }else{
                    self.lottieView.isHidden = true
                     self.view.makeToast(result?.data?.userForgotPassword?.errorMessage)
                }
               
                }
        }else{
            self.lottieView.isHidden = true
            self.Offline_View.isHidden = false
            //self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey: "network_check"))!)")
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

//Mark: ****************************************************** Textfield Delegate Methods *************************************************************>

extension ForgotPasswordVC:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        
        
        
        if textField == forgotTF {
            
            
            self.emailValidation()
        }
        if (forgotTF.text?.isValidEmail())! {
            
            self.nextbtn.isUserInteractionEnabled = true
            self.nextbtn.alpha = 1.0
            
        }else {
            
            self.nextbtn.isUserInteractionEnabled = false
            self.nextbtn.alpha = 0.7
        }
        
        
        return true
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if textField == forgotTF {
            
            self.emailValidation()
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if Utility.shared.isConnectedToNetwork(){
            if textField == forgotTF {
                if !(forgotTF.text?.isValidEmail())!{
                    
                    self.nextbtn.isUserInteractionEnabled = false
                    self.nextbtn.alpha = 0.7
                }
            }
        }
        
    }
}

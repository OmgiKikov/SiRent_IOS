//
//  CreateListVC.swift
//  Rent_All
//
//  Created by RadicalStart on 08/07/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Lottie
import Apollo

class CreateListVC: UIViewController {

    @IBOutlet weak var createTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var retryBtn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var offlineView: UIView!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var topView: UIView!
    var lottieView: LOTAnimationView!
    let apollo_headerClient: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
        
        let url = URL(string:graphQLEndpoint)!
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()

        // Do any additional setup after loading the view.
    }

    func initialSetup()
    {
        self.offlineView.isHidden = true
        self.createBtn.layer.cornerRadius = 6.0
        self.createBtn.layer.masksToBounds = true
        let shadowSize : CGFloat = 3.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.topView.frame.size.width + shadowSize,
                                                   height: self.topView.frame.size.height + shadowSize))
        
        self.topView.layer.masksToBounds = false
        self.topView.layer.shadowColor = TextLightColor.cgColor
        self.topView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.topView.layer.shadowOpacity = 0.3
        self.topView.layer.shadowPath = shadowPath.cgPath
        titleTF.becomeFirstResponder()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        createBtn.backgroundColor  = Theme.PRIMARY_COLOR
        errorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
        retryBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
        createBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"create"))!)", for:.normal)
         titleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"title"))!)"
         createTitleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"createlist"))!)"
        
        
    }
    func configureNextBtn(enable:Bool){
        if(enable){
            self.createBtn.isUserInteractionEnabled = true
            self.createBtn.alpha = 1.0
        }
        else {
            self.createBtn.isUserInteractionEnabled = false
            self.createBtn.alpha = 0.7
        }
        
    }
    func lottieanimation()
    {
        createBtn.setTitle("", for:.normal)
        lottieView = LOTAnimationView.init(name: "animation_white")
        
        self.lottieView.isHidden = false
        self.lottieView.frame = CGRect(x:createBtn.frame.size.width/2-60, y:-25, width:100, height:100)
        self.createBtn.addSubview(self.lottieView)
        self.lottieView.backgroundColor = UIColor.clear
        self.lottieView.play()
        // animation_white.json
        Timer.scheduledTimer(timeInterval:0.3, target: self, selector: #selector(autoscroll), userInfo: nil, repeats: true)
    }
    @objc func autoscroll()
    {
        self.lottieView.play()
    }
    func createWhishlistAPICall()
    {
         if Utility().isConnectedToNetwork(){
            let createWhishlistMutation = CreateWishListGroupMutation(name:titleTF.text!)
            apollo_headerClient.perform(mutation: createWhishlistMutation){(result,error) in
                
                if(result?.data?.createWishListGroup?.status == 200)
                {
                   
                    self.createBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"create"))!)", for: .normal)
                    //self.view.makeToast("Your message sent to the host")
                     self.lottieView.isHidden = true
                    
                    self.dismiss(animated: true, completion: nil)
                    return
                }
                else
                {
                    self.view.makeToast(result?.data?.createWishListGroup?.errorMessage)
                }
            
        }
         }
        else
         {
            self.lottieView.isHidden = true
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
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-130, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
            }
        }
    }
    //Mark: ************************************ Keyboard show/Hide **********************************************>
    
    
    @objc func keyboardWillShow(sender: NSNotification) {
        let info = sender.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        
        //  self.GoBtn.frame.origin.y -= keyboardFrame.height
        self.createBtn.frame.origin.y = keyboardFrame.origin.y - 75
        
        
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        let info = sender.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        self.createBtn.frame.origin.y = FULLHEIGHT - 90
//        
//        if(!((Utility.shared.checkEmptyWithString(value:titleTF.text!)))) {
//            self.configureNextBtn(enable: true)
//            
//        }
//        else{
//            self.configureNextBtn(enable: false)
//        }
        
    }

    @IBAction func closeBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
        titleTF.resignFirstResponder()
            if(titleTF.text!.isBlank)
        {
            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"eneterwhishlisttitle"))!)")
            }else if titleTF.text!.containsSpecialCharacter {
                
                self.view.makeToast("No Special Characters are allowed")
            }
        else{
            self.lottieanimation()
            self.createWhishlistAPICall()
            
        }
        }
        else{
            self.titleTF.resignFirstResponder()
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
        self.offlineView.isHidden = true
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
extension String {
   var containsSpecialCharacter: Bool {
      let regex = ".*[^A-Za-z0-9 ].*"
      let testString = NSPredicate(format:"SELF MATCHES %@", regex)
      return testString.evaluate(with: self)
   }
}
extension CreateListVC:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        
        return true
    }
    
    //    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    //
    //        let currentCharacterCount = textField.text?.count ?? 0
    //        if range.length + range.location > currentCharacterCount {
    //            return false
    //        }
    //        let newLength = currentCharacterCount + string.count - range.length
    //        return newLength <= 25
    //    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        
        let currenctCharacterCount = textField.text?.count ?? 0
        if range.length + range.location > currenctCharacterCount {
            return false
            
        }else{
            
            let length = currenctCharacterCount + string.count - range.length
            if range.location > 0 && string.count > 0{
                let whitespace = CharacterSet.whitespaces
                //get list of whitespace characters

                let start = string.unicodeScalars.startIndex
                if let textFieldText = textField.text{
                    let location = textFieldText.unicodeScalars.index(textFieldText.unicodeScalars.startIndex, offsetBy: range.location - 1)

                    //Check if a space follows a space
                    if whitespace.contains(string.unicodeScalars[start]) && whitespace.contains(textFieldText.unicodeScalars[location]){

                        //Manually replace the space with your own space, programmatically
                        textField.text = (textFieldText as NSString?)?.replacingCharacters(in: range, with: " ")

                        if let pos = textField.position(from: textField.beginningOfDocument, offset: range.location + 1)
                        {
                            //Make sure you update the text caret to reflect the programmatic change to the text view
                            textField.selectedTextRange = textField.textRange(from: pos, to: pos)


                            //Tell UIKit not to insert its space, because you've just inserted your own
                            return false
                        }
                    }
                }
            }
            //return true
            return length <= 50
        }
        

        
//        if Utility.shared.checkEmptyWithString(value: titleTF.text!)
//        {
//            configureNextBtn(enable: false)
//        }
//        else
//        {
//            configureNextBtn(enable: true)
//        }
       // return true
        
        
    }
    
    
    
    
}

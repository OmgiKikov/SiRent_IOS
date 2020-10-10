//
//  AboutmeVC.swift
//  Rent_All
//
//  Created by RadicalStart on 09/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Apollo

class AboutmeVC: UIViewController,UITextViewDelegate{
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var aboutTxtView: UITextView!
    var aboutvaluArray = GetProfileQuery.Data.UserAccount.Result()
    let apollo_headerClient: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
        
        let url = URL(string:graphQLEndpoint)!
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        aboutTxtView.becomeFirstResponder()
        IQKeyboardManager.shared.enable = false
        if(Utility.shared.isaboutmechanged)
        {
         aboutTxtView.text = Utility.shared.aboutme_Name
         
         self.countLabel.text =  "\(aboutTxtView.text.count)/250" 
        }
        else {
        if(aboutvaluArray.info != "" && aboutvaluArray.info != nil)
        {
        let trimToCharacter = 250
        let shortString = "\(aboutvaluArray.info!.prefix(trimToCharacter))"
        aboutTxtView.text = shortString
        self.countLabel.text =  "\(aboutTxtView.text.count)/250"
        }
        }
        aboutTxtView.autocorrectionType = UITextAutocorrectionType.no
        let toolBar = UIToolbar().ToolbarPikerSelect(mySelect: #selector(dismissPicker))
        aboutTxtView.inputAccessoryView = toolBar
        saveBtn.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
        countLabel.textColor = Theme.PRIMARY_COLOR
        
        
        titleLbl.text = "\((Utility.shared.getLanguage()?.value(forKey:"aboutme"))!)"
        subTitleLbl.text = "\((Utility.shared.getLanguage()?.value(forKey:"about_desc"))!)"
        saveBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"save"))!)", for:.normal)
 
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)

        
        // Do any additional setup after loading the view.
    }
    @objc func dismissPicker()
    {
        view.endEditing(true)
        
    }
    @IBAction func closeBtnTapped(_ sender: Any){
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        self.view.endEditing(true)
        if(aboutTxtView.text != ""){
        Utility.shared.isaboutmechanged = true
        Utility.shared.aboutme_Name = aboutTxtView.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        self.EditProfileAPICall(fieldName: "info", fieldValue:aboutTxtView.text!.trimmingCharacters(in: .whitespacesAndNewlines))
        self.dismiss(animated: true, completion: nil)
        }
        else{
            self.view.makeToast("About Required")
        }
    }
    func EditProfileAPICall(fieldName:String,fieldValue:String)
    {
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
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            let descriptionCount = (textView.text.count + (text.count - range.length))
        
            return textView.text.count + (text.count - range.length) <= 250
    }
  

    @objc func keyboardWillShow(sender: NSNotification) {
         //  if Utility().isConnectedToNetwork(){
           
           
           
           let info = sender.userInfo!
           let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
       
        self.aboutTxtView.frame.size.height = (keyboardFrame.origin.y - self.aboutTxtView.frame.origin.y)-20
        
    }
    @objc func keyboardWillHide(sender: NSNotification) {
        
       // if Utility().isConnectedToNetwork(){
        let info = sender.userInfo!
      //  self.inboxlistingTable.frame.size.height += keyboardFrame.height-10
        self.aboutTxtView.frame.size.height = FULLHEIGHT - self.aboutTxtView.frame.origin.y

        
    }
   func textViewDidChange(_ textView: UITextView)
   {
    let text = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
    self.countLabel.text = "\(text.count)/250"
    }
}

//
//  ListingDescriptionVC.swift
//  Rent_All
//
//  Created by RadicalStart on 30/07/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Apollo


class ListingDescriptionVC: UIViewController,UITextViewDelegate {

    @IBOutlet weak var retryBtn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var editdescTitleLabel: UILabel!
    @IBOutlet weak var offlineView: UIView!
    @IBOutlet weak var nextimg: UIImageView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var descriptionTV: UITextView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var Bottom_label: UILabel!
    var placeholderLabel : UILabel!
    
    var getListingStep2Array = GetListingDetailsStep2Query.Data.GetListingDetail.Result()
    
    var apollo_headerClient: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
        
        let url = URL(string:graphQLEndpoint)!
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()
    var saveexit_Activated = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialsetup()

        // Do any additional setup after loading the view.
    }

    func offlineviewShow()
    {
        self.offlineView.isHidden = false
         self.nextBtn.isHidden = true
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
        self.view.addSubview(offlineView)
        if IS_IPHONE_X || IS_IPHONE_XR{
            offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-85, width: FULLWIDTH, height: 55)
        }else{
            offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-55, width: FULLWIDTH, height: 55)
        }
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            self.view.endEditing(true)
        //self.view.window!.layer.add(dismissrightAnimation()!, forKey: kCATransition)
         self.dismiss(animated: true, completion: nil)
        }
        else
        {
            self.offlineviewShow()
        }
    }
    @IBAction func nextBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
        let text_Title = descriptionTV.text.trimmingCharacters(in:.whitespacesAndNewlines)
        if(text_Title == "")
        {
            self.descriptionTV.resignFirstResponder()
            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"desc_alert"))!)")
        }
        else
        {
            self.updateAPICall()
        }
        }
        else
        {
            self.offlineviewShow()
        }
    }
    @IBAction func retryBtnTapped(_ sender: Any) {
         if Utility().isConnectedToNetwork(){
            self.nextBtn.isHidden = false
            self.offlineView.isHidden = true
        }
        
    }
    @IBAction func saveAndExitBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
        if(Utility.shared.host_step2_isfromEdit)
        {
            let text_Title = descriptionTV.text.trimmingCharacters(in:.whitespacesAndNewlines)
            if(text_Title == "")
            {
                self.descriptionTV.resignFirstResponder()
                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"desc_alert"))!)")
            }
            else
            {
        self.updateAPICall()
            }
        }
        }
        else
        {
          self.offlineviewShow()
        }
    }
    
    func initialsetup()
    {
        
        nextBtn.layer.cornerRadius = 6.0
        nextBtn.layer.masksToBounds = true
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        descriptionTV.autocorrectionType = UITextAutocorrectionType.no
        descriptionTV.becomeFirstResponder()
        nextBtn.backgroundColor = Theme.PRIMARY_COLOR
        saveBtn.setTitleColor(Theme.PRIMARY_COLOR, for:.normal)
        
        descriptionTV.isEditable = true
        if(Utility.shared.step2_Description != "")
        {
            descriptionTV.text = Utility.shared.step2_Description
        }
        else
        {
        if(getListingStep2Array.description != nil)
        {
        descriptionTV.text = getListingStep2Array.description
        }
        else
        {
         descriptionTV.text = ""
        }
        }
        
        descriptionTV.isScrollEnabled = true
        descriptionTV.frame = CGRect(x: 20, y: 120, width: 340, height: FULLHEIGHT-330)
        placeholderLabel = UILabel()
        placeholderLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"desc_Placeholder"))!)"
        placeholderLabel.font = descriptionTV.font
        placeholderLabel.numberOfLines = 0
        placeholderLabel.sizeToFit()
        descriptionTV.addSubview(placeholderLabel)
        placeholderLabel.frame = CGRect(x:6, y:-10, width:descriptionTV.frame.size.width-20, height:75)
        placeholderLabel.numberOfLines = 2
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !descriptionTV.text.isEmpty
        self.nextimg.image = self.nextimg.image?.withRenderingMode(.alwaysTemplate)
        self.nextimg.tintColor = UIColor.white
        if(saveexit_Activated == "true")
        {
            saveBtn.isHidden = false
        }
        else
        {
            saveBtn.isHidden = true
        }
        let toolBar = UIToolbar().ToolbarPikerSelect(mySelect: #selector(dismissName))
        descriptionTV.inputAccessoryView = toolBar
        self.offlineView.isHidden = true
        
        errorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
        retryBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
        nextBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"next"))!)", for:.normal)
        saveBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"saveexit"))!)", for:.normal)
         summaryLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"summary"))!)"
         editdescTitleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"edit_desc"))!)"
    }
    @objc func dismissName() {
        
        self.view.endEditing(true)
        
    }
    
    
    
    @objc func keyboardWillShow(sender: NSNotification) {
        let info = sender.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        descriptionTV.frame = CGRect(x: 20, y: 120, width: FULLWIDTH-40, height:keyboardFrame.size.height-50 )
        Bottom_label.frame = CGRect(x: 20, y: descriptionTV.frame.origin.y+descriptionTV.frame.size.height+5, width: FULLWIDTH-40, height: 1)
        //  self.GoBtn.frame.origin.y -= keyboardFrame.height
//        self.nextBtn.frame.origin.y = keyboardFrame.origin.y - 150
//        self.nextimg.frame.origin.y = keyboardFrame.origin.y - 135
        
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        let info = sender.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        descriptionTV.frame = CGRect(x: 20, y: 120, width:  FULLWIDTH-40, height: FULLHEIGHT-330)
        Bottom_label.frame = CGRect(x: 20, y: descriptionTV.frame.origin.y+descriptionTV.frame.size.height+5, width: FULLWIDTH-40, height: 1)
        self.nextBtn.frame.origin.y = FULLHEIGHT - 170
        self.nextimg.frame.origin.y = FULLHEIGHT - 155

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
    
   
    func updateAPICall()
    {
        let UpdateListingStep2mutation = UpdateListingStep2Mutation(id:Utility.shared.host_step2_listId, description:descriptionTV.text!, title: Utility.shared.host_step2_title, coverPhoto: Utility.shared.host_photo_coverid)
        apollo_headerClient.perform(mutation: UpdateListingStep2mutation){ (result,error) in
            
            if(result?.data?.updateListingStep2?.status == 200)
            {
               
                self.manageListingSteps(listId: "\(Utility.shared.host_step2_listId)", currentStep: 2)
               
                
            }
        }
        
    }
    func manageListingSteps(listId:String,currentStep:Int)
    {
        let manageListingStepsMutation = ManageListingStepsMutation(listId:listId, currentStep:currentStep)
        apollo_headerClient.perform(mutation: manageListingStepsMutation){ (result,error) in
            
            if(result?.data?.manageListingSteps?.status == 200)
                {
                    
                    let becomeHostObj = BecomeHostVC()
                    becomeHostObj.listID = "\(Utility.shared.host_step2_listId)"
                    becomeHostObj.showListingStepsAPICall(listID:"\(Utility.shared.host_step2_listId)")
                    //self.view.window!.layer.add(presentrightAnimation()!, forKey: kCATransition)
                      becomeHostObj.modalPresentationStyle = .fullScreen
                    self.present(becomeHostObj, animated:false, completion: nil)
            }
            
        }
            
    }
    
    // MARK: - Textview Delegate
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        return numberOfChars < 1000  // 10 Limit Value
    }
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
      //  textView.resizeForHeight()
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        Utility.shared.step2_Description = textView.text!
        
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
extension UITextView {
    func resizeForHeight(){
        self.translatesAutoresizingMaskIntoConstraints = true
        self.sizeToFit()
        self.isScrollEnabled = true
    }
}

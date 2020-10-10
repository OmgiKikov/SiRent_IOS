//
//  ListingTitleVC.swift
//  Rent_All
//
//  Created by RadicalStart on 30/07/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Apollo

class ListingTitleVC: UIViewController,UITextViewDelegate {
    
     // MARK: - IBOUTLET CONNECTIONS & GLOBAL VARIABLE DECLARATIONS
    
    @IBOutlet weak var nameListingLabel: UILabel!
    @IBOutlet weak var namedescLabel: UILabel!
    @IBOutlet weak var retryBtn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var offlineView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var titleView: UIView!
    
    @IBOutlet weak var nextimg: UIImageView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var titleTV: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    var placeholderLabel : UILabel!
    var getListingStep2Array = GetListingDetailsStep2Query.Data.GetListingDetail.Result()
    var saveexit_Activated = String()
    var apollo_headerClient: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
        
        let url = URL(string:graphQLEndpoint)!
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialsetup()

        // Do any additional setup after loading the view.
    }
    
    
 // MARK: - IBACTIONS & FUNCTIONS
    
    
    func initialsetup()
    {
        nextBtn.layer.cornerRadius = 6.0
        nextBtn.layer.masksToBounds = true
     //   NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
       // NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        titleTV.autocorrectionType = UITextAutocorrectionType.no
        titleTV.becomeFirstResponder()
        nextBtn.backgroundColor = Theme.PRIMARY_COLOR
        saveBtn.setTitleColor(Theme.PRIMARY_COLOR, for:.normal)
        
        titleTV.isEditable = true
        if(Utility.shared.step2_Title != "")
        {
           titleTV.text = Utility.shared.step2_Title
        }
        else
        {
        if(getListingStep2Array.title != nil)
        {
         titleTV.text = getListingStep2Array.title
        }
        else {
        titleTV.text = ""
        }
        }
        titleTV.isScrollEnabled = true
        
        placeholderLabel = UILabel()
        placeholderLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"addtitle"))!)"
        placeholderLabel.font = titleTV.font
        placeholderLabel.numberOfLines = 0
        placeholderLabel.sizeToFit()
        titleTV.addSubview(placeholderLabel)
        placeholderLabel.frame = CGRect(x:6, y: 0, width:titleTV.frame.size.width-20, height:30)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !titleTV.text.isEmpty
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
        titleTV.inputAccessoryView = toolBar
        self.offlineView.isHidden = true
        
        
        errorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
        retryBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
        nameListingLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"namelisting"))!)"
        namedescLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"placespecial"))!)"
           titleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"title"))!)"
        saveBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"saveexit"))!)", for:.normal)
        nextBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"next"))!)", for:.normal)
        
        
    }
    @objc func dismissName() {
        
        self.view.endEditing(true)
        
    }
    
    func offlineviewShow()
    {
        self.view.endEditing(true)
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
     //   self.view!.layer.add(dismissrightAnimation()!, forKey: kCATransition)
            
        self.dismiss(animated: true, completion: nil)
        }
        else
        {
        self.offlineviewShow()
        }
    }
    @IBAction func savandexitBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            
        if(Utility.shared.host_step2_isfromEdit)
        {
            let text_Title = titleTV.text.trimmingCharacters(in:.whitespacesAndNewlines)
            if(text_Title == "")
            {
                self.titleTV.resignFirstResponder()
                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"addtitlealert"))!)")
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
    
    @IBAction func retryBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            self.nextBtn.isHidden = false
            self.offlineView.isHidden = true
        }
    }
    
    func updateAPICall()
    {
        var coverphoto = Int()
        
        if(Utility.shared.host_photo_coverid == 0)
        {
            if(getListingStep2Array.coverPhoto != nil)
            {
            coverphoto = getListingStep2Array.coverPhoto!
            }
            else{
               coverphoto = 0
            }
        }
        else
        {
            coverphoto = Utility.shared.host_photo_coverid
        }
        var title = String()
        if(titleTV.text != getListingStep2Array.title!)
        {
            title = titleTV.text
        }
        else
        {
            title = getListingStep2Array.title!
        }
        
        let UpdateListingStep2mutation = UpdateListingStep2Mutation(id:getListingStep2Array.id!, description:getListingStep2Array.description!, title:title, coverPhoto:coverphoto)
        apollo_headerClient.perform(mutation: UpdateListingStep2mutation){ (result,error) in
            
            if(result?.data?.updateListingStep2?.status == 200)
            {
               
                let becomeHostObj = BecomeHostVC()
                becomeHostObj.listID = "\(self.getListingStep2Array.id!)"
                becomeHostObj.showListingStepsAPICall(listID:"\(self.getListingStep2Array.id!)")
               // self.view.window!.layer.add(presentrightAnimation()!, forKey: kCATransition)
                   becomeHostObj.modalPresentationStyle = .fullScreen
                self.present(becomeHostObj, animated:false, completion: nil)
                
            }
        }
        
    }
    @IBAction func nextBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
        let text_Title = titleTV.text.trimmingCharacters(in:.whitespacesAndNewlines)
        if(text_Title == "")
        {
            self.titleTV.resignFirstResponder()
           self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"addtitlealert"))!)")
        }
        else
        {
        let listingDescriptionObj = ListingDescriptionVC()
        Utility.shared.host_step2_title = titleTV.text
        listingDescriptionObj.saveexit_Activated = saveexit_Activated
        listingDescriptionObj.getListingStep2Array = getListingStep2Array
           listingDescriptionObj.modalPresentationStyle = .fullScreen
//        self.view?.layer.add(presentrightAnimation()!, forKey: kCATransition)
        self.present(listingDescriptionObj, animated:false, completion: nil)
        }
        }
        else
        {
            self.offlineviewShow()
        }
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        let info = sender.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        
        //  self.GoBtn.frame.origin.y -= keyboardFrame.height
        self.nextBtn.frame.origin.y = keyboardFrame.origin.y - 150
        self.nextimg.frame.origin.y = keyboardFrame.origin.y - 135
        
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        let info = sender.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
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
     // MARK: - Textview Delegate
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        guard text.rangeOfCharacter(from: CharacterSet.newlines) == nil else {
//            return false
//        }
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        return numberOfChars < 51   // 10 Limit Value
    }
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        Utility.shared.step2_Title = textView.text!
        
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

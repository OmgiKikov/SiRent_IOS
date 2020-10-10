//
//  ContactusVC.swift
//  Rent_All
//
//  Created by RadicalStart on 08/06/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Apollo
import Lottie

class ContactusVC: UIViewController,UITextViewDelegate {
    
    //MARK:************************************ IBOUTLET CONNECTIONS & VARIABLE DECLARATIONS **********************************************>
    
    @IBOutlet weak var contactTextView: UITextView!
    
    @IBOutlet weak var retryBtn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var contactTitleLabel: UILabel!
    @IBOutlet weak var offlineView: UIView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var contactView: UIView!
    @IBOutlet weak var topView: UIView!
    var Listid = Int()
    var reservationid = Int()
    var lottieWholeView = UIView()
    var lottieView: LOTAnimationView!
    var placeholderLabel : UILabel!
    
    var apollo_headerClient: ApolloClient = {
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
    
    func lottieanimation()
    {
        sendBtn.setTitle("", for:.normal)
        lottieView = LOTAnimationView.init(name: "animation_white")
        self.lottieWholeView.isHidden = false
      //  self.lottieWholeView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height: FULLHEIGHT)
      //  self.lottieWholeView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
      //  self.view.addSubview(lottieWholeView)
        self.lottieView.isHidden = false
        self.lottieView.frame = CGRect(x:20, y:-25, width:100, height:100)
        self.sendBtn.addSubview(self.lottieView)
        self.lottieView.backgroundColor = UIColor.clear
        self.lottieView.play()
       // animation_white.json
        Timer.scheduledTimer(timeInterval:0.3, target: self, selector: #selector(autoscroll), userInfo: nil, repeats: true)
    }
    @objc func autoscroll()
    {
        self.lottieView.play()
    }
    func initialSetup()
    {
    cancelBtn.setBorder(color: Theme.PRIMARY_COLOR)
    cancelBtn.layer.cornerRadius = 6.0
    cancelBtn.setTitleColor(Theme.PRIMARY_COLOR, for:.normal)
    sendBtn.backgroundColor = Theme.PRIMARY_COLOR
    cancelBtn.layer.masksToBounds = true
    sendBtn.layer.cornerRadius = 6.0
    sendBtn.layer.masksToBounds = true
    self.offlineView.isHidden = true
    contactTextView.isScrollEnabled = true
   // contactTextView.layer.borderWidth = 1.0
   // contactTextView.layer.borderColor = TextBorderColor.cgColor
   
        let shadowSize : CGFloat = 3.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.bottomView.frame.size.width+40 + shadowSize,
                                                   height: self.bottomView.frame.size.height + shadowSize))
        
        self.bottomView.layer.masksToBounds = false
        self.bottomView.layer.shadowColor = TextLightColor.cgColor
        self.bottomView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.bottomView.layer.shadowOpacity = 0.3
        self.bottomView.layer.shadowPath = shadowPath.cgPath
        
        
        let shadowPath1 = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                    y: -shadowSize / 2,
                                                    width: self.topView.frame.size.width+40 + shadowSize,
                                                    height: self.topView.frame.size.height + shadowSize))
        
        self.topView.layer.masksToBounds = false
        self.topView.layer.shadowColor = TextLightColor.cgColor
        self.topView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.topView.layer.shadowOpacity = 0.3
        self.topView.layer.shadowPath = shadowPath1.cgPath
        self.contactTextView.becomeFirstResponder()
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = true
        
        lottieView = LOTAnimationView.init(name: "animation_white")
        contactTextView.delegate = self
        contactTextView.returnKeyType = .default
        contactTextView.isEditable = true
        contactTextView.text = ""
        contactTextView.isScrollEnabled = true
        placeholderLabel = UILabel()
        placeholderLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"add_a_message"))!)"
        placeholderLabel.font = contactTextView.font
        placeholderLabel.numberOfLines = 0
        placeholderLabel.sizeToFit()
        contactTextView.addSubview(placeholderLabel)
        placeholderLabel.frame = CGRect(x:9, y:3, width:contactTextView.frame.size.width-20, height:30)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !contactTextView.text.isEmpty
        
        errorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
         contactTitleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"contactus"))!)"
        retryBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
        cancelBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"cancel_uppercase"))!)", for: .normal)
        sendBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"send_uppercase"))!)", for: .normal)
        
        
        //keyboardFrame.origin.y
    }
    
  
   
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendBtnTapped(_ sender: Any) {
          if Utility().isConnectedToNetwork(){
            if(contactTextView.text == "")
            {
                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"messagealert"))!)")
            }
            else{
                self.lottieanimation()
            self.contactSupportAPICall(message: contactTextView.text, listId: Listid, reservationId: reservationid, userType:GUEST)
            }
        }
          else{
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
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-95, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-55, width: FULLWIDTH, height: 55)
            }
            
        }
    }
    
    @IBAction func retryBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            self.offlineView.isHidden = true
            self.lottieView.isHidden = false
            self.lottieWholeView.isHidden = false
            self.lottieWholeView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height: FULLHEIGHT)
            self.lottieWholeView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            self.view.addSubview(lottieWholeView)
            self.lottieView.frame = CGRect(x:FULLWIDTH/2-50, y: FULLHEIGHT/2-50, width: 100, height: 100)
            self.lottieWholeView.addSubview(self.lottieView)
            self.lottieView.backgroundColor = UIColor.white
            self.lottieView.layer.cornerRadius = 6.0
            self.lottieView.clipsToBounds = true
            self.lottieView.play()
            self.contactSupportAPICall(message: contactTextView.text, listId: Listid, reservationId: reservationid, userType:GUEST)
        }
    }
    func contactSupportAPICall(message:String,listId:Int,reservationId:Int,userType:String)
    {
        let contactsupportQuery = ContactSupportQuery(message: message, listId: listId, reservationId: reservationId, userType: userType)
        apollo_headerClient.fetch(query: contactsupportQuery){(result,error) in
            if(result?.data?.contactSupport?.status) != 200 {
                return
            }
            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"contacthost_alert"))!)")
            self.lottieView.isHidden = true
            self.sendBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"send_uppercase"))!)", for:.normal)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                // code to remove your view
                self.dismiss(animated: true, completion: nil)
            }
            
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
   
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        return numberOfChars < 250  // 10 Limit Value
    }
}

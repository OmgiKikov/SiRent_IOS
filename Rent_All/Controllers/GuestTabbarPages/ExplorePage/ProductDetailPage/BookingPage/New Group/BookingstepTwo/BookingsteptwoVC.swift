//
//  BookingsteptwoVC.swift
//  Rent_All
//
//  Created by RadicalStart on 29/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Apollo
import IQKeyboardManagerSwift

class BookingsteptwoVC: UIViewController,UITableViewDelegate,UITableViewDataSource,checkTextviewCellDelegate {
    

    func didChangeText(text: String?) {
       
    }
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bookingtwoTV: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    var viewListingArray = ViewListingDetailsQuery.Data.ViewListing.Result()
    var apollo_client: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
        
        let url = URL(string:graphQLEndpoint)!
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.profileAPICall()
        self.initialsetup()
    }
    func initialsetup()
    {
        if IS_IPHONE_XR
        {
            self.topView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH-40, height: 80)
            bookingtwoTV.frame = CGRect(x: 0, y: 85, width: FULLWIDTH-40, height: FULLHEIGHT-300)
            
        }
        bookingtwoTV.register(UINib(nibName: "bookingsteptwoCell", bundle: nil), forCellReuseIdentifier: "bookingsteptwoCell")
        bookingtwoTV.register(UINib(nibName: "checkTextviewCell", bundle: nil), forCellReuseIdentifier: "checkTextviewCell")
        nextBtn.backgroundColor = Theme.PRIMARY_COLOR
        
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
        nextBtn.layer.cornerRadius = 5.0
        nextBtn.layer.masksToBounds = true
        nextBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"next"))!)", for:.normal)
       
    }

    @IBAction func nextBtnTapped(_ sender: Any) {
        let cell = view.viewWithTag((1) + 2000) as? checkTextviewCell
         Utility.shared.booking_message = (cell?.checkTxtview.text!)!
       // self.profileAPICall()
        if((cell?.checkTxtview.text.isBlank)!)
       {
        self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"messagealert"))!)")
        }
       else{
        if(Utility.shared.isprofilepictureVerified)
        {
        let bookingThreeObj = BookingStepThreeVC()
           
         bookingThreeObj.viewListingArray = viewListingArray
        bookingThreeObj.modalPresentationStyle = .fullScreen
        self.present(bookingThreeObj, animated: true, completion: nil)
        }
        else
        {
            let bookingThreeObj = BookingStepFourVC()
            bookingThreeObj.viewListingArray = viewListingArray
            bookingThreeObj.modalPresentationStyle = .fullScreen
            self.present(bookingThreeObj, animated: true, completion: nil)
        }
        }
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        let cell = view.viewWithTag((1) + 2000) as? checkTextviewCell
        Utility.shared.booking_message = (cell?.checkTxtview.text!)!
        self.dismiss(animated: true, completion: nil)
    }
    
//MARK*************************************************** TABLEVIEW DELEGATE & DATASOURCE METHODS *****************************************************************************>
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0)
        {
          return 195
        }
        
          return 235
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "bookingsteptwoCell", for: indexPath)as!  bookingsteptwoCell
            cell.selectionStyle = .none
            if(Utility.shared.isprofilepictureVerified)
            {
                cell.stepLabel.text =  "\((Utility.shared.getLanguage()?.value(forKey:"step2of4"))!)"
            }
            else
            {
             cell.stepLabel.text =  "\((Utility.shared.getLanguage()?.value(forKey:"step2of3"))!)"
            }
           
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "checkTextviewCell", for: indexPath)as! checkTextviewCell
            cell.selectionStyle = .none
            cell.tag = indexPath.section+2000
            if(Utility.shared.booking_message != "")
            {
                cell.checkTxtview.text = Utility.shared.booking_message
                cell.placeholderLabel.isHidden = true
            }
            else{
                cell.checkTxtview.text = ""
            }
            let toolBar = UIToolbar().ToolbarPikerSelect(mySelect: #selector(dismissgenderPicker))
            cell.checkTxtview.inputAccessoryView = toolBar
            cell.checkTxtview.autocorrectionType = UITextAutocorrectionType.no
            cell.checkTxtview.becomeFirstResponder()
            return cell
        }
    }
     @objc func dismissgenderPicker() {
        view.endEditing(true)
    }
    func didChangeText(text: String?, cell: checkTextviewCell) {
        bookingtwoTV.beginUpdates()
        bookingtwoTV.endUpdates()
    }
    
    func profileAPICall() {
        
        if Utility.shared.isConnectedToNetwork() {
            
            if (Utility.shared.getCurrentUserID() != nil){
                
                let profileQuery = GetProfileQuery()
                apollo_client = {
                    let configuration = URLSessionConfiguration.default
                    // Add additional headers as needed
                    configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
                    
                    let url = URL(string:graphQLEndpoint)!
                    
                    return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
                    
                }()
                
                apollo_client.fetch(query: profileQuery, cachePolicy: .fetchIgnoringCacheData){ (result, error) in
                    
                    guard (result?.data?.userAccount?.result) != nil else {
                        
                        
                        print("Missing Data")
                        return
                    }
                   
    
                    if (result?.data?.userAccount?.result?.picture) == nil {
                        Utility.shared.isprofilepictureVerified = true
                    }else{
                        
                        Utility.shared.isprofilepictureVerified = false
                    }
                    
                    self.bookingtwoTV.reloadData()
                }
            }
        }else{
            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey: "error_field"))!)")
            
        }
    }

}
extension String {
    
    var isBlank: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
}

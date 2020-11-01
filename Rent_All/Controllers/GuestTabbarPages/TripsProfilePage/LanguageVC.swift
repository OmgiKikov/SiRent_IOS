//
//  LanguageVC.swift
//  Rent_All
//
//  Created by RadicalStart on 08/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Apollo

protocol LanguageVCDelegate {
    func getcurrencycode(code:String)
}

class LanguageVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var retryBtn: UIButton!
    
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var languageTable: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var offlineView: UIView!
    
    var payout_currency_symbol = String()
    
   // var LanguageDataArray = [UserLanguageQuery.Data.UserLanguage.Result]()
//    var currencyDataArray = [GetCurrenciesListQuery.Data.GetCurrency.Result]()
    var LanguageArray = [String]()
    var LanguagesymbolArray = [String]()
    
    var userEditProfileArray = GetProfileQuery.Data.UserAccount.Result()
    var selectedLanguageArray = NSMutableArray()
    var delegate:LanguageVCDelegate!
    var selectedCurrency = String()
    var selectedLanguageSymbol = String()
    var selectedLanguage = String()
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
        //self.LanguageAPICall()
//        self.currencyAPICall()

        // Do any additional setup after loading the view.
    }
    
    func initialSetup()
    {
        
        
        if(IS_IPHONE_X)
        {
        topView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height: 80)
        languageTable.frame = CGRect(x: 0, y: 85, width: FULLWIDTH, height: FULLHEIGHT-210)
        }
        if IS_IPHONE_XR || IS_IPHONE_PLUS
        {
            topView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height:80)
            languageTable.frame = CGRect(x: 0, y: 85, width: FULLWIDTH-40, height: FULLHEIGHT-370)
        }else if IS_IPHONE_678 {
            languageTable.frame = CGRect(x: 0, y:85, width: FULLWIDTH, height: FULLHEIGHT-160)
        }
        else{
        languageTable.frame = CGRect(x: 0, y:85, width: FULLWIDTH, height: FULLHEIGHT-220)
        }
        languageTable.register(UINib(nibName: "EditAboutCell", bundle: nil), forCellReuseIdentifier: "EditAboutCell")
        doneBtn.layer.cornerRadius = 3.0
        doneBtn.layer.masksToBounds = true
        doneBtn.backgroundColor = Theme.PRIMARY_COLOR
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
        
        if(Utility.shared.isfromLanguage)
        {
            self.titleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"languages"))!)"
        }
        else{
            self.titleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"currencylist"))!)"
        }
        self.offlineView.isHidden = true
        
        errorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
        retryBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
        doneBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"done"))!)", for:.normal)
        LanguageArray = ["Русский", "English"]
        LanguagesymbolArray = ["Ru", "En"]
        selectedLanguageArray.add("\(Utility.shared.getAppLanguage()!)")
        
        
        
    }

    @IBAction func retryBtnTapped(_ sender: Any) {
         if Utility().isConnectedToNetwork(){
        self.offlineView.isHidden = true
        self.doneBtn.isHidden = false
        }
       // self.LanguageAPICall()
//        self.currencyAPICall()
    }
    @IBAction func donebtntapped(_ sender: Any) {
         if Utility().isConnectedToNetwork(){
             self.offlineView.isHidden = true
        if(!Utility.shared.isfrom_payoutcurrency){
           
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        Utility.shared.setTab(index: 0)
        
        
        if(Utility.shared.isfromLanguage)
        {
            
            Utility.shared.setAppLanguage(Language: selectedLanguage)
            Utility.shared.setAppLanguageCode(Language:selectedLanguageSymbol)
            Utility.shared.configureLanguage()
           // self.dismiss(animated: true, completion: nil)
//            Utility.shared.selectedLanguage = selectedLanguage
//           Utility.shared.selectedLanguage_code = selectedLanguageSymbol
//        self.EditProfileAPICall(fieldName: "preferredLanguage", fieldValue: selectedLanguageSymbol)
        }
           
        else if(Utility.shared.isfromCurrency || Utility.shared.isfrom_payoutcurrency)
        {
            if(selectedCurrency == "")
            {
               Utility.shared.selectedCurrency =  Utility.shared.getPreferredCurrency()!
                selectedCurrency = Utility.shared.getPreferredCurrency()!
            }
            else
            {
            Utility.shared.selectedCurrency = selectedCurrency
                Utility.shared.setPreferredCurrency(currency_rate: selectedCurrency)
            }
        self.EditProfileAPICall(fieldName: "preferredCurrency", fieldValue:selectedCurrency)
        }else if (Utility.shared.isfrom_payoutcurrency){
            
            }
//        appDelegate.GuestaddingElementsToObjects()
//        appDelegate.GuestsettingRootViewControllerFunction()
            Utility.shared.isfromfloatmap_Page = false
            Utility.shared.isfromGuestProfile = false
            Utility.shared.isfromsearchLocationFilter = false
            Utility.shared.locationfromSearch  = ""
            Utility.shared.TotalFilterCount = 0
            if(Utility.shared.searchLocationDict.count > 0)
            {
                Utility.shared.searchLocationDict.setValue(nil, forKey: "lat")
                Utility.shared.searchLocationDict.setValue(nil, forKey: "lon")
            }
            Utility.shared.instantBook = ""
            Utility.shared.roomtypeArray.removeAllObjects()
            Utility.shared.amenitiesArray.removeAllObjects()
            Utility.shared.priceRangeArray.removeAllObjects()
            Utility.shared.facilitiesArray.removeAllObjects()
            Utility.shared.houseRulesArray.removeAllObjects()
            Utility.shared.beds_count = 0
            Utility.shared.bedrooms_count = 0
            Utility.shared.bathroom_count = 0
            
            self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
        appDelegate.GuestTabbarInitialize(initialView: CustomTabbar())
        
            
        }
        else
        {
        delegate?.getcurrencycode(code:payout_currency_symbol)
        self.dismiss(animated: true, completion: nil)
        }
        }
        else
         {
             self.doneBtn.isHidden = true
            self.offlineView.isHidden = false
            
        }

    }
    
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        selectedCurrency = ""
        self.dismiss(animated: true, completion: nil)
    }
    

    //MARK: ********************************************************* TABLEVIEW DELEGATE & DATASOURCE METHODS ********************************************************>
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(Utility.shared.isfromLanguage)
        {
        if(Utility.shared.LanguageDataArray.count > 0)
        {
            return LanguageArray.count
           // return Utility.shared.LanguageDataArray.count
        }
        }
        else if(Utility.shared.isfromCurrency || Utility.shared.isfrom_payoutcurrency)
        {
            if(Utility.shared.currencyDataArray.count > 0)
            {
                return Utility.shared.currencyDataArray.count
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditAboutCell", for: indexPath)as! EditAboutCell
        cell.phoneLabel.isHidden = true
        cell.editLabel.isHidden = true
        cell.rightArrowimg.frame = CGRect(x:FULLWIDTH-40, y: 30, width: 25, height: 25)
        cell.selectionStyle = .none
        
        if(Utility.shared.isfromLanguage)
        {
            cell.aboutLabel.text = LanguageArray[indexPath.row]

        if(selectedLanguageArray.contains(LanguageArray[indexPath.row]))
        {
            cell.rightArrowimg.image = #imageLiteral(resourceName: "checked")

//            selectedLanguageSymbol = Utility.shared.LanguageDataArray[indexPath.row].value!
//            selectedLanguage = Utility.shared.LanguageDataArray[indexPath.row].label!
            selectedLanguage = LanguageArray[indexPath.row]
            selectedLanguageSymbol = LanguagesymbolArray[indexPath.row]
       
        }
           
        else{
            cell.rightArrowimg.image = #imageLiteral(resourceName: "unchecked")
        }
        }
        else if(Utility.shared.isfromCurrency || Utility.shared.isfrom_payoutcurrency)
        {
            
            let currencysymbol = Utility.shared.getSymbol(forCurrencyCode: Utility.shared.currencyDataArray[indexPath.row].symbol!)
            cell.aboutLabel.text = "\(Utility.shared.currencyDataArray[indexPath.row].symbol!) - \(currencysymbol!)"
            if(selectedLanguageArray.contains((Utility.shared.currencyDataArray[indexPath.row].symbol!)))
            {
                cell.rightArrowimg.image = #imageLiteral(resourceName: "checked")
                selectedCurrency = "\(Utility.shared.currencyDataArray[indexPath.row].symbol!)"
                
                
            }
            else if((Utility.shared.currencyDataArray[indexPath.row].symbol!) == payout_currency_symbol && Utility.shared.isfrom_payoutcurrency)
            {
              cell.rightArrowimg.image = #imageLiteral(resourceName: "checked")
            }
            else if((userEditProfileArray.preferredCurrency) != nil)
            {
            if((userEditProfileArray.preferredCurrency!) == (Utility.shared.currencyDataArray[indexPath.row].symbol!))
            {
                cell.rightArrowimg.image = #imageLiteral(resourceName: "checked")
            }
            else{
                cell.rightArrowimg.image = #imageLiteral(resourceName: "unchecked")
                }
            }
            else if(Utility.shared.getPreferredCurrency() != nil && Utility.shared.isfromCurrency)
            {
                if((Utility.shared.getPreferredCurrency()!) == (Utility.shared.currencyDataArray[indexPath.row].symbol!))
                {
                    cell.rightArrowimg.image = #imageLiteral(resourceName: "checked")
                }
                else{
                    cell.rightArrowimg.image = #imageLiteral(resourceName: "unchecked")
                }
            }
                

            else{
                cell.rightArrowimg.image = #imageLiteral(resourceName: "unchecked")
            }
        }
        else
        {
            if(Utility.shared.getPreferredCurrency() != nil && Utility.shared.getPreferredCurrency() != "")
            {
                if((Utility.shared.getPreferredCurrency()!) == (Utility.shared.currencyDataArray[indexPath.row].symbol!))
                {
                    cell.rightArrowimg.image = #imageLiteral(resourceName: "checked")
                }
                else{
                    cell.rightArrowimg.image = #imageLiteral(resourceName: "unchecked")
                }
            }
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        payout_currency_symbol = ""
        
        if(Utility.shared.isfromLanguage)
        {
      //  if(selectedLanguageArray.contains(Utility.shared.LanguageDataArray[indexPath.row].label!))
        if(selectedLanguageArray.contains(LanguageArray[indexPath.row]))
        {
           
           // selectedLanguageArray.remove(LanguageArray[indexPath.row])
        }
        else{
            selectedLanguageArray.removeAllObjects()
            userEditProfileArray.preferredLanguageName = ""
            selectedLanguageArray.add(LanguageArray[indexPath.row])
            //selectedLanguageArray.add(Utility.shared.LanguageDataArray[indexPath.row].label!)
        }
            
        }
        else if(Utility.shared.isfromCurrency)
        {
            
            if(selectedLanguageArray.contains(Utility.shared.currencyDataArray[indexPath.row].symbol!))
            {
                //selectedLanguageArray.remove(Utility.shared.currencyDataArray[indexPath.row].symbol!)
            }
            else{
                selectedLanguageArray.removeAllObjects()
                userEditProfileArray.preferredCurrency = ""
                selectedLanguageArray.add(Utility.shared.currencyDataArray[indexPath.row].symbol!)
               // Utility.shared.setPreferredCurrency(currency_rate: (Utility.shared.currencyDataArray[indexPath.row].symbol!))
            }
        }
        else if(Utility.shared.isfrom_payoutcurrency)
        {
           
        payout_currency_symbol = (Utility.shared.currencyDataArray[indexPath.row].symbol!)
           
        }
        languageTable.reloadData()
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
    
    
    
    

}

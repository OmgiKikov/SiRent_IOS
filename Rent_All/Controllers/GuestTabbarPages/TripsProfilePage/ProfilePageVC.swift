//
//  ProfilePageVC.swift
//  Rent_All
//
//  Created by RADICAL START on 22/03/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Apollo
import  Lottie





class ProfilePageVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UITabBarControllerDelegate,UITabBarDelegate{
    
    
   
    //***************************************IBOUTLET CONNECTIONS  & GLOBAL DECLARATIONS *********************************************************>
    @IBOutlet weak var profileTable: UITableView!
    
    @IBOutlet weak var retryBtn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var profileBackImage: UIImageView!
    @IBOutlet weak var offlineView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var profileName: UILabel!
    
    var ProfileArray = NSMutableArray()
    var ProfileTickImageArray = NSMutableArray()
     var lottieView: LOTAnimationView!
    
    var ProfileAPIArray = GetProfileQuery.Data.UserAccount.Result()
    
    
    var apollo_headerClient:ApolloClient!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkApolloStatus()
        CustomTabbar().delegate = self
       
        self.initialSetup()
        self.lottieAnimation()
        self.LanguageAPICall()
        self.currencyAPICall()
       

        // Do any additional setup after loading the view.
    }
    func checkApolloStatus()
    {
        if((Utility.shared.getCurrentUserToken()) != nil)
        {
            apollo_headerClient = {
                let configuration = URLSessionConfiguration.default
                // Add additional headers as needed
                configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
                
                let url = URL(string:graphQLEndpoint)!
                
                return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
            }()
        }
        else{
            apollo_headerClient = ApolloClient(url: URL(string:graphQLEndpoint)!)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        if((Utility.shared.getCurrentUserToken()) != nil || (Utility.shared.getCurrentUserToken()) != "")
        {
        
        self.profileAPICall()
        }
        
        
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController)
    {
         print("Test")
    }

    
    func initialSetup()
    {
         self.offlineView.isHidden = true
        if(IS_IPHONE_XR || IS_IPHONE_PLUS)
        {
            profileTable.frame = CGRect(x: 0, y:0, width: FULLWIDTH-40, height: FULLHEIGHT)
        }
        else
        {
        profileTable.frame = CGRect(x: 0, y:0, width: FULLWIDTH, height: FULLHEIGHT)
        }
        profileTable.register(UINib(nibName: "HeaderProfileCell", bundle: nil), forCellReuseIdentifier: "HeaderProfileCell")
        profileTable.register(UINib(nibName: "SwitchtohostCell", bundle: nil), forCellReuseIdentifier: "SwitchtohostCell")
       // ProfileArray = ["Connect Email","Connect Facebook","Connect Google","Verify Phone Number","Logout","VERSION 1.0"]
        ProfileArray = ["\((Utility.shared.getLanguage()?.value(forKey:"Switchhosting"))!)","\((Utility.shared.getLanguage()?.value(forKey:"payoutpreference"))!)","\((Utility.shared.getLanguage()?.value(forKey:"termsprivacy"))!)","\((Utility.shared.getLanguage()?.value(forKey:"gethelp"))!)","\((Utility.shared.getLanguage()?.value(forKey:"logout"))!)","\((Utility.shared.getLanguage()?.value(forKey:"version"))!)"]
        ProfileTickImageArray = [#imageLiteral(resourceName: "profile_Verify_Tick"),#imageLiteral(resourceName: "profile_NotVerify_Tick"),#imageLiteral(resourceName: "profile_NotVerify_Tick"),#imageLiteral(resourceName: "profile_NotVerify_Tick"),#imageLiteral(resourceName: "profile_NotVerify_Tick")]
        
        errorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
        retryBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
    }
    
    
    
    func lottieAnimation(){
        lottieView = LOTAnimationView.init(name:"animation")
        lottieView.isHidden = false
        self.lottieView.frame = CGRect(x:FULLWIDTH/2-40, y:FULLHEIGHT/2-50, width:100, height:100)
        self.view.addSubview(self.lottieView)
        self.lottieView.backgroundColor = UIColor.clear
        self.lottieView.layer.cornerRadius = 6.0
        self.lottieView.clipsToBounds = true
        self.lottieView.play()
        Timer.scheduledTimer(timeInterval:0.3, target: self, selector: #selector(autoscroll), userInfo: nil, repeats: true)
    }
    @objc func autoscroll()
    {
        self.lottieView.play()
    }
    func profileAPICall()
    {
         if Utility().isConnectedToNetwork(){
        let profileQuery = GetProfileQuery()
        
        apollo_headerClient.fetch(query:profileQuery,cachePolicy:.fetchIgnoringCacheData){(result,error) in

            guard (result?.data?.userAccount?.result) != nil else
            {
                print("Missing Data")
                //  self.logoutCall()
                //   Utility().userLogout()
                Utility.shared.setUserToken(userID: "")
                //self.view.makeToast(result?.data?.userAccount?.errorMessage)
                return
            }
            self.ProfileAPIArray = ((result?.data?.userAccount?.result)!)
            Utility.shared.setEmail(email:(result?.data?.userAccount?.result?.email as AnyObject)as! NSString)
            self.profileTable.reloadData()
            self.lottieView.isHidden = true
            }
//            else
//            {
//                UserDefaults.standard.removeObject(forKey: "user_token")
//                UserDefaults.standard.removeObject(forKey: "user_id")
//                UserDefaults.standard.removeObject(forKey: "password")
//                UserDefaults.standard.removeObject(forKey: "currency_rate")
//                let welcomeObj = WelcomePageVC()
//                self.present(welcomeObj, animated:false, completion: nil)
//                //  self.logoutCall()
//                // Utility().userLogout()
//            }
         
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
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-130, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
            }
        }
        
        
    }

    @IBAction func backBtnTapped(_ sender: Any) {
    }
    @IBAction func editprofileTapped(_ sender: Any) {
    }
    
    
    
    
    
    //******************************************************** TABLEVIEW DELEGATE & DATASOURCE METHODS ********************************************>

    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if(ProfileAPIArray.userId != nil)
    {
      if(section == 0)
      {
        return 1
        }
      else {
        return ProfileArray.count
        }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(ProfileAPIArray.userId != nil)
        {
        if(indexPath.section == 0)
        {
            return 130
        }
        else{
           return 80
        }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderProfileCell", for: indexPath) as! HeaderProfileCell
            cell.profileName.text = "\(ProfileAPIArray.displayName!)".firstUppercased
            if(ProfileAPIArray.picture != nil)
            {
            let profImage = ProfileAPIArray.picture!
            cell.profileImage.sd_setImage(with: URL(string:"\(IMAGE_AVATAR_MEDIUM)\(profImage)"), placeholderImage: #imageLiteral(resourceName: "unknown"))
          
            }
            else
            {
              cell.profileImage.image = #imageLiteral(resourceName: "unknown")
        
            }
            
            cell.profileImage.cornerViewRadius()
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }

        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchtohostCell", for: indexPath) as! SwitchtohostCell
            cell.lineLabel.frame = CGRect(x: 15, y: 79.5, width: FULLWIDTH-40, height: 0.5)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.profileSettingLabel.text = ProfileArray[indexPath.row] as! String
        
            if(indexPath.row == 0)
            {
                if(ProfileAPIArray.loginUserType == "Host" && !Utility.shared.getTabbar()!)
                {
                  if Utility.shared.isfromNotificationHost || Utility.shared.isfromOfflineNotification || Utility.shared.isfromBackroundBooking || Utility.shared.isfromOfflineBooking
                  {
                    
                    cell.profileSettingLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"switchtraveling"))!)"
                    
                  }else if (ProfileAPIArray.isAddedList == true){
                    
                    cell.profileSettingLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"Switchhosting"))!)"
                    
                  }
                    else
                  {
                   
                    cell.profileSettingLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"becomehost"))!)"
                  }
                }
                else{
                    if(ProfileAPIArray.isAddedList == true && !Utility.shared.getTabbar()!)
                    {

                        cell.profileSettingLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"Switchhosting"))!)"
                        
                    }
                    else if(ProfileAPIArray.isAddedList == false && !Utility.shared.getTabbar()!)
                    {
                        
                        cell.profileSettingLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"becomehost"))!)"
                        
                    }
                    else
                    {
                       
                       
                        cell.profileSettingLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"switchtraveling"))!)"
                    }
                   
                }
                cell.profileSettingLabel.textColor = UIColor.darkGray
             cell.profilesettingImage.image =  #imageLiteral(resourceName: "switch-to-travelling-25")

            }
            
            else if(indexPath.row == 1)
            {
                cell.profilesettingImage.image =  #imageLiteral(resourceName: "payment-25")
                cell.profileSettingLabel.textColor = UIColor.darkGray
            }
            else if(indexPath.row == 2)
            {
                cell.profilesettingImage.image =  #imageLiteral(resourceName: "terms-of-service-25")
                cell.profileSettingLabel.textColor = UIColor.darkGray
            }
            else if(indexPath.row == 3)
            {
                cell.profilesettingImage.image =  #imageLiteral(resourceName: "ques-25")
                cell.profileSettingLabel.textColor = UIColor.darkGray

            }

            else if(indexPath.row == 4)
            {
                cell.profilesettingImage.image = nil
                cell.profileSettingLabel.textColor = Theme.PRIMARY_COLOR
                //cell.lineLabel.isHidden = true
                
            }
            else if(indexPath.row == 5)
            {
                cell.profilesettingImage.isHidden = true
                cell.profileSettingLabel.font = UIFont(name: "Circular-Book", size:13)
                cell.profileSettingLabel.textAlignment = .center
                cell.profileSettingLabel.textColor = UIColor.darkGray
                cell.lineLabel.isHidden = true
            }

            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 0)
        {
        if(indexPath.row == 0)
        {
             if Utility().isConnectedToNetwork(){
            let editprofileobj = EditProfileVC()
          editprofileobj.EditProfileArray = ProfileAPIArray
                editprofileobj.modalPresentationStyle = .fullScreen
            self.present(editprofileobj, animated: true, completion: nil)
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
                    offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-130, width: FULLWIDTH, height: 55)
                }else{
                    offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
                }
            }
        }
        }
        else{
            if(indexPath.row == 0)
            {
                 if Utility().isConnectedToNetwork(){
                if(!Utility.shared.getTabbar()!)
                {
                    
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                Utility.shared.isfromGuestProfile = true
                
               
                Utility.shared.host_message_isfrommessage = true
                Utility.shared.host_message_isfromHost = true
                
                let SplashObj = SwitchTravelAndHostVC()
                    
                    if Utility.shared.isfromNotificationHost || Utility.shared.isfromOfflineNotification || Utility.shared.isfromBackroundBooking || Utility.shared.isfromOfflineBooking{
                        Utility.shared.isfromHost = true
                        Utility.shared.isfromNotificationHost = false
                        Utility.shared.isfromOfflineNotification = false
                        Utility.shared.isfromBackroundBooking = false
                        Utility.shared.isfromOfflineBooking = false
                        Utility.shared.isfromGuestProfile = false
                    }else{
                        Utility.shared.isfromHost = false
                    }
                       SplashObj.modalPresentationStyle = .fullScreen
                    self.present(SplashObj, animated: false) {
                       // appDelegate.settingRootViewControllerFunction()
                    }
                   
                   
                
                }
                else
                {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    Utility.shared.setTab(index: 0)
                    Utility.shared.isfromGuestProfile = false
                    Utility.shared.host_message_isfromHost = false
                    Utility.shared.host_message_isfrommessage = false
                    Utility.shared.isfromfloatmap_Page = false
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
                    if(Utility.shared.isSwitchEnable)
                    {
                        Utility.shared.isSwitchEnable = false
                    }
//                    appDelegate.GuestaddingElementsToObjects()
//                    appDelegate.GuestsettingRootViewControllerFunction()
                    Utility.shared.isfromHost = true
                    let switchObj = SwitchTravelAndHostVC()
                    switchObj.modalPresentationStyle = .fullScreen
                    self.view.window?.rootViewController!.present(switchObj, animated: false) {
                        // appDelegate.GuestTabbarInitialize(initialView: CustomTabbar())
                    }
                   
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
                        offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-130, width: FULLWIDTH, height: 55)
                    }else{
                        offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
                    }
                }
                
        
            }
            if(indexPath.row == 1)
            {
                let payoutObj = PayoutPreferenceVC()
                payoutObj.modalPresentationStyle = .fullScreen
                self.view.window?.rootViewController?.present(payoutObj, animated: true, completion: nil)
//                self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
//                self.present(payoutObj, animated: true, completion: nil)
                
            }
            if(indexPath.row == 2)
            {
                let webviewObj = WebviewVC()
                webviewObj.webstring = TERMS_URL
                webviewObj.modalPresentationStyle = .fullScreen
                webviewObj.webviewRedirection(webviewString:TERMS_URL)
                self.present(webviewObj, animated: true, completion: nil)
                
            }
             if(indexPath.row == 3)
            {
                let webviewObj = WebviewVC()
                webviewObj.webstring = HELP_URL
                webviewObj.modalPresentationStyle = .fullScreen
                 webviewObj.webviewRedirection(webviewString:HELP_URL)
                self.present(webviewObj, animated: true, completion: nil)

            }

        if(indexPath.row == 4)
        {
            
            let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            // create an action
            let firstAction: UIAlertAction = UIAlertAction(title: "\((Utility.shared.getLanguage()?.value(forKey:"logout"))!)", style: .destructive) { action -> Void in
                Utility.shared.isfromGuestProfile = false
                Utility.shared.isaboutmechanged = false
                Utility.shared.selectedLanguage = ""
                Utility.shared.selectedphoneNumber = ""
                Utility.shared.selectedCurrency = ""
                Utility.shared.isfromfloatmap_Page = false
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
                Utility.shared.EditProfileArray.picture = nil
                if(Utility.shared.isSwitchEnable)
                {
                    Utility.shared.isSwitchEnable = false
                }
                Utility.shared.TotalFilterCount = 0
                self.userlogoutAPICall()
            }
            
            let cancelAction: UIAlertAction = UIAlertAction(title: "\((Utility.shared.getLanguage()?.value(forKey:"cancel"))!)", style: .cancel) { action -> Void in }
            
            // add actions
            actionSheetController.addAction(firstAction)
            actionSheetController.addAction(cancelAction)
            
            // present an actionSheet...
            present(actionSheetController, animated: true, completion: nil)
        }
        }
    }
    
    @IBAction func retryBtnTapped(_ sender: Any){
         if Utility().isConnectedToNetwork(){
        self.offlineView.isHidden = true
        }
//        if(ProfileAPIArray != nil)
//        {
//        let editprofileobj = EditProfileVC()
//        editprofileobj.EditProfileArray = ProfileAPIArray
//
//        self.present(editprofileobj, animated: true, completion: nil)
//        }
    }

    
    // MARK: LanguageAPI Calling Function
    
    func LanguageAPICall()
    {
        if Utility().isConnectedToNetwork(){
            let languageQuery = UserLanguageQuery()
            apollo_headerClient.fetch(query: languageQuery){(result,error) in
                guard (result?.data?.userLanguages?.result) != nil else{
                    print("Missing Data")
                    return
                }
                
                Utility.shared.LanguageDataArray.removeAll()
                Utility.shared.LanguageDataArray = ((result?.data?.userLanguages?.result)!) as! [UserLanguageQuery.Data.UserLanguage.Result]
               // self.languageTable.reloadData()
            }
        }
        else
        {
            self.offlineView.isHidden = false
           // self.doneBtn.isHidden = true
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
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-85, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-55, width: FULLWIDTH, height: 55)
            }
        }
    }
    func logoutCall()
    {
        UserDefaults.standard.removeObject(forKey: "user_token")
        UserDefaults.standard.removeObject(forKey: "user_id")
        UserDefaults.standard.removeObject(forKey: "password")
        UserDefaults.standard.removeObject(forKey: "currency_rate")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let welcomeObj = SignInViewController()
        appDelegate.setInitialViewController(initialView: welcomeObj)
    }
    func userlogoutAPICall()
    {
        if Utility().isConnectedToNetwork(){
                let logoutMutation = LogoutMutation(deviceType: "iOS", deviceId:Utility.shared.pushnotification_devicetoken)
            apollo_headerClient.perform(mutation:logoutMutation){(result,error) in
                
        if(result?.data?.userLogout?.status == 200)
        {
            self.logoutCall()
            print("loggedout")
        }
                else if(result?.data?.userLogout?.errorMessage ==  "You haven\'t logged in.")
                  {
                    self.logoutCall()
                }
            
            }
        }
        else
        {
            self.offlineView.isHidden = false
            // self.doneBtn.isHidden = true
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
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-85, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-55, width: FULLWIDTH, height: 55)
            }
        }
    }
    
    // MARK: Currency API Call
    
    func currencyAPICall()
    {
        if Utility().isConnectedToNetwork(){
            let currencyQuery = GetCurrenciesListQuery()
            apollo_headerClient.fetch(query: currencyQuery){(result,error) in
                guard (result?.data?.getCurrencies?.results) != nil else{
                    print("Missing Data")
                    return
                }
                Utility.shared.currencyDataArray = ((result?.data?.getCurrencies?.results)!) as! [GetCurrenciesListQuery.Data.GetCurrency.Result]
                Utility.shared.currencyvalue = Utility.shared.currencyDataArray.first!.symbol!
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
            if IS_IPHONE_X || IS_IPHONE_XR{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-85, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-55, width: FULLWIDTH, height: 55)
            }
        }
    }
    
    
    
}
extension StringProtocol {
    var firstUppercased: String {
        return prefix(1).uppercased() + dropFirst()
    }
    var firstCapitalized: String {
        return String(prefix(1)).capitalized + dropFirst()
    }
}

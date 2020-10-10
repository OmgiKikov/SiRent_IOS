//
//  Utility.swift
//  Rent_All
//
//  Created by RADICAL START on 19/03/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import SystemConfiguration


public class Utility: NSObject {
    
    static let shared = Utility()
    var timer = Timer()
    var locationfromSearch:String!
    var isfromExplorePage:Bool = false
    var isfromFilterPage:Bool = false
    var isfromMoreFilter:Bool = false
    var isfromsearchLocationFilter:Bool = false
    var isfromLanguage:Bool = false
    var isfromCurrency:Bool = false
    var isfromdetailpage:Bool = false
    var ContainsTodayDate = false
    //var signupArray = NSMutableArray()
    var signupArray = NSMutableArray()
    var signupdataArray = [AnyObject]()
    var logindataArray = [AnyObject]()
    var searchLocationDict = NSDictionary()
    var selectedLanguage = String()
    var selectedphoneNumber = String()
    var selectedCurrency = String()
    var selectedLanguage_code = String()
    var aboutme_Name = String()
    var isaboutmechanged : Bool = false
    var isfromcheckingPage:Bool = false
    var blockedDates = NSMutableArray()
    var blocked_date_month = NSMutableArray()
    var minimumstay = Int()
    var numberofnights_Selected = Int()
    var maximum_Count_for_booking = Int()
    var maximum_days_notice = Int()
    var isprofilepictureVerified :Bool = false
    var passbillingArray = GetBillingCalculationQuery.Data.GetBillingCalculation.Result()
    var passCurrencyvaluefromAPI = String()
    var currencyvalue_from_API_base = String()
     var currency_Dict = NSDictionary()
    
    var isfromSavedShortcut: Bool = false
    var isfromMessageShortcut: Bool = false
    var isfrommessageShortcutSplashScreen: Bool = false
    var isfromcancelPAge:Bool = false
    var isfromTripsPage:Bool = false
    var maximum_guest_count = Int()
    
    var bookingListimage = String()
    var bookingListname = String()
    var bookingdateLabel = String()
    var booking_message = String()
    var isfromGuestProfile:Bool = false
    var pushnotification_devicetoken = String()
    var isfromPhonePage: Bool = false
    var deepLinkEmail = String()
    var deepLinkToken = String()
    var PreapproveValue = NSMutableArray()
    var personCapcityForMessagePage = Int()
    var ConfirmEmailString = String()
    var ConfirmEmailToken = String()
    
    // Currency Data and Language Data for Edit Profile Page
    
    var LanguageDataArray = [UserLanguageQuery.Data.UserLanguage.Result]()
     var currencyDataArray = [GetCurrenciesListQuery.Data.GetCurrency.Result]()
    var ListID = String()
    var PreApprovedID: Bool = Bool()
    // Explore Page Call back
   var recommendListingArray = [GetDefaultSettingQuery.Data.GetRecommend.Result]()
//    var mostListingArray = [GetDefaultSettingQuery.Data.GetMostViewedListing.Result]()
    
    //MARK: - Receipt Page
    var isreceiptAccepted : Bool = false
    var isreceiptAcceptedHost: Bool = false
    
    var isFromMessageListingPage: Bool = false
    var isFromMessageListingPage_host: Bool = false
    var isFromMessageListingPage_guest: Bool = false
    var isfromPhoneVC:Bool = false
    
      var isGoogleEnable:Bool = false
    
    // Mark: Travel And Host Page
    
    var isfromHost: Bool = true
    var pickedImage_profile = UIImage()
    var imgChanged:Bool = false
     var pickedimageString = String()
    var imgGalleryChanged:Bool = false
    
    var EditProfileArray = GetProfileQuery.Data.UserAccount.Result()
    
    //MoreFilterPage
    
    var roomtypeArray = NSMutableArray()
    var amenitiesArray = NSMutableArray()
    var facilitiesArray = NSMutableArray()
    var houseRulesArray = NSMutableArray()
    var priceRangeArray = NSMutableArray()
    var instantBook = String()
    var bedrooms_count = Int()
    var beds_count = Int()
    var bathroom_count = Int()
    var TotalFilterCount : Int = 0
    var isSwitchEnable:Bool = false
    var user_token = String()
    var unpublish_preview_check:Bool = false
    static var calendar: Calendar {
        get {
            var c = Calendar.current
            c.timeZone = TimeZone(abbreviation: "GMT")!
            return c
        }
    }
    
    //Step 1 Host
    var step1ValuesInfo = [String : Any]()
    var createId = Int()
    var step3ValuesInfo = [String : Any]()
    var step1_inactivestatus = String()
    var currencyvalue = ""
    var step3_Edit:Bool = false


    //MARK: - Host Variables
    
     //MARK: - Host Variables
    var host_specialDay_Array = NSMutableArray()
    var host_bookDay_Array = NSMutableArray()
    var hosr_blockDay_Array = NSMutableArray()
    
    var host_photo_coverid = Int()
    var host_step2_listId = Int()
    var host_step2_title = String()
    var host_step2_isfromEdit:Bool = false
    var host_message_isfromHost:Bool = false
    var host_cancel_isfromCancel:Bool = false
    var host_message_isfrommessage:Bool = false
    var host_blockedDates_Array = NSMutableArray()
    var host_specialPricing_Array = NSMutableArray()
    var host_bookedPricing_Array = NSMutableArray()
    var host_selected_dates_Array = NSMutableArray()
    var host_specialPrice_value_Array = NSMutableArray()
    var host_specialPrice_Array = [[String:Any]]()
    var host_currency_Array = NSMutableArray()
    var host_selected_Array = NSMutableArray()
    var host_isfrom_hostRecipt:Bool = false
    
    var payout_Address_Dict = [String:Any]()
     var calendar_Date_Array = [Date]()
    var isfrom_payoutcurrency : Bool = false
    var selected_Countrycode_Payout = String()
    
    
    var guest_filter = 0

    var isfromNotificationHost: Bool = false
    var isfromOfflineNotification: Bool = false
    
    
    var isfromBackroundBooking: Bool = false
    var isfromOfflineBooking: Bool = false
    
    
    var isfromAppDelegateMessageBackground: Bool = false
    var isfromAppdelegateMessageOffline: Bool = false
    
    var host_basePrice:Double!
    var host_cleanPrice: Double!
    
    var isfrom_availability_calendar:Bool = false
    var isfrom_availability_calendar_date:Bool = false

  var selectedRules = NSMutableArray()
  var selectedAmenityIdList = NSMutableArray()
    var selectedsafetyAmenityIdList = NSMutableArray()
    var selectedspaceAmenityIdList = NSMutableArray()
     var bedtypeInfoArr = [[String : Any]]()
    
    var cancelpolicy = String()
    var cancelpolicy_content = String()
    
    var isfromfloatmap_Page:Bool = false
    var selectedstartDate_filter = String()
    var selectedEndDate_filter = String()
    var isfrombecomehoststep1Edit:Bool = false
    
    
    var isTodayEnable: Bool = false
    var step2_Title = String()
    var step2_Description = String()
    var bedcount = 0
    
    var getListSettingsArray = GetListingSettingQuery.Data.GetListingSetting.Result()
    var countrylist = [GetCountrycodeQuery.Data.GetCountry.Result]()

    var ProfileAPIArray = GetProfileQuery.Data.UserAccount.Result()
    var isPhonenumberCountrycode : Bool = false
    
    
    //MARK: - Configure  App Language
    func configureLanguage()
    {
        if let path = Bundle.main.path(forResource:Utility.shared.getAppLanguage()!, ofType: "json")
        {
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                self.setDefaultLanguage(languageDict: jsonResult as! NSDictionary)
            } catch {
                // handle error
            }
        }
    }
    //MARK: - app language setup
    
    func setAppLanguage(Language: String) {
        UserDefaults.standard.set(Language, forKey: "language_name")
    }
    func getAppLanguage() -> String? {
        return UserDefaults.standard.value(forKey: "language_name") as? String
    }
    
    func setAppLanguageCode(Language: String) {
        UserDefaults.standard.set(Language, forKey: "language_code")
    }
    func getAppLanguageCode() -> String? {
        return UserDefaults.standard.value(forKey: "language_code") as? String
    }
    func setappleAccountEmail(email:String)
    {
        UserDefaults.standard.set(email, forKey: "apple_email")
    }
    func getappleAccountEmail() -> String?
    {
        return UserDefaults.standard.value(forKey: "apple_email") as? String
    }
    func setappleAccountname(name:String)
    {
        UserDefaults.standard.set(name, forKey:"apple_name")
    }
    
    func getappleAccountname() -> String?
    {
        return UserDefaults.standard.value(forKey: "apple_name") as? String
    }
    
    //MARK:set App language
    func setDefaultLanguage(languageDict: NSDictionary){
        UserDefaults.standard.set(languageDict, forKey: "app_language")
    }
    func getLanguage() -> NSDictionary? {
        return UserDefaults.standard.value(forKey: "app_language") as? NSDictionary
    }
    
    //***************************************** Gradient Layer ****************************************************>
    
    func gradient(size:CGSize) -> CAGradientLayer{
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        gradientLayer.frame.size = size
        gradientLayer.colors = PRIMARY_COLOR
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.2)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        //Use diffrent colors
        return gradientLayer
    }
     //MARK:************************************** Check string is empty ********************************************>
    
    func checkEmptyWithString(value:String) -> Bool {
        if  (value == "") || (value == "NULL") || (value == "(null)") || (value == "<null>") || (value == "Json Error") || (value == "0") || (value.isEmpty) ||  value.trimmingCharacters(in: .whitespaces).isEmpty || value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty  {
            return true
        }
        return false
    }
    
   //MARK: ****************************************Network rechability ************************************************.
    
    func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        return ret
    }
    
    //MARK: store & get tab index
    func setTab(index: Int){
        UserDefaults.standard.set(index, forKey: "tab_index")
    }
    func tabIndex() -> Int {
        return UserDefaults.standard.value(forKey: "tab_index") as! Int
    }
    
    //MARK: store & get Host tab index
    func setHostTab(index: Int){
        UserDefaults.standard.set(index, forKey: "tab_index")
    }
    func tabHostIndex() -> Int {
        return UserDefaults.standard.value(forKey: "tab_index") as! Int
    }
    //MARK: Show normal alertview
    func showAlert(msg:String){
        AJAlertController.initialization().showAlertWithOkButton(aStrMessage: msg, completion: { (index, title) in
        })
    }
    func getCurrentUserToken() -> NSString?
    {
        
        return UserDefaults.standard.value(forKey: "user_token") as? NSString
    }
    func getCurrentUserID() -> NSString?
    {
        
        return UserDefaults.standard.value(forKey: "user_id") as? NSString
    }
    
    func getPreferredCurrency() -> String?
    {
        return (UserDefaults.standard.value(forKey: "currency_rate") as? String)
    }
    
    func setPreferredCurrency(currency_rate:String)
    {
        UserDefaults.standard.set(currency_rate, forKey: "currency_rate")
        
    }
    func setopenTabbar(iswhichtabbar:Bool)
    {
       UserDefaults.standard.set(iswhichtabbar, forKey:"which_tabbar")
    }
    func getTabbar() -> Bool?
    {
      return UserDefaults.standard.value(forKey: "which_tabbar") as? Bool
    }
    func setUserToken(userID: NSString){
        UserDefaults.standard.set(userID, forKey: "user_token")
    }
    func setUserID(userid: NSString){
        UserDefaults.standard.set(userid, forKey: "user_id")
    }
    
    func setPassword(password: NSString)
    {
        UserDefaults.standard.set(password, forKey: "password")
    }
    func getPassword() -> NSString {
        
        return UserDefaults.standard.value(forKey: "password") as! NSString
    }
    func setEmail(email: NSString)
    {
        UserDefaults.standard.set(email, forKey: "email")
    }
    func getEmail() -> NSString {
        
        return UserDefaults.standard.value(forKey: "email") as! NSString
    }
    
    func getSymbol(forCurrencyCode code: String) -> String? {
        if(code == "USD")
        {
            return "$"
        }
        if(code == "JPY")
        {
            return "¥"
        }
        if code == "BGN" || code == "HUF" || code == "IDR" || code == "NOK" || code == "PLN" || code == "RUB" || code == "SEK" || code == "TRY"
        {
            return code
        }
        else{
        let locale = NSLocale(localeIdentifier: code)
        if locale.displayName(forKey: .currencySymbol, value: code) == code {
            let newlocale = NSLocale(localeIdentifier: code.dropLast() + "_en")
            return newlocale.displayName(forKey: .currencySymbol, value: code)
        }
        return locale.displayName(forKey: .currencySymbol, value: code)
        }
    }
//    func userLogout()
//    {
//        
//        UserDefaults.standard.removeObject(forKey: "user_token")
//        UserDefaults.standard.removeObject(forKey: "user_id")
//        UserDefaults.standard.removeObject(forKey: "password")
//        UserDefaults.standard.removeObject(forKey: "currency_rate")
//       // Utility.shared.pushnotification_devicetoken = ""
//        let welcomeObj = WelcomePageVC()
//        UIWindow().rootViewController?.present(welcomeObj, animated: false, completion: nil)
//       
//        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
//     //   UIWindow().rootViewController?.dismiss(animated: false, completion: nil)
//        //appDelegate.setInitialViewController(initialView: welcomeObj)
//    }
    
    //Restrict date in calender
    func maximum_notice_period(maximumnoticeperiod:String) ->Int?
    {
        if(maximumnoticeperiod == "3months")
        {
            return 3
        }
        else if(maximumnoticeperiod == "6months")
        {
            return 6
        }
        else if(maximumnoticeperiod == "9months")
        {
            return 9
        }
        else if(maximumnoticeperiod == "12months")
        {
            return 9
        }
        else if(maximumnoticeperiod == "available")
        {
            return 0
        }
        return 0
        
    }
    
    func getcolorcode(type:String) -> UIColor?
    
    {
        if(type == "Pending")
        {
            return UIColor().hexValue(hex:"337ab7")
        }
        else if((type == "Declined") || (type == "Cancelled"))
        {
           return UIColor().hexValue(hex:"d9534f")
        }
        else if((type == "Completed") || (type == "Approved"))
        {
            return UIColor().hexValue(hex:"5cb85c")
        }
        else if(type == "Inquiry")
        {
           return UIColor().hexValue(hex:"46A6F8")
        }
        else if((type == "CancelledByGuest") || (type == "CancelledByHost"))
        {
         return UIColor().hexValue(hex:"d9534f")
        }
        else if((type == "RequestToBook") || (type == "PreApproved"))
        {
          return UIColor().hexValue(hex:"337ab7")
        }
        else if(type == "Expired")
        {
            return UIColor().hexValue(hex:"f0ad4e")
        }
        return UIColor().hexValue(hex:"f0ad4e")
        
    }
    func getbookingtype(type:String) -> String?
    {
        
        if(type == "inquiry"){return "\((Utility.shared.getLanguage()?.value(forKey:"inquiry"))!)"}
        else if(type == "pending"){return "\((Utility.shared.getLanguage()?.value(forKey:"pending"))!)"}
        else if(type == "cancelled"){return "\((Utility.shared.getLanguage()?.value(forKey:"cancelled"))!)"}
        else if(type == "preApproved"){return "\((Utility.shared.getLanguage()?.value(forKey:"preapproved"))!)"}
        else if(type == "declined"){return "\((Utility.shared.getLanguage()?.value(forKey:"declined"))!)"}
        else if(type == "approved"){return "\((Utility.shared.getLanguage()?.value(forKey:"approved"))!)"}
        else if(type == "cancelledByHost"){return "\((Utility.shared.getLanguage()?.value(forKey:"cancelbyhost"))!)"}
        else if(type == "cancelledByGuest"){return "\((Utility.shared.getLanguage()?.value(forKey:"cancelbyguest"))!)"}
        else if(type == "intantBooking"){return "\((Utility.shared.getLanguage()?.value(forKey:"approved"))!)"}
        else if(type == "confirmed"){return "\((Utility.shared.getLanguage()?.value(forKey:"bookingconfirmed"))!)"}
        else if(type == "expired"){return "\((Utility.shared.getLanguage()?.value(forKey:"expired"))!)"}
        else if(type == "requestToBook"){return "\((Utility.shared.getLanguage()?.value(forKey:"requestbook"))!)"}
        else if(type == "completed"){return "\((Utility.shared.getLanguage()?.value(forKey:"completed"))!)"}
        else if(type == "reflection"){return "\((Utility.shared.getLanguage()?.value(forKey:"reflection"))!)"}
        else if(type == "message"){return "\((Utility.shared.getLanguage()?.value(forKey:"message"))!)"}
        return ""
    }
    
    
    //func to perform spring animation on imageview
    func performSpringAnimation(imgView: UIImageView) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            imgView.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
            //reducing the size
            UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                imgView.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }) { (flag) in
            }
        }) { (flag) in
        }
    }
    
    
    //Func to get Attributedtsrings
    func getAtrributedstring(fullString:String,ChangedString:String) -> NSMutableAttributedString
    {
        let main_string = fullString
        let string_to_color = ChangedString
        
        let range = (main_string as NSString).range(of: string_to_color)
        let attributedString = NSMutableAttributedString(string:main_string)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.darkGray , range: range)
        return attributedString
    }
    

}

@IBDesignable
extension UIView {
    // Shadow
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
        }
    }
    
    fileprivate func addShadow(shadowColor: CGColor = TextLightColor.cgColor, shadowOffset: CGSize = CGSize(width: 3.0, height: 3.0), shadowOpacity: Float = 0.35, shadowRadius: CGFloat = 5.0) {
        let layer = self.layer
        layer.masksToBounds = false
        
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius).cgPath
        
        let backgroundColor = self.backgroundColor?.cgColor
        self.backgroundColor = nil
        layer.backgroundColor =  backgroundColor
    }
    
    
    // Corner radius
    @IBInspectable var circle: Bool {
        get {
            return layer.cornerRadius == self.bounds.width*0.5
        }
        set {
            if newValue == true {
                self.cornerRadius = self.bounds.width*0.5
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    
    // Borders
    // Border width
    @IBInspectable
    public var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        
        get {
            return layer.borderWidth
        }
    }
    
    // Border color
    @IBInspectable
    public var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        
        get {
            if let borderColor = layer.borderColor {
                return UIColor(cgColor: borderColor)
            }
            return nil
        }
    }
}

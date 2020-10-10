//
//  AppDelegate.swift
//  Rent_All
//
//  Created by RADICAL START on 18/03/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import FBSDKLoginKit
import GoogleSignIn
import GoogleMaps
import GooglePlacePicker
import Apollo
import Stripe
import Firebase
import FirebaseCrashlytics
import UserNotifications
import FirebaseMessaging
import Siren


//MARK: **************************************** GLOBAL VARIABLE DECLARATIONS **************************************************************>
var tabNameArray = NSMutableArray()
var tabImageArray = NSMutableArray()
var tabImage_RedArray = NSMutableArray()
 var locationfromSearch:String!
var LauchShortcutItem: UIApplicationShortcutItem?


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate,MessagingDelegate {

    var window: UIWindow?
    
    var apollo_headerClient:ApolloClient!
  
  var statusBarStyle: UIStatusBarStyle = .lightContent
    var isreplyenabled:Bool = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        GIDSignIn.sharedInstance().clientID = "1042279124434-pd4c5gk3lao2odr52d2cuk6bh8dm0stb.apps.googleusercontent.com"
        //config goole api
        GMSServices.provideAPIKey(GOOGLE_API_KEY)
        GMSPlacesClient.provideAPIKey(GOOGLE_API_KEY)
        self.LanguageinitialSetup()
        self.GetDefaultSettingAPICall()
        self.getcurrencyAPICall()
        self.profileAPICall()
      //  self.checkActivesociallogin()
       
         STPPaymentConfiguration.shared().publishableKey = STRIPE_PUBLISHABLE_KEY
      
        STPPaymentConfiguration.shared().requiredBillingAddressFields = .zip
        
        
        
        //Siren.shared.wail()
        
        self.annoyingRuleExample()
        // UniversalLink after the app got killed is handled here
        
        var shortCutItemIsCalled = false
        if let shortcutItem = launchOptions?[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem{
            LauchShortcutItem = shortcutItem
           // handleShortcutItem(item: shortcutItem)
            shortCutItemIsCalled = true
        }
        

        if let option = launchOptions {
            let info = option[UIApplication.LaunchOptionsKey.remoteNotification]
            if (info != nil) {
            }}

        var isuniversalLinkClick: Bool = false
        let activityDictionary = launchOptions?[UIApplication.LaunchOptionsKey.userActivityDictionary] as? [UIApplication.LaunchOptionsKey: Any]
        let userActivity = activityDictionary?.values.first(where: { $0 is NSUserActivity }) as? NSUserActivity
    
        if activityDictionary != nil {
            isuniversalLinkClick = true
        }
        
        
        // Notification View after the app got killed is held here
        
        var isRemoteNotification: Bool = false
        var contentDict =  [String: Any]()
        var NotificationString = String()
        var userType = String()
        
        if let notifiedoptions = launchOptions{
            if   let info = notifiedoptions[UIApplication.LaunchOptionsKey.remoteNotification] as! [String: Any]? {
                           if info != nil{
                            
                            let variableName = info["content"] as! String
                            
                            if let data = variableName.data(using: String.Encoding.utf8) {
                                do {
                                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
                                    contentDict = json!
                                    print(json)
                                } catch {
                                    print("Something went wrong")
                                }
                            }
                            
                            if contentDict.count > 0 {
                               NotificationString =  contentDict["title"] as! String
                                userType = contentDict["userType"] as! String
                               isRemoteNotification = true
                            }
                            
                //                let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertController.Style.Alert)
                //                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                //                self.presentViewController(alert, animated: true, completion: nil)
                            

                           }
            }
            
            

            
        }
        

        if isuniversalLinkClick{
            
            if userActivity?.activityType == NSUserActivityTypeBrowsingWeb{
                let url = userActivity?.webpageURL!
                var view = url?.pathComponents
                // print(view)
                var str = url?.absoluteString
                //  print("Items Fetched : \(queryParameters(from: url))")
                let urlString = queryParameters(from: url!)
                print(urlString["email"])
                
                print("\(Utility.shared.pushnotification_devicetoken) -- \(Utility.shared.signupArray.count)" )
                
                if ((Utility.shared.getCurrentUserToken()) == nil || (Utility.shared.getCurrentUserToken()) == ""){
                    if view!.count > 0{
                        if view!.contains("password"){
                            Utility.shared.deepLinkEmail = urlString["email"]!
                            Utility.shared.deepLinkToken = urlString["token"]!
                            let resetPasswordPage = ResetPasswordVC()
                            self.setInitialViewController(initialView: resetPasswordPage)
                        }else{
                            let loginpage = LoginPageVC()
                            self.setInitialViewController(initialView: loginpage)
                        }
                        
                    }else{
                        
                        let loginpage = LoginPageVC()
                        self.setInitialViewController(initialView: loginpage)
                    }
                    
                }else{
                    if view!.count > 0{
                        if view!.contains("user"){
                            Utility.shared.ConfirmEmailString = urlString["email"]!
                            Utility.shared.ConfirmEmailToken = urlString["confirm"]!
                            let VerifyEmail = VerificationSuccessVC()
                            setInitialViewController(initialView: VerifyEmail)
                        }else{
                            
                            let loginpage = LoginPageVC()
                            self.setInitialViewController(initialView: loginpage)
                        }
                        
                    }else{
                        let loginpage = LoginPageVC()
                        self.setInitialViewController(initialView: loginpage)
                    }
                }
            }
            

            //let resetPasswordVC = ResetPasswordVC()
//            self.setInitialViewController(initialView: resetPasswordVC)
        }else if isRemoteNotification {
            
//            let alert = UIAlertController(title: "alert", message: "\(sampleString)", preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "okay", style: UIAlertAction.Style.default, handler: nil))
//            self.setInitialViewController(initialView: alert)
            if Utility.shared.isConnectedToNetwork() {
                
                if NotificationString == "New Inquiry" || NotificationString == "New Enquiry" || NotificationString == "New Message"{
                    
                    if userType == "guest"{
                        
                        
                        let inboxpageVc = InboxListingVC()
                        Utility.shared.ListID = (contentDict["listId"] as! NSString) as String
                        Utility.shared.isfromAppdelegateMessageOffline = true
                        inboxpageVc.threadId = Int((contentDict["threadId"] as! NSString).intValue)
                        inboxpageVc.getmessageListquery.removeAll()
                        inboxpageVc.getMessageListAPICall(threadId: Int((contentDict["threadId"] as! NSString).intValue))
                        self.setInitialViewController(initialView: inboxpageVc)
                        
                    }else{
                        
                        let inboxpageVc = InboxListingVC()
                        Utility.shared.ListID = (contentDict["listId"] as! NSString) as String
                        Utility.shared.isfromOfflineNotification = true
                        inboxpageVc.threadId = Int((contentDict["threadId"] as! NSString).intValue)
                        inboxpageVc.getmessageListquery.removeAll()
                        inboxpageVc.getMessageListAPICall(threadId: Int((contentDict["threadId"] as! NSString).intValue))
                        self.setInitialViewController(initialView: inboxpageVc)
                    }
                    
                }else if NotificationString == "New Booking" || NotificationString == "Booking is Cancelled" || NotificationString == "Approved" || NotificationString == "Declined"{
                    
                    if userType == "guest" {
                        
                        Utility.shared.setTab(index: 2)
                        self.GuestTabbarInitialize(initialView: CustomTabbar())
                        
                    }else{
                        
                        Utility.shared.isfromOfflineBooking = true
            
                        self.addingElementsToObjects()
                        self.settingRootViewControllerFunction()
                        
                    }
                    
                }
            }else{
                Utility.shared.setTab(index: 0)
                self.GuestTabbarInitialize(initialView: CustomTabbar())
                
            }
  
        }else if shortCutItemIsCalled == true {
            
//            var sampleDict = LauchShortcutItem?.userInfo as NSDictionary?
//            let alertController = UIAlertController(title: "Quick Action", message: "\(sampleDict)", preferredStyle: .alert)
//            alertController.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
//            window?.rootViewController?.present(alertController, animated: true, completion: nil)
            
        }else{
            if((Utility.shared.getCurrentUserToken()) != nil)
            {

                apollo_headerClient = {
                    let configuration = URLSessionConfiguration.default
                    // Add additional headers as needed
                    configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`

                    let url = URL(string:graphQLEndpoint)!

                    return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
                }()
                self.UserBanStatus()

            }

            else{
                Utility.shared.setTab(index: 0)
                self.GuestTabbarInitialize(initialView: CustomTabbar())
            }

        }

        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        window?.backgroundColor = .white
        FirebaseApp.configure()
        
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        Messaging.messaging().isAutoInitEnabled = true

        
        if #available(iOS 10, *) {

            
            
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                
                guard error == nil else {
                    //Display Error.. Handle Error.. etc..
                    return
                }
                
                if granted {
                    //Do stuff here..
                    
                    //Register for RemoteNotifications. Your Remote Notifications can display alerts now :)
                    DispatchQueue.main.async {
                        application.registerForRemoteNotifications()
                        UNUserNotificationCenter.current().delegate = self
                    }
                }
                else {
                    //Handle user denying permissions..
                }
            }
            
            //Register for remote notifications.. If permission above is NOT granted, all notifications are delivered silently to AppDelegate.
            application.registerForRemoteNotifications()
        }
        else {
            
            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
            UNUserNotificationCenter.current().delegate = self
            application.registerForRemoteNotifications()
            
        }
        
        
        
        return true
    }
    
//    func checkActivesociallogin()
//    {
//        let getactiveSocialLogin = GetActiveSocialLoginsQuery()
//        apollo.fetch(query: getactiveSocialLogin,cachePolicy:.fetchIgnoringCacheData) {(result,error) in
//
//            Utility.shared.isGoogleEnable = (result?.data?.getActiveSocialLogins?.results?.google!)!
//
//        }
//    }
    

    
    
    //MARK: - initial Language setup
    func LanguageinitialSetup(){
        Utility.shared.setAppLanguage(Language: DEFAULT_LANGUAGE)
//        //setup language
//        if Utility.shared.getAppLanguage() == nil{
//            Utility.shared.setAppLanguage(Language: DEFAULT_LANGUAGE)
//
//
//        }else{
//            Utility.shared.setAppLanguage(Language: Utility.shared.getAppLanguage()!)
//
//        }
//          if Utility.shared.getAppLanguageCode() == nil{
//
//             Utility.shared.setAppLanguageCode(Language:"en")
//        }
//        else
//          {
//            Utility.shared.setAppLanguageCode(Language:Utility.shared.getAppLanguageCode()!)
//        }
        Utility.shared.configureLanguage()
        
        //keyborad manager
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        
        print("It is Called")
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb {
            let url = userActivity.webpageURL!
            var view = url.pathComponents
           // print(view)
            var str = url.absoluteString
          //  print("Items Fetched : \(queryParameters(from: url))")
            let urlString = queryParameters(from: url)
            
            if ((Utility.shared.getCurrentUserToken()) == nil || (Utility.shared.getCurrentUserToken()) == ""){
                if view.count > 0{
                    if view.contains("password"){
                        Utility.shared.deepLinkEmail = urlString["email"]!
                        Utility.shared.deepLinkToken = urlString["token"]!
                        let resetPasswordPage = ResetPasswordVC()
                        self.setInitialViewController(initialView: resetPasswordPage)
                    }else{
                        let loginpage = LoginPageVC()
                        self.setInitialViewController(initialView: loginpage)
                    }
                    
                }else{
//                    let loginpage = LoginPageVC()
//                    self.setInitialViewController(initialView: loginpage)
                    
                }

            }else{
                
                 if view.count > 0{
                    if view.contains("user"){
                        Utility.shared.ConfirmEmailString = urlString["email"]!
                        Utility.shared.ConfirmEmailToken = urlString["confirm"]!
                        let VerifyEmail = VerificationSuccessVC()
                        setInitialViewController(initialView: VerifyEmail)
                    }else{
                        
//                        let loginpage = LoginPageVC()
//                        self.setInitialViewController(initialView: loginpage)
                    }

                 }else{
//                    let loginpage = LoginPageVC()
//                    self.setInitialViewController(initialView: loginpage)
                }

            }

            
        }
        return true
    }
    
    func queryParameters(from url: URL) -> [String: String]{
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        var queryParams = [String: String]()
        for queryItem: URLQueryItem in (urlComponents?.queryItems)!{
            if queryItem.value == nil{
                continue
            }
            queryParams[queryItem.name] = queryItem.value
        }
        return queryParams
    }
    

    func showPushButtons(){
        let replyAction = UNTextInputNotificationAction(
            identifier: "reply.action",
            title: "Reply on message",
            textInputButtonTitle: "Send",
            textInputPlaceholder: "Input text here")
        
        let pushNotificationButtons = UNNotificationCategory(
            identifier: "allreply.action",
            actions: [replyAction],
            intentIdentifiers: [],
            options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([pushNotificationButtons])
    }


    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("\(response.notification.request.content.userInfo)")
        
        
        let userdata = response.notification.request.content.userInfo
        if let textResponse =  response as? UNTextInputNotificationResponse {
            let sendText =  textResponse.userText
            print("Received text message: \(sendText)")
            var threadid = String()
            if let bedtypeInfo = userdata["content"] as? String
            {
                if let dict = convertToDictionary(text:bedtypeInfo)
                {
                    threadid = (dict["threadId"] as?String)!
                    sendMessageAPICall(threadid:Int(threadid)!, message:sendText)
                    
                }
            }
            
            
            
            
        }
        
        
        let appstatechecker = UIApplication.shared.applicationState
        
        if(appstatechecker == UIApplication.State.inactive) || (appstatechecker == UIApplication.State.background)
        {
            let userContent = userdata["content"] as? String
            print("Content String \(String(describing: userdata["content"]))")
            let ContentDictionary = convertToDictionary(text:userContent!)
            //print(ContentDictionary!["hostId"] as? String)
            print(ContentDictionary!["title"] as! String)
            print("background")
            
            let userType = ContentDictionary!["userType"] as? String
            
            Utility.shared.isfromNotificationHost = false
            Utility.shared.isfromBackroundBooking = false
            Utility.shared.isfromOfflineBooking = false
            
            let navigationString = (ContentDictionary!["title"] as? String)

            
            if Utility.shared.isConnectedToNetwork() {
                
                
                if navigationString == "New Inquiry" || navigationString == "New Enquiry" || navigationString == "New Message" {
                    
                    if userType == "guest"{
                        
                        let inboxPage = InboxListingVC()
                        Utility.shared.ListID = "\(ContentDictionary!["listId"] as! NSString)"

                        Utility.shared.isfromAppDelegateMessageBackground = true
                        // Utility.shared.isfromNotificationHost = true
                        inboxPage.threadId = Int((ContentDictionary!["threadId"] as! NSString).intValue)
                        inboxPage.getmessageListquery.removeAll()
                        inboxPage.getMessageListAPICall(threadId: Int((ContentDictionary!["threadId"] as! NSString).intValue))
                        self.setInitialViewController(initialView: inboxPage)
                        
                    }else{
                        let inboxPage = InboxListingVC()
                         Utility.shared.ListID = "\(ContentDictionary!["listId"] as! NSString)"
                        Utility.shared.isfromNotificationHost = true
                        inboxPage.threadId = Int((ContentDictionary!["threadId"] as! NSString).intValue)
                        inboxPage.getmessageListquery.removeAll()
                        inboxPage.getMessageListAPICall(threadId: Int((ContentDictionary!["threadId"] as! NSString).intValue))
                        self.setInitialViewController(initialView: inboxPage)
                    }
                    
                }else if navigationString == "New Booking" || navigationString == "Booking is Cancelled" || navigationString == "Approved" || navigationString == "Declined"{
                    
                    
                    if userType == "guest" {
                        Utility.shared.setTab(index: 2)
                        self.GuestTabbarInitialize(initialView: CustomTabbar())
                        
                    }else{
                        
                        Utility.shared.isfromBackroundBooking = true
                          Utility.shared.isfromNotificationHost = true
                        self.addingElementsToObjects()
                        self.settingRootViewControllerFunction()
                        
                    }
                    
                }
            }else{
                
                
            }
            
            
            
            if #available(iOS 10.0, *) {
                let center = UNUserNotificationCenter.current()
                center.removeAllPendingNotificationRequests() // To remove all pending notifications which are not delivered yet but scheduled.
                center.removeAllDeliveredNotifications() // To remove all delivered notifications
            } else {
                UIApplication.shared.cancelAllLocalNotifications()
            }
        }
        
        
        completionHandler()
    }


    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    func sendMessageAPICall(threadid:Int,message:String)
    {
        var apollo_headerClient: ApolloClient = {
            let configuration = URLSessionConfiguration.default
            // Add additional headers as needed
            configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
            
            let url = URL(string:graphQLEndpoint)!
            
            return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
        }()
        let sendMsgMutation = SendMessageMutation(threadId:threadid,content:message, type: "message")
        
        apollo_headerClient.perform(mutation: sendMsgMutation){(result,error) in
            guard (result?.data?.sendMessage?.results) != nil else{
                print("Missing Data")
                return
            }
            print("sent")
            let appstatechecker = UIApplication.shared.applicationState
            if(appstatechecker == UIApplication.State.inactive)
            {
                if #available(iOS 10.0, *) {
                    let center = UNUserNotificationCenter.current()
                    center.removeAllPendingNotificationRequests() // To remove all pending notifications which are not delivered yet but scheduled.
                    center.removeAllDeliveredNotifications() // To remove all delivered notifications
                } else {
                    UIApplication.shared.cancelAllLocalNotifications()
                }
            }
            
            
        }
    }
    func GetDefaultSettingAPICall()
    {
        if(Utility.shared.getCurrentUserToken() != nil)
        {
        apollo_headerClient = {
            let configuration = URLSessionConfiguration.default
            // Add additional headers as needed
            configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
            
            let url = URL(string:graphQLEndpoint)!
            
            return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
        }()
            let mostlistingquery = GetDefaultSettingQuery()
            apollo_headerClient.fetch(query: mostlistingquery,cachePolicy:.fetchIgnoringCacheData){(result,error) in
                //RecommendedListing
                guard (result?.data?.currency?.result) != nil else {
                    print("Missing data")
                    return
                }
                Utility.shared.currencyvalue_from_API_base = (result?.data?.currency?.result?.base)!
                let currency_value = result?.data?.currency?.result?.rates
                Utility.shared.currency_Dict = self.convertToDictionary(text: currency_value!)! as NSDictionary
                
        }
        }
    }
    
    func profileAPICall()
    {
        
        if(Utility.shared.getCurrentUserToken() != nil)
        {
        let profileQuery = GetProfileQuery()
            apollo_headerClient = {
                let configuration = URLSessionConfiguration.default
                // Add additional headers as needed
                configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
                
                let url = URL(string:graphQLEndpoint)!
                
                return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
            }()
        apollo_headerClient.fetch(query:profileQuery,cachePolicy:.fetchIgnoringCacheData){(result,error) in
            
            guard (result?.data?.userAccount?.result) != nil else
            {
                print("Missing Data")
                
                return
            }
            
            
            Utility.shared.ProfileAPIArray = ((result?.data?.userAccount?.result)!)
            
         
           
            }
        }
        }
        
    
    func getcurrencyAPICall()
    {
        if(Utility.shared.getCurrentUserToken() != nil)
        {
        apollo_headerClient = {
            let configuration = URLSessionConfiguration.default
            // Add additional headers as needed
            configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
            
            let url = URL(string:graphQLEndpoint)!
            
            return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
        }()
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
    }

    //MARK:CHECK USERBAN STATUS
    func UserBanStatus()
    {
        let UserbanstatusQuery = UserBanStatusQuery()
        
        apollo_headerClient.fetch(query: UserbanstatusQuery){(result,error) in
            
            if(result?.data?.getUserBanStatus?.status == 200)
            {
                if(((Utility.shared.getTabbar()) != nil) && Utility.shared.getTabbar() == true)
                {
                    Utility.shared.host_message_isfromHost = true
                    self.addingElementsToObjects()
                    self.settingRootViewControllerFunction()
                }
                else
                {
                Utility.shared.setTab(index: 0)
                self.GuestTabbarInitialize(initialView: CustomTabbar())
                }
                

                
            }
            else if(result?.data?.getUserBanStatus == nil)
            {
            
                 if(Utility.shared.getTabbar() != nil && Utility.shared.getTabbar() == true)
                {
                    Utility.shared.host_message_isfromHost = true
                    self.addingElementsToObjects()
                    self.settingRootViewControllerFunction()
                }
                else
                {
            Utility.shared.setTab(index: 0)

            self.GuestTabbarInitialize(initialView: CustomTabbar())
                }
            }
            else
            {
           
                if(Utility.shared.getTabbar() != nil && Utility.shared.getTabbar() == true)
                {
                    Utility.shared.host_message_isfromHost = true
                    self.addingElementsToObjects()
                    self.settingRootViewControllerFunction()
                }
                else
                {
            Utility.shared.setTab(index: 0)

            self.GuestTabbarInitialize(initialView: CustomTabbar())
                }
            }
            
            
        }
        
    }
        
    
    
    // MARK:set initial view controller
    func setInitialViewController(initialView: UIViewController)  {
         IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        window?.backgroundColor = .white
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController?.dismiss(animated: false, completion: nil)
        let homeViewController = initialView
        let nav = UINavigationController(rootViewController: homeViewController)
        nav.isNavigationBarHidden = true
       
        window!.rootViewController = nav
        window!.makeKeyAndVisible()
    }
    func GuestTabbarInitialize(initialView:UITabBarController)
    {
        Utility.shared.setopenTabbar(iswhichtabbar:false)
        Utility.shared.host_message_isfromHost = false
        Utility.shared.host_message_isfrommessage = false
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
         window?.rootViewController?.dismiss(animated: false, completion: nil)
        window?.rootViewController = initialView
        window?.rootViewController?.view.backgroundColor = .white
        window?.makeKeyAndVisible()
        
    }
    
    

    public func application(_ application: UIApplication,
                            continue userActivity: NSUserActivity,
                            restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        guard let url = userActivity.webpageURL else {
            return false
        }
       window?.rootViewController = ResetPasswordVC()
        window?.makeKeyAndVisible()
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb {
            if let url = userActivity.webpageURL {
                let stripeHandled = Stripe.handleURLCallback(with: url)
                if (stripeHandled) {
                    return true
                } else {
                    // This was not a Stripe url – handle the URL normally as you would
                }
            }
        }


        return true
    }
    
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if let scheme = url.scheme,
            scheme.localizedCaseInsensitiveCompare("com.rs.RentALL") == .orderedSame,
            let view = url.host {
            
            var parameters: [String: String] = [:]
            URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?.forEach {
                parameters[$0.name] = $0.value
            }
            window?.rootViewController = ResetPasswordVC()
         
        }
        let stripeHandled = Stripe.handleURLCallback(with: url)
               if (stripeHandled) {
                   return true
               } else {
                   // This was not a Stripe url – handle the URL normally as you would
               }
        return true
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {

        let facebookHandle = ApplicationDelegate.shared.application(application,open: (url as URL?)!,sourceApplication: sourceApplication,annotation: annotation)
        return facebookHandle

    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        
        // Handle quick actions
        
        LauchShortcutItem = shortcutItem
        completionHandler(handleShortcutItem(item: shortcutItem))
       // completionHandler(handleQuickAction(shortcutItem))
        
        
    }
    

    enum shortCutItemIdentifier: String{
        
        case first
        case message
        case saved
        init?(fullnameForType: String){
            guard let last = fullnameForType.components(separatedBy: ".").last else{return nil}
            self.init(rawValue: last)
        }
        
        var type: String{
            return Bundle.main.bundleIdentifier! + ".\(self.rawValue)"
        }
    }
    func configureDynamicData(){
        
//        let identifier = Bundle.main.bundleIdentifier! + ".message"
//        let item = UIApplicationShortcutItem.init(type: identifier, localizedTitle: "message", localizedSubtitle: "Speed up your message", icon: UIApplicationShortcutIcon.init(systemImageName: "tabchat_red"), userInfo: nil)
//        UIApplication.shared.shortcutItems = [item]
        if Utility.shared.getTabbar() != nil && Utility.shared.getTabbar() == true{
             if((Utility.shared.getCurrentUserToken()) == nil || (Utility.shared.getCurrentUserToken()) == ""){
                
                let welcomepage = WelcomePageVC()
                self.setInitialViewController(initialView: welcomepage)
    
             }else{
                Utility.shared.isfromMessageShortcut = true
                 self.addingElementsToObjects()
                self.settingRootViewControllerFunction()
            }
        }else{
             if((Utility.shared.getCurrentUserToken()) == nil || (Utility.shared.getCurrentUserToken()) == ""){
                let welcomepage = WelcomePageVC()
                self.setInitialViewController(initialView: welcomepage)
             }else{
                Utility.shared.setTab(index: 3)
                self.GuestTabbarInitialize(initialView: CustomTabbar())
            }
        }
//        let messagePage = TripsMessageVC()
//        setInitialViewController(initialView: messagePage)
    }
    
    
    func NavigatetoSavedPage(){
//        if(((Utility.shared.getTabbar()) != nil) && Utility.shared.getTabbar() == true)
//                       {
//                           Utility.shared.host_message_isfromHost = true
//                           self.addingElementsToObjects()
//                           self.settingRootViewControllerFunction()
//                       }
        
        if Utility.shared.getTabbar() != nil && Utility.shared.getTabbar() == true{
            
            Utility.shared.isfromHost = true
            Utility.shared.isfromSavedShortcut = true
            let splashscreen  = SwitchTravelAndHostVC()
            self.setInitialViewController(initialView: splashscreen)
            
        }else{
            if((Utility.shared.getCurrentUserToken()) == nil || (Utility.shared.getCurrentUserToken()) == ""){
                let welcomepage = WelcomePageVC()
                self.setInitialViewController(initialView: welcomepage)
               
            }else{
                Utility.shared.setTab(index: 1)
                self.GuestTabbarInitialize(initialView: CustomTabbar())
            }
        }

    }
    func handleShortcutItem(item: UIApplicationShortcutItem) -> Bool {
        var handled = false
        
        guard shortCutItemIdentifier(fullnameForType: item.type) != nil else {return false}
        guard let shortcutType = item.type as String? else {return false}
        
//        let mainStoryboard = UIStoryboard.init(name: "main", bundle: Bundle.main)
//        var reqVC: UIViewController!
        
        switch shortcutType {
            
        case shortCutItemIdentifier.first.type:
            handled = true
            Utility.shared.setTab(index: 3)
            self.GuestTabbarInitialize(initialView: CustomTabbar())
        case shortCutItemIdentifier.message.type:
            self.configureDynamicData()
            return true
        case shortCutItemIdentifier.saved.type:
            self.NavigatetoSavedPage()
            return true
        default:
        print("Nothing")
        }
        return handled
        
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        application.applicationIconBadgeNumber = 0
        AppEvents.activateApp()
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        if let shortcutItem = LauchShortcutItem {
               var message = "\(shortcutItem.type) triggered"
//                if let name = shortcutItem.userInfo?["Name"] {
//                    message += " for \(name)"
//                }
//                let alertController = UIAlertController(title: "Quick Action", message: message, preferredStyle: .alert)
//                alertController.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
//                window?.rootViewController?.present(alertController, animated: true, completion: nil)

                // Reset the shortcut item so it's never processed twice.
                LauchShortcutItem = nil
            }
            print("success")
//        }
        
//        guard let shortcutItem = LauchShortcutItem else { return }
//        
//        //If there is any shortcutItem,that will be handled upon the app becomes active
//        _ = handleShortcutItem(item: shortcutItem)
//        //We make it nil after perfom/handle method call for that shortcutItem action
//        LauchShortcutItem = nil
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    //MARK: - Pushnotification  Implementation:
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            // 1. Check if permission granted
            guard granted else { return }
            // 2. Attempt registration for remote notifications on the main thread
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
   
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        
        
        if Utility.shared.isConnectedToNetwork() {
            // Print full message.
            print("userinfo\(userInfo)")
            let userdata = userInfo
            let userContent = userdata["content"] as? String
            print("Content String \(String(describing: userdata["content"]))")
            let ContentDictionary = convertToDictionary(text:userContent!)
            print(ContentDictionary!["hostId"] as? String)
            print(ContentDictionary!["title"] as! String)
            
            //Parsing userinfo:
            print("Notify me: \(userInfo)")
            let aps = userInfo["aps"] as! NSDictionary
            print("Data APNS : \(aps) ")
            if let userAlert = aps["alert"] as? NSDictionary{
                //            let messageBody = userAlert["body"] as! String
                //            let titleNotification = userAlert["title"] as! String
                
            }
            
            // Push Notification Customization
            var screentype = String()
            if let bedtypeInfo = userdata["content"] as? String
            {
                if let dict = convertToDictionary(text:bedtypeInfo)
                {
                    screentype = (dict["title"] as?String)!
                    if(screentype == "New Message")
                    {
                        isreplyenabled = true
                        
                        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
                            if error != nil
                            {
                                print("\u{1F6AB} \(error!.localizedDescription).")
                            }
                            else
                            {
                                if granted
                                {
                                    print("\u{2705} Request granted.")
                                    
                                    let commentAction = UNTextInputNotificationAction(identifier:"myNotificationCategory", title: "Comment", options: [], textInputButtonTitle: "Send", textInputPlaceholder: "")
                                    let category = UNNotificationCategory(identifier:"", actions: [commentAction], intentIdentifiers: [], options: [])
                                    UNUserNotificationCenter.current().setNotificationCategories([category])
                                    UNUserNotificationCenter.current().delegate = self
                                    return
                                    
                                }
                                else
                                {
                                    print("\u{1F6AB} Request denied.")
                                    let center = UNUserNotificationCenter.current()
                                    center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
                                        // Enable or disable features based on authorization.
                                    }
                                }
                            }
                        }
                    }
                    else
                    {
                        isreplyenabled = false
                        
                        let category = UNNotificationCategory(identifier:"", actions:[], intentIdentifiers: [], options: [])
                        UNUserNotificationCenter.current().setNotificationCategories([category])
                        UNUserNotificationCenter.current().delegate = self
                        
                        return
                        
                    }
                    
                    
                }
            }
        }else{
            
        }
 
    }

    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        
        print("received remote notification \(remoteMessage.appData)")
        
        
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
//        if((Utility.shared.getCurrentUserToken()) != nil)
//        {
        // 1. Convert device token to string
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        let token = tokenParts.joined()
        // 2. Print device token to use for PNs payloads
        print("Device Token: \(token)")
      //  Utility.shared.pushnotification_devicetoken = "\(token)"
        Messaging.messaging().apnsToken = deviceToken as Data
      //  }
        
    }
  
    // MARK:- Messaging Delegates
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
//        if((Utility.shared.getCurrentUserToken()) != nil)
//        {
            InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            } else if let result = result {
                 Utility.shared.pushnotification_devicetoken = "\(result.token)"
                print("Remote instance ID token: \(result.token)")
            //}
        }
        let dataDict:[String: String] = ["token": fcmToken]
        Utility.shared.pushnotification_devicetoken  = fcmToken
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
       }
        
    }
    //MARK: Register for push notification
    
    func registerForPushNotification(_ application: UIApplication)  {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        
    }
    
    
    
    

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // 1. Print out error if PNs registration not successful
        print("Failed to register for remote notifications with error: \(error)")
    }
    
 

    // This method will be called when app received push notifications in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler([.alert, .badge, .sound])
    }
    // For handling tap and user actions


    //Mark: SetinitialController ********************************************************************************>
    
    


//    func application(application: UIApplication,
//                     openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
//        var options: [String: AnyObject] = [UIApplication.OpenURLOptionsKey.sourceApplication.rawValue: sourceApplication as AnyObject,
//                                            UIApplication.OpenURLOptionsKey.annotation.rawValue: annotation!]
//        return GIDSignIn.sharedInstance().handle(url as URL,
//                                                    sourceApplication: sourceApplication,
//                                                    annotation: annotation)
//    }
    
    //MARK:************************************* GLOBAL DECLARATION METHODS ***************************************************>
    
    func settingRootViewControllerFunction()
    {
        let tabBarController = UITabBarController()
   
        if let aSize = UIFont(name: "Avenir Next Demi", size: 15.0) {
            UITabBarItem.appearance().setTitleTextAttributes([
                NSAttributedString.Key.font : aSize,
                NSAttributedString.Key.foregroundColor : TabSelectedColor
                ], for: .selected)
        }
        if let aSize = UIFont(name: "Avenir Next Demi", size: 15.0) {
            UITabBarItem.appearance().setTitleTextAttributes([
                 NSAttributedString.Key.font : aSize,
                 NSAttributedString.Key.foregroundColor : UIColor.black
                ], for: .normal)
        }
    
        tabBarController.tabBar.tintColor = Theme.PRIMARY_COLOR
        tabBarController.tabBar.unselectedItemTintColor = .black
        UITabBar.appearance().barTintColor = UIColor.white
        
        tabBarController.tabBarItem.titlePositionAdjustment =  UIOffset(horizontal: 0, vertical: -4)
        
        let explorePageObj = HostListingVC(
            nibName: "HostListingVC",
            bundle: nil)
        let savedPAgeObj = HostCalendarVC(
            nibName: "HostCalendarVC",
            bundle: nil)
        let TripsPageObj = HostProgressVC(
            nibName: "HostProgressVC",
            bundle: nil)
        let MessagePageObj = TripsMessageVC(
            nibName: "TripsMessageVC",
            bundle: nil)
        let ProfilePageObj = ProfilePageVC(
            nibName: "ProfilePageVC",
            bundle: nil)
        explorePageObj.tabBarItem.tag = 0
        savedPAgeObj.tabBarItem.tag = 1
        TripsPageObj.tabBarItem.tag = 2
        MessagePageObj.tabBarItem.tag = 3
        ProfilePageObj.tabBarItem.tag = 4
        
//        if Utility.shared.isfromNotificationHost || Utility.shared.isfromOfflineNotification || Utility.shared.isfromBackroundBooking{
//
//        }
       
        
        let controllers = [explorePageObj,savedPAgeObj,TripsPageObj,MessagePageObj,ProfilePageObj]
        print(controllers.count)
       // tabBarController.setViewControllers(controllers, animated: false)
        tabBarController.viewControllers = controllers
        print(tabBarController.viewControllers?.count)
        
        self.tarbarIconUpdates(tabBarController)
       // tabBarController.selectedIndex = 3
        
           window = UIWindow(frame: UIScreen.main.bounds)
        if Utility.shared.isfromOfflineNotification || Utility.shared.isfromNotificationHost || Utility.shared.isfromAppDelegateMessageBackground || Utility.shared.isfromAppdelegateMessageOffline || Utility.shared.isFromMessageListingPage_host || Utility.shared.isfromMessageShortcut{
            
           // tabBarController.selectedViewController = controllers[3]
            Utility.shared.isfromMessageShortcut = false
            tabBarController.selectedIndex = 3
        
        }else if Utility.shared.isfromBackroundBooking || Utility.shared.isfromOfflineBooking{

             tabBarController.selectedIndex = 2
           //tabBarController.selectedViewController = controllers[2]
            print(tabBarController.tabBar.selectedItem)

        }

   
    //    window?.rootViewController?.dismiss(animated: false, completion: nil)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    
      //  Utility.shared.isfromNotificationHost = false
    }
    func tarbarIconUpdates(_ tabbarController: UITabBarController?)
    {
        print(tabbarController?.tabBar.items?.count)
        for item: UITabBarItem in (tabbarController?.tabBar.items)! {
            print(item)
            item.title = tabNameArray[item.tag] as? String
            item.image = ((tabImageArray[item.tag]) as! UIImage)
            item.selectedImage = ((tabImageArray[item.tag]) as! UIImage)
            if(!IS_IPHONE_XR)
            {
            item.titlePositionAdjustment.vertical = item.titlePositionAdjustment.vertical-5
            }
        }
    }
    func addingElementsToObjects(){
        
        tabImage_RedArray.removeAllObjects()
        tabImageArray.removeAllObjects()
        tabNameArray.removeAllObjects()
        tabNameArray.add("\((Utility.shared.getLanguage()?.value(forKey:"list_upper"))!)")
        tabNameArray.add("\((Utility.shared.getLanguage()?.value(forKey:"calendar_upper"))!)")
        tabNameArray.add("\((Utility.shared.getLanguage()?.value(forKey:"progress_upper"))!)")
        tabNameArray.add("\((Utility.shared.getLanguage()?.value(forKey:"tabinbox"))!)")
        tabNameArray.add("\((Utility.shared.getLanguage()?.value(forKey:"tabprofile"))!)")
        
        
        tabImageArray = [#imageLiteral(resourceName: "home-25-2"),#imageLiteral(resourceName: "calendar-25-2"),#imageLiteral(resourceName: "tabtrip"),#imageLiteral(resourceName: "tabchat"),#imageLiteral(resourceName: "tabprofile")]
        tabImage_RedArray = [#imageLiteral(resourceName: "tablisting_red"),#imageLiteral(resourceName: "tabcalendar_red"),#imageLiteral(resourceName: "tabtrip_red"),#imageLiteral(resourceName: "tabchat_red"),#imageLiteral(resourceName: "tabprofile_red")]

        
    }
    
    
    
    
    func GuestsettingRootViewControllerFunction(){
        let tabBarController = UITabBarController()
        
        if let aSize = UIFont(name: "Avenir Next Demi", size: 15.0) {
            UITabBarItem.appearance().setTitleTextAttributes([
                NSAttributedString.Key.font : aSize,
                NSAttributedString.Key.foregroundColor : TabSelectedColor
                ], for: .selected)
        }
        if let aSize = UIFont(name: "Avenir Next Demi", size: 15.0) {
            UITabBarItem.appearance().setTitleTextAttributes([
                NSAttributedString.Key.font : aSize,
                NSAttributedString.Key.foregroundColor : UIColor.black
                ], for: .normal)
        }
        
        tabBarController.tabBar.tintColor = Theme.PRIMARY_COLOR
        tabBarController.tabBar.unselectedItemTintColor = .black
        UITabBar.appearance().barTintColor = UIColor.white
        
        tabBarController.tabBarItem.titlePositionAdjustment =  UIOffset(horizontal: 0, vertical: -4)
        
        let explorePageObj = ExplorePageVC(
            nibName: "ExplorePageVC",
            bundle: nil)
        let savedPAgeObj = SavedPageVC(
            nibName: "SavedPageVC",
            bundle: nil)
        let TripsPageObj = TripsMainVC(
            nibName: "TripsMainVC",
            bundle: nil)
        let MessagePageObj = TripsMessageVC(
            nibName: "TripsMessageVC",
            bundle: nil)
        let ProfilePageObj = ProfilePageVC(
            nibName: "ProfilePageVC",
            bundle: nil)
        explorePageObj.tabBarItem.tag = 0
        savedPAgeObj.tabBarItem.tag = 1
        TripsPageObj.tabBarItem.tag = 2
        MessagePageObj.tabBarItem.tag = 3
        ProfilePageObj.tabBarItem.tag = 4
        
        let controllers = [explorePageObj,savedPAgeObj,TripsPageObj,MessagePageObj,ProfilePageObj]
        tabBarController.viewControllers = controllers
        self.GuesttarbarIconUpdates(tabBarController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    func GuesttarbarIconUpdates(_ tabbarController: UITabBarController?)
    {
        for item: UITabBarItem in (tabbarController?.tabBar.items)! {
            item.title = tabNameArray[item.tag] as? String
            item.image = ((tabImageArray[item.tag]) as! UIImage)
            item.selectedImage = ((tabImage_RedArray[item.tag]) as! UIImage)
            if(!IS_IPHONE_XR)
            {
                item.titlePositionAdjustment.vertical = item.titlePositionAdjustment.vertical-5
            }
        }
    }
    func GuestaddingElementsToObjects(){
        tabImage_RedArray.removeAllObjects()
        tabImageArray.removeAllObjects()
        tabNameArray.removeAllObjects()
        tabNameArray.add("EXPLORE")
        tabNameArray.add("SAVED")
        tabNameArray.add("TRIPS")
        tabNameArray.add("INBOX")
        tabNameArray.add("PROFILE")
        
        
        tabImageArray = [#imageLiteral(resourceName: "tabsearch"),#imageLiteral(resourceName: "tabsaved"),#imageLiteral(resourceName: "tabtrip"),#imageLiteral(resourceName: "tabchat"),#imageLiteral(resourceName: "tabprofile")]
        tabImage_RedArray = [#imageLiteral(resourceName: "tabsearch_red"),#imageLiteral(resourceName: "tabsaved_red"),#imageLiteral(resourceName: "tabtrip_red"),#imageLiteral(resourceName: "tabchat_red"),#imageLiteral(resourceName: "tabprofile_red")]

        
    }
    
    func annoyingRuleExample() {
        let siren = Siren.shared
        siren.rulesManager = RulesManager(globalRules: .annoying)

        siren.wail { results in
            switch results {
            case .success(let updateResults):
                print("AlertAction ", updateResults.alertAction)
                print("Localization ", updateResults.localization)
                print("Model ", updateResults.model)
                print("UpdateType ", updateResults.updateType)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

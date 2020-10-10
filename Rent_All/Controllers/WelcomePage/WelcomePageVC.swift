//
//  WelcomePageVC.swift
//  Rent_All
//
//  Created by RADICAL START on 19/03/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons
import FBSDKLoginKit
import GoogleSignIn
import AuthenticationServices

class WelcomePageVC: UIViewController,GIDSignInDelegate  {
    
    
    //********************Outlet Connection *****************************************>
    @IBOutlet var welcomeView: UIView!
    @IBOutlet var socailloginBtn: UIButton!
    
    @IBOutlet var loginalterBtn: UIButton!
    @IBOutlet var closeBtn: UIButton!
    
    @IBOutlet var fbimage: UIImageView!
    @IBOutlet var loginBtn: UIButton!
    
    @IBOutlet var googleimg: UIImageView!
    @IBOutlet var welcomeLabel: UILabel!
  
    
    @IBOutlet var googleLabel: UIButton!
    
    @IBOutlet var createAccountLabel: UIButton!
    
    @IBOutlet var facebookLabel: UIButton!
    @IBOutlet var infoLabel: UILabel!
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        self.navigationController?.isNavigationBarHidden = true
        self.initialSetup()
        NotificationCenter.default.removeObserver(self)
        
       // welcomeView.backgroundColor = Theme.PRIMARY_COLOR
      //  self.view.backgroundColor = Theme.PRIMARY_COLOR
        fbimage.image = #imageLiteral(resourceName: "fb_logo").withRenderingMode(.alwaysTemplate)
        fbimage.tintColor = Theme.PRIMARY_COLOR
        googleimg.image = #imageLiteral(resourceName: "g_logo").withRenderingMode(.alwaysTemplate)
        googleimg.tintColor = Theme.PRIMARY_COLOR
        self.welcomeView.applyGradient(colours:PRIMARY_COLOR)
        self.view.applyGradient(colours: PRIMARY_COLOR)
        
        
        
        socailloginBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey: "DoSocialLogin"))!)", for: .normal)
        // Do any additional setup after loading the view.
    }
//    deinit {
//        print("Remove NotificationCenter Deinit")
//        NotificationCenter.default.removeObserver(self)
//    }
    //Mark: ************************************* ButtonActions ******************************************>
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    @IBAction func closeAction(_ sender: Any) {
  
        Utility.shared.isfromdetailpage = false

        Utility.shared.setTab(index: 0)
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)

        appdelegate.GuestTabbarInitialize(initialView: CustomTabbar())
    }
    
    @IBAction func FacebookAction(_ sender: Any) {
        faceBookLogin(viewC: self)
    }
    
    @IBAction func googleAction(_ sender: Any) {


        URLCache.shared.removeAllCachedResponses()

        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                HTTPCookieStorage.shared.deleteCookie(cookie)
            }
        }
        GIDSignIn.sharedInstance().signOut()
        GIDSignIn.sharedInstance().signIn()
    }

    @IBAction func createAccountAction(_ sender: Any) {
        Utility.shared.signupArray.removeAllObjects()
        let FirstnameObj = FirstLastnamePageVC()
        FirstnameObj.modalPresentationStyle = .fullScreen
         self.present(FirstnameObj, animated: false, completion: nil)
       // self.navigationController?.pushViewController(FirstnameObj, animated: true)
    }
 
    @IBAction func socialLoginAction(_ sender: Any) {
        
        let socialloginObj = SocialSigninPage()
        socialloginObj.modalPresentationStyle = .fullScreen
        self.present(socialloginObj, animated: false, completion: nil)

    }

    
    @IBAction func loginBtnAction(_ sender: Any) {
        let loginObj = LoginPageVC()
        loginObj.modalPresentationStyle = .fullScreen
   // self.view.window?.rootViewController?.present(loginObj, animated: false, completion: nil)
    self.present(loginObj, animated: false, completion: nil)
       // self.navigationController?.pushViewController(loginObj, animated: true)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

   
    // Mark:Functions *******************************************************************************************>
    
    func initialSetup()
    {
        
      welcomeView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height: FULLHEIGHT)
       // self.welcomeView.applyGradient()
       
        loginalterBtn.layer.cornerRadius = 25.0
        loginalterBtn.clipsToBounds = true
        facebookLabel.backgroundColor = UIColor.white
        googleLabel.backgroundColor = UIColor.white
        googleLabel.layer.cornerRadius = 25.0
        googleLabel.clipsToBounds = true
        createAccountLabel.setTitleColor(UIColor.white, for: .highlighted)
        createAccountLabel.setTitleColor(UIColor.white, for: .normal)
         createAccountLabel.setTitleColor(UIColor.white, for: .selected)
        createAccountLabel.titleLabel?.alpha = 1.0
        createAccountLabel.layer.cornerRadius = 25.0
        createAccountLabel.clipsToBounds = true
        createAccountLabel.layer.borderWidth = 1.0
        createAccountLabel.layer.borderColor = UIColor.white.cgColor
        loginBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"login"))!)", for:.normal)
        facebookLabel.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"facebook_login"))!)", for:.normal)
        googleLabel.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"google_login"))!)", for:.normal)
        infoLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"login_content"))!)"
        createAccountLabel.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"create_account"))!)", for:.normal)
        createAccountLabel.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"create_account"))!)", for:.highlighted)
        createAccountLabel.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"create_account"))!)", for:.selected)
        welcomeLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"welcome_rent"))!)"
        
        

    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if(error == nil)
        {
           
            let name = user.profile.name!
            let email = user.profile.email!
            let userImageURL = user.profile.imageURL(withDimension: 200)!

            
        
            let params = [
                "name": "\(name)",
                "email": "\(email)",
                "image": "\(userImageURL)"
            ]
            
            let signupMutation = SocialLoginQuery(firstName: "\(name)", lastName: "", email: "\(email)", dateOfBirth: "", deviceType: "iOS", deviceDetail: "", deviceId:Utility.shared.pushnotification_devicetoken, registerType: "google", gender: "", profilePicture:"\(userImageURL)")
            
             apollo.fetch(query: signupMutation,cachePolicy:.fetchIgnoringCacheData){ (result,error) in

                if(result?.data?.userSocialLogin?.status == 200)
                {
                    Utility.shared.setopenTabbar(iswhichtabbar:false)
                    Utility.shared.signupArray.removeAllObjects()
                    Utility.shared.signupdataArray.removeAll()
                    Utility.shared.setUserToken(userID: (result?.data?.userSocialLogin?.result?.userToken as AnyObject) as! NSString)
                    Utility.shared.setUserID(userid: (result?.data?.userSocialLogin?.result?.userId as AnyObject)as! NSString)
                    if(result?.data?.userSocialLogin?.result?.user?.preferredCurrency != nil)
                    {
                    Utility.shared.setPreferredCurrency(currency_rate: (result?.data?.userSocialLogin?.result?.user?.preferredCurrency as AnyObject) as! String)
                    }
                    else
                    {
                        Utility.shared.setPreferredCurrency(currency_rate:"USD")
                        Utility.shared.selectedCurrency = "USD"
                    }
                    Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.firstName as AnyObject)   //Username
                    Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.createdAt as AnyObject) //createdAt
                    Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.picture as AnyObject)  //profile
                    Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.verification?.isEmailConfirmed as AnyObject) //emailverification
                    Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.verification?.isIdVerification as AnyObject) //idVerification
                    Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.verification?.isFacebookConnected as AnyObject) //FbVerification
                    Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.verification?.isPhoneVerified as AnyObject) //phoneVerifcation
                    Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.verification?.isGoogleConnected as AnyObject) //googleVerification
                   
                    Utility.shared.user_token =  (result?.data?.userSocialLogin?.result?.userToken)! //usertoken
                    Utility.shared.setTab(index: 0)
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate

                    self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)


                    appDelegate.GuestTabbarInitialize(initialView: CustomTabbar())


                }
                else
                {
                    if(result?.data?.userSocialLogin?.errorMessage != nil)
                    {
                    Utility.shared.showAlert(msg:((result?.data?.userSocialLogin?.errorMessage)!))
                    }
                }
                
            }
            
            
        }
        else
        {
            print("\(error.localizedDescription)")
        }
    }
    
    func facebookSignup(){
        let graphRequest : GraphRequest = GraphRequest(graphPath: "me", parameters:["fields": "id, name, first_name, last_name, picture.type(large), email"])
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                print("Error: \(String(describing: error))")
            }
            else
            {
                let userName  = result as! NSDictionary
                
                let name = userName.value(forKey: "name") as! NSString
                
                let profile = userName.value(forKey: "picture") as! NSDictionary
                
                let data = profile.value(forKey: "data")as! NSDictionary
                let url = data.value(forKey: "url") as! String
                if let userEmail = userName.value(forKey: "email") as? NSString{
        
                        
                        
                        let params = [
                            
                            "first_name": "\(name)",
                            "email": "\(userEmail)",
                            
                        ]
                        
                        
                    let signupMutation = SocialLoginQuery(firstName: "\(name)", lastName: "", email: "\(userEmail)", dateOfBirth: "", deviceType: "iOS", deviceDetail: "", deviceId:Utility.shared.pushnotification_devicetoken, registerType: "facebook", gender: "", profilePicture:"\(url)")
                    
                    apollo.fetch(query: signupMutation,cachePolicy:.fetchIgnoringCacheData){ (result,error) in
                        if(result?.data?.userSocialLogin?.status == 200)
                        {
                            Utility.shared.signupArray.removeAllObjects()
                            Utility.shared.signupdataArray.removeAll()
                            Utility.shared.setopenTabbar(iswhichtabbar:false)
                            Utility.shared.setUserToken(userID: (result?.data?.userSocialLogin?.result?.userToken as AnyObject) as! NSString)
                            Utility.shared.setUserID(userid: (result?.data?.userSocialLogin?.result?.userId as AnyObject)as! NSString)
                            Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.firstName as AnyObject)   //Username
                            Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.createdAt as AnyObject) //createdAt
                            Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.picture as AnyObject)  //profile
                            if(result?.data?.userSocialLogin?.result?.user?.preferredCurrency != nil)
                            {
                             Utility.shared.setPreferredCurrency(currency_rate: (result?.data?.userSocialLogin?.result?.user?.preferredCurrency as AnyObject) as! String)
                            }
                            else
                            {
                                Utility.shared.setPreferredCurrency(currency_rate:"USD")
                                Utility.shared.selectedCurrency = "USD"
                            }
                            Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.verification?.isEmailConfirmed as AnyObject) //emailverification
                            Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.verification?.isIdVerification as AnyObject) //idVerification
                            Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.verification?.isFacebookConnected as AnyObject) //FbVerification
                            Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.verification?.isPhoneVerified as AnyObject) //phoneVerifcation
                            Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.verification?.isGoogleConnected as AnyObject) //googleVerification
                            Utility.shared.user_token  = (result?.data?.userSocialLogin?.result?.userToken)! //usertoken
                             Utility.shared.setTab(index: 0)
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate

                            self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)

                            appDelegate.GuestTabbarInitialize(initialView: CustomTabbar())
                            
//                            appDelegate.GuestaddingElementsToObjects()
//                            appDelegate.GuestsettingRootViewControllerFunction()

                        }
                        else{
                            Utility.shared.showAlert(msg:((result?.data?.userSocialLogin?.errorMessage)!))
                        }
                        
                        
                 
            }
            }
            }
        })
        
    }
    
    func faceBookLogin(viewC: UIViewController){

//        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
//        let deviceVersion = Float(UIDevice.current.systemVersion)
////        if deviceVersion! <= Float(9) {
////             fbLoginManager.loginBehavior = FBSDKLoginBehavior.systemAccount
////        }else{
////            fbLoginManager.loginBehavior = FBSDKLoginBehavior.web
////        }
//        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email", "user_friends"], from: viewC) { (result, error) in


        let fbLoginManager : LoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["public_profile", "email", "user_friends"], from: viewC) { (result, error) in

            if (error == nil){
                let fbloginresult : LoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {   self.facebookSignup()
                        LoginManager().logOut()
                    }
                }
            }
        }
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
extension UINavigationController {
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .lightContent
    }
}
extension UIView {
    func applyGradient(colours: [UIColor]) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = CGPoint(x : 0.0, y : 0.5)
        gradient.endPoint = CGPoint(x :1.0, y: 0.5)
        self.layer.insertSublayer(gradient, at: 0)
    }
}

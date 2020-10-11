////
////  SocialSigninPage.swift
////  Rent_All
////
////  Created by RadicalStart on 8/1/2020.
////  Copyright © 2020 RADICAL START. All rights reserved.
////
//
//import UIKit
//import Lottie
//import AuthenticationServices
//class SocialSigninPage: UIViewController,GIDSignInDelegate {
//    
//    @IBOutlet var welcomeLabel: UILabel!
//    @IBOutlet var Close_Button: UIButton!
//    @IBOutlet var appleView: UIView!
//    @IBOutlet var facebookView: UIView!
//    @IBOutlet var googleView: UIView!
//    @IBOutlet var appleView_Label: UILabel!
//    @IBOutlet var appleView_imageView: UIImageView!
//    @IBOutlet var facebookView_Label: UILabel!
//    @IBOutlet var facebookView_imageView: UIImageView!
//    @IBOutlet var googleView_label: UILabel!
//    @IBOutlet var googleView_imageView: UIImageView!
//    
//    @IBOutlet var ImageView: UIImageView!
//    
//    @IBOutlet var socialloginView: UIView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        GIDSignIn.sharedInstance().delegate = self
//        GIDSignIn.sharedInstance()?.presentingViewController = self
//        welcomeLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"welcome_rent"))!)"
//       // appleView.backgroundColor = .clear
//        appleView_imageView.image = #imageLiteral(resourceName: "apple-black-shape-logo-with-a-bite-hole")
//        appleView_Label.text = "\((Utility.shared.getLanguage()?.value(forKey: "appleSignin"))!)"
//        appleView_Label.textColor = .white
//        appleView.layer.cornerRadius = 28.0
//        appleView.clipsToBounds = true
//        
//        self.socialloginView.applyGradient(colours:PRIMARY_COLOR)
//               self.view.applyGradient(colours: PRIMARY_COLOR)
////        let gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:     #selector(YourClass.viewTapped(gesture:)))
////        yourView.addGestureRecognizer(gesture)
//        //facebookView.backgroundColor = .white
//        //facebookView_imageView.image = #imageLiteral(resourceName: "facebook-logo")
//        facebookView_Label.text = "\((Utility.shared.getLanguage()?.value(forKey: "facebook_login"))!)"
//        facebookView.layer.cornerRadius = 28.0
//        facebookView_Label.textColor = .white
//        facebookView.clipsToBounds = true
//         let facebookGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(faceBookLogin))
//        facebookView.addGestureRecognizer(facebookGesture)
//        googleView.backgroundColor = Theme.TERTIARY_COLOR
//       // googleView_imageView.image = #imageLiteral(resourceName: "Verify_Google")
//        
//        facebookView_imageView.image = #imageLiteral(resourceName: "fb_logo").withRenderingMode(.alwaysTemplate)
//        facebookView_imageView.tintColor = .white
//        googleView_imageView.image = #imageLiteral(resourceName: "g_logo").withRenderingMode(.alwaysTemplate)
//        googleView_imageView.tintColor = .white
//        googleView_label.text = "\((Utility.shared.getLanguage()?.value(forKey: "google_login"))!)"
//        googleView_label.textColor = .white
////       appleView.borderWidth = 2.0
////        appleView.borderColor = .white
////        facebookView.borderWidth = 2.0
////        facebookView.borderColor = .black
//        googleView.layer.cornerRadius = 28.0
//        googleView.clipsToBounds = true
//        
//        let GoogleGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(googleLogin))
//        googleView.addGestureRecognizer(GoogleGesture)
//        
//        let AppleGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(applelogin))
//        appleView.addGestureRecognizer(AppleGesture)
//        
//      //  ImageView.loadGif(name: "3046-me-at-office")
//
//    }
//    @objc func applelogin(){
//        if Utility().isConnectedToNetwork(){
//        if #available(iOS 13.0, *) {
//        let authorizationProvider = ASAuthorizationAppleIDProvider()
//                let request = authorizationProvider.createRequest()
//                request.requestedScopes = [.fullName, .email]
//              let authorizationController = ASAuthorizationController(authorizationRequests: [request])
//               authorizationController.delegate = self // ASAuthorizationControllerDelegate
//               authorizationController.presentationContextProvider = self // ASAuthorizationControllerPresentationContextProviding
//               authorizationController.performRequests()
//        }
//        else
//        {
//            
//            
//            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey: "appleloginalert"))!)")
//        }
//        }
//        else
//        {
//           self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey: "error_field"))!)")
//        }
//    }
//
//    @objc func faceBookLogin(){
//        
//        let fbLoginManager : LoginManager = LoginManager()
//        fbLoginManager.logIn(permissions: ["public_profile", "email", "user_friends"], from: self) { (result, error) in
//
//            if (error == nil){
//                let fbloginresult : LoginManagerLoginResult = result!
//                if fbloginresult.grantedPermissions != nil {
//                    if(fbloginresult.grantedPermissions.contains("email"))
//                    {   self.facebookSignup()
//                        LoginManager().logOut()
//                    }
//                }
//            }
//        }
//        
//    }
//
//    func facebookSignup(){
//            let graphRequest : GraphRequest = GraphRequest(graphPath: "me", parameters:["fields": "id, name, first_name, last_name, picture.type(large), email"])
//            graphRequest.start(completionHandler: { (connection, result, error) -> Void in
//                
//                if ((error) != nil)
//                {
//                    print("Error: \(String(describing: error))")
//                }
//                else
//                {
//                    let userName  = result as! NSDictionary
//                    
//                    let name = userName.value(forKey: "name") as! NSString
//                    
//                    let profile = userName.value(forKey: "picture") as! NSDictionary
//                    
//                    let data = profile.value(forKey: "data")as! NSDictionary
//                    let url = data.value(forKey: "url") as! String
//                    if let userEmail = userName.value(forKey: "email") as? NSString{
//            
//                            
//                            
//                            let params = [
//                                
//                                "first_name": "\(name)",
//                                "email": "\(userEmail)",
//                                
//                            ]
//                        let signupMutation = SocialLoginQuery(firstName: "\(name)", lastName: "", email: "\(userEmail)", dateOfBirth: "", deviceType: "iOS", deviceDetail: "", deviceId:Utility.shared.pushnotification_devicetoken, registerType: "facebook", gender: "", profilePicture:"\(url)")
//                        
//                        apollo.fetch(query: signupMutation,cachePolicy:.fetchIgnoringCacheData){ (result,error) in
//                            if(result?.data?.userSocialLogin?.status == 200)
//                            {
//                                Utility.shared.signupArray.removeAllObjects()
//                                Utility.shared.signupdataArray.removeAll()
//                                Utility.shared.setopenTabbar(iswhichtabbar:false)
//                                Utility.shared.setUserToken(userID: (result?.data?.userSocialLogin?.result?.userToken as AnyObject) as! NSString)
//                                Utility.shared.setUserID(userid: (result?.data?.userSocialLogin?.result?.userId as AnyObject)as! NSString)
//                                Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.firstName as AnyObject)   //Username
//                                Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.createdAt as AnyObject) //createdAt
//                                Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.picture as AnyObject)  //profile
//                                if(result?.data?.userSocialLogin?.result?.user?.preferredCurrency != nil)
//                                {
//                                 Utility.shared.setPreferredCurrency(currency_rate: (result?.data?.userSocialLogin?.result?.user?.preferredCurrency as AnyObject) as! String)
//                                }
//                                else
//                                {
//                                    Utility.shared.setPreferredCurrency(currency_rate:"USD")
//                                    Utility.shared.selectedCurrency = "USD"
//                                }
//                                Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.verification?.isEmailConfirmed as AnyObject) //emailverification
//                                Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.verification?.isIdVerification as AnyObject) //idVerification
//                                Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.verification?.isFacebookConnected as AnyObject) //FbVerification
//                                Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.verification?.isPhoneVerified as AnyObject) //phoneVerifcation
//                                Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.verification?.isGoogleConnected as AnyObject) //googleVerification
//                                Utility.shared.user_token  = (result?.data?.userSocialLogin?.result?.userToken)! //usertoken
//                                 Utility.shared.setTab(index: 0)
//                                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//
//                                self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
//
//                                appDelegate.GuestTabbarInitialize(initialView: CustomTabbar())
//                                
//    //                            appDelegate.GuestaddingElementsToObjects()
//    //                            appDelegate.GuestsettingRootViewControllerFunction()
//
//                            }
//                            else{
//                                Utility.shared.showAlert(msg:((result?.data?.userSocialLogin?.errorMessage)!))
//                            }
//                        }
//                    }
//                }
//            })
//            
//        }
//
//    @objc func googleLogin(){
//        
//        URLCache.shared.removeAllCachedResponses()
//
//        if let cookies = HTTPCookieStorage.shared.cookies {
//            for cookie in cookies {
//                HTTPCookieStorage.shared.deleteCookie(cookie)
//            }
//        }
//        GIDSignIn.sharedInstance().signOut()
//        GIDSignIn.sharedInstance().signIn()
//        
//    }
//
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//        if(error == nil)
//               {
//                  
//                   let name = user.profile.name!
//                   let email = user.profile.email!
//                   let userImageURL = user.profile.imageURL(withDimension: 200)!
//
//                   
//               
//                   let params = [
//                       "name": "\(name)",
//                       "email": "\(email)",
//                       "image": "\(userImageURL)"
//                   ]
//                   
//                   let signupMutation = SocialLoginQuery(firstName: "\(name)", lastName: "", email: "\(email)", dateOfBirth: "", deviceType: "iOS", deviceDetail: "", deviceId:Utility.shared.pushnotification_devicetoken, registerType: "google", gender: "", profilePicture:"\(userImageURL)")
//                   
//                    apollo.fetch(query: signupMutation,cachePolicy:.fetchIgnoringCacheData){ (result,error) in
//
//                       if(result?.data?.userSocialLogin?.status == 200)
//                       {
//                           Utility.shared.setopenTabbar(iswhichtabbar:false)
//                           Utility.shared.signupArray.removeAllObjects()
//                           Utility.shared.signupdataArray.removeAll()
//                           Utility.shared.setUserToken(userID: (result?.data?.userSocialLogin?.result?.userToken as AnyObject) as! NSString)
//                           Utility.shared.setUserID(userid: (result?.data?.userSocialLogin?.result?.userId as AnyObject)as! NSString)
//                           if(result?.data?.userSocialLogin?.result?.user?.preferredCurrency != nil)
//                           {
//                           Utility.shared.setPreferredCurrency(currency_rate: (result?.data?.userSocialLogin?.result?.user?.preferredCurrency as AnyObject) as! String)
//                           }
//                           else
//                           {
//                               Utility.shared.setPreferredCurrency(currency_rate:"USD")
//                               Utility.shared.selectedCurrency = "USD"
//                           }
//                           Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.firstName as AnyObject)   //Username
//                           Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.createdAt as AnyObject) //createdAt
//                           Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.picture as AnyObject)  //profile
//                           Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.verification?.isEmailConfirmed as AnyObject) //emailverification
//                           Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.verification?.isIdVerification as AnyObject) //idVerification
//                           Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.verification?.isFacebookConnected as AnyObject) //FbVerification
//                           Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.verification?.isPhoneVerified as AnyObject) //phoneVerifcation
//                           Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.verification?.isGoogleConnected as AnyObject) //googleVerification
//                          
//                           Utility.shared.user_token =  (result?.data?.userSocialLogin?.result?.userToken)! //usertoken
//                           Utility.shared.setTab(index: 0)
//                           let appDelegate = UIApplication.shared.delegate as! AppDelegate
//
//                           self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
//
//
//                           appDelegate.GuestTabbarInitialize(initialView: CustomTabbar())
//
//
//                       }
//                       else
//                       {
//                            Utility.shared.showAlert(msg:((result?.data?.userSocialLogin?.errorMessage)!))
//                       }
//                       
//                   }
//                   
//                   
//               }
//               else
//               {
//                   print("\(error.localizedDescription)")
//               }
//    }
//    
//    @IBAction func close_tapped(_ sender: Any) {
//        
//        self.dismiss(animated: false, completion: nil)
//    }
//    
//}
//extension SocialSigninPage: ASAuthorizationControllerDelegate {
//    
//    @available(iOS 13.0, *)
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
//            return
//        
//        }
//        
//        if(appleIDCredential.email != nil)
//        {
//            KeychainService.saveEmail(email: "\(appleIDCredential.email!)" as NSString)
//            KeychainService.saveUsername(name: "\((appleIDCredential.fullName?.givenName!)!)\((appleIDCredential.fullName?.familyName)!)" as NSString)
//        Utility.shared.setappleAccountname(name: "\((appleIDCredential.fullName?.givenName!)!)\((appleIDCredential.fullName?.familyName)!)")
//        Utility.shared.setappleAccountEmail(email: "\(appleIDCredential.email!)")
//        }
//        let email = KeychainService.loadEmail()
//        let name = KeychainService.loadUsername()
//        
//        let signupMutation = SocialLoginQuery(firstName:name as String?, lastName: "", email:email as! String, dateOfBirth: "", deviceType: "iOS", deviceDetail: "", deviceId:Utility.shared.pushnotification_devicetoken, registerType: "apple", gender: "", profilePicture:"")
//        
//         apollo.fetch(query: signupMutation,cachePolicy:.fetchIgnoringCacheData){ (result,error) in
//
//            if(result?.data?.userSocialLogin?.status == 200)
//            {
//                Utility.shared.setopenTabbar(iswhichtabbar:false)
//                Utility.shared.signupArray.removeAllObjects()
//                Utility.shared.signupdataArray.removeAll()
//                Utility.shared.setUserToken(userID: (result?.data?.userSocialLogin?.result?.userToken as AnyObject) as! NSString)
//                Utility.shared.setUserID(userid: (result?.data?.userSocialLogin?.result?.userId as AnyObject)as! NSString)
//                if(result?.data?.userSocialLogin?.result?.user?.preferredCurrency != nil)
//                {
//                Utility.shared.setPreferredCurrency(currency_rate: (result?.data?.userSocialLogin?.result?.user?.preferredCurrency as AnyObject) as! String)
//                }
//                else
//                {
//                    Utility.shared.setPreferredCurrency(currency_rate:"USD")
//                    Utility.shared.selectedCurrency = "USD"
//                }
//                Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.firstName as AnyObject)   //Username
//                Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.createdAt as AnyObject) //createdAt
//                Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.picture as AnyObject)  //profile
//                Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.verification?.isEmailConfirmed as AnyObject) //emailverification
//                Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.verification?.isIdVerification as AnyObject) //idVerification
//                Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.verification?.isFacebookConnected as AnyObject) //FbVerification
//                Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.verification?.isPhoneVerified as AnyObject) //phoneVerifcation
//                Utility.shared.signupdataArray.append(result?.data?.userSocialLogin?.result?.user?.verification?.isGoogleConnected as AnyObject) //googleVerification
//               
//                Utility.shared.user_token =  (result?.data?.userSocialLogin?.result?.userToken)! //usertoken
//                Utility.shared.setTab(index: 0)
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//
//                self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
//
//
//                appDelegate.GuestTabbarInitialize(initialView: CustomTabbar())
//
//
//            }
//            else
//            {
//                
//                 Utility.shared.showAlert(msg:((result?.data?.userSocialLogin?.errorMessage)!))
//            }
//        }
//        print("AppleID Credential Authorization: userId: \(appleIDCredential.user), email: \(String(describing: appleIDCredential.email))")
//        
//    }
//    @available(iOS 13.0, *)
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
//        print("AppleID Credential failed with error: \(error.localizedDescription)")
//    }
//}
//extension SocialSigninPage: ASAuthorizationControllerPresentationContextProviding {
//    @available(iOS 13.0, *)
//    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
//        return self.view.window!
//    }
//}
//

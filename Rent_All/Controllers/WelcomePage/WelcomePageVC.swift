//
//  WelcomePageVC.swift
//  Rent_All
//
//  Created by RADICAL START on 19/03/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons
import AuthenticationServices

class WelcomePageVC: UIViewController  {
    
    
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
    

    @IBAction func createAccountAction(_ sender: Any) {
        Utility.shared.signupArray.removeAllObjects()
        let FirstnameObj = FirstLastnamePageVC()
        FirstnameObj.modalPresentationStyle = .fullScreen
         self.present(FirstnameObj, animated: false, completion: nil)
       // self.navigationController?.pushViewController(FirstnameObj, animated: true)
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

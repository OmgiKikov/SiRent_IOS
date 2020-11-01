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
    
    @IBOutlet var loginalterBtn: UIButton!
    @IBOutlet var closeBtn: UIButton!
    
    @IBOutlet var loginBtn: UIButton!
    
    @IBOutlet var welcomeLabel: UILabel!
    
    
    
    @IBOutlet var createAccountLabel: UIButton!
    
    @IBOutlet var infoLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.initialSetup()
        NotificationCenter.default.removeObserver(self)
    }
    
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
    }
    
    
    
    @IBAction func loginBtnAction(_ sender: Any) {
        let loginObj = LoginPageVC()
        loginObj.modalPresentationStyle = .fullScreen
        self.present(loginObj, animated: false, completion: nil)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    // Mark:Functions *******************************************************************************************>
    
    func initialSetup()
    {
        
        welcomeView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height: FULLHEIGHT)
        loginalterBtn.layer.cornerRadius = 25.0
        loginalterBtn.clipsToBounds = true
        createAccountLabel.layer.cornerRadius = 25.0
        createAccountLabel.clipsToBounds = true
        createAccountLabel.layer.borderWidth = 1.0
        createAccountLabel.layer.borderColor = UIColor.white.cgColor
        loginBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"login"))!)", for:.normal)
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

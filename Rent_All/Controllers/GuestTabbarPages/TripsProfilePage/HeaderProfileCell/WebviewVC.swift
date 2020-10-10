//
//  WebviewVC.swift
//  Rent_All
//
//  Created by RadicalStart on 17/06/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import WebKit
import Lottie

protocol WebviewVCDelegate {
    func setPayoutCall(accountid:String)
}

class WebviewVC: UIViewController,WKNavigationDelegate {
    @IBOutlet weak var topView: UIView!
     var webview = WKWebView()
    var lottieView: LOTAnimationView!
    var webstring = String()
    var succesURL = String()
    var failureURL = String()
    var preferences = WKPreferences()
    var delegate:WebviewVCDelegate!
    var accountID = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lottieView = LOTAnimationView.init(name:"animation")
        if IS_IPHONE_XR
        {
            //topView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH-40, height: 80)
            webview.frame = CGRect(x: 0, y:self.topView.frame.origin.y+self.topView.frame.size.height+5, width: FULLWIDTH, height: FULLHEIGHT-85)
            
        }
        else{
            // topView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH-40, height: 80)
            webview.frame = CGRect(x: 0, y:self.topView.frame.origin.y+self.topView.frame.size.height+5, width: FULLWIDTH, height: FULLHEIGHT-85)
        }
        self.view.addSubview(webview)
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
        
        
        
     //   self.webviewRedirection(webviewString: webstring)
        // Do any additional setup after loading the view.
    }
    func lottieAnimation(){
        
        lottieView = LOTAnimationView.init(name:"animation")
        lottieView.isHidden = false
        self.lottieView.frame = CGRect(x:FULLWIDTH/2-40, y:FULLHEIGHT/2-150, width:100, height:100)
        self.webview.addSubview(self.lottieView)
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
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func webviewRedirection(webviewString:String)
    {
        webview.navigationDelegate = self
        let url = URL (string: webviewString)
        let requestObj = URLRequest(url: url!)
        preferences = WKPreferences()
        preferences.javaScriptEnabled = false
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        //webview = WKWebView(frame:.zero, configuration: configuration)
            self.webview.load(requestObj)

       
     
     //   lottieView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!)
    {
        self.lottieAnimation()
    }// show indicator
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
    {
        //preferences.javaScriptEnabled = true
        // Create a configuration for the preferences
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        let removeElementIdScript = "javascript:(function() { " + "document.getElementsByClassName('rentAllHeader')[0].style.display='none';})()"
        webView.evaluateJavaScript(removeElementIdScript) { (response, error) in
            debugPrint("Am here")
            
        }

        let elementID = "intercom-container"
        let removeElementIdScript1 = "var element = document.getElementById('\(elementID)'); element.parentElement.removeChild(element);"
        webView.evaluateJavaScript(removeElementIdScript1) { (response, error) in
            debugPrint("Am here")
        }
      
        lottieView.isHidden = true
       
       
    }
  func webView(
             _ webView: WKWebView,
             decidePolicyFor navigationAction: WKNavigationAction,
             decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    
    print("pradee \(navigationAction.request.url)")

             guard let url = navigationAction.request.url else {
                 decisionHandler(.allow)
                 return
             }
             let Cur_URL = URL(fileURLWithPath: succesURL)
    
    
             //now u and ur server team can decide on what url will they redirect and what will be url string on login success
             //lets say u and ur server team decides url to be https://some_base_url/login/success

            if url.absoluteString.contains("/payout/success") {
                 // this means login successful
                 decisionHandler(.cancel)
                let accountIDVal = self.getQueryStringParameter(url:succesURL, param: "account")

                delegate?.setPayoutCall(accountid:accountIDVal!)
                _ = self.dismiss(animated: true, completion: nil)
             }
            else if url.absoluteString.contains("/payout/failure"){
                   
                  decisionHandler(.cancel)
                   
                      let alert = UIAlertController(title: "Oops", message: "\((Utility.shared.getLanguage()?.value(forKey:"stripe_connection_failed"))!)", preferredStyle: .alert)
                      alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                        let accountIDVal = self.getQueryStringParameter(url:self.failureURL, param: "account")
                        let payoutObj = PayoutPreferenceVC()
                                                                                          Utility.shared.isfrom_payoutcurrency = true
                                                                                           payoutObj.modalPresentationStyle = .fullScreen
                                                                                          self.present(payoutObj, animated: true, completion: nil)
//                        self.delegate?.setPayoutCall(accountid:accountIDVal!)
//                         _ = self.dismiss(animated: true, completion: nil)
                      }))
                      self.present(alert, animated: true) {
                       // self.AnimationView.stop()
                      }
                   
                  
                }
             else {
                 decisionHandler(.allow)
//                self.view.makeToast("Connecting your bank account with the platform verification is failed")
//
//                let payoutObj = PayoutPreferenceVC()
//                                                                   Utility.shared.isfrom_payoutcurrency = true
//                                                                    payoutObj.modalPresentationStyle = .fullScreen
//                                                                   self.present(payoutObj, animated: true, completion: nil)

             }
         }
    
    func getQueryStringParameter(url: String, param: String) -> String? {
      guard let url = URLComponents(string: url) else { return nil }
      return url.queryItems?.first(where: { $0.name == param })?.value
    }
    

}

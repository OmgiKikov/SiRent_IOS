//
//  EmailGoogleFBViewController.swift
//  Rent_All
//
//  Created by RadicalStart on 08/11/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Apollo
import Lottie

class EmailGoogleFBViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    

    @IBOutlet weak var VerificationTableView: UITableView!
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var titleLAbel: UILabel!
    let apollo_headerClient: ApolloClient = {
    let configuration = URLSessionConfiguration.default
    // Add additional headers as needed
    configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
    
    let url = URL(string:graphQLEndpoint)!
    
    return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    
}()
    var lottieViewbtn: LOTAnimationView!
    var email_btn_title = String()
    var is_email_verify = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true

        // Do any additional setup after loading the view.
        
        VerificationTableView.register(UINib(nibName: "EmailGoogleFBTableViewCell", bundle: nil), forCellReuseIdentifier: "EmailGoogleFBTableViewCell")
        VerificationTableView.estimatedRowHeight = 50
        VerificationTableView.rowHeight = UITableView.automaticDimension
        VerificationTableView.delegate = self
        VerificationTableView.dataSource = self
        topView.dropShadow(scale: true)
        titleLAbel.text = "\((Utility.shared.getLanguage()?.value(forKey:"trustverify"))!)"
        if(is_email_verify)
        {
            email_btn_title = "\((Utility.shared.getLanguage()?.value(forKey:"verified"))!)"
        }
        else
        {
            email_btn_title = "\((Utility.shared.getLanguage()?.value(forKey:"verifyemail"))!)"
        }
    }
    @objc func autoscrolling()
    {
        self.lottieViewbtn.play()
    }
    
    func lottienextAnimation(sender:UIButton)
    {
        lottieViewbtn = LOTAnimationView.init(name: "animation")
        self.lottieViewbtn.isHidden = false
        self.lottieViewbtn.frame = CGRect(x:sender.frame.size.width/2-50, y:-30, width:100, height:100)
        self.lottieViewbtn.backgroundColor = .red
        sender.addSubview(self.lottieViewbtn)
        self.lottieViewbtn.backgroundColor = UIColor.clear
        sender.setTitle("", for:.normal)
        self.lottieViewbtn.play()
        Timer.scheduledTimer(timeInterval:0.2, target: self, selector: #selector(autoscrolling), userInfo: nil, repeats: true)
    }
   

    @IBAction func backBtnTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
     func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmailGoogleFBTableViewCell", for: indexPath)as! EmailGoogleFBTableViewCell
        cell.selectionStyle = .none
        cell.tag = indexPath.row + 2000
        cell.action_Button.tag = indexPath.row
        if indexPath.row == 0 {
            
            cell.title_label.text = "\((Utility.shared.getLanguage()?.value(forKey:"email_verify"))!)"
            
            
            cell.logo_imageView.image = #imageLiteral(resourceName: "Verify_email")
             cell.action_Button.setTitle(email_btn_title, for: .normal)
            if(email_btn_title == "\((Utility.shared.getLanguage()?.value(forKey:"verified"))!)")
            {
            cell.action_Button.isUserInteractionEnabled = false
            cell.des_text_label.text = "\((Utility.shared.getLanguage()?.value(forKey:"verify_email"))!)"
            }
            else
            {
             cell.action_Button.isUserInteractionEnabled = true
            cell.des_text_label.text = "\((Utility.shared.getLanguage()?.value(forKey:"emailverify"))!)"
            }
           // cell.action_Button.removeTarget(nil, action: nil, for: .allEvents)
            cell.action_Button.addTarget(self, action: #selector(emailBtnTapped), for: .touchUpInside)
            
        }
        cell.NewView.sizeToFit()
        return cell
    }
    @objc func emailBtnTapped(sender : UIButton)
    {
        if Utility.shared.isConnectedToNetwork(){
        if(sender.tag == 0)
        {
        self.lottienextAnimation(sender: sender)
        self.emailAPICall(sender: sender)
        }
        }
        else
        {
           self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)")
        }
        
    }
   
    func emailAPICall(sender : UIButton)
    {
        let resendAPIquery = ResendConfirmEmailQuery()
        apollo_headerClient.fetch(query: resendAPIquery,cachePolicy: .fetchIgnoringCacheData){(result,error) in
            if(result?.data?.resendConfirmEmail?.status == 200)
            {
               // self.email_btn_title = "\((Utility.shared.getLanguage()?.value(forKey:"verified"))!)"
                sender.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"verifyemail"))!)", for: .normal)
                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"confirmationemail"))!)")
                self.lottieViewbtn.isHidden = true
                //self.VerificationTableView.reloadData()
            }
            else
            {
                self.view.makeToast(result?.data?.resendConfirmEmail?.errorMessage!)
                self.lottieViewbtn.isHidden = true
            }
        }
    }
    
}
extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = TextLightColor.cgColor
        layer.shadowOpacity = 1.0
        layer.shadowOffset = .zero
        layer.shadowRadius = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

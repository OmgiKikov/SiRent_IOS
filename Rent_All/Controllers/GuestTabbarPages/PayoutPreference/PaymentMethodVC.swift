//
//  PaymentMethodVC.swift
//  Rent_All
//
//  Created by RadicalStart on 19/08/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Apollo
import Lottie

class PaymentMethodVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var retryBtn: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var offlineView: UIView!
    
    @IBOutlet weak var nextimg: UIImageView!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var paymentMethodTable: UITableView!
    
    var apollo_headerClient: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
        
        let url = URL(string:graphQLEndpoint)!
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()
    var getpaymentmethodsArray = [GetPaymentMethodsQuery.Data.GetPaymentMethod.Result]()
    var lottieView: LOTAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialsetup()
        self.payoutAPICall()
        self.lottieAnimation()

        // Do any additional setup after loading the view.
    }
    func initialsetup()
    {
        paymentMethodTable.register(UINib(nibName: "paymethodCell", bundle: nil), forCellReuseIdentifier: "paymethodCell")
        
        self.continueBtn.layer.cornerRadius = 22.0
        self.continueBtn.layer.masksToBounds = true
        self.nextimg.image = self.nextimg.image?.withRenderingMode(.alwaysTemplate)
        self.nextimg.tintColor = .white
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.offlineView.isHidden = true
        
        errorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
    retryBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
        
        
    }
    func lottieAnimation(){
        lottieView = LOTAnimationView.init(name:"animation")
        lottieView.isHidden = false
        self.lottieView.frame = CGRect(x:FULLWIDTH/2-40, y:FULLHEIGHT/2-150, width:100, height:100)
        self.paymentMethodTable.addSubview(self.lottieView)
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
    
    func payoutAPICall()
    {
        
        
        let getpayoutquery = GetPaymentMethodsQuery()
        apollo_headerClient.fetch(query: getpayoutquery,cachePolicy:.fetchIgnoringCacheData){(result,error) in
            guard (result?.data?.getPaymentMethods?.results) != nil else{
                print("Missing Data")
                 self.lottieView.isHidden = true
                return
            }
            
             self.lottieView.isHidden = true
            self.getpaymentmethodsArray = ((result?.data?.getPaymentMethods?.results)!) as! [GetPaymentMethodsQuery.Data.GetPaymentMethod.Result]
            
            self.paymentMethodTable.reloadData()
            
        }
        
    }

    
    @objc func keyboardWillShow(sender: NSNotification) {
        let info = sender.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        
        //  self.GoBtn.frame.origin.y -= keyboardFrame.height
        self.continueBtn.frame.origin.y = keyboardFrame.origin.y - 60
        self.nextimg.frame.origin.y = keyboardFrame.origin.y - 45
        
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        let info = sender.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        self.continueBtn.frame.origin.y = FULLHEIGHT - 70
        self.nextimg.frame.origin.y = FULLHEIGHT - 55
        //
        //        if ((emailTF.text?.isValidEmail())! && ((passwordTF.text?.count)! > 6)) {
        //            self.configureNextBtn(enable: true)
        //
        //        }
        //        else{
        //            self.configureNextBtn(enable: false)
        //        }
        
    }
    @IBAction func retryBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            self.offlineView.isHidden = true
        }
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView( _ tableView : UITableView,  titleForHeaderInSection section: Int)->String?
    {
        if(section == 0){
            return "\((Utility.shared.getLanguage()?.value(forKey:"newpayment"))!)"
        }
        return ""
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        
        let lineLabel = UILabel(frame: CGRect(x:20, y: 0, width:
            tableView.bounds.size.width-30, height: 1.0))
        lineLabel.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        //headerView.addSubview(lineLabel)
        
        let headerLabel = UILabel(frame: CGRect(x:20, y:0, width:
            tableView.bounds.size.width-40, height: 80))
        headerLabel.font = UIFont(name: "Circular-Medium",size:25)
        headerLabel.addCharacterSpacing(kernValue: 1.3)
         headerLabel.numberOfLines = 2
        headerLabel.textColor = UIColor.black
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0)
        {
            return 90
            
        }
        return CGFloat.leastNormalMagnitude
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getpaymentmethodsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "paymethodCell", for: indexPath)as! paymethodCell
        cell.selectionStyle = .none
        if("\((getpaymentmethodsArray[indexPath.row].name!))" == "Paypal")
        {
        cell.paypalLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"paypal"))!)"
        }
        else
        {
            cell.paypalLabel.text = getpaymentmethodsArray[indexPath.row].name!
        }
        
        cell.feeLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"fees"))!): \(getpaymentmethodsArray[indexPath.row].fees!)"
        cell.processLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"processedin"))!): \(getpaymentmethodsArray[indexPath.row].processedIn!)"
        cell.currencyLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"currency"))!): \(getpaymentmethodsArray[indexPath.row].currency!)"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if Utility().isConnectedToNetwork(){
        if(indexPath.row == 0)
        {
            let paymethodObj = PaypalPayoutVC()
            paymethodObj.modalPresentationStyle = .fullScreen
            self.present(paymethodObj, animated: true, completion: nil)
        }
        else
        {
            let bankmethodObj = BankAccountVC()
            bankmethodObj.modalPresentationStyle = .fullScreen
            self.present(bankmethodObj, animated: true, completion: nil)
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
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-130, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
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

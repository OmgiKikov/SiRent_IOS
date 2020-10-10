//
//  PayoutPreferenceVC.swift
//  Rent_All
//
//  Created by RadicalStart on 16/08/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Apollo
import Lottie
import MKToolTip

class PayoutPreferenceVC: UIViewController,UITableViewDelegate,UITableViewDataSource,WebviewVCDelegate {
    
    
    @IBOutlet weak var retryBtn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var nopayoutLabel: UILabel!
    @IBOutlet weak var payoutLabel: UILabel!
    @IBOutlet weak var offlineview: UIView!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var payoutTable: UITableView!
    @IBOutlet weak var nodataview: UIView!
    var lottieWholeView = UIView()
    var lottieView1 =  LOTAnimationView()
    var apollo_headerClient: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
        
        let url = URL(string:graphQLEndpoint)!
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()
     var getpayoutArray = [GetPayoutsQuery.Data.GetPayout.Result]()
    var lottieView: LOTAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialsetup()
        self.lottieAnimation()
        self.payoutAPICall()

        // Do any additional setup after loading the view.
    }
    
    func initialsetup()
    {
            payoutTable.register(UINib(nibName: "PayoutCell", bundle: nil), forCellReuseIdentifier: "PayoutCell")
            self.nodataview.isHidden = true
            self.offlineview.isHidden = true
        
            errorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
            retryBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
        
            payoutLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"payoutmethod"))!)"
            nopayoutLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"nopayoutmethods"))!)"
            addBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"add"))!)", for:.normal)
        addBtn.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
    }
    func lottieAnimation(){
        lottieView = LOTAnimationView.init(name:"animation")
        lottieView.isHidden = false
        self.lottieView.frame = CGRect(x:FULLWIDTH/2-40, y:FULLHEIGHT/2-150, width:100, height:100)
        self.payoutTable.addSubview(self.lottieView)
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
    @objc func autoscrolling()
    {
        self.lottieView1.play()
    }
    
     @IBAction func addBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
        Utility.shared.payout_Address_Dict.removeAll()
        let payoutcountryObj = PayoutCountryVC()
        payoutcountryObj.modalPresentationStyle = .fullScreen
        self.present(payoutcountryObj, animated: true, completion: nil)
        }
        else
        {
            self.offlineview.isHidden = false
            let shadowSize2 : CGFloat = 3.0
            let shadowPath2 = UIBezierPath(rect: CGRect(x: -shadowSize2 / 2,
                                                        y: -shadowSize2 / 2,
                                                        width: self.offlineview.frame.size.width + shadowSize2,
                                                        height: self.offlineview.frame.size.height + shadowSize2))
            
            self.offlineview.layer.masksToBounds = false
            self.offlineview.layer.shadowColor = TextLightColor.cgColor
            self.offlineview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            self.offlineview.layer.shadowOpacity = 0.3
            self.offlineview.layer.shadowPath = shadowPath2.cgPath
            if IS_IPHONE_X || IS_IPHONE_XR{
                offlineview.frame = CGRect.init(x: 0, y: FULLHEIGHT-85, width: FULLWIDTH, height: 55)
            }else{
                offlineview.frame = CGRect.init(x: 0, y: FULLHEIGHT-55, width: FULLWIDTH, height: 55)
            }
        }
    }

   
    @IBAction func beckBtnTapped(_ sender: Any) {
//        if(Utility.shared.isfrom_payoutcurrency)
//        {
//        if(!Utility.shared.isfromGuestProfile)
//        {
//        Utility.shared.setTab(index:0)
//         Utility.shared.isfromfloatmap_Page = false
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.GuestTabbarInitialize(initialView: CustomTabbar())
//        }
//        else{
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.addingElementsToObjects()
//            appDelegate.settingRootViewControllerFunction()
//        }
//        }
//        else
//        {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
            //self.dismiss(animated: true, completion: nil)
       // }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int{
     if(getpayoutArray.count > 0)
     {
        return 1
        }
        return 0
    }
    
    func tableView( _ tableView : UITableView,  titleForHeaderInSection section: Int)->String?
    {
        if(section == 0){
            
            if(getpayoutArray.count > 0)
            {
                
            return "\((Utility.shared.getLanguage()?.value(forKey:"editpayout"))!)"
            }
             return "\((Utility.shared.getLanguage()?.value(forKey:"nopayoutmethods"))!)"
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        
        let lineLabel = UILabel(frame: CGRect(x:30, y: 0, width:
            tableView.bounds.size.width-30, height: 1.0))
        lineLabel.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        //headerView.addSubview(lineLabel)
        
        let headerLabel = UILabel(frame: CGRect(x:20, y:0, width:
            tableView.bounds.size.width-40, height: 80))
        headerLabel.font = UIFont(name: "Circular-Medium", size:25)
        headerLabel.addCharacterSpacing(kernValue: 1.3)
        headerLabel.textColor = UIColor.black
        headerLabel.numberOfLines = 2
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    @IBAction func retryBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            self.offlineview.isHidden = true
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0)
        {
            if Utility.shared.getAppLanguageCode() == "En" || Utility.shared.getAppLanguageCode() == "en"{
                return 60
            }
            return 90
            
        }
        return CGFloat.leastNormalMagnitude
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(getpayoutArray.count > 0)
        {
            return getpayoutArray.count
        }
        return 0
    
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PayoutCell", for: indexPath)as! PayoutCell
        cell.selectionStyle = .none
        
        if("\((getpayoutArray[indexPath.row].paymentMethod?.name)!)" == "Paypal")
        {
        cell.payoutLAbel.text = "\((Utility.shared.getLanguage()?.value(forKey:"paypal"))!)"
        cell.detailLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"Details"))!) \(getpayoutArray[indexPath.row].payEmail!)"
        }
        else
        {
            cell.payoutLAbel.text = getpayoutArray[indexPath.row].paymentMethod?.name
            cell.detailLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"Details"))!) *******\(getpayoutArray[indexPath.row].last4Digits!)"
        }
        
        cell.currencyLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"currency"))!): \(getpayoutArray[indexPath.row].currency!)"
        if getpayoutArray[indexPath.row].default == true
        {
          cell.defaultBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"default"))!)", for: .normal)
         cell.defaultBtn.isUserInteractionEnabled = false
        cell.deleteBtn.isHidden = true
            cell.verifyInfoicon.isHidden = true
            cell.statusLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"statusready"))!)"
           // cell.defaultBtn.backgroundColor = Theme.PRIMARY_COLOR
        }
        else if(getpayoutArray[indexPath.row].default == false && getpayoutArray.count == 1 && getpayoutArray[indexPath.row].isVerified != false)
        {
            cell.defaultBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"default"))!)", for: .normal)
            cell.defaultBtn.isUserInteractionEnabled = false
            cell.deleteBtn.isHidden = true
            cell.verifyInfoicon.isHidden = true
            cell.statusLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"statusready"))!)"
            
        }
        else
        {
            if(getpayoutArray[indexPath.row].isVerified == false)
            {
                cell.defaultBtn.tag = indexPath.row
                cell.defaultBtn.isUserInteractionEnabled = true
                cell.deleteBtn.isHidden = false
                cell.defaultBtn.setTitle("VERIFY", for: .normal)
                cell.statusLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"notready"))!)"
                //cell.defaultBtn.removeTarget(self, action: <#T##Selector?#>, for: <#T##UIControl.Event#>)
                cell.defaultBtn.removeTarget(self, action: nil, for: .allEvents)
                cell.defaultBtn.addTarget(self, action:  #selector(verifyBtnTapped), for: .touchUpInside)
                cell.verifyInfoicon.isHidden = false
                if Utility.shared.getAppLanguageCode() == "It" || Utility.shared.getAppLanguageCode() == "it" || Utility.shared.getAppLanguageCode() == "Pt" || Utility.shared.getAppLanguageCode() == "pt"{
                   
                  cell.verifyInfoicon.frame.origin.x = 175
                }
                cell.verifyInfoicon.addTarget(self, action: #selector(tooltipBtnTapped(_:)), for: .touchUpInside)
            }
            else
            {
                cell.statusLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"statusready"))!)"
                cell.verifyInfoicon.isHidden = true
            cell.defaultBtn.tag = indexPath.row
            cell.defaultBtn.isUserInteractionEnabled = true
            cell.deleteBtn.isHidden = false
            cell.defaultBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"setdefault"))!)", for: .normal)
                cell.defaultBtn.removeTarget(self, action: nil, for: .allEvents)
            cell.defaultBtn.addTarget(self, action:  #selector(defaultBtnTapped), for: .touchUpInside)
            }
            
            //cell.defaultBtn.backgroundColor = Red_color
        }
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(deleteBtnTapped), for: .touchUpInside)
        
        return cell
    }
    @objc func tooltipBtnTapped(_ sender: UIButton!)
    {
      let preference = ToolTipPreferences()
      preference.drawing.bubble.color = UIColor.darkGray
      preference.drawing.bubble.spacing = 10
      preference.drawing.bubble.cornerRadius = 5
      preference.drawing.bubble.inset = 15
      preference.drawing.bubble.border.color = UIColor.darkGray
      preference.drawing.bubble.border.width = 1
      preference.drawing.arrow.tipCornerRadius = 5
      preference.drawing.message.color = UIColor.white
      preference.drawing.message.font = UIFont(name: "Circular-Book", size:15)!
      preference.drawing.button.color = UIColor(red: 0.074, green: 0.231, blue: 0.431, alpha: 1.000)
      preference.drawing.button.font = UIFont(name: "Circular-Book", size:15)!
     //  sender.showToolTip(identifier: “”, message:“\((Utility.shared.getLanguage()?.value(forKey:“specialtooltip”))!)“, button:nil, arrowPosition: .bottom, preferences: preference, delegate: nil)
          sender.showToolTip(identifier: "", message:"\((Utility.shared.getLanguage()?.value(forKey:"stripe_verificationInfo"))!)", button:nil, arrowPosition: .bottom, preferences: preference, delegate: nil)
        
        
    }
    @objc func verifyBtnTapped(_ sender: UIButton)
    {
      if Utility().isConnectedToNetwork(){
        self.VerifyAPICall(stripeaccountID: getpayoutArray[sender.tag].payEmail!)
        }
        else
      {
        self.offlineview.isHidden = false
        let shadowSize2 : CGFloat = 3.0
        let shadowPath2 = UIBezierPath(rect: CGRect(x: -shadowSize2 / 2,
                                                    y: -shadowSize2 / 2,
                                                    width: self.offlineview.frame.size.width + shadowSize2,
                                                    height: self.offlineview.frame.size.height + shadowSize2))
        
        self.offlineview.layer.masksToBounds = false
        self.offlineview.layer.shadowColor = TextLightColor.cgColor
        self.offlineview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.offlineview.layer.shadowOpacity = 0.3
        self.offlineview.layer.shadowPath = shadowPath2.cgPath
        if IS_IPHONE_X || IS_IPHONE_XR{
            offlineview.frame = CGRect.init(x: 0, y: FULLHEIGHT-130, width: FULLWIDTH, height: 55)
        }else{
            offlineview.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
        }
        
        }
    }
    func lottiewholeAnimation()
       {
           self.lottieView1.isHidden = false
           self.lottieWholeView.isHidden = false
            lottieView1 = LOTAnimationView.init(name: "loading_qwe")
           self.lottieWholeView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height: FULLHEIGHT)
           self.lottieWholeView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
           self.view.addSubview(lottieWholeView)
           self.lottieView1.frame = CGRect(x:FULLWIDTH/2-50, y: FULLHEIGHT/2-50, width: 100, height: 100)
           self.lottieWholeView.addSubview(self.lottieView1)
           self.lottieView1.backgroundColor = UIColor.white
           self.lottieView1.layer.cornerRadius = 6.0
           self.lottieView1.clipsToBounds = true
           self.lottieView1.play()
            Timer.scheduledTimer(timeInterval:0.3, target: self, selector: #selector(autoscrolling), userInfo: nil, repeats: true)
       }
    func setPayoutCall(accountid:String)
    {
        self.lottiewholeAnimation()
        let setPayoutMutation = ConfirmPayoutMutation(currentAccountId:accountid)
        apollo_headerClient.perform(mutation:setPayoutMutation){(result,error) in
                if(result?.data?.confirmPayout?.status == 200)
                {
                    self.payoutAPICall()
                    self.lottieView1.isHidden = true
                    self.lottieWholeView.isHidden = true
                    //self.payoutTable.reloadData()

//                                    let payoutObj = PayoutPreferenceVC()
//                                                    Utility.shared.isfrom_payoutcurrency = true
//                                                     payoutObj.modalPresentationStyle = .fullScreen
//                                                    self.present(payoutObj, animated: true, completion: nil)
                }
                else
                {
                    self.lottieView1.isHidden = true
                    self.lottieWholeView.isHidden = true
                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"somethingwrong"))!)")
                }
    }
            
            
    }
    func VerifyAPICall(stripeaccountID:String)
    {
    let verifyPayoutmutation = VerifyPayoutMutation(stripeAccount: stripeaccountID)
    apollo_headerClient.perform(mutation:verifyPayoutmutation) {(result,error) in
        if(result?.data?.verifyPayout?.status == 200)
        {
            let webviewObj = WebviewVC()
            webviewObj.delegate = self
            webviewObj.webstring = (result?.data?.verifyPayout?.connectUrl)!
            webviewObj.modalPresentationStyle = .fullScreen
            webviewObj.succesURL = (result?.data?.verifyPayout?.successUrl)!
            webviewObj.failureURL = (result?.data?.verifyPayout?.failureUrl)!
            webviewObj.webviewRedirection(webviewString:(result?.data?.verifyPayout?.connectUrl!)!)
            webviewObj.accountID = (result?.data?.verifyPayout?.stripeAccountId!)!
            self.present(webviewObj, animated: true, completion: nil)
    }
        else
        {
            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"somethingwrong"))!)")
        }
    }
    
    }
    @objc func defaultBtnTapped(_ sender: UIButton)
    {
        if Utility().isConnectedToNetwork(){
        self.setDefaultAPICall(id: getpayoutArray[sender.tag].id!, type: "set")
        }
        else
        {
            self.offlineview.isHidden = false
            let shadowSize2 : CGFloat = 3.0
            let shadowPath2 = UIBezierPath(rect: CGRect(x: -shadowSize2 / 2,
                                                        y: -shadowSize2 / 2,
                                                        width: self.offlineview.frame.size.width + shadowSize2,
                                                        height: self.offlineview.frame.size.height + shadowSize2))
            
            self.offlineview.layer.masksToBounds = false
            self.offlineview.layer.shadowColor = TextLightColor.cgColor
            self.offlineview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            self.offlineview.layer.shadowOpacity = 0.3
            self.offlineview.layer.shadowPath = shadowPath2.cgPath
            if IS_IPHONE_X || IS_IPHONE_XR{
                offlineview.frame = CGRect.init(x: 0, y: FULLHEIGHT-130, width: FULLWIDTH, height: 55)
            }else{
                offlineview.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
            }
            
        }
        
    }
    @objc func deleteBtnTapped(_ sender: UIButton)
    {
         if Utility().isConnectedToNetwork(){
            if((getpayoutArray.count > sender.tag) && getpayoutArray[sender.tag].id != nil)
            {
        self.setDefaultAPICall(id: getpayoutArray[sender.tag].id!, type: "remove")
            }
        }
         else
         {
            self.offlineview.isHidden = false
            let shadowSize2 : CGFloat = 3.0
            let shadowPath2 = UIBezierPath(rect: CGRect(x: -shadowSize2 / 2,
                                                        y: -shadowSize2 / 2,
                                                        width: self.offlineview.frame.size.width + shadowSize2,
                                                        height: self.offlineview.frame.size.height + shadowSize2))
            
            self.offlineview.layer.masksToBounds = false
            self.offlineview.layer.shadowColor = TextLightColor.cgColor
            self.offlineview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            self.offlineview.layer.shadowOpacity = 0.3
            self.offlineview.layer.shadowPath = shadowPath2.cgPath
            if IS_IPHONE_X || IS_IPHONE_XR{
                offlineview.frame = CGRect.init(x: 0, y: FULLHEIGHT-130, width: FULLWIDTH, height: 55)
            }else{
                offlineview.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
            }
            
        }
        
    }
    
    func payoutAPICall()
    {
        let getpayoutquery = GetPayoutsQuery()
        apollo_headerClient.fetch(query: getpayoutquery,cachePolicy:.fetchIgnoringCacheData){(result,error) in
            guard (result?.data?.getPayouts?.results) != nil else{
                print("Missing Data")
                self.payoutTable.isHidden = true
                self.nodataview.isHidden = false
                self.lottieView.isHidden = true
                return
            }
           
            
            self.getpayoutArray = ((result?.data?.getPayouts?.results)!) as! [GetPayoutsQuery.Data.GetPayout.Result]
            if(self.getpayoutArray.count>0)
            {
                self.payoutTable.isHidden = false
                self.nodataview.isHidden = true
                self.lottieView.isHidden = true
                self.payoutTable.reloadData()
                self.scrollToBottom()
            }
            else
            {
                self.payoutTable.isHidden = true
                self.lottieView.isHidden = true
                self.nodataview.isHidden = false
            }
            
           
        }
        
    }
    
   func scrollToBottom() {
        if self.getpayoutArray.count != 0  {
            
            
            // DispatchQueue.main.async {
            let indexPath = IndexPath(row:0,section:0)
            self.payoutTable.scrollToRow(at: indexPath, at: .top, animated: false)
            // }
        }
    }

func setDefaultAPICall(id:Int,type:String)
{
        let setdefaultMutation = SetDefaultPayoutMutation(id: id, type: type)
        apollo_headerClient.perform(mutation: setdefaultMutation) {(result,error) in
            
            if (result?.data?.setDefaultPayout?.status == 200)
            {
                self.payoutAPICall()
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

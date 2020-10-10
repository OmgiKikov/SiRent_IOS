//
//  ContacthostVC.swift
//  Rent_All
//
//  Created by RadicalStart on 17/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Apollo
import Lottie


protocol ContacthostVCDelegate {
    func passSelectedStartDate(selectedstartDate:Date)
    func passSelectedEndDate(selectedenddate:Date)
    
    
}

class ContacthostVC: UIViewController,UITableViewDelegate,UITableViewDataSource,checkTextviewCellDelegate,AirbnbDatePickerDelegate,AirbnbOccupantFilterControllerDelegate {
    
    @IBOutlet weak var offlineView: UIView!
    
    @IBOutlet weak var errorLAbel: UILabel!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var retryBtn: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var contacthostTable: UITableView!
     var viewListingArray = ViewListingDetailsQuery.Data.ViewListing.Result()
    var getbillingArray = GetBillingCalculationQuery.Data.GetBillingCalculation.Result()
    var currencyvalue_from_API_base = String()
    var currency_Dict = NSDictionary()
    var addDateinLabel = String()
    var addDateoutLabel = String()
    var guestLabel_text = String()
    var selected_datein_Label = String()
    var selected_dateout_Label = String()
    public var selectedStartDate: Date?
    public var selectedEndDate: Date?
    var adultCount: Int = 1
    var childrenCount: Int = 0
    var infantCount: Int = 0
    var hasPet: Bool = false
    var guest_filter = Int()
    var delegate:ContacthostVCDelegate?
    var guest_Count = Int()
    var lottieView: LOTAnimationView!
    
    var apollo_headerClient: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
        
        let url = URL(string:graphQLEndpoint)!
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        contacthostTable.rowHeight = UITableView.automaticDimension
        // Do any additional setup after loading the view.
    }
    func initialSetup()
    {
        selectedStartDate = nil
        selectedEndDate = nil
        let shadowSize : CGFloat = 3.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.bottomView.frame.size.width+40 + shadowSize,
                                                   height: self.bottomView.frame.size.height+40 + shadowSize))
        
        self.bottomView.layer.masksToBounds = false
        self.bottomView.layer.shadowColor = TextLightColor.cgColor
        self.bottomView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.bottomView.layer.shadowOpacity = 0.3
        self.bottomView.layer.shadowPath = shadowPath.cgPath
        sendBtn.backgroundColor = Theme.PRIMARY_COLOR
        let shadowPath1 = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                    y: -shadowSize / 2,
                                                    width: self.topView.frame.size.width+40 + shadowSize,
                                                    height: self.topView.frame.size.height + shadowSize))
        
        self.topView.layer.masksToBounds = false
        self.topView.layer.shadowColor = TextLightColor.cgColor
        self.topView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.topView.layer.shadowOpacity = 0.3
        self.topView.layer.shadowPath = shadowPath1.cgPath
        contacthostTable.register(UINib(nibName: "ContactheaderCell", bundle: nil), forCellReuseIdentifier: "ContactheaderCell")
        contacthostTable.register(UINib(nibName: "contactcheckCell", bundle: nil), forCellReuseIdentifier: "contactcheckCell")
        contacthostTable.register(UINib(nibName: "checkTextviewCell", bundle: nil), forCellReuseIdentifier: "checkTextviewCell")
        contacthostTable.rowHeight = UITableView.automaticDimension
        self.offlineView.isHidden = true
        self.sendBtn.layer.cornerRadius = 6.0
        self.sendBtn.layer.masksToBounds = true
        lottieView = LOTAnimationView.init(name: "animation_white")
        errorLAbel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
        retryBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
        sendBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"sendmessage"))!)", for:.normal)
        
        
    }
    func lottieanimation()
    {
        sendBtn.setTitle("", for:.normal)
        lottieView = LOTAnimationView.init(name: "animation_white")
       
        self.lottieView.isHidden = false
        self.lottieView.frame = CGRect(x:sendBtn.frame.size.width/2-60, y:-25, width:100, height:100)
        self.sendBtn.addSubview(self.lottieView)
        self.lottieView.backgroundColor = UIColor.clear
        self.lottieView.play()
        // animation_white.json
        Timer.scheduledTimer(timeInterval:0.3, target: self, selector: #selector(autoscroll), userInfo: nil, repeats: true)
    }
    @objc func autoscroll()
    {
        self.lottieView.play()
    }
    
func ContacthostAPICall(message:String)
{
    let contacthostMutation = ContactHostMutation(listId: viewListingArray.id!, hostId: viewListingArray.userId!, content:message, userId: "\(Utility.shared.getCurrentUserID()!)", type: "inquiry", startDate: selected_datein_Label, endDate: selected_dateout_Label, personCapacity: guest_Count)
    
    Utility.shared.personCapcityForMessagePage = guest_Count
    
    apollo_headerClient.perform(mutation: contacthostMutation){ (result,error) in
        
        if(result?.data?.createEnquiry?.status == 200)
        {
           self.lottieView.isHidden = true
            self.sendBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"sendmessage"))!)", for: .normal)
            
            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"sendmessage_alert"))!)")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                // code to remove your view
                self.sendBtn.isUserInteractionEnabled = true
                self.dismiss(animated: true, completion: nil)
            }
        }
        else{
            self.sendBtn.isUserInteractionEnabled = true; self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"somethingwrong"))!)")
        }
    }
    
    }

    @IBAction func sendMesgBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
        let cell = view.viewWithTag((2) + 2000) as? checkTextviewCell
        let text = cell?.checkTxtview.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if(Utility.shared.checkEmptyWithString(value: text!))
        {
            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"messagealert"))!)")
        }
        else if(selected_datein_Label == "")
        {
        self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"selectdate"))!)")
        }
        else{
            sendBtn.isUserInteractionEnabled = false
            self.lottieanimation()
            self.ContacthostAPICall(message:(cell?.checkTxtview.text!)!)
            
        }
        }
        else
        {
            self.offlineView.isHidden = false
            self.bottomView.isHidden = true
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
            if IS_IPHONE_X || IS_IPHONE_XR {
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-85, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-55, width: FULLWIDTH, height: 55)
            }
            
        }
    }
    @IBAction func retryBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            self.offlineView.isHidden = true
             self.bottomView.isHidden = false
        }
            
    }
    
    @objc func listBtnTapped(_ sender: UIButton)
     {
         if Utility().isConnectedToNetwork(){
    let guestdetailObj = GuestDetailVC()
    Utility.shared.unpublish_preview_check = false
    guestdetailObj.listID = viewListingArray.id!
    guestdetailObj.currencyvalue_from_API_base = Utility.shared.currencyvalue_from_API_base
    guestdetailObj.currency_Dict = Utility.shared.currency_Dict
     guestdetailObj.modalPresentationStyle = .fullScreen
    self.present(guestdetailObj, animated: true, completion: nil)
        }
         else
         {
            self.view.endEditing(true)
            self.offlineView.isHidden = false
            self.bottomView.isHidden = true
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
            if IS_IPHONE_X || IS_IPHONE_XR {
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-85, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-55, width: FULLWIDTH, height: 55)
            }
            
        }
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        if(selectedStartDate != nil)
        {
        self.delegate?.passSelectedStartDate(selectedstartDate: selectedStartDate!)
        self.delegate?.passSelectedEndDate(selectedenddate: selectedEndDate!)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:TABLEVIEW DELEGATE & DATASOURCE METHODS *********************************************************************>
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0)
        {
            return 125
        }
        else if(indexPath.row == 1)
        {
        return  95
        }
        else{
         return 1000
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContactheaderCell", for: indexPath)as! ContactheaderCell
            cell.selectionStyle = .none
            let listimage = viewListingArray.listPhotoName!
            cell.listImage.sd_setImage(with: URL(string:"\(IMAGE_LISTING_MEDIUM)\(String(describing: listimage))"),placeholderImage: #imageLiteral(resourceName: "unknown"))
            if(viewListingArray.roomType != nil)
            {
            cell.entireLabel.text = viewListingArray.roomType!
            }
            else{
              cell.entireLabel.text = ""
            }
            if(Utility.shared.getPreferredCurrency() != nil && Utility.shared.getPreferredCurrency() != "")
            {
                let currencysymbol = Utility.shared.getSymbol(forCurrencyCode: Utility.shared.getPreferredCurrency()!)
                let from_currency = self.viewListingArray.listingData?.currency
                let currency_amount = self.viewListingArray.listingData?.basePrice
                let price_value = self.getCurrencyRate(basecurrency:currencyvalue_from_API_base, fromCurrency:from_currency!, toCurrency:Utility.shared.getPreferredCurrency()!, CurrencyRate: self.currency_Dict, amount:currency_amount!)
                 let restricted_price =  Double(String(format: "%.2f",price_value))!
                cell.priceLabel.text =  "\(currencysymbol!)\(restricted_price.clean) \((Utility.shared.getLanguage()?.value(forKey:"pernight"))!)"
            }
            else
            {
                let currencysymbol = Utility.shared.getSymbol(forCurrencyCode:self.currencyvalue_from_API_base)
                let from_currency = self.viewListingArray.listingData?.currency
                let currency_amount = self.viewListingArray.listingData?.basePrice
                let price_value = self.getCurrencyRate(basecurrency:currencyvalue_from_API_base, fromCurrency:from_currency!, toCurrency:currencyvalue_from_API_base, CurrencyRate: self.currency_Dict, amount:currency_amount!)
                let restricted_price =  Double(String(format: "%.2f",price_value))!
                cell.priceLabel.text =  "\(currencysymbol!)\(restricted_price.clean) \((Utility.shared.getLanguage()?.value(forKey:"pernight"))!)"
            }
            //Review Count
            if(viewListingArray.reviewsStarRating != nil)
            {
                let value1 = Double("\(viewListingArray.reviewsCount!)")
                let value2 = Double("\(viewListingArray.reviewsStarRating!)")
                if(value2 != nil){
                    let reviewcount = Int(value2!/value1!)
                    cell.ratingView.rating = Double(reviewcount)
                }
                else{
                    cell.ratingView.rating = 0
                }
            }
            else{
                cell.ratingView.rating = 0
            }
            cell.reviewLabel.text = "\(viewListingArray.reviewsCount!) \((Utility.shared.getLanguage()?.value(forKey:"review"))!)\(viewListingArray.reviewsCount! > 1 ? "s" : "")"
            cell.listBtn.tag = indexPath.row
            cell.listBtn.addTarget(self, action: #selector(listBtnTapped), for: .touchUpInside)
            
            return cell
        }
        else if(indexPath.row == 1)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "contactcheckCell", for: indexPath)as! contactcheckCell
            cell.selectionStyle = .none
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd"
            if(getbillingArray.checkIn != nil)
            {
            let showDate = inputFormatter.date(from:getbillingArray.checkIn!)
            let showDate2 = inputFormatter.date(from:getbillingArray.checkOut!)
                inputFormatter.dateFormat = "MMM dd"
                inputFormatter.locale = NSLocale(localeIdentifier:Utility.shared.getAppLanguageCode()!) as Locale
                addDateinLabel = inputFormatter.string(from: showDate!)
                addDateoutLabel = inputFormatter.string(from: showDate2!)
                cell.addDateinLabel.setTitle(addDateinLabel, for: .normal)
                cell.addOutDateLabel.setTitle(addDateoutLabel, for: .normal)
                let dateformatter = DateFormatter()
                dateformatter.dateFormat = "yyyy-MM-dd"
                let showDate3 = dateformatter.date(from:getbillingArray.checkIn!)
                let showDate4 = dateformatter.date(from:getbillingArray.checkOut!)
                dateformatter.dateFormat = "MM-dd-yyyy"
                selected_datein_Label = dateformatter.string(from: showDate3!)
                selected_dateout_Label = dateformatter.string(from: showDate4!)
                
            }
            else
            {
                cell.addDateinLabel.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"adddate"))!)", for: .normal)
                cell.addOutDateLabel.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"adddate"))!)", for: .normal)
            }
            if(guestLabel_text == "")
            {
                guest_Count = 1
                cell.guestLabel.setTitle("1 \((Utility.shared.getLanguage()?.value(forKey:"guest"))!)", for: .normal)
            }
            else{
                cell.guestLabel.setTitle(guestLabel_text, for: .normal)
            }
            cell.addDateinLabel.addTarget(self, action: #selector(addinBtnTapped), for: .touchUpInside)
            cell.addOutDateLabel.addTarget(self, action: #selector(addinBtnTapped), for: .touchUpInside)
            cell.guestLabel.addTarget(self, action: #selector(guestBtnTapped), for: .touchUpInside)
            return cell
            
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "checkTextviewCell", for: indexPath)as! checkTextviewCell
            cell.selectionStyle = .none
            cell.delegate = self
            cell.tag = indexPath.row + 2000
            cell.checkTxtview.layer.cornerRadius = 6.0
            cell.checkTxtview.layer.masksToBounds = true
            //cell.checkTxtview.backgroundColor = .red
            let toolBar = UIToolbar().ToolbarPikerSelect(mySelect: #selector(dismissPicker))
            cell.checkTxtview.inputAccessoryView = toolBar
           // cell.checkTxtview.becomeFirstResponder()
//            cell.checkTxtview.translatesAutoresizingMaskIntoConstraints = true
//            cell.checkTxtview.sizeToFit()
            return cell
        }
    }
    @objc func dismissPicker()
    {
        view.endEditing(true)
        
    }
    
    //  fun getRate(base: String, to: String, from: String, rateStr: String, amount: Double) : Double {
    func getCurrencyRate(basecurrency:String,fromCurrency:String,toCurrency:String,CurrencyRate:NSDictionary,amount:Double) -> Double
    {
        if(fromCurrency == basecurrency)
        {
            return (CurrencyRate.object(forKey: toCurrency) as! Double) * (amount)
        }
        else if(toCurrency == basecurrency)
        {
            return  (1 / (CurrencyRate.object(forKey: fromCurrency)as! Double) * (amount))
        }
        else{
            return amount * ((CurrencyRate.object(forKey: toCurrency)as! Double) * ((1 / (CurrencyRate.object(forKey: fromCurrency)as! Double))))
        }
        
    }
    @objc func addinBtnTapped(_ sender: UIButton!) {
        Utility.shared.blocked_date_month.removeAllObjects()
        for i in viewListingArray.blockedDates!
        {
            let timestamp = i?.blockedDates
            let timestamValue = Int(timestamp!)!/1000
            let newTime = Date(timeIntervalSince1970: TimeInterval(timestamValue))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-LL-YYYY" //Specify your format that you want
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "LL"
            let date = "\(dateFormatter.string(from: newTime))"
            if(i?.calendarStatus != "available")
            {
            Utility.shared.blocked_date_month.add("\(date)")
            }
            Utility.shared.blockedDates.add(dateFormatter.string(from: newTime))
        }
        Utility.shared.minimumstay = (viewListingArray.listingData?.minNight!)!
        Utility.shared.isfromcheckingPage = true
        Utility.shared.maximum_days_notice = Utility.shared.maximum_notice_period(maximumnoticeperiod: (viewListingArray.listingData?.maxDaysNotice!)!)!
        let datePickerViewController = AirbnbDatePickerViewController(dateFrom: selectedStartDate, dateTo: selectedEndDate)
        datePickerViewController.delegate = self
        datePickerViewController.viewListingArray = viewListingArray
        let navigationController = UINavigationController(rootViewController: datePickerViewController)
        
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @objc func guestBtnTapped(_ sender: UIButton!) {
        Utility.shared.isfromcheckingPage = true
        Utility.shared.maximum_Count_for_booking = viewListingArray.personCapacity!
        let occupantController = AirbnbOccupantFilterController(adultCount: adultCount, childrenCount: childrenCount, infantCount: infantCount, hasPet: hasPet)
        occupantController.delegate = self
        let navigationController = UINavigationController(rootViewController: occupantController)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func datePickerController(_ datePickerController: AirbnbDatePickerViewController, didSaveStartDate startDate: Date?, endDate: Date?) {
        
        selectedStartDate = startDate
        selectedEndDate = endDate
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        if(startDate != nil && endDate != nil){
            print(dateFormatterGet.string(from: startDate!))
        }
        
        if selectedStartDate == nil && selectedEndDate == nil {
            
        } else {
            let fmt = DateFormatter()
            fmt.dateFormat = "yyyy-MM-dd"
            billingListAPICall(startDate: fmt.string(from: startDate!), endDate: fmt.string(from: endDate!))
        }
    }
    
    func occupantFilterController(_ occupantFilterController: AirbnbOccupantFilterController, didSaveAdult adult: Int, children: Int, infant: Int, pet: Bool) {
        self.adultCount = adult
        self.childrenCount = children
        self.infantCount = infant
        self.hasPet = pet
        self.guest_filter = adult
        
        let human = adult + children
        let infant = "\(infant > 0 ? (infant.description + " infant" + (infant > 1 ? "s" : "")) : "")"
        let pet = "\(pet ? "pets" : "")"
        guest_Count = human
        guestLabel_text = "\(human) \((Utility.shared.getLanguage()?.value(forKey:"guest"))!)\(human > 1 ? "s" : "")" + (infant != "" ? ", " + infant : "") + (pet != "" ? ", " + pet : "")
        contacthostTable.reloadData()
        
    }
    func billingListAPICall(startDate:String,endDate:String)
    {
        if Utility().isConnectedToNetwork(){
            var currency = String()
            if(Utility.shared.getPreferredCurrency() != nil && Utility.shared.getPreferredCurrency() != "")
            {
                currency = Utility.shared.getPreferredCurrency()!
            }
            else
            {
                currency = Utility.shared.currencyvalue_from_API_base
            }
        let billingListquery = GetBillingCalculationQuery(listId: viewListingArray.id!, startDate: startDate, endDate: endDate, guests: 1, convertCurrency:currency)
        apollo_headerClient.fetch(query: billingListquery){(result,error) in
            guard (result?.data?.getBillingCalculation?.result) != nil else{
                print("Missing Data")
                return
            }
            self.getbillingArray = (result?.data?.getBillingCalculation?.result)!
            self.contacthostTable.reloadData()
            
        }
        }
        else
        {
            self.offlineView.isHidden = false
            self.bottomView.isHidden = true
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
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-85, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-55, width: FULLWIDTH, height: 55)
            }
            
        }
    }
    func configureNextBtn(enable:Bool){
        
        if(enable){
            self.sendBtn.isUserInteractionEnabled = true
            self.sendBtn.alpha = 1.0
        }
        else {
            self.sendBtn.isUserInteractionEnabled = false
            self.sendBtn.alpha = 0.7
        }
        
    }
    
    func didChangeText(text: String?, cell: checkTextviewCell) {
//        Dispatch
//        contacthostTable.beginUpdates()
//        contacthostTable.endUpdates()
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
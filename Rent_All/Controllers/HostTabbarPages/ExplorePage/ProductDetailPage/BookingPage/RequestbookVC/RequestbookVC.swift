//
//  RequestbookVC.swift
//  Rent_All
//
//  Created by RadicalStart on 27/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Apollo
import MKToolTip

protocol RequestbookVCDelegate {
    func passSelectedStartDate(selectedstartDate:Date)
    func passSelectedEndDate(selectedenddate:Date)
    
    
}


class RequestbookVC: UIViewController,UITableViewDelegate,UITableViewDataSource,AirbnbDatePickerDelegate,AirbnbOccupantFilterControllerDelegate{
    
   
    
    
    //MARK******************************* IBOUTLET CONNECTIONS ***********************************************************>
    
    @IBOutlet weak var offlineView: UIView!
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var bookBtn: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var requestTable: UITableView!
     var viewListingArray = ViewListingDetailsQuery.Data.ViewListing.Result()
     var currencyvalue_from_API_base = String()
    var currency_Dict = NSDictionary()
    public var selectedStartDate: Date?
    public var selectedEndDate: Date?
    var delegate:RequestbookVCDelegate?
      var ProfileAPIArray = GetProfileQuery.Data.UserAccount.Result()
    var addDateinLabel = String()
    var addDateoutLabel = String()
    var totalPriceLabel = String()
    var guestLabel_text = String()
    
    var adultCount: Int = 1
    var childrenCount: Int = 0
    var infantCount: Int = 0
    var hasPet: Bool = false
     var guest_filter = Int()
    
    
    var apollo_headerClient: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
        
        let url = URL(string:graphQLEndpoint)!
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()
    
    var getbillingArray = GetBillingCalculationQuery.Data.GetBillingCalculation.Result()
    override func viewDidLoad() {
        super.viewDidLoad()
         self.initialsetUp()
         bookBtn.layer.cornerRadius = 5.0
        DispatchQueue.main.async {
      self.profileAPICall()
        }
    
        // Do any additional setup after loading the view.
    }

    @IBAction func closeBtnTapped(_ sender: Any) {
        self.delegate?.passSelectedStartDate(selectedstartDate: selectedStartDate!)
        self.delegate?.passSelectedEndDate(selectedenddate: selectedEndDate!)
        self.dismiss(animated: true, completion: nil)
      
        
    }
    
    @IBAction func retryBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            offlineView.isHidden = true
            self.bottomView.isHidden = false
            let fmt = DateFormatter()
            fmt.dateFormat = "yyyy-MM-dd"
            billingListAPICall(startDate: fmt.string(from: selectedStartDate!), endDate: fmt.string(from: selectedEndDate!))
        }
    }
    @IBAction func requestBookBtnTapped(_ sender: Any) {
         if Utility().isConnectedToNetwork(){
        if(ProfileAPIArray.verification?.isEmailConfirmed == true)
        {
        
        let bookoneStepObj = BookingstepOneVC()
        bookoneStepObj.houserulesArray = self.viewListingArray.houseRules! as! [ViewListingDetailsQuery.Data.ViewListing.Result.HouseRule]
        Utility.shared.passbillingArray = getbillingArray
        Utility.shared.passCurrencyvaluefromAPI = currencyvalue_from_API_base
        bookoneStepObj.viewListingArray = viewListingArray
        bookoneStepObj.addDateinLabel = addDateinLabel
        bookoneStepObj.addDateoutLabel = addDateoutLabel
        bookoneStepObj.totalPriceLabel = totalPriceLabel
        if(ProfileAPIArray.picture == nil)
            {
                Utility.shared.isprofilepictureVerified = true
            }
            Utility.shared.bookingListimage = viewListingArray.listPhotoName!
            Utility.shared.bookingListname = viewListingArray.title!
            if(guestLabel_text == "")
            {
               guestLabel_text = "1 guest"
            }
            Utility.shared.bookingdateLabel = "\(addDateinLabel) - \(addDateoutLabel),\(guestLabel_text)"
        self.present(bookoneStepObj, animated: true, completion: nil)
        }
        else{

            if(ProfileAPIArray.verification?.isEmailConfirmed != nil)
            {
            self.view.makeToast("Email is not verified.Please verify it.")
            }

    
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
            
            //        let offLineViewObj = OfflinePage()
            //        UIApplication.shared.keyWindow?.rootViewController?.present(offLineViewObj, animated: false, completion: nil)
            
        }
    }
    
    func initialsetUp()
    {
        if IS_IPHONE_XR
        {
            self.topView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH-40, height: 80)
            requestTable.frame = CGRect(x: 0, y: 85, width: FULLWIDTH-40, height: FULLHEIGHT-300)
            
        }
        requestTable.register(UINib(nibName: "ContactheaderCell", bundle: nil), forCellReuseIdentifier: "ContactheaderCell")
        requestTable.register(UINib(nibName: "contactcheckCell", bundle: nil), forCellReuseIdentifier: "contactcheckCell")
        requestTable.register(UINib(nibName: "RequestBookcellTableViewCell", bundle: nil), forCellReuseIdentifier: "RequestBookcellTableViewCell")
        requestTable.register(UINib(nibName: "ReservationCell", bundle: nil), forCellReuseIdentifier: "ReservationCell")
        requestTable.register(UINib(nibName: "BookingTotalCell", bundle: nil), forCellReuseIdentifier: "BookingTotalCell")
        
        let shadowSize : CGFloat = 3.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.bottomView.frame.size.width+40 + shadowSize,
                                                   height: self.bottomView.frame.size.height + shadowSize))
        
        self.bottomView.layer.masksToBounds = false
        self.bottomView.layer.shadowColor = TextLightColor.cgColor
        self.bottomView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.bottomView.layer.shadowOpacity = 0.3
        self.bottomView.layer.shadowPath = shadowPath.cgPath
        
        
        let shadowPath1 = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                    y: -shadowSize / 2,
                                                    width: self.topView.frame.size.width+40 + shadowSize,
                                                    height: self.topView.frame.size.height + shadowSize))
        
        self.topView.layer.masksToBounds = false
        self.topView.layer.shadowColor = TextLightColor.cgColor
        self.topView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.topView.layer.shadowOpacity = 0.3
        self.topView.layer.shadowPath = shadowPath1.cgPath
        if(viewListingArray.bookingType! == "instant")
        {
            self.bookBtn.setTitle("Book", for: .normal)
        }
        else
        {
           self.bookBtn.setTitle("Request to book", for: .normal)
        }
        self.offlineView.isHidden = true
    }
     func numberOfSections(in tableView: UITableView) -> Int {
       return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       if(section == 3)
       {
        if(getbillingArray.cleaningPrice == 0)
        {
            if(getbillingArray.discountLabel != nil && getbillingArray.discount != 0)
            {
                return 3
            }
            return 2
            
        }
        else
        {
            if(getbillingArray.discountLabel != nil && getbillingArray.discount != 0 )
            {
                return 4
            }
             return 3
        }
        
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0)
        {
            return 125
        }
        else if(indexPath.section == 1)
        {
            return  95
        }
            else if(indexPath.section == 2)
        {
            return 45
        }
            else if(indexPath.section == 3)
        {
            return 55
        }
    
        else{
            return 100
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContactheaderCell", for: indexPath)as! ContactheaderCell
            cell.selectionStyle = .none
            let listimage = viewListingArray.listPhotoName!
            cell.listImage.sd_setImage(with: URL(string:"\(IMAGE_LISTING_MEDIUM)\(String(describing: listimage))"),placeholderImage: #imageLiteral(resourceName: "unknown"))
            cell.entireLabel.text = viewListingArray.roomType!
            if(Utility.shared.getPreferredCurrency() != nil)
            {
                let currencysymbol = Utility.shared.getSymbol(forCurrencyCode: Utility.shared.getPreferredCurrency()!)
                let from_currency = self.viewListingArray.listingData?.currency
                let currency_amount = self.viewListingArray.listingData?.basePrice!
                let price_value = self.getCurrencyRate(basecurrency:currencyvalue_from_API_base, fromCurrency:from_currency!, toCurrency:Utility.shared.getPreferredCurrency()!, CurrencyRate: self.currency_Dict, amount:currency_amount!)
                let restricted_price =  Double(String(format: "%.2f",price_value))
                cell.priceLabel.text =  "\(currencysymbol!)\(restricted_price!.clean) per night"
            }
            else
            {
                let currencysymbol = Utility.shared.getSymbol(forCurrencyCode:self.currencyvalue_from_API_base)
                let from_currency = self.viewListingArray.listingData?.currency
                let currency_amount = self.viewListingArray.listingData?.basePrice!
                let price_value = self.getCurrencyRate(basecurrency:currencyvalue_from_API_base, fromCurrency:from_currency!, toCurrency:currencyvalue_from_API_base, CurrencyRate: self.currency_Dict, amount:currency_amount!)
                let restricted_price =  Double(String(format: "%.2f",price_value))
                cell.priceLabel.text =  "\(currencysymbol!)\(restricted_price!.clean) per night"
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
            if(viewListingArray.reviewsCount!>1)
            {
             cell.reviewLabel.text = "\(viewListingArray.reviewsCount!) Reviews"
            }
            else
            {
             cell.reviewLabel.text = "\(viewListingArray.reviewsCount!) Review"
            }
            return cell
        }
        else if(indexPath.section == 1)
        {
          let cell = tableView.dequeueReusableCell(withIdentifier: "contactcheckCell", for: indexPath)as! contactcheckCell
            cell.selectionStyle = .none
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd"
            let showDate = inputFormatter.date(from:getbillingArray.checkIn!)
            let showDate2 = inputFormatter.date(from:getbillingArray.checkOut!)
            inputFormatter.dateFormat = "MMM dd"
            addDateinLabel = inputFormatter.string(from: showDate!)
            addDateoutLabel = inputFormatter.string(from: showDate2!)
            cell.addDateinLabel.setTitle(addDateinLabel, for: .normal)
            cell.addOutDateLabel.setTitle(addDateoutLabel, for: .normal)
            if(guestLabel_text == "")
            {
            cell.guestLabel.setTitle("1 guest", for: .normal)
            }
            else{
              cell.guestLabel.setTitle(guestLabel_text, for: .normal)
            }
            cell.addDateinLabel.addTarget(self, action: #selector(addinBtnTapped), for: .touchUpInside)
            cell.addOutDateLabel.addTarget(self, action: #selector(addinBtnTapped), for: .touchUpInside)
            cell.guestLabel.addTarget(self, action: #selector(guestBtnTapped), for: .touchUpInside)
            return cell
        }
        else if(indexPath.section == 2)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationCell", for: indexPath)as! ReservationCell
            cell.selectionStyle = .none
            return cell
        }
        else if(indexPath.section == 3)
        {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestBookcellTableViewCell", for: indexPath)as! RequestBookcellTableViewCell
        cell.selectionStyle = .none
        var currencysymbol = String()
        cell.specialImage.isHidden = true
        cell.specialImage.addTarget(self, action: #selector(tooltipBtnTapped),for:.touchUpInside)
            
        if(Utility.shared.getPreferredCurrency() != nil)
        {
            currencysymbol = Utility.shared.getSymbol(forCurrencyCode: Utility.shared.getPreferredCurrency()!)!
        }
        else
        {
            currencysymbol = Utility.shared.getSymbol(forCurrencyCode:self.currencyvalue_from_API_base)!
        }
            
            if(getbillingArray.cleaningPrice == 0)
            {
                if(getbillingArray.discountLabel != nil && getbillingArray.discount != 0)
                {
                    if(indexPath.row == 0)
                    {
                        cell.priceLabel.text =  "\(currencysymbol)\(getbillingArray.averagePrice!.clean) * \(Utility.shared.numberofnights_Selected) night\(Utility.shared.numberofnights_Selected > 1 ? "s" : "")"
                        if(getbillingArray.isSpecialPriceAssigned == true)
                        {
                            cell.specialImage.isHidden = false
                        }
            
                       // let calculated_Price = Double(String(format: "%.2f",(getbillingArray.basePrice! * Double(Utility.shared.numberofnights_Selected))))as! Double
                        cell.priceLeftLabel.text = "\(currencysymbol)\(getbillingArray.priceForDays!.clean)"
                    }
                    else if(indexPath.row == 1)
                    {
                        cell.priceLabel.text =  "Service Fee"
                      
                        cell.priceLeftLabel.text = "\(currencysymbol)\(getbillingArray.guestServiceFee!.clean)"
                    }
                    else{
                        cell.priceLabel.text =  getbillingArray.discountLabel!.capitalized
                        
                        cell.priceLeftLabel.text = "-\(currencysymbol)\(getbillingArray.discount!.clean)"
                    }
                    return cell
                }
                else
                {
                    if(indexPath.row == 0)
                    {
                        cell.priceLabel.text =  "\(currencysymbol)\(getbillingArray.averagePrice!.clean) * \(Utility.shared.numberofnights_Selected) night\(Utility.shared.numberofnights_Selected > 1 ? "s" : "")"
                        if(getbillingArray.isSpecialPriceAssigned == true)
                        {
                            cell.specialImage.isHidden = false
                        }
                        
                       // let calculated_Price = Double(String(format: "%.2f",(getbillingArray.basePrice! * Double(Utility.shared.numberofnights_Selected))))as! Double
                        cell.priceLeftLabel.text = "\(currencysymbol)\(getbillingArray.priceForDays!.clean)"
                    }
                    else if(indexPath.row == 1)
                    {
                        cell.priceLabel.text =  "Service Fee"
                        
                        cell.priceLeftLabel.text = "\(currencysymbol)\(getbillingArray.guestServiceFee!.clean)"
                    }
                    return cell
                    
                }
                
            }
            else{
                
                if(getbillingArray.discountLabel != nil &&  getbillingArray.discount != 0)
                {
                    if(indexPath.row == 0)
                    {
                        cell.priceLabel.text =  "\(currencysymbol)\(getbillingArray.averagePrice!.clean) * \(Utility.shared.numberofnights_Selected) night\(Utility.shared.numberofnights_Selected > 1 ? "s" : "")"
                        let calculated_Price = Double(String(format: "%.2f",(getbillingArray.basePrice! * Double(Utility.shared.numberofnights_Selected))))as! Double
                        if(getbillingArray.isSpecialPriceAssigned == true)
                        {
                            cell.specialImage.isHidden = false
                        }
                        
                        cell.priceLeftLabel.text = "\(currencysymbol)\(getbillingArray.priceForDays!.clean)"
                    }
                    else if(indexPath.row == 1)
                    {
                        cell.priceLabel.text =  "Cleaning Fee"
                    
                        cell.priceLeftLabel.text = "\(currencysymbol)\(getbillingArray.cleaningPrice!.clean)"
                    }
                    else if(indexPath.row == 2)
                    {
                        cell.priceLabel.text =  "Service Fee"
                        
                        cell.priceLeftLabel.text = "\(currencysymbol)\(getbillingArray.guestServiceFee!.clean)"
                    }
                    else{
                        cell.priceLabel.text =  getbillingArray.discountLabel!.capitalized
                        
                        cell.priceLeftLabel.text = "-\(currencysymbol)\(getbillingArray.discount!.clean)"
                    }
                    return cell
                }
                
                else{
                    if(indexPath.row == 0)
                    {
                        cell.priceLabel.text =  "\(currencysymbol)\(getbillingArray.averagePrice!.clean) * \(Utility.shared.numberofnights_Selected) night\(Utility.shared.numberofnights_Selected > 1 ? "s" : "")"
                        let calculated_Price = Double(String(format: "%.2f",(getbillingArray.basePrice! * Double(Utility.shared.numberofnights_Selected))))as! Double
                        if(getbillingArray.isSpecialPriceAssigned == true)
                        {
                            cell.specialImage.isHidden = false
                        }
        
                        cell.priceLeftLabel.text = "\(currencysymbol)\(getbillingArray.priceForDays!.clean)"
                    }
                    else if(indexPath.row == 1)
                    {
                        cell.priceLabel.text =  "Cleaning Fee"
                        
                        cell.priceLeftLabel.text = "\(currencysymbol)\(getbillingArray.cleaningPrice!.clean)"
                    }
                    else if(indexPath.row == 2)
                    {
                        cell.priceLabel.text =  "Service Fee"
                        
                        cell.priceLeftLabel.text = "\(currencysymbol)\(getbillingArray.guestServiceFee!.clean)"
                    }
                    return cell
                }
                
                
            }
            
        
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookingTotalCell", for: indexPath)as! BookingTotalCell
            cell.selectionStyle = .none
            var currencysymbol = String()
            if(Utility.shared.getPreferredCurrency() != nil)
            {
                currencysymbol = Utility.shared.getSymbol(forCurrencyCode: Utility.shared.getPreferredCurrency()!)!
            }
            else
            {
                currencysymbol = Utility.shared.getSymbol(forCurrencyCode:self.currencyvalue_from_API_base)!
            }
            cell.totalPriceLabel.text = "\(currencysymbol)\(getbillingArray.total!.clean)"
            totalPriceLabel = "\(currencysymbol)\(getbillingArray.total!.clean)"
            return cell
        }
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
    @objc func tooltipBtnTapped(_ sender: UIButton!)
    {
        let preference = ToolTipPreferences()
        preference.drawing.bubble.color = UIColor.darkGray
        preference.drawing.bubble.spacing = 10
        preference.drawing.bubble.cornerRadius = 5
        preference.drawing.bubble.inset = 15
        preference.drawing.bubble.border.color = UIColor(red: 0.768, green: 0.843, blue: 0.937, alpha: 1.000)
        preference.drawing.bubble.border.width = 1
        preference.drawing.arrow.tipCornerRadius = 5
        preference.drawing.message.color = UIColor.white
        preference.drawing.message.font = UIFont.systemFont(ofSize:15, weight: .medium)
        preference.drawing.button.color = UIColor(red: 0.074, green: 0.231, blue: 0.431, alpha: 1.000)
        preference.drawing.button.font = UIFont.systemFont(ofSize:15, weight: .medium)
        sender.showToolTip(identifier: "", message: "Average rate per night for your trip.", button:nil, arrowPosition: .bottom, preferences: preference, delegate: nil)
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
            print(fmt.string(from: startDate!))
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
        
         guestLabel_text = "\(human) guest\(human > 1 ? "s" : "")" + (infant != "" ? ", " + infant : "") + (pet != "" ? ", " + pet : "")
        requestTable.reloadData()
        
    }
    
    
    func billingListAPICall(startDate:String,endDate:String)
    {
        var currency = String()
        if(Utility.shared.getPreferredCurrency() != nil)
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
            self.requestTable.reloadData()
            
        }
        
    }
    func profileAPICall()
    {
        let profileQuery = GetProfileQuery()
        
        apollo_headerClient.fetch(query:profileQuery,cachePolicy:.fetchIgnoringCacheData){(result,error) in
            
            guard (result?.data?.userAccount?.result) != nil else
            {
                print("Missing Data")
                return
            }
            
            print(result?.data?.userAccount?.result as Any)
            
            self.ProfileAPIArray = ((result?.data?.userAccount?.result)!)
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

//
//  BookingItenaryVC.swift
//  Rent_All
//
//  Created by RadicalStart on 31/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Apollo

@available(iOS 11.0, *)
@available(iOS 11.0, *)
class BookingItenaryVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var iterationTable: UITableView!
    let apollo_headerClient: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
        
        let url = URL(string:graphQLEndpoint)!
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()
    var getReservationArray = GetReservationQuery.Data.GetReservation.Result()
    var getReservation_currencyArray = GetReservationQuery.Data.GetReservation()
    var getbillingArray = GetBillingCalculationQuery.Data.GetBillingCalculation.Result()
    var currencyvalue_from_API_base = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialsetup()

        // Do any additional setup after loading the view.
    }


    @IBAction func backBtnTapped(_ sender: Any) {
        if(Utility.shared.isfromTripsPage)
        {
          self.dismiss(animated: true, completion: nil)
        }
        else{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        Utility.shared.setTab(index: 0)
            Utility.shared.host_message_isfromHost = false
            Utility.shared.host_message_isfrommessage = false
            Utility.shared.isfromfloatmap_Page = false
            Utility.shared.isfromsearchLocationFilter = false
            Utility.shared.locationfromSearch  = ""
            Utility.shared.TotalFilterCount = 0
            if(Utility.shared.searchLocationDict.count > 0)
            {
                Utility.shared.searchLocationDict.setValue(nil, forKey: "lat")
                Utility.shared.searchLocationDict.setValue(nil, forKey: "lon")
            }
            Utility.shared.instantBook = ""
            Utility.shared.roomtypeArray.removeAllObjects()
            Utility.shared.amenitiesArray.removeAllObjects()
            Utility.shared.priceRangeArray.removeAllObjects()
            Utility.shared.facilitiesArray.removeAllObjects()
            Utility.shared.houseRulesArray.removeAllObjects()
            Utility.shared.beds_count = 0
            Utility.shared.bedrooms_count = 0
            Utility.shared.bathroom_count = 0
            if(Utility.shared.isSwitchEnable)
            {
                Utility.shared.isSwitchEnable = false
            }
            Utility.shared.isfromGuestProfile = false
            Utility.shared.setopenTabbar(iswhichtabbar: false)

            self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
            appDelegate.GuestTabbarInitialize(initialView: CustomTabbar())
            
        }
    }
    func initialsetup()
    {
        if IS_IPHONE_XR
        {
            self.topView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH-40, height: 80)
            iterationTable.frame = CGRect(x: 0, y: 85, width: FULLWIDTH-40, height: FULLHEIGHT-300)
            
        }
        let shadowSize : CGFloat = 3.0
        
        let shadowPath1 = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                    y: -shadowSize / 2,
                                                    width: self.topView.frame.size.width+40 + shadowSize,
                                                    height: self.topView.frame.size.height + shadowSize))
        
        self.topView.layer.masksToBounds = false
        self.topView.layer.shadowColor = TextLightColor.cgColor
        self.topView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.topView.layer.shadowOpacity = 0.3
        self.topView.layer.shadowPath = shadowPath1.cgPath
        iterationTable.register(UINib(nibName: "ItenaryListCell", bundle: nil), forCellReuseIdentifier: "ItenaryListCell")
         iterationTable.register(UINib(nibName: "ItenaryImageCell", bundle: nil), forCellReuseIdentifier: "ItenaryImageCell")
         iterationTable.register(UINib(nibName: "ItenarycheckCell", bundle: nil), forCellReuseIdentifier: "ItenarycheckCell")
         iterationTable.register(UINib(nibName: "ItenaryaddressCell", bundle: nil), forCellReuseIdentifier: "ItenaryaddressCell")
         iterationTable.register(UINib(nibName: "ItenaryHostCell", bundle: nil), forCellReuseIdentifier: "ItenaryHostCell")
         iterationTable.register(UINib(nibName: "ItenaryBillingCell", bundle: nil), forCellReuseIdentifier: "ItenaryBillingCell")
        
    }
    
    
    func createReservationAPICall(reservationid:Int)
    {
        var currency = String()
        if(Utility.shared.getPreferredCurrency() != nil && Utility.shared.getPreferredCurrency() != "")
        {
            currency = Utility.shared.getPreferredCurrency()!
        }
        else
        {
            currency = Utility.shared.currencyvalue_from_API_base
        }
     let createReservationquery = GetReservationQuery(reservationId: reservationid,convertCurrency:currency)
        apollo_headerClient.fetch(query: createReservationquery,cachePolicy:.fetchIgnoringCacheData){(result,error) in
            guard (result?.data?.getReservation?.results) != nil else{
                print("Missing Data")
                return
            }
            self.getReservationArray = (result?.data?.getReservation?.results)!
            self.getReservation_currencyArray = (result?.data?.getReservation!)!
            
            self.iterationTable.reloadData()
        
    }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if(getReservationArray.listData?.city != nil)
        {
        return 6
        }
        return 0
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0)
        {
            return 155
        }
        else if(indexPath.section == 1)
        {
            return 365
        }
        else if(indexPath.section == 2)
        {
            return 155
        }
        else if(indexPath.section == 3)
        {
            return 150
        }
        else if(indexPath.section == 4)
        {
            return 235
        }
        else
        {
           return 115
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(getReservationArray.listData?.city != nil)
        {
        return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItenaryListCell", for: indexPath)as! ItenaryListCell
            let city = (getReservationArray.listData?.city!)!
            cell.locationLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"yougoing"))!) \(String(describing: city))!"
            cell.reservationCodeLAbel.text = " \((Utility.shared.getLanguage()?.value(forKey:"reservationcode"))!) \((getReservationArray.confirmationCode!))"

              cell.viewReceiptBtn.addTarget(self, action: #selector(ReceiptBtnTapped), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell
        }
        if(indexPath.section == 1)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItenaryImageCell", for: indexPath)as! ItenaryImageCell
            let listimage = (getReservationArray.listData?.listPhotoName!)!
            cell.listImage.sd_setImage(with: URL(string: "\(IMAGE_LISTING_MEDIUM)\(String(describing: listimage))"), placeholderImage: #imageLiteral(resourceName: "ItemTransparentImg"))
 
            cell.listTitleLabel.text = (getReservationArray.listData?.title!)!
          //  cell.listTitleLabel.frame.size.width =  (cell.frame.size.width-10)
          //  cell.listTitleLabel.frame.size.height = 33
           // cell.listTitleLabel.numberOfLines = 0
           // cell.listTitleLabel.lineBreakMode = .byWordWrapping
            //cell.listTitleLabel.sizeToFit()
            cell.listImage.layer.cornerRadius = 6.0
            cell.listImage.layer.masksToBounds = true
            cell.listLocationLabel.text = "\((getReservationArray.listData?.city!)!), \((getReservationArray.listData?.state!)!), \((getReservationArray.listData?.country!)!)"
            cell.selectionStyle = .none
            if(getReservationArray.listData?.reviewsStarRating != nil)
            {
            let value1 = Double("\((getReservationArray.listData?.reviewsCount!)!)")
            let value2 = Double("\((getReservationArray.listData?.reviewsStarRating!)!)")
            if(value2 != nil){
                let reviewcount = Int(value2!/value1!)
                cell.ratingView.rating = Double(reviewcount)
            }
            else{
                cell.ratingView.rating = 0
            }
            }
            else
            {
               cell.ratingView.rating = 0
            }
            if((getReservationArray.listData?.reviewsCount!)! > 0)
            {
                cell.ratingcountLabel.text = "\((getReservationArray.listData?.reviewsCount!)!) \((Utility.shared.getLanguage()?.value(forKey:"reviews"))!)"
            }
            else
            {
                cell.ratingcountLabel.text = "\((getReservationArray.listData?.reviewsCount!)!) \((Utility.shared.getLanguage()?.value(forKey:"review"))!)"
            }
            return cell
        }
        if(indexPath.section == 2)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItenarycheckCell", for: indexPath)as! ItenarycheckCell
            cell.selectionStyle = .none
            if(getReservationArray.checkIn != nil)
            {
                let day = getdayValue(timestamp:(getReservationArray.checkIn!))
                let date = getdateValue(timestamp:(getReservationArray.checkIn!))
                let endDay = getdayValue(timestamp:(getReservationArray.checkOut!))
                let endDate = getdateValue(timestamp:(getReservationArray.checkOut!))
               
            cell.checkinLabel.text = "\(day), \(date) "
            cell.checkoutLabel.text = "\(endDay), \(endDate)"
            }
            else
            {
                cell.checkinLabel.text = "Flexible"
                cell.checkoutLabel.text = "Flexible"
            }
//            if(getReservationArray.listData?.listingData?.checkInStart != "Flexible")
//            {
//               // let day = getdayValue(timestamp:(getReservationArray.listData?.listingData?.checkInStart!)!)
//                let date = conversionRailwaytime(time:(getReservationArray.listData?.listingData?.checkInStart!)!)
//                cell.checkinTimeLabel.text = "\(date)"
//
//            }
//            else
//            {
//                cell.checkinTimeLabel.text = getReservationArray.listData?.listingData?.checkInStart!
//            }
            if(getReservationArray.checkInStart != "" && getReservationArray.checkInStart != ""){
            if (getReservationArray.checkInStart == "Flexible" && getReservationArray.checkInEnd == "Flexible") {
                       
                                          cell.checkinTimeLabel.text = "\(getReservationArray.checkInStart!) check in time"
                           
                       } else if (getReservationArray.checkInStart != "Flexible" && getReservationArray.checkInEnd == "Flexible") {
                           let date = conversionRailwaytime(time:(getReservationArray.checkInStart!))
                           cell.checkinTimeLabel.text = "From \(date)"
                           
                       } else if (getReservationArray.checkInStart == "Flexible" && getReservationArray.checkInEnd != "Flexible") {
                           let date = conversionRailwaytime(time:(getReservationArray.checkInEnd!))
                                          cell.checkinTimeLabel.text = "Upto \(date)"
                           
                       } else if (getReservationArray.checkInStart != "Flexible" && getReservationArray.checkInEnd != "Flexible") {
                           let date = conversionRailwaytime(time:(getReservationArray.checkInStart!))
                           let date1 = conversionRailwaytime(time:(getReservationArray.checkInEnd!))
                           cell.checkinTimeLabel.text = "\(date) - \(date1)"
                }}else{
                cell.checkinTimeLabel.text = ""
            }
//            if(getReservationArray.listData?.listingData?.checkInEnd != "Flexible")
//            {
//               // let day = getdayValue(timestamp:(getReservationArray.listData?.listingData?.checkInEnd!)!)
//                let date = conversionRailwaytime(time:(getReservationArray.listData?.listingData?.checkInEnd!)!)
//                cell.checkouttimeLabel.text = "\(date)"
//            }
//            else
//            {
//                cell.checkouttimeLabel.text = getReservationArray.listData?.listingData?.checkInEnd!
//            }
            cell.checkouttimeLabel.text = ""
            return cell
        }
        if(indexPath.section == 3)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItenaryaddressCell", for: indexPath)as! ItenaryaddressCell
            cell.selectionStyle = .none
            cell.addressLabel.text = "\((getReservationArray.listData?.street!)!), \((getReservationArray.listData?.city!)!), \((getReservationArray.listData?.state!)!)-\((getReservationArray.listData?.zipcode)!), \((getReservationArray.listData?.country!)!)"
            cell.viewListingBtn.tag = indexPath.row
            cell.viewListingBtn.addTarget(self, action: #selector(viewListingBtnTapped), for: .touchUpInside)
            
            return cell
        }
        if(indexPath.section == 4)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItenaryHostCell", for: indexPath)as! ItenaryHostCell
            cell.hostImage.layer.cornerRadius = cell.hostImage.frame.size.width/2
            if(getReservationArray.hostData?.picture != nil)
            {
            let listimage = (getReservationArray.hostData?.picture!)!
            cell.hostImage.sd_setImage(with: URL(string: "\(IMAGE_AVATAR_MEDIUM)\(String(describing: listimage))"), placeholderImage: #imageLiteral(resourceName: "ItemTransparentImg"))
            }
            cell.hostNameLabel.text = (getReservationArray.hostData?.displayName!)!
            cell.hostImage.layer.masksToBounds = true
            cell.selectionStyle = .none
            cell.messageHostBtn.tag = indexPath.row
            cell.messageHostBtn.addTarget(self, action: #selector(hostBtnTapped), for: .touchUpInside)
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItenaryBillingCell", for: indexPath)as! ItenaryBillingCell
            cell.selectionStyle = .none
            if(Utility.shared.getPreferredCurrency() != nil && Utility.shared.getPreferredCurrency() != "")
            {
                let currencysymbol = Utility.shared.getSymbol(forCurrencyCode: Utility.shared.getPreferredCurrency()!)
                
                let price_value = self.getCurrencyRate(basecurrency:Utility.shared.currencyvalue_from_API_base, fromCurrency:getReservationArray.currency!, toCurrency:Utility.shared.getPreferredCurrency()!, CurrencyRate:Utility.shared.currency_Dict, amount:getReservationArray.totalWithGuestServiceFee!)
                let restricted_price =  Double(String(format: "%.2f",price_value))
                
                cell.priceLabel.text = "\(currencysymbol!)\(restricted_price!.clean)"
                
                
                
            }
            else
            {
                let currencysymbol = Utility.shared.getSymbol(forCurrencyCode:Utility.shared.currencyvalue_from_API_base)
                
                let price_value = self.getCurrencyRate(basecurrency:Utility.shared.currencyvalue_from_API_base, fromCurrency:getReservationArray.currency!, toCurrency:Utility.shared.currencyvalue_from_API_base, CurrencyRate: Utility.shared.currency_Dict, amount:getReservationArray.totalWithGuestServiceFee!)
                let restricted_price =  Double(String(format: "%.2f",price_value))
                cell.priceLabel.text = "\(currencysymbol!)\(restricted_price!.clean)"
            }
            
//            let currencysymbol = Utility.shared.getSymbol(forCurrencyCode:(getReservationArray.currency!))
//            cell.priceLabel.text =  "\(currencysymbol!)\(getReservationArray.totalWithGuestServiceFee!)"
            cell.stayLabel.text = "\(getReservationArray.nights!) \((Utility.shared.getLanguage()?.value(forKey:"night"))!)\(getReservationArray.nights! > 1 ? "" : "")"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 1)
        {
            let guestdetailObj = GuestDetailVC()
            Utility.shared.selectedstartDate_filter = ""
                      Utility.shared.selectedEndDate_filter = ""
            Utility.shared.unpublish_preview_check = false
            guestdetailObj.listID = getReservationArray.listId!
            guestdetailObj.currencyvalue_from_API_base = Utility.shared.currencyvalue_from_API_base
            guestdetailObj.currency_Dict = Utility.shared.currency_Dict
              guestdetailObj.modalPresentationStyle = .fullScreen
            self.present(guestdetailObj, animated: true, completion: nil)
        }
    }
    @objc func viewListingBtnTapped(_ sender: UIButton)
    {
        let guestdetailObj = GuestDetailVC()
        Utility.shared.selectedstartDate_filter = ""
                  Utility.shared.selectedEndDate_filter = ""
        Utility.shared.unpublish_preview_check = false
        guestdetailObj.listID = getReservationArray.listId!
        guestdetailObj.currencyvalue_from_API_base = Utility.shared.currencyvalue_from_API_base
        guestdetailObj.currency_Dict = Utility.shared.currency_Dict
          guestdetailObj.modalPresentationStyle = .fullScreen
        self.present(guestdetailObj, animated: true, completion: nil)
    }
    @objc func ReceiptBtnTapped()
    {
        if #available(iOS 11.0, *) {
            
            let receiptPageObj = ReceiptVC()
             Utility.shared.host_isfrom_hostRecipt = false
            receiptPageObj.getReservationArray = getReservationArray
            receiptPageObj.getReservation_currencyArray = getReservation_currencyArray
            receiptPageObj.getbillingArray = getbillingArray
            receiptPageObj.currencyvalue_from_API_base = currencyvalue_from_API_base
            receiptPageObj.modalPresentationStyle = .overFullScreen
            self.view.window?.rootViewController?.present(receiptPageObj, animated:false, completion: nil)
            //self.present(receiptPageObj, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }
        
        
    }
    @objc func hostBtnTapped(_ sender: UIButton)
    {
            if Utility().isConnectedToNetwork(){
            if(getReservationArray.messageData?.id != nil)
            {
            let InboxListingObj = InboxListingVC()
            Utility.shared.ListID = "\(getReservationArray.listId!)"
            InboxListingObj.threadId = (getReservationArray.messageData?.id!)!
            InboxListingObj.getMessageListAPICall(threadId:(getReservationArray.messageData?.id!)!)
              InboxListingObj.modalPresentationStyle = .fullScreen
            self.present(InboxListingObj, animated: true, completion: nil)
            }
            }
            else{
                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)")
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
    
    func getdateValue(timestamp:String) -> String
    {
        let timestamValue = Int(timestamp)!/1000
        let showDate = Date(timeIntervalSince1970:TimeInterval(timestamValue))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        dateFormatter.locale = NSLocale(localeIdentifier:Utility.shared.getAppLanguageCode()!) as Locale
        let date = dateFormatter.string(from: showDate)
        return date
    }
    
    func getdayValue(timestamp:String) -> String
    {
        let timestamValue = Int(timestamp)!/1000
        let showDate = Date(timeIntervalSince1970:TimeInterval(timestamValue))
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "EEE"
        dateFormatter1.locale = NSLocale(localeIdentifier:Utility.shared.getAppLanguageCode()!) as Locale
        let day = dateFormatter1.string(from: showDate)
        return day
    }
    func conversionRailwaytime(time:String) -> String
    {
        var dateAsString = time
        var strArr = time.split{$0 == ":"}.map(String.init)
        let hour = Int(strArr[0])!
        if(hour > 12 && hour != 24 && hour != 25 && hour != 26){
            dateAsString = "\(Int(dateAsString)!-12)" + " " +  "PM"
        }
        else if(hour == 25)
        {
            dateAsString = "1 AM"
        }
        else if(hour == 26)
        {
            dateAsString = "2 AM"
        }
        else if(hour == 12)
        {
            dateAsString = "12 PM"
        }
        else if(hour == 24)
        {
            dateAsString = "12 AM"
        }
        else{
            let trimmedString = dateAsString.replacingOccurrences(of: "^0+", with: "", options: .regularExpression)
            dateAsString = trimmedString +  " " +  "AM"
        }
        return dateAsString
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

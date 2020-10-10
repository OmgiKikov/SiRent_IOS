//
//  TripsMainVC.swift
//  Rent_All
//
//  Created by RADICAL START on 22/03/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Lottie
import Apollo

class TripsMainVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate{
    
    

    @IBOutlet weak var offlineView: UIView!
    @IBOutlet weak var upcomingTable: UITableView!
    @IBOutlet weak var previousTable: UITableView!
    @IBOutlet weak var exploreBtn: UIButton!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var wheretoLabel: UILabel!
    @IBOutlet weak var WhereView: UIView!
    @IBOutlet weak var previousLabel: UILabel!
    @IBOutlet weak var upcomingLabel: UILabel!
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var upcomingBtn: UIButton!
    @IBOutlet weak var topView: UIView!
    var totalListcount:Int = 0
    var PageIndex : Int = 1
    var previoustotalListcount:Int = 0
    var previousPageIndex : Int = 1
    var isupcomingTable:Bool = true
    var checkinDate = String()
    var checkoutDate = String()
    
    var getReservationArray = GetReservationQuery.Data.GetReservation.Result()
    var apollo_headerClient:ApolloClient!
    var getallreservationquery = [GetAllReservationQuery.Data.GetAllReservation.Result]()
    var getpreviousReservationquery = [GetAllReservationQuery.Data.GetAllReservation.Result]()
     var lottieView: LOTAnimationView!
    var getReservation_currencyArray = GetReservationQuery.Data.GetReservation()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        self.getTripsAPICall()
//        self.previousTripsAPICall()
//
        self.previousTable.isHidden = true
        self.upcomingTable.isHidden = false
         upcomingLabel.isHidden = false
        lottieView = LOTAnimationView.init(name:"animation")

        // Do any additional setup after loading the view.
    }
    @IBAction func exploreBtnTapped(_ sender: Any) {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        Utility.shared.setTab(index: 0)
        appdelegate.setInitialViewController(initialView: CustomTabbar())
    }
    override func viewWillAppear(_ animated: Bool) {
        self.checkApolloStatus()
        self.initialsetup()
        self.lottieAnimation()
//        if(Utility.shared.isfromcancelPAge)
//        {
//            PageIndex = 1
//            totalListcount = 0
//            self.getallreservationquery.removeAll()
//            self.getTripsAPICall()
//            Utility.shared.isfromcancelPAge = false
//        }
        self.getallreservationquery.removeAll()
        self.getpreviousReservationquery.removeAll()
        PageIndex = 1
        previousPageIndex = 1
        self.getTripsAPICall()
        self.previousTripsAPICall()
    }
    func checkApolloStatus()
    {
        if((Utility.shared.getCurrentUserToken()) != nil)
        {
            apollo_headerClient = {
                let configuration = URLSessionConfiguration.default
                // Add additional headers as needed
                configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
                
                let url = URL(string:graphQLEndpoint)!
                
                return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
            }()
        }
        else{
            apollo_headerClient = ApolloClient(url: URL(string:graphQLEndpoint)!)
        }
        
    }
    func lottieAnimation(){
        lottieView = LOTAnimationView.init(name:"animation")
        lottieView.isHidden = false
        self.lottieView.frame = CGRect(x:FULLWIDTH/2-40, y:FULLHEIGHT/2-150, width:100, height:100)
        self.upcomingTable.addSubview(self.lottieView)
        self.lottieView.backgroundColor = UIColor.clear
        self.lottieView.layer.cornerRadius = 6.0
        self.lottieView.clipsToBounds = true
        self.lottieView.play()
        // Timer.scheduledTimer(timeInterval:0.3, target: self, selector: #selector(autoscroll), userInfo: nil, repeats: true)
       
       
    }
    @objc func autoscroll(){
    //   self.lottieView.play()
    }
    
    @IBAction func upcomingTapped(_ sender: Any) {
        self.lottieAnimation()
        isupcomingTable = true
        self.previousTable.isHidden = true
        previousLabel.isHidden = true
        getallreservationquery.removeAll()
        self.getTripsAPICall()
//        if(getallreservationquery.count>0)
//        {
//         self.upcomingTable.isHidden = false
//         self.previousTable.isHidden = true
//        }
//        else{
//            self.upcomingTable.isHidden = true
//            self.previousTable.isHidden = true
//            self.WhereView.isHidden = false
//        }
        upcomingBtn.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
        previousBtn.setTitleColor(UIColor.black, for: .normal)
        upcomingLabel.isHidden = false
        upcomingTable.reloadData()
    }
    
    @IBAction func previousTapped(_ sender: Any) {
        isupcomingTable = false
        previousBtn.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
        upcomingBtn.setTitleColor(UIColor.black, for: .normal)
        previousLabel.isHidden = false
        upcomingLabel.isHidden = true
        if(getpreviousReservationquery.count>0)
        {
        self.upcomingTable.isHidden = true
        self.previousTable.isHidden = false
        }
        else{
            self.upcomingTable.isHidden = true
            self.previousTable.isHidden = true
            self.WhereView.isHidden = false
        }
        previousTable.reloadData()
    }
    func initialsetup()
    {
    exploreBtn.layer.cornerRadius = 6.0
    exploreBtn.layer.masksToBounds = true
    exploreBtn.layer.borderWidth = 1.0
    exploreBtn.layer.borderColor = Theme.PRIMARY_COLOR.cgColor
    previousLabel.isHidden = true
    upcomingLabel.isHidden = false
    previousBtn.setTitleColor(UIColor.black, for: .normal)
    upcomingBtn.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
    previousTable.register(UINib(nibName: "TripsCell", bundle: nil), forCellReuseIdentifier: "TripsCell")
    upcomingTable.register(UINib(nibName: "TripsCell", bundle: nil), forCellReuseIdentifier: "TripsCell")
        previousTable.register(UINib(nibName: "nolistTripsCell", bundle: nil), forCellReuseIdentifier: "nolistTripsCell")
        upcomingTable.register(UINib(nibName: "nolistTripsCell", bundle: nil), forCellReuseIdentifier: "nolistTripsCell")
    self.WhereView.isHidden = true
    self.offlineView.isHidden = true
        
    
        
    }
    func getTripsAPICall()
    {
         if Utility().isConnectedToNetwork(){
        let getallreservationQuery = GetAllReservationQuery(userType: "Guest", currentPage:PageIndex, dateFilter: "upcoming")
        
        apollo_headerClient.fetch(query:getallreservationQuery,cachePolicy:.fetchIgnoringCacheData){(result,error) in
            guard (result?.data?.getAllReservation?.result) != nil else{
                print("Missing Data")
                if(self.getallreservationquery.count == 0)
                {
                    self.upcomingTable.isHidden = true
                    self.WhereView.isHidden = false
                }
                else{
                    self.upcomingTable.isHidden = false
                    self.WhereView.isHidden = true
                }
                return
            }
             self.totalListcount = (result?.data?.getAllReservation?.count)!
            //self.getallreservationquery = (result?.data?.getAllReservation?.result)! as! [GetAllReservationQuery.Data.GetAllReservation.Result]
//            if(result?.data?.searchListing?.currentPage == 1){
//                self.FilterArray.removeAll()
//            }
            self.getallreservationquery.append(contentsOf: ((result?.data?.getAllReservation?.result)!) as! [GetAllReservationQuery.Data.GetAllReservation.Result])
           
            self.upcomingTable.isHidden = false
             self.lottieView.isHidden = true
            self.upcomingTable?.reloadData()
            
    }
        }
         else{
           // self.previousTable.isHidden = true
            self.view.addSubview(offlineView)
            self.upcomingTable.bringSubviewToFront(offlineView)
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
            if IS_IPHONE_X || IS_IPHONE_XR {
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-135, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
            }
            
        }
        
    }

    @IBAction func retryBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
        self.lottieAnimation()
        self.offlineView.isHidden = true
            self.getallreservationquery.removeAll()
            self.getpreviousReservationquery.removeAll()
            if(isupcomingTable)
            {
        self.getTripsAPICall()
            }
            else
            {
        self.previousTripsAPICall()
            }
        }
    }
    
    func previousTripsAPICall()
    {
        if Utility().isConnectedToNetwork(){
            self.offlineView.isHidden = true
            let getallreservationQuery = GetAllReservationQuery(userType: "Guest", currentPage:previousPageIndex, dateFilter: "previous")
            
            apollo_headerClient.fetch(query:getallreservationQuery,cachePolicy:.fetchIgnoringCacheData){(result,error) in
                guard (result?.data?.getAllReservation?.result) != nil else{
                    print("Missing Data")
                    if(self.getpreviousReservationquery.count == 0)
                    {
                        self.previousTable.isHidden = true
                        self.WhereView.isHidden = false
                    }
                    else{
                        self.previousTable.isHidden = false
                        self.WhereView.isHidden = true
                    }
                    return
                }
               
                    self.previoustotalListcount = (result?.data?.getAllReservation?.count)!
                    //self.getallreservationquery = (result?.data?.getAllReservation?.result)! as! [GetAllReservationQuery.Data.GetAllReservation.Result]
                    //            if(result?.data?.searchListing?.currentPage == 1){
                    //                self.FilterArray.removeAll()
                    //            }
                    self.getpreviousReservationquery.append(contentsOf: ((result?.data?.getAllReservation?.result)!) as! [GetAllReservationQuery.Data.GetAllReservation.Result])
                
                    self.previousTable?.reloadData()
                
            }
        }
        else{
            //self.previousTable.isHidden = true
            self.view.addSubview(offlineView)
            self.previousTable.bringSubviewToFront(offlineView)
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
            if IS_IPHONE_X || IS_IPHONE_XR {
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-135, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == upcomingTable)
        {
        if(getallreservationquery.count > 0)
        {
        return getallreservationquery.count
        }
            return 0
        }
        else{
            if(getpreviousReservationquery.count > 0)
            {
                return getpreviousReservationquery.count
            }
            return 0
           
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(tableView == upcomingTable)
        {
            
            if((getallreservationquery.count > 0) && (getallreservationquery[indexPath.row].listData != nil))
            {
        return 210
            }
            return 145
        }
        else{
            if((getpreviousReservationquery.count > 0) && (getpreviousReservationquery[indexPath.row].listData != nil))
            {
                return 210
            }
            return 145
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == upcomingTable)
        {
           
            if((getallreservationquery.count > 0) && (getallreservationquery[indexPath.row].listData != nil))
             {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TripsCell", for: indexPath)as! TripsCell
                cell.selectionStyle = .none
                cell.approvedLabel.text = getallreservationquery[indexPath.row].reservationState!.firstUppercased
                cell.approvedLabel.backgroundColor = Utility.shared.getcolorcode(type: getallreservationquery[indexPath.row].reservationState!.firstUppercased)
                cell.titleBtn.setTitle(getallreservationquery[indexPath.row].listData?.title!, for: .normal)
                cell.titleBtn.tag = indexPath.row
                cell.titleBtn.addTarget(self, action: #selector(listBtnTapped(_:)), for: .touchUpInside)
                //cell.titleLabel.text = getallreservationquery[indexPath.row].listData?.title!
                cell.streetLabel.text = getallreservationquery[indexPath.row].listData?.street!
                cell.addressLAbel.text = "\((getallreservationquery[indexPath.row].listData?.city!)!), \((getallreservationquery[indexPath.row].listData?.state!)!), \((getallreservationquery[indexPath.row].listData?.country!)!) \((getallreservationquery[indexPath.row].listData?.zipcode!)!)"
                let inday = getdayValue(timestamp: getallreservationquery[indexPath.row].checkIn!)
                checkinDate = getdateValue(timestamp: getallreservationquery[indexPath.row].checkIn!)
                let outday = getdayValue(timestamp: getallreservationquery[indexPath.row].checkOut!)
                checkoutDate = getdateValue(timestamp: getallreservationquery[indexPath.row].checkOut!)
                cell.dateLabel.text = "\(inday),\(checkinDate) - \(outday),\(checkoutDate)"
               // let currencysymbol = Utility.shared.getSymbol(forCurrencyCode:getallreservationquery[indexPath.row].currency!)!
               // let total = Double(getallreservationquery[indexPath.row].total!) + Double(getallreservationquery[indexPath.row].guestServiceFee!)
                 //cell.nameLabel.text = "\((getallreservationquery[indexPath.row].hostData?.displayName!)!) - \(currencysymbol)\(total)"
                if(Utility.shared.getPreferredCurrency() != nil)
                {
                    let currencysymbol = Utility.shared.getSymbol(forCurrencyCode: Utility.shared.getPreferredCurrency()!)
                    let from_currency = getallreservationquery[indexPath.row].currency!
                    let total = Double(getallreservationquery[indexPath.row].total!) + Double(getallreservationquery[indexPath.row].guestServiceFee!)
                    let price_value = self.getCurrencyRate(basecurrency:Utility.shared.currencyvalue_from_API_base, fromCurrency:from_currency, toCurrency:Utility.shared.getPreferredCurrency()!, CurrencyRate:Utility.shared.currency_Dict, amount:total)
                    let restricted_price =  Double(String(format: "%.2f",price_value))
                    cell.nameLabel.text = "\((getallreservationquery[indexPath.row].hostData?.displayName!)!) - \(currencysymbol!)\(restricted_price!.clean)"
                    
                }
                else
                {
                    let currencysymbol = Utility.shared.getSymbol(forCurrencyCode:Utility.shared.currencyvalue_from_API_base)
                    let from_currency = getallreservationquery[indexPath.row].currency!
                    let total = Double(getallreservationquery[indexPath.row].total!) + Double(getallreservationquery[indexPath.row].guestServiceFee!)
                    let price_value = self.getCurrencyRate(basecurrency:Utility.shared.currencyvalue_from_API_base, fromCurrency:from_currency, toCurrency:Utility.shared.currencyvalue_from_API_base, CurrencyRate: Utility.shared.currency_Dict, amount:total)
                    let restricted_price =  Double(String(format: "%.2f",price_value))
                    cell.nameLabel.text = "\((getallreservationquery[indexPath.row].hostData?.displayName!)!) - \(currencysymbol!)\(restricted_price!.clean)"
                }
                if((getallreservationquery[indexPath.row].reservationState! == "cancelled") || (getallreservationquery[indexPath.row].reservationState! == "declined") || (getallreservationquery[indexPath.row].reservationState! == "expired"))
                {
                    cell.messageBtn.frame = CGRect(x: cell.messageBtn.frame.origin.x, y: 74, width: cell.messageBtn.frame.size.width, height: cell.messageBtn.frame.size.height)
                    cell.itenaryBtn.isHidden = true
                    cell.cancelBtn.isHidden = true
                }
                else if((getallreservationquery[indexPath.row].reservationState! == "pending") &&  (getallreservationquery[indexPath.row].listData?.bookingType! == "request"))
                {
                    cell.messageBtn.frame = CGRect(x: cell.messageBtn.frame.origin.x, y: 74, width: cell.messageBtn.frame.size.width, height: cell.messageBtn.frame.size.height)
                    cell.cancelBtn.isHidden = true
                    cell.itenaryBtn.isHidden = true
                }
                else if ((getallreservationquery[indexPath.row].reservationState! == "completed"))
                    {
                        cell.messageBtn.frame = CGRect(x: cell.messageBtn.frame.origin.x, y: 74, width: cell.messageBtn.frame.size.width, height: cell.messageBtn.frame.size.height)
                        cell.cancelBtn.isHidden = true
                        cell.itenaryBtn.isHidden = true
                    
                    }
                else
                {
                     cell.messageBtn.frame = CGRect(x: cell.messageBtn.frame.origin.x, y: 35, width: cell.messageBtn.frame.size.width, height: cell.messageBtn.frame.size.height)
                    cell.cancelBtn.isHidden = false
                    cell.itenaryBtn.isHidden = false
                    cell.receiptBtn.isHidden = false
                    cell.messageBtn.isHidden = false
                }
               
                cell.receiptBtn.tag = indexPath.row
                cell.receiptBtn.addTarget(self, action: #selector(ReceiptBtnTapped), for: .touchUpInside)
                cell.itenaryBtn.tag = indexPath.row
                cell.itenaryBtn.addTarget(self, action: #selector(IteneraryBtnTapped), for: .touchUpInside)
                cell.cancelBtn.tag = indexPath.row
                cell.cancelBtn.addTarget(self, action: #selector(cancelBtnTapped), for: .touchUpInside)
                cell.messageBtn.tag = indexPath.row
                cell.messageBtn.addTarget(self, action: #selector(messageBtnTapped), for: .touchUpInside)
              
                return cell
             }
            else
            {
                 let cell = tableView.dequeueReusableCell(withIdentifier: "nolistTripsCell", for: indexPath)as! nolistTripsCell
            if(getallreservationquery.count > 0)
                    {
               
                cell.selectionStyle = .none
                let inday = getdayValue(timestamp: getallreservationquery[indexPath.row].checkIn!)
                let indate = getdateValue(timestamp: getallreservationquery[indexPath.row].checkIn!)
                let outday = getdayValue(timestamp: getallreservationquery[indexPath.row].checkOut!)
                let outdate = getdateValue(timestamp: getallreservationquery[indexPath.row].checkOut!)
                cell.dateLabel.text = "\(inday),\(indate) - \(outday),\(outdate)"
                cell.approvedLabel.text = getallreservationquery[indexPath.row].reservationState!.firstUppercased
                cell.approvedLabel.backgroundColor = Utility.shared.getcolorcode(type: getallreservationquery[indexPath.row].reservationState!.firstUppercased)
                cell.contactSupportBtn.tag = indexPath.row
                cell.contactSupportBtn.addTarget(self, action: #selector(contactsupprtBtnTapped), for: .touchUpInside)
                
                
                }
                return cell
            }
        }
        else
        {
            if((getpreviousReservationquery.count > 0) && (getpreviousReservationquery[indexPath.row].listData != nil))
            {

            let cell = tableView.dequeueReusableCell(withIdentifier: "TripsCell", for: indexPath)as! TripsCell
                cell.selectionStyle = .none
                cell.approvedLabel.text = getpreviousReservationquery[indexPath.row].reservationState!.firstUppercased
                cell.approvedLabel.backgroundColor = Utility.shared.getcolorcode(type: getpreviousReservationquery[indexPath.row].reservationState!.firstUppercased)
                //cell.nameLabel.text = "\((getpreviousReservationquery[indexPath.row].hostData?.displayName!)!)"
                cell.titleBtn.setTitle(getpreviousReservationquery[indexPath.row].listData?.title!, for: .normal)
                cell.titleBtn.tag = indexPath.row
                cell.titleBtn.addTarget(self, action: #selector(listpreviousBtnTapped(_:)), for: .touchUpInside)
                //cell.titleLabel.text = getpreviousReservationquery[indexPath.row].listData?.title!
                cell.streetLabel.text = getpreviousReservationquery[indexPath.row].listData?.street!
                cell.addressLAbel.text = "\((getpreviousReservationquery[indexPath.row].listData?.city!)!),\((getpreviousReservationquery[indexPath.row].listData?.state!)!),\((getpreviousReservationquery[indexPath.row].listData?.country!)!),\((getpreviousReservationquery[indexPath.row].listData?.zipcode!)!)"
                let inday = getdayValue(timestamp: getpreviousReservationquery[indexPath.row].checkIn!)
                let indate = getdateValue(timestamp: getpreviousReservationquery[indexPath.row].checkIn!)
                let outday = getdayValue(timestamp: getpreviousReservationquery[indexPath.row].checkOut!)
                let outdate = getdateValue(timestamp: getpreviousReservationquery[indexPath.row].checkOut!)
                cell.dateLabel.text = "\(inday),\(indate) - \(outday),\(outdate)"
                if(Utility.shared.getPreferredCurrency() != nil)
                {
                    let currencysymbol = Utility.shared.getSymbol(forCurrencyCode: Utility.shared.getPreferredCurrency()!)
                    let from_currency = getpreviousReservationquery[indexPath.row].currency!
                    let total = Double(getpreviousReservationquery[indexPath.row].total!) + Double(getpreviousReservationquery[indexPath.row].guestServiceFee!)
                    let price_value = self.getCurrencyRate(basecurrency:Utility.shared.currencyvalue_from_API_base, fromCurrency:from_currency, toCurrency:Utility.shared.getPreferredCurrency()!, CurrencyRate:Utility.shared.currency_Dict, amount:total)
                    let restricted_price =  Double(String(format: "%.2f",price_value))
                     cell.nameLabel.text = "\((getpreviousReservationquery[indexPath.row].hostData?.displayName!)!) - \(currencysymbol!)\(restricted_price!.clean)"
                   
                }
                else
                {
                    let currencysymbol = Utility.shared.getSymbol(forCurrencyCode:Utility.shared.currencyvalue_from_API_base)
                    let from_currency = getpreviousReservationquery[indexPath.row].currency!
                    let total = Double(getpreviousReservationquery[indexPath.row].total!) + Double(getpreviousReservationquery[indexPath.row].guestServiceFee!)
                    let price_value = self.getCurrencyRate(basecurrency:Utility.shared.currencyvalue_from_API_base, fromCurrency:from_currency, toCurrency:Utility.shared.currencyvalue_from_API_base, CurrencyRate: Utility.shared.currency_Dict, amount:total)
                    let restricted_price =  Double(String(format: "%.2f",price_value))
                    cell.nameLabel.text = "\((getpreviousReservationquery[indexPath.row].hostData?.displayName!)!) - \(currencysymbol!)\(restricted_price!.clean)"
                }
    
                if((getpreviousReservationquery[indexPath.row].reservationState! == "cancelled") || (getpreviousReservationquery[indexPath.row].reservationState! == "declined") || (getpreviousReservationquery[indexPath.row].reservationState! == "expired"))
                {
                    cell.messageBtn.frame = CGRect(x: cell.messageBtn.frame.origin.x, y: 74, width: cell.messageBtn.frame.size.width, height: cell.messageBtn.frame.size.height)
                    cell.itenaryBtn.isHidden = true
                    cell.cancelBtn.isHidden = true
                }
                else if((getpreviousReservationquery[indexPath.row].reservationState! == "pending") &&  (getpreviousReservationquery[indexPath.row].listData?.bookingType! == "request"))
                {
                    cell.messageBtn.frame = CGRect(x: cell.messageBtn.frame.origin.x, y: 74, width: cell.messageBtn.frame.size.width, height: cell.messageBtn.frame.size.height)
                    cell.cancelBtn.isHidden = true
                    cell.itenaryBtn.isHidden = true
                }
                else if ((getpreviousReservationquery[indexPath.row].reservationState! == "completed"))
                {
                    cell.messageBtn.frame = CGRect(x: cell.messageBtn.frame.origin.x, y: 74, width: cell.messageBtn.frame.size.width, height: cell.messageBtn.frame.size.height)
                    cell.cancelBtn.isHidden = true
                    cell.itenaryBtn.isHidden = true
                    
                }
                else
                {
                    cell.messageBtn.frame = CGRect(x: cell.messageBtn.frame.origin.x, y: 35, width: cell.messageBtn.frame.size.width, height: cell.messageBtn.frame.size.height)
                    cell.cancelBtn.isHidden = false
                    cell.itenaryBtn.isHidden = false
                    cell.receiptBtn.isHidden = false
                    cell.messageBtn.isHidden = false
                }
                 cell.receiptBtn.tag = indexPath.row
                cell.receiptBtn.addTarget(self, action: #selector(ReceiptPreviousBtnTapped), for: .touchUpInside)
                cell.itenaryBtn.tag = indexPath.row
                cell.itenaryBtn.addTarget(self, action: #selector(IteneraryPreviousBtnTapped), for: .touchUpInside)
                cell.cancelBtn.tag = indexPath.row
                cell.cancelBtn.addTarget(self, action: #selector(previouscancelBtnTapped), for: .touchUpInside)
                cell.messageBtn.tag = indexPath.row
                cell.messageBtn.addTarget(self, action: #selector(messagePreviousBtnTapped), for: .touchUpInside)
                
                return cell
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "nolistTripsCell", for: indexPath)as! nolistTripsCell

                if(getpreviousReservationquery.count > 0)
                {
                cell.selectionStyle = .none
                let inday = getdayValue(timestamp: getpreviousReservationquery[indexPath.row].checkIn!)
                let indate = getdateValue(timestamp: getpreviousReservationquery[indexPath.row].checkIn!)
                let outday = getdayValue(timestamp: getpreviousReservationquery[indexPath.row].checkOut!)
                let outdate = getdateValue(timestamp: getpreviousReservationquery[indexPath.row].checkOut!)
                cell.dateLabel.text = "\(inday),\(indate) - \(outday),\(outdate)"
                cell.approvedLabel.text = getpreviousReservationquery[indexPath.row].reservationState!.firstUppercased
                cell.approvedLabel.backgroundColor = Utility.shared.getcolorcode(type: getpreviousReservationquery[indexPath.row].reservationState!.firstUppercased)
                cell.contactSupportBtn.tag = indexPath.row
                cell.contactSupportBtn.addTarget(self, action: #selector(previouscontactsupprtBtnTapped), for: .touchUpInside)
                }
                return cell
            }
        }
    }
    @objc func contactsupprtBtnTapped(_ sender: UIButton)
    {
         if Utility().isConnectedToNetwork(){
        let contactSupportObj = ContactusVC()
        contactSupportObj.Listid = getallreservationquery[sender.tag].listId!
        contactSupportObj.reservationid = getallreservationquery[sender.tag].id!
        self.present(contactSupportObj, animated:false, completion: nil)
        }
         else{
            self.view.addSubview(offlineView)
            self.upcomingTable.bringSubviewToFront(offlineView)
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
            if IS_IPHONE_X || IS_IPHONE_XR {
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-135, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
            }
        }
    }
    @objc func previouscontactsupprtBtnTapped(_ sender: UIButton)
    {
        if Utility().isConnectedToNetwork(){
        let contactSupportObj = ContactusVC()
        contactSupportObj.Listid = getpreviousReservationquery[sender.tag].listId!
        contactSupportObj.reservationid = getpreviousReservationquery[sender.tag].id!
        self.present(contactSupportObj, animated: false, completion: nil)
        }
        else{
            self.view.addSubview(offlineView)
            self.previousTable.bringSubviewToFront(offlineView)
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
            if IS_IPHONE_X || IS_IPHONE_XR {
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-135, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
            }
        }
    }
    
    @objc func cancelBtnTapped(_ sender: UIButton)
    {
         if Utility().isConnectedToNetwork(){
            if(getallreservationquery.count > 0)
            {
        print(getallreservationquery[sender.tag].id!)
            
        let cancelObj = TripsCancelVC()
        cancelObj.listID = getallreservationquery[sender.tag].listId!
        var currency = String()
        
        if(Utility.shared.getPreferredCurrency() != nil)
        {
        currency = Utility.shared.getPreferredCurrency()!
        }
        else{
          currency = Utility.shared.currencyvalue_from_API_base
        }
        cancelObj.checkinDate =  getdateValue(timestamp: getallreservationquery[sender.tag].checkIn!)
        cancelObj.checkoutDate = getdateValue(timestamp: getallreservationquery[sender.tag].checkOut!)
        cancelObj.getcancellationAPICall(reservationId: getallreservationquery[sender.tag].id!, userType: "guest", currency: currency)
        
        self.present(cancelObj, animated: true, completion: nil)
            }
        }
         else{
            self.view.addSubview(offlineView)
            self.upcomingTable.bringSubviewToFront(offlineView)
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
            if IS_IPHONE_X || IS_IPHONE_XR {
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-135, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
            }
        }
        
    }
    @objc func previouscancelBtnTapped(_ sender: UIButton)
    {
        if Utility().isConnectedToNetwork(){
        print(getpreviousReservationquery[sender.tag].id!)
        
        let cancelObj = TripsCancelVC()
        cancelObj.listID = getpreviousReservationquery[sender.tag].listId!
        var currency = String()
        
        if(Utility.shared.getPreferredCurrency() != nil)
        {
            currency = Utility.shared.getPreferredCurrency()!
        }
        else{
            currency = Utility.shared.currencyvalue_from_API_base
        }
        cancelObj.checkinDate = checkinDate
        cancelObj.checkoutDate = checkoutDate
        cancelObj.getcancellationAPICall(reservationId:getpreviousReservationquery[sender.tag].id!, userType: "guest", currency: currency)
        
        self.present(cancelObj, animated: true, completion: nil)
        }
        else{
            self.view.addSubview(offlineView)
            self.previousTable.bringSubviewToFront(offlineView)
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
            if IS_IPHONE_X || IS_IPHONE_XR {
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-135, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
            }
        }
    }
    
    @objc func ReceiptPreviousBtnTapped(_ sender: UIButton)
    {
        if(getpreviousReservationquery.count > 0)
        {
         self.createReservationAPICall(reservationid:getpreviousReservationquery[sender.tag].id!)
        }
    }
    
    @objc func ReceiptBtnTapped(_ sender: UIButton)
    {
       if(getallreservationquery.count > 0)
       {
        self.createReservationAPICall(reservationid:getallreservationquery[sender.tag].id!)
        }
    }
    @objc func IteneraryPreviousBtnTapped(_ sender: UIButton)
    {

        if(getpreviousReservationquery.count > 0)
        {

        Utility.shared.isfromTripsPage = true
        print(getpreviousReservationquery[sender.tag].id!)
        
        self.getReservationAPICall(reservationid:getpreviousReservationquery[sender.tag].id!)

        }

    }
    
    @objc func IteneraryBtnTapped(_ sender: UIButton)
    {

        if(getallreservationquery.count > 0)
        {
        Utility.shared.isfromTripsPage = true
        self.getReservationAPICall(reservationid:getallreservationquery[sender.tag].id!)
        }

        Utility.shared.isfromTripsPage = true
        self.getReservationAPICall(reservationid:getallreservationquery[sender.tag].id!)

    }
    @objc func messageBtnTapped(_ sender: UIButton)
    {
         if Utility().isConnectedToNetwork(){

            if(getallreservationquery.count > 0)
            {

        let InboxListingObj = InboxListingVC()
        InboxListingObj.threadId = (getallreservationquery[sender.tag].messageData?.id)!
        InboxListingObj.getmessageListquery.removeAll()
        InboxListingObj.getMessageListAPICall(threadId:(getallreservationquery[sender.tag].messageData?.id)!)
           
        self.present(InboxListingObj, animated: true, completion: nil)

            }
         }

        
         else{
            self.view.addSubview(offlineView)
            self.upcomingTable.bringSubviewToFront(offlineView)
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
            if IS_IPHONE_X || IS_IPHONE_XR {
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-135, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
            }
        }
    }
    @objc func messagePreviousBtnTapped(_ sender: UIButton)
    {
         if Utility().isConnectedToNetwork(){

            if(getpreviousReservationquery.count > 0)
            {
        let InboxListingObj = InboxListingVC()
        InboxListingObj.threadId = (getpreviousReservationquery[sender.tag].messageData?.id)!
        InboxListingObj.getMessageListAPICall(threadId:(getpreviousReservationquery[sender.tag].messageData?.id)!)
        self.present(InboxListingObj, animated: true, completion: nil)

            }

         }
        else{
            self.view.addSubview(offlineView)
            self.previousTable.bringSubviewToFront(offlineView)
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
            if IS_IPHONE_X || IS_IPHONE_XR {
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-135, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
            }
        }
        
    }
    
    func getdateValue(timestamp:String) -> String
    {
        let timestamValue = Int(timestamp)!/1000
        let showDate = Date(timeIntervalSince1970:TimeInterval(timestamValue))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let date = dateFormatter.string(from: showDate)
        return date
    }
    
    func getdayValue(timestamp:String) -> String
    {
        let timestamValue = Int(timestamp)!/1000
        let showDate = Date(timeIntervalSince1970:TimeInterval(timestamValue))
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "EEE"
        let day = dateFormatter1.string(from: showDate)
        return day
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        if Utility().isConnectedToNetwork(){
        if(isupcomingTable)
        {
        let totalPages = (self.totalListcount/10)
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if((self.upcomingTable.contentOffset.y + self.upcomingTable.bounds.height) >= self.upcomingTable.contentSize.height)
        {
            //   if distanceFromBottom < height {
            if(totalPages >= PageIndex){
                self.PageIndex = self.PageIndex + 1
                print("currentpage2 \(self.PageIndex)")
                self.getTripsAPICall()
                
            }
        }
        }
        else
        {
            let totalPages = (self.previoustotalListcount/10)
            let height = scrollView.frame.size.height
            let contentYoffset = scrollView.contentOffset.y
            let distanceFromBottom = scrollView.contentSize.height - contentYoffset
            if((self.previousTable.contentOffset.y + self.previousTable.bounds.height) >= self.previousTable.contentSize.height)
            {
                //   if distanceFromBottom < height {
                if(totalPages >= previousPageIndex){
                    self.previousPageIndex = self.previousPageIndex + 1
                    print("currentpage2 \(self.previousPageIndex)")
                    self.previousTripsAPICall()
                    
                }
            }
        }
        }
        else{
            self.upcomingTable.isHidden = true
            self.view.addSubview(offlineView)
            self.previousTable.bringSubviewToFront(offlineView)
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
            if IS_IPHONE_X || IS_IPHONE_XR {
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-135, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
            }
        }
        
    }
    
    func createReservationAPICall(reservationid:Int)
    {
        if Utility().isConnectedToNetwork(){
            var currency = String()
            if(Utility.shared.getPreferredCurrency() != nil)
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
            if #available(iOS 11.0, *) {
                let receiptPageObj = ReceiptVC()
                receiptPageObj.getReservation_currencyArray = self.getReservation_currencyArray
                receiptPageObj.getReservationArray = self.getReservationArray
                //receiptPageObj.currencyvalue_from_API_base = currencyvalue_from_API_base
                self.present(receiptPageObj, animated: true, completion: nil)
            } else {
                // Fallback on earlier versions
            }
        }
        }
        else{
            self.view.addSubview(offlineView)
            self.upcomingTable.bringSubviewToFront(offlineView)
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
            if IS_IPHONE_X || IS_IPHONE_XR {
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-135, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
            }
        }
        
    }
    func getReservationAPICall(reservationid:Int)
    {
         if Utility().isConnectedToNetwork(){
        let createReservationquery = GetReservationQuery(reservationId: reservationid)
        apollo_headerClient.fetch(query: createReservationquery){(result,error) in
            guard (result?.data?.getReservation?.results) != nil else{
                print("Missing Data")
                return
            }
            self.getReservationArray = (result?.data?.getReservation?.results)!
            if #available(iOS 11.0, *) {
                let receiptPageObj = BookingItenaryVC()
                receiptPageObj.getReservation_currencyArray = self.getReservation_currencyArray
                receiptPageObj.getReservationArray = self.getReservationArray
                //receiptPageObj.currencyvalue_from_API_base = currencyvalue_from_API_base
                self.present(receiptPageObj, animated: true, completion: nil)
            } else {
                // Fallback on earlier versions
            }
        }
        }
         else{
            self.view.addSubview(offlineView)
            self.upcomingTable.bringSubviewToFront(offlineView)
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
            if IS_IPHONE_X || IS_IPHONE_XR {
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-135, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
            }
        }
    }
     @objc func listBtnTapped(_ sender: UIButton){
        if(getallreservationquery.count > 0)
        {

        let guestdetailObj = GuestDetailVC()
        guestdetailObj.listID = getallreservationquery[sender.tag].listId!
        guestdetailObj.currencyvalue_from_API_base = Utility.shared.currencyvalue_from_API_base
        guestdetailObj.currency_Dict = Utility.shared.currency_Dict
        self.present(guestdetailObj, animated: true, completion: nil)

        }
    }
    @objc func listpreviousBtnTapped(_ sender: UIButton){
        if(getpreviousReservationquery.count > 0)
        {
        let guestdetailObj = GuestDetailVC()
        guestdetailObj.listID = getpreviousReservationquery[sender.tag].listId!
        guestdetailObj.currencyvalue_from_API_base = Utility.shared.currencyvalue_from_API_base
        guestdetailObj.currency_Dict = Utility.shared.currency_Dict
        self.present(guestdetailObj, animated: true, completion: nil)

        }

    }
    
    //  fun getRate(base: String, to: String, from: String, rateStr: String, amount: Double) : Double {
    func getCurrencyRate(basecurrency:String,fromCurrency:String,toCurrency:String,CurrencyRate:NSDictionary,amount:Double) -> Double
    {
        if(!(CurrencyRate.count == 0))
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
        return 0
        
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

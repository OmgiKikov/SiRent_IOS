//
//  HostCalendarVC.swift
//  Rent_All
//
//  Created by RadicalStart on 24/07/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Apollo
import Lottie

class HostCalendarVC: UIViewController,WWCalendarTimeSelectorProtocol,CalendarListingVCProtocol,AvailabilityHostVCDelegate,CalendarDetailVCDelegate{

 
    
    //MARK: - IBOUTLET & GLOBAL VARIABLE DECLARATIONS
    
    @IBOutlet weak var calendarLabel: UILabel!
    @IBOutlet weak var nocalendardesLabel: UILabel!
    @IBOutlet weak var retryBtn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var calendardetailsBtn: UIButton!
    @IBOutlet weak var nextimage: UIImageView!
    @IBOutlet weak var nextgreenImg: UIImageView!
    @IBOutlet weak var calendarDetailView: UIView!
    @IBOutlet weak var offlineView: UIView!
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var downarrowImg: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var entireLabel: UILabel!
    
    @IBOutlet weak var calendarView: UIView!
    @IBOutlet weak var listtitleLabel: UILabel!
    @IBOutlet weak var listImage: UIImageView!
    @IBOutlet weak var calendarStatusView: UIView!
    @IBOutlet weak var entirehomeview: UIView!
    
    @IBOutlet weak var nextArrowImage: UIImageView!
    @IBOutlet weak var specialPriceView: UIImageView!
    @IBOutlet weak var availableView: UIImageView!
    @IBOutlet weak var notavailableView: UIImageView!
    @IBOutlet weak var bookedView: UIImageView!
    fileprivate var singleDate: Date = Date()
    fileprivate var multipleDates: [Date] = []
    @IBOutlet weak var nextBtn: UIButton!
    var listId = Int()
    var new_titleArray = [String:String]()
    
    var image_list = String()
    var title_list = String()
    var entireTitle_Value = String()
   
    
    
    var manageListingArray = [ManageListingsQuery.Data.ManageListing.Result]()
    var inprogress_List_Array = [ManageListingsQuery.Data.ManageListing.Result]()
    var completed_List_Array = [ManageListingsQuery.Data.ManageListing.Result]()
    var getListingSpecialPrice_Array = [GetListingSpecialPriceQuery.Data.GetListingSpecialPrice.Result]()
    var apollo_headerClient: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
        
        let url = URL(string:graphQLEndpoint)!
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()
    open weak var delegate: WWCalendarTimeSelectorProtocol?
    
    open var optionCurrentDateRange: WWCalendarTimeSelectorDateRange = WWCalendarTimeSelectorDateRange()
    
    var lottieView: LOTAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lottieAnimation()
       // self.initialSetup()
       // self.manageListingAPICall()
        self.tabBarController?.tabBar.isHidden = false
        

    }
    override func viewWillAppear(_ animated: Bool) {
        if(!Utility.shared.isfrom_availability_calendar)
        {
            
            
            self.initialSetup()
            self.manageListingAPICall()
            Utility.shared.host_selected_Array.removeAllObjects()
            self.tabBarController?.tabBar.isHidden = false
        }
        else
        {
            Utility.shared.isfrom_availability_calendar = false
            Utility.shared.isfrom_availability_calendar_date = true
        }
//
//            self.lottieAnimation()
//            self.initialSetup()
//
//            if(self.new_titleArray.count > 0)
//            {
//                self.BlockedlistAPICall(listId: listId)
//                self.listtitleLabel.text = self.new_titleArray["title"]
//                self.entireLabel.text = self.new_titleArray["entireTitle"]
//                if(self.new_titleArray["listImage"] != nil)
//                {
//                     self.APICall(listImage:self.new_titleArray["listImage"]!, title: self.new_titleArray["title"]!, entireTitle: self.new_titleArray["entireTitle"]!, listId: listId)
//
//                }
//
//            }
       // }

        
    }
    override func viewDidAppear(_ animated: Bool) {

    }
    
    func initialSetup()
    {
        specialPriceView.layer.borderWidth = 1.0
        specialPriceView.layer.borderColor = TextBorderColor.cgColor
        availableView.layer.borderWidth = 1.0
        availableView.layer.borderColor  = TextBorderColor.cgColor
        notavailableView.layer.borderWidth = 1.0
        notavailableView.layer.borderColor = TextBorderColor.cgColor
        bookedView.layer.borderWidth = 1.0
        bookedView.layer.borderColor = TextBorderColor.cgColor
        nextBtn.layer.cornerRadius = 6.0
        nextBtn.layer.masksToBounds = true
        listImage.layer.cornerRadius = 6.0
        listImage.layer.masksToBounds = true
        self.noDataView.isHidden = true
        self.topView.isHidden = true
        self.nextBtn.isHidden = false
        self.offlineView.isHidden = true
        self.nextArrowImage.image = self.nextArrowImage.image?.withRenderingMode(.alwaysTemplate)
        self.nextArrowImage.tintColor = UIColor.white
        self.nextgreenImg.image = self.nextgreenImg.image?.withRenderingMode(.alwaysTemplate)
        self.nextgreenImg.tintColor = UIColor.darkGray
        self.nextimage.image = self.nextimage.image?.withRenderingMode(.alwaysTemplate)
        self.nextimage.tintColor = UIColor.darkGray
        
        
        
        
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
        
        

        self.view.addSubview(self.lottieView)
        self.view.sendSubviewToBack(self.lottieView)
       calendardetailsBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"calendardetails"))!)", for: .normal)
        errorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
        retryBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
        nextBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"edit"))!)", for:.normal)
        calendarLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"calendar"))!)"
        
        nocalendardesLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"calendar_description"))!)"
        


    }
    @objc func calendarViewCall()
    {
        let selector =  UIStoryboard.init(name: "WWCalendarTimeSelector", bundle:nil).instantiateViewController(withIdentifier:"Calendar") as? WWCalendarTimeSelector
        selector?.delegate = self
        
        

        
        selector?.optionCurrentDate = singleDate
        //selector?.optionCurrentDates = Set(multipleDates)
        multipleDates = (selector?.optionCurrentDateRange.array)!
        selector?.optionCurrentDateRange.setStartDate(multipleDates.first ?? singleDate)
        selector?.optionCurrentDateRange.setEndDate(multipleDates.last ?? singleDate)
        selector?.optionSelectionType = WWCalendarTimeSelectorSelection.range
        selector?.optionShowTopContainer = false
        Utility.shared.isTodayEnable = false

      //  self.addChild(selector!)
        calendarView.addSubview(selector!.view)
        
         selector!.view.frame = CGRect(x:-30, y:self.calendarView.frame.origin.y-200, width: self.calendarView.frame.size.width+60, height: self.calendarView.frame.size.height)
        
       
        selector?.view.addSubview(nextBtn)
        selector?.view.addSubview(nextArrowImage)
        selector?.view.bringSubviewToFront(nextBtn)
        selector?.view.bringSubviewToFront(nextArrowImage)
        
        selector?.view.addSubview(lottieView)
        selector?.view.sendSubviewToBack(lottieView)
        nextBtn.backgroundColor = Theme.PRIMARY_COLOR
        
        self.lottieView.isHidden = true


        if IS_IPHONE_XR || IS_IPHONE_X 
        {
            
            self.nextBtn.frame = CGRect(x:self.calendarView.frame.size.width-120, y:self.calendarView.frame.size.height-128, width: 130, height: 45)
            self.nextArrowImage.frame = CGRect(x:self.calendarView.frame.size.width-15, y:self.calendarView.frame.size.height-114, width: 15, height: 15)
        }else {
            self.nextBtn.frame = CGRect(x:self.calendarView.frame.size.width-120, y:self.calendarView.frame.size.height-97, width: 130, height: 45)
            self.nextArrowImage.frame = CGRect(x:self.calendarView.frame.size.width-15, y:self.calendarView.frame.size.height-82, width: 15, height: 15)
        }
        
        
        
    }
    func lottieAnimation(){
        lottieView = LOTAnimationView.init(name:"animation")
        lottieView.isHidden = false
        self.lottieView.frame = CGRect(x:FULLWIDTH/2-40, y:FULLHEIGHT/2-50, width:100, height:100)
        //self.lottieView.frame = CGRect(x:FULLWIDTH/2-60, y:FULLHEIGHT/2-150, width:100, height:100)
        self.view.addSubview(self.lottieView)
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
    
    @IBAction func retryBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            self.nextBtn.isHidden = false
            self.calendardetailsBtn.isHidden = false
            self.topView.isHidden = false
        self.offlineView.isHidden = true
            if(!(self.manageListingArray.count > 0))
            {
                self.lottieAnimation()
               self.manageListingAPICall()
            }
        // self.manageListingAPICall()
        }
    }
    @IBAction func calendarDetailBtnTapped(_ sender: Any) {
        let calendarDetailObj = CalendarDetailVC()
        calendarDetailObj.delegate = self
        calendarDetailObj.listId = self.listId
        if(new_titleArray["listImage"] != nil)
        {
            calendarDetailObj.listImage = "\(new_titleArray["listImage"]!)"
            calendarDetailObj.title_val = "\(new_titleArray["title"]!)"
            calendarDetailObj.entireTitle = "\(new_titleArray["entireTitle"]!)"
        }
        else{
            calendarDetailObj.listImage = self.completed_List_Array[0].listPhotoName!
            calendarDetailObj.title_val = self.completed_List_Array[0].title!
            calendarDetailObj.entireTitle = (self.completed_List_Array[0].settingsData![0]?.listsettings?.itemName!)!
        }
        calendarDetailObj.delegate = self
         calendarDetailObj.modalPresentationStyle = .fullScreen
        self.present(calendarDetailObj, animated: true, completion: nil)
    }
    func manageListingAPICall()
    {
        //self.tabBarController?.tabBar.isHidden = true
       
         if Utility().isConnectedToNetwork(){
        let manageListingquery = ManageListingsQuery()
        apollo_headerClient.fetch(query: manageListingquery,cachePolicy:.fetchIgnoringCacheData){(result,error) in
            guard (result?.data?.manageListings?.results) != nil else{
                print("Missing Data")
                self.noDataView.isHidden = false
                self.lottieView.isHidden = true
                return
            }
        
            self.manageListingArray = ((result?.data?.manageListings?.results)!) as! [ManageListingsQuery.Data.ManageListing.Result]
            self.completed_List_Array.removeAll()
            self.inprogress_List_Array.removeAll()
            for i in self.manageListingArray
            {
                if(i.isReady == false)
                {
                    self.inprogress_List_Array.append(i)
                }
                else{
                    self.completed_List_Array.append(i)
                }
            }
            
            
           
            if(self.completed_List_Array.count > 0)
            {
               self.noDataView.isHidden = true
                self.topView.isHidden = false
                self.calendarView.isHidden = false
               
               
            
                
                
                self.listId = self.completed_List_Array[0].id!
               // if(self.new_titleArray.count > 0)
//                {
//                    self.listtitleLabel.text = self.new_titleArray["title"]
//                    self.entireLabel.text = self.new_titleArray["entireTitle"]
//                    if(self.new_titleArray["listImage"] != nil)
//                    {
//                        self.listImage.sd_setImage(with: URL(string: "\(IMAGE_LISTING_MEDIUM)\(self.new_titleArray["listImage"]!)"), placeholderImage: #imageLiteral(resourceName: "home-1"))
//                    Utility.shared.isfrom_availability_calendar_date = true
//                    }
//                    else
//                    {
//                        self.listImage.image = #imageLiteral(resourceName: "camera-50")
//                    }
//
//                }
//                else
//                {
                self.listtitleLabel.text = self.completed_List_Array[0].title!
                if(self.completed_List_Array[0].settingsData![0]?.listsettings?.itemName != nil)
                {
                self.entireLabel.text = self.completed_List_Array[0].settingsData![0]?.listsettings?.itemName!
                }
                else
                {
                  self.entireLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"entireplace"))!)"
                }
                    if(self.completed_List_Array[0].listPhotoName != nil)
                    {
                        let listimage = self.completed_List_Array[0].listPhotoName!
                        self.listImage.sd_setImage(with: URL(string: "\(IMAGE_LISTING_MEDIUM)\(listimage)"), placeholderImage: #imageLiteral(resourceName: "ItemTransparentImg"))
                    }
                    else
                    {
                        self.listImage.image = #imageLiteral(resourceName: "camera-50")
                    }
               // }
                self.listId = self.completed_List_Array[0].id!
               self.BlockedlistAPICall(listId: self.completed_List_Array[0].id!)
            }
            else{
                self.noDataView.isHidden = false
                self.lottieView.isHidden = true
                self.topView.isHidden = true
                self.calendarView.isHidden = true
            }
            
        }
        }
         else{
            self.lottieView.isHidden = true
            self.nextBtn.isHidden = true
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
            if IS_IPHONE_XR || IS_IPHONE_X {
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-130, width: self.offlineView.frame.size.width, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: self.offlineView.frame.size.width, height: 55)
        }
    }
    }
    func APICall(listImage:String,title:String,entireTitle:String,listId:Int)
    {
        if(listImage != nil)
        {
            
            self.listImage.sd_setImage(with: URL(string: "\(IMAGE_LISTING_MEDIUM)\(listImage)"), placeholderImage: #imageLiteral(resourceName: "ItemTransparentImg"))
        }
        else
        {
            self.listImage.image = #imageLiteral(resourceName: "camera-50")
        }
        if(title != nil)
        {
            self.listtitleLabel.text = title
        }
        if(entireTitle != nil)
        {
            self.entireLabel.text = entireTitle
        }
         self.lottieView.isHidden = true
        
        new_titleArray.updateValue(listImage, forKey: "listImage")
        new_titleArray.updateValue(title, forKey: "title")
        new_titleArray.updateValue(entireTitle, forKey: "entireTitle")
         self.listId = listId
        let selector =  UIStoryboard.init(name: "WWCalendarTimeSelector", bundle:nil).instantiateViewController(withIdentifier:"Calendar") as? WWCalendarTimeSelector
        selector?.delegate = self
        self.WWCalendarTimeSelectorCancel(selector!, dates: Utility.shared.calendar_Date_Array)
       
    }
    
    func WWCalendarTimeSelectorCancel(_ selector: WWCalendarTimeSelector, dates: [Date])
    {
    Utility.shared.calendar_Date_Array.removeAll()
     
    }
    
  
    
    func WWCalendarTimeSelectorDidDismiss(_ selector: WWCalendarTimeSelector)
    {
       
    }
    
    func BlockedlistAPICall(listId:Int)
    {
         self.lottieAnimation()
        if Utility().isConnectedToNetwork(){
            let getListingSpecialPricequery = GetListingSpecialPriceQuery(listId: listId)
            apollo_headerClient.fetch(query: getListingSpecialPricequery,cachePolicy:.fetchIgnoringCacheData){(result,error) in
                guard (result?.data?.getListingSpecialPrice?.results) != nil else{
                    print("Missing Data")
                    self.noDataView.isHidden = false
                    self.lottieView.isHidden = true
                    return
                }
                self.getListingSpecialPrice_Array = (result?.data?.getListingSpecialPrice?.results)! as! [GetListingSpecialPriceQuery.Data.GetListingSpecialPrice.Result]
                Utility.shared.host_blockedDates_Array.removeAllObjects()
                Utility.shared.host_bookedPricing_Array.removeAllObjects()
                Utility.shared.host_specialPricing_Array.removeAllObjects()
                Utility.shared.host_specialPrice_value_Array.removeAllObjects()
                Utility.shared.host_specialDay_Array.removeAllObjects()
                Utility.shared.host_currency_Array.removeAllObjects()
                Utility.shared.hosr_blockDay_Array.removeAllObjects()
                for i in self.getListingSpecialPrice_Array
                {
                    let timestamp = i.blockedDates
                    let timestamValue = Int(timestamp!)!/1000
                    let newTime = Date(timeIntervalSince1970: TimeInterval(timestamValue))
                    //let newdate = Calendar.current.date(byAdding: .day, value: 1, to: newTime)
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd MMM YYYY" //Specify your format that you want
                    dateFormatter.locale = NSLocale(localeIdentifier:Utility.shared.getAppLanguageCode()!) as Locale
                    let dateFormatter1 = DateFormatter()
                    dateFormatter1.dateFormat = "EEE"
                    dateFormatter1.locale = NSLocale(localeIdentifier:Utility.shared.getAppLanguageCode()!) as Locale
                    let date1 = "\(dateFormatter1.string(from: newTime))".uppercased()
                    
                    let date = "\(dateFormatter.string(from: newTime))"
                  
                    
                   
                    if(i.calendarStatus == "blocked")
                    {
                        if(i.reservationId != nil)
                        {
                        Utility.shared.host_bookedPricing_Array.add("\(date)")
                       Utility.shared.host_bookDay_Array.add("\(date1)")
                        }
                        else{
    
                        Utility.shared.host_blockedDates_Array.add("\(date)")
                        Utility.shared.hosr_blockDay_Array.add("\(date1)")
                        }
                    }
                    else if(i.calendarStatus == "available" && i.isSpecialPrice != nil)
                    {
                        var Dict = [String:Any]()
                        Dict.updateValue("\(date)", forKey: "Date")
                        Dict.updateValue(i.isSpecialPrice!, forKey: "SpecialPrice")
                        Dict.updateValue(i.listCurrency, forKey: "Currency")
                        Utility.shared.host_specialPrice_Array.append(Dict)
                        if(i.listCurrency != nil)
                        {
                        Utility.shared.host_currency_Array.add(i.listCurrency!)
                        }
                        else{
                          Utility.shared.host_currency_Array.add(Utility.shared.currencyvalue_from_API_base)
                        }
                    Utility.shared.host_specialPricing_Array.add("\(date)")
                    Utility.shared.host_specialDay_Array.add("\(date1)")
                    Utility.shared.host_specialPrice_value_Array.add(i.isSpecialPrice!)
                    }
                    
                }
               
                self.calendarViewCall()
                
                    
                }
            }
        
        else
        {
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
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-130, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
            }
        }
        
    }
    @IBAction func nextBtnTapped(_ sender: Any) {
         if Utility().isConnectedToNetwork(){
        if(Utility.shared.calendar_Date_Array.count > 0)
        {
        
       let selector =  UIStoryboard.init(name: "WWCalendarTimeSelector", bundle:nil).instantiateViewController(withIdentifier:"Calendar") as? WWCalendarTimeSelector
        
        
        self.WWCalendarTimeSelectorDone(selector!,dates:Utility.shared.calendar_Date_Array)
        }
        else{
            
            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"selectdates"))!)")
        }
        }
        else
         {
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
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-130, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
            }
            
        }
    }
    
    @IBAction func downArrowBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
        
        let headerView = CalendarListingVC()
            headerView.deleagte = self
            headerView.modalPresentationStyle = .fullScreen
            self.present(headerView, animated: true, completion: nil)
//         headerView.deleagte = self
//        self.addChild(headerView)
//        self.view.addSubview(headerView.view)
//        headerView.didMove(toParent: self)
//
//        headerView.view.frame = self.view.frame
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
            if IS_IPHONE_X || IS_IPHONE_XR {
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-130, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
            }
            if(IS_IPHONE_XR || IS_IPHONE_X || IS_IPHONE_PLUS)
            {
            self.nextBtn.backgroundColor = Theme.PRIMARY_COLOR
            self.nextBtn.frame = CGRect(x:FULLWIDTH-150, y:FULLHEIGHT-185, width: 100, height: 100)
            }
        }
    }
    
    
    func WWCalendarTimeSelectorShouldSelectDate(_ selector: WWCalendarTimeSelector, date: Date) -> Bool {
        
        //let curDate = Date().addingTimeInterval(-24*60*60)
        let curDate = Date().beginningOfDay
        let newdate = Calendar.current.date(byAdding: .day, value: 1, to: curDate)
        let fmt = DateFormatter()
        fmt.dateFormat = "dd MMM YYYY"
        
        //if (date < curDate) || (date == newdate!){
            if (date < curDate){
            return false
        }
        else if (fmt.string(from: date) == fmt.string(from: curDate)){
            Utility.shared.isTodayEnable = true
            return true
        }
        else if(Utility.shared.host_bookedPricing_Array.contains(fmt.string(from: date)))
        {
            return false
        }
        else if(Utility.shared.host_bookedPricing_Array.contains(fmt.string(from: date)))
        {
            return false
        }
        
        else {
            return true
        }
    }
    
    
    
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, dates: [Date]) {
        Utility.shared.host_selected_dates_Array.removeAllObjects()
        let array_dates = NSMutableArray()
        var booked_Selected:Bool = false
        for i in dates
        {
            
            let current_date = ("\(i.stringFromFormat("yyyy-MM-dd"))")
            //let date =
            Utility.shared.host_selected_dates_Array.add(current_date)
            let date_Value = ("\(i.stringFromFormat("dd MMM yyyy"))")
            array_dates.add(date_Value)
            if(Utility.shared.host_bookedPricing_Array.contains(date_Value))
            {
               booked_Selected = true
            }
        }
        
          
        if(!booked_Selected)
        {
        if let date = dates.first {
            singleDate = date
            nextBtn.isHidden = false
            nextBtn.backgroundColor = Theme.PRIMARY_COLOR
            
            let availabilityHostObj = AvailabilityHostVC()
            availabilityHostObj.delegate = self
            let startdate = dates.first
            let endDate = dates.last
            
            availabilityHostObj.startDate = "\(startdate!.stringFromFormat("MMM dd"))"
            availabilityHostObj.endDate = "\(endDate!.stringFromFormat("MMM dd"))"
            availabilityHostObj.listId = self.listId
            if(new_titleArray["listImage"] != nil)
            {
            availabilityHostObj.listImage = "\(new_titleArray["listImage"]!)"
            availabilityHostObj.title_val = "\(new_titleArray["title"]!)"
            availabilityHostObj.entireTitle = "\(new_titleArray["entireTitle"]!)"
            }
            else{
                availabilityHostObj.listImage = self.completed_List_Array[0].listPhotoName!
                availabilityHostObj.title_val = self.completed_List_Array[0].title!
                availabilityHostObj.entireTitle = (self.completed_List_Array[0].settingsData![0]?.listsettings?.itemName!)!
            }
            availabilityHostObj.delegate = self
            availabilityHostObj.modalPresentationStyle = .fullScreen
            self.present(availabilityHostObj, animated: true, completion: nil)
        }
        else {
            
          //  dateLabel.text = "No Date Selected"
        }
        multipleDates = dates
    }
    else
    {
        
    self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"thosedates"))!)")
    }
    }

}

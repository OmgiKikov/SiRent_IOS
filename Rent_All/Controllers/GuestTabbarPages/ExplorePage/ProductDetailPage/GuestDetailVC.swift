//
//  GuestDetailVC.swift
//  Rent_All
//
//  Created by RadicalStart on 04/04/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Cosmos
import GoogleMaps
import GooglePlaces
import GooglePlacePicker
import SKPhotoBrowser
import Apollo
import Lottie
import SDWebImage
import ISPageControl

protocol GuestDetailVCDelegate: class {
    func removeWhishlistAPICall()
}

class GuestDetailVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SKPhotoBrowserDelegate,AirbnbDatePickerDelegate,RequestbookVCDelegate,ContacthostVCDelegate,WhishlistPageVCProtocol{
    
    func didupdateWhishlistStatus(status: Bool) {
        self.viewDetailAPICall(listid:listID)
    }
    
    
    
    func passbillingArray(getbillingarray: GetBillingCalculationQuery.Data.GetBillingCalculation.Result) {
        
    }
    
    func passCurrencyvaluefromAPI(currency: String) {
        
    }
    
   

    
    
    //MARK:********************************** IBOUTLET CONNECTIONS ****************************************************>
    
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var infoclose: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var itemNavigationView: UIImageView!
    @IBOutlet weak var PriceLabel: UILabel!
    @IBOutlet weak var chkAvailabiltyBtn: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var detailTable: UITableView!
    @IBOutlet weak var profileImg: UIButton!
    @IBOutlet weak var hostedLabel: UILabel!
    @IBOutlet weak var customcountryLabel: UILabel!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var entireLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var moreBtnImage: UIImageView!
    
    @IBOutlet weak var retry_label: UILabel!
    @IBOutlet weak var Error_View: UIView!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var retry_button: UIButton!
    
    @IBOutlet weak var offlineView: UIView!
    //MARK:******************************************* GLOBAL VARIABLE DECLARATIONS **********************************************>
    
    var sectionTitleArray = NSArray()
    var amenitiesArray = NSMutableArray()
    var userSpaceArray = NSMutableArray()
    var usersafetyArray = NSMutableArray()
    var homeImageArray = NSMutableArray()
    var homeTitleArray = NSMutableArray()
    var homePriceArray = NSMutableArray()
    var pageNumber : Int = 0
    var checkArray = NSMutableArray()
    var checkleftSideArray = NSMutableArray()
     var explorecollectionView: UICollectionView?
    var sampleImages = NSMutableArray()
    var filteredImageArray = NSMutableArray()
    var images = [SKPhotoProtocol]()
     var lottieView: LOTAnimationView!
    var listID: Int!
    var reviewDate = String()
    
    var headerview = UIView()
    var BackImg = UIImageView()
    var heartImg = UIImageView()
    var shareImg = UIImageView()
    public var selectedStartDate: Date?
    public var selectedEndDate: Date?
    var currencyvalue_from_API_base = String()
    var currency_Dict = NSDictionary()
    var alphaval = Float()
    var pageindexForImageScrolled = Int()
    
    var apollo_headerClient: ApolloClient!
    
    var viewListingArray = ViewListingDetailsQuery.Data.ViewListing.Result()
    var similarlistingArray = [GetSimilarListingQuery.Data.GetSimilarListing.Result]()
    var reiewListingArray = [UserReviewsQuery.Data.UserReview.Result]()
    var getreviewArray = [GetReviewsListQuery.Data.GetReview.Result]()
    var getbillingArray = GetBillingCalculationQuery.Data.GetBillingCalculation.Result()
    var delegate:GuestDetailVCDelegate?
    var Pagecontrol:ISPageControl!
    var isamenityTapped:Bool = false
    var isuserspaceTapped:Bool = false
    var isusersafetyamenityTapped:Bool = false
    var lastContentOffset: CGFloat = 0
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.checkApolloStatus()
        detailTable.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.initialSetup()
        self.lottieAnimation()
        self.registerCells()
        self.viewDetailAPICall(listid:listID)
        self.view.addSubview(navigationView)
        self.Error_View.isHidden = true
       
        if(((Utility.shared.getCurrentUserToken()) != nil) && Utility.shared.selectedstartDate_filter != nil && Utility.shared.selectedEndDate_filter != nil && Utility.shared.selectedstartDate_filter != "" && Utility.shared.selectedEndDate_filter != "")
        {
       self.billingListAPICall(startDate: Utility.shared.selectedstartDate_filter, endDate: Utility.shared.selectedEndDate_filter)
        }
//
        
        
        // Do any additional setup after loading the view.
    }
    //MARK:***************************************** OTHER FUNCTIONS *******************************************************************************>
    override func viewWillAppear(_ animated: Bool) {

    }
    @IBAction func infocloseBtnTapped(_ sender: Any) {
        self.infoView.isHidden = true
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
            moreBtnImage.isHidden = false
            moreBtn.isHidden = false
            
        }
        else{
            apollo_headerClient = ApolloClient(url: URL(string:graphQLEndpoint)!)
            moreBtnImage.isHidden = true
            moreBtn.isHidden = true
            
        }
    }
    
    func APIMethodCall() {
        
    }
    @IBAction func moreBtnTapped(_ sender: Any) {
        
          if Utility().isConnectedToNetwork(){
            
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // create an action
        let firstAction: UIAlertAction = UIAlertAction(title: "\((Utility.shared.getLanguage()?.value(forKey:"reportlisting"))!)", style: .default) { action -> Void in
           
            self.dismiss(animated:true, completion:{
                 self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"reportalert"))!)")
            })
          
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title:"\((Utility.shared.getLanguage()?.value(forKey:"cancel"))!)", style: .cancel) { action -> Void in }
        
        // add actions
        actionSheetController.addAction(firstAction)
        actionSheetController.addAction(cancelAction)
        
        // present an actionSheet...
        present(actionSheetController,animated: true, completion: nil)
            
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
    
    @IBAction func checkAvailabilityTapped(_ sender: Any) {
        let btnsendtag: UIButton = sender as! UIButton
        if(viewListingArray.userId != nil)
        {
        if(Utility.shared.getCurrentUserID() != nil && ("\(Utility.shared.getCurrentUserID()!)" == "\(viewListingArray.userId!)"))
        {
            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"ownbookalert"))!)")
        }
        else if(viewListingArray.listingData?.maxDaysNotice == "unavailable")
        {
            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"listunavailablebook"))!)")
        }
        else{
        
        if(btnsendtag.currentTitle == "\((Utility.shared.getLanguage()?.value(forKey:"checkavailability"))!)")
        {
        Utility.shared.blocked_date_month.removeAllObjects()
        for i in viewListingArray.blockedDates!
        {
        let timestamp = i?.blockedDates
        let timestamValue = Int(timestamp!)!/1000
        let newTime = Date(timeIntervalSince1970: TimeInterval(timestamValue))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-LL-yyyy" //Specify your format that you want
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
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
            }
            else{
                if Utility().isConnectedToNetwork(){
                    if((Utility.shared.getCurrentUserToken()) == nil || (Utility.shared.getCurrentUserToken()) == "")
                    {
                        let welcomeObj = SignInViewController()
                        welcomeObj.modalPresentationStyle = .fullScreen
                        self.present(welcomeObj, animated:false, completion: nil)
                        
                    }
                    else
                    {
                if(getbillingArray.checkIn != nil)
                {
                let bookobj = RequestbookVC()
                Utility.shared.booking_message = ""
                bookobj.viewListingArray = viewListingArray
                bookobj.currency_Dict = currency_Dict
                bookobj.selectedStartDate = selectedStartDate
                bookobj.selectedEndDate = selectedEndDate
                bookobj.currencyvalue_from_API_base = currencyvalue_from_API_base
                if(bookobj.getbillingArray.checkIn == nil)
                {
                bookobj.getbillingArray = getbillingArray
                }
                bookobj.delegate = self
                bookobj.modalPresentationStyle = .fullScreen
                self.present(bookobj, animated: true, completion: nil)
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
                    
                    
                    
                }
               
               
            }
        }
     
        }
        
    }
    
    
func initialSetup()
{
   
    
    retry_label.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
    chkAvailabiltyBtn.backgroundColor = Theme.TERTIARY_COLOR
    
    retry_button.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
     self.infoView.isHidden = true
    self.infoclose.setImage(#imageLiteral(resourceName: "close-black").withRenderingMode(.alwaysTemplate), for: .normal)
    self.infoclose.tintColor = UIColor.lightGray
    self.offlineView.isHidden = true
    if IS_IPHONE_XR || IS_IPHONE_XS_MAX || IS_IPHONE_PLUS {
        navigationView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH-35, height: 80)
        itemNavigationView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH-35, height: 80)
        detailTable.frame = CGRect(x: 0, y:0, width: FULLWIDTH-35, height:FULLHEIGHT-80)
    }
    else if IS_IPHONE_5{
        navigationView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH+55, height: 80)
        itemNavigationView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH+55, height:80)
        detailTable.frame = CGRect(x: 0, y:0, width: FULLWIDTH+55, height:FULLHEIGHT-80)
    }
    else
    {
        navigationView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height: 80)
        itemNavigationView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height: 80)
        detailTable.frame = CGRect(x: 0, y:0, width: FULLWIDTH, height:FULLHEIGHT-80)
    }
    
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
    profileImg.layer.cornerRadius = profileImg.frame.size.width/2
    profileImg.clipsToBounds = true
    chkAvailabiltyBtn.layer.cornerRadius = 5.0
    checkArray = ["\((Utility.shared.getLanguage()?.value(forKey:"checkintime"))!)","\((Utility.shared.getLanguage()?.value(forKey:"checkouttime"))!)","\((Utility.shared.getLanguage()?.value(forKey:"cancellationPolicy"))!)","\((Utility.shared.getLanguage()?.value(forKey:"availability"))!)","\((Utility.shared.getLanguage()?.value(forKey:"contacthost"))!)"]
    
    checkleftSideArray = ["\((Utility.shared.getLanguage()?.value(forKey:"checkintime"))!)","\((Utility.shared.getLanguage()?.value(forKey:"checkouttime"))!)","\((Utility.shared.getLanguage()?.value(forKey:"houserules"))!)","\((Utility.shared.getLanguage()?.value(forKey:"cancellationPolicy"))!)","\((Utility.shared.getLanguage()?.value(forKey:"availability"))!)","\((Utility.shared.getLanguage()?.value(forKey:"contacthost"))!)"]
    chkAvailabiltyBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"checkavailability"))!)", for: .normal)
 
    }
    
   
    func lottieAnimation(){
        lottieView = LOTAnimationView.init(name:"animation")
        lottieView.isHidden = false
        self.lottieView.frame = CGRect(x:FULLWIDTH/2-40, y:FULLHEIGHT/2-150, width:100, height:100)
        self.detailTable.addSubview(self.lottieView)
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
    
    func registerCells(){
        detailTable.register(UINib(nibName: "DescriptionCell", bundle: nil), forCellReuseIdentifier: "DescriptionCell")
        detailTable.register(UINib(nibName: "AmenityDetailCell", bundle: nil), forCellReuseIdentifier: "AmenityDetailCell")
        detailTable.register(UINib(nibName: "MapCell", bundle: nil), forCellReuseIdentifier: "MapCell")
        detailTable.register(UINib(nibName: "CheckingCell", bundle: nil), forCellReuseIdentifier: "CheckingCell")
        detailTable.register(UINib(nibName: "HeaderDetailCell", bundle: nil), forCellReuseIdentifier: "HeaderDetailCell")
        detailTable.register(UINib(nibName: "ReviewCell", bundle: nil), forCellReuseIdentifier: "ReviewCell")
        
    }
    
    func viewDetailAPICall(listid:Int)
    {
       if Utility().isConnectedToNetwork(){
        var viewListQuery = ViewListingDetailsQuery(listId:listid)
        
        if(Utility.shared.unpublish_preview_check)
        {
            viewListQuery = ViewListingDetailsQuery(listId: listid, preview: true)
            
        }
        else
        {
           viewListQuery = ViewListingDetailsQuery(listId:listid)
        }
         apollo_headerClient.fetch(query: viewListQuery,cachePolicy:.fetchIgnoringCacheData){(result,error) in
            
            guard (result?.data?.viewListing?.status) == 200 else{
                    print("Missing Data")
//                    if(self.viewListingArray == nil)
//                    {
                    self.navigationView.backgroundColor = .white
                
                    self.BackImg.frame = CGRect(x:10, y: 12, width:18, height:18)
                    self.BackImg.image = #imageLiteral(resourceName: "back_white")
                    self.BackImg.backgroundColor = UIColor.clear
                    self.backBtn.backgroundColor = UIColor.clear
                    //BackBtn.addTarget(self, action: #selector(BackBtnTapped(_:)), for: .touchUpInside)
                    self.backBtn.addSubview(self.BackImg)
                    self.navigationView.addSubview(self.backBtn)
                    self.moreBtnImage.isHidden = true
                    self.BackImg.image = self.BackImg.image?.withRenderingMode(.alwaysTemplate)
                    self.BackImg.tintColor = UIColor.black
                    self.likeBtn.isHidden = true
                    self.shareBtn.isHidden = true
                    self.moreBtn.isHidden = true
                    self.Error_View.isHidden = false
                    self.lottieView.isHidden = true
                    self.bottomView.isHidden = true
//                    }
                    return
                }
            
            if result?.data?.viewListing?.status == 200 {
                    self.viewListingArray = (result?.data?.viewListing?.results)!
                    if(self.viewListingArray.listingData != nil)
                    {
                        if(Utility.shared.getPreferredCurrency() != nil &&  Utility.shared.getPreferredCurrency() != "")
                        {
                            let currencysymbol = Utility.shared.getSymbol(forCurrencyCode: Utility.shared.getPreferredCurrency()!)
                            let from_currency = (self.viewListingArray.listingData?.currency!)
                            let currency_amount = (self.viewListingArray.listingData?.basePrice?.clean)
                            let price_value = self.getCurrencyRate(basecurrency:self.currencyvalue_from_API_base, fromCurrency:from_currency!, toCurrency:Utility.shared.getPreferredCurrency()!, CurrencyRate:Utility.shared.currency_Dict, amount:Double(currency_amount!) as! Double)
                            let restricted_price =  Double(String(format: "%.2f",price_value))
                            self.PriceLabel.text =  "\(currencysymbol!)\(restricted_price!.clean) \((Utility.shared.getLanguage()?.value(forKey:"pernight"))!)"
                        }
                        else
                        {
                            let currencysymbol = Utility.shared.getSymbol(forCurrencyCode:self.currencyvalue_from_API_base)
                            let from_currency = (self.viewListingArray.listingData?.currency!)
                            let currency_amount = (self.viewListingArray.listingData?.basePrice?.clean)
                            let price_value = self.getCurrencyRate(basecurrency:self.currencyvalue_from_API_base, fromCurrency:from_currency!, toCurrency:self.currencyvalue_from_API_base, CurrencyRate:Utility.shared.currency_Dict, amount:Double(currency_amount!) as! Double)
                            let restricted_price =  Double(String(format: "%.2f",price_value))
                            self.PriceLabel.text =  "\(currencysymbol!)\(restricted_price!.clean) \((Utility.shared.getLanguage()?.value(forKey:"pernight"))!)"
                        }
                        if let val = (self.viewListingArray.listingData?.cancellation?.policyName!)
                        {
                            Utility.shared.cancelpolicy = val
                        }
                        if let value = (self.viewListingArray.listingData?.cancellation?.policyContent!)
                        {
                            Utility.shared.cancelpolicy_content = value
                        }
                        
                    }else{
                        self.navigationView.backgroundColor = .white
                         self.BackImg.frame = CGRect(x:10, y: 12, width:18, height:18)
                         self.BackImg.image = #imageLiteral(resourceName: "back_white")
                         self.BackImg.backgroundColor = UIColor.clear
                         self.backBtn.backgroundColor = UIColor.clear
                         //BackBtn.addTarget(self, action: #selector(BackBtnTapped(_:)), for: .touchUpInside)
                         self.backBtn.addSubview(self.BackImg)
                         self.navigationView.addSubview(self.backBtn)
                         self.moreBtnImage.isHidden = true
                         self.BackImg.image = self.BackImg.image?.withRenderingMode(.alwaysTemplate)
                         self.BackImg.tintColor = UIColor.black
                         self.likeBtn.isHidden = true
                         self.shareBtn.isHidden = true
                         self.moreBtn.isHidden = true
                         self.Error_View.isHidden = false
                         self.lottieView.isHidden = true
                         self.bottomView.isHidden = true
                        
                }
                    
                    let value1 = (self.viewListingArray.reviewsCount)
                    let value2 = (self.viewListingArray.reviewsStarRating)
                    if(value2 != nil){
                        let reviewcount = (value2!/value1!)
                        self.ratingView.rating = Double(reviewcount)
                    }
                    else{
                        self.ratingView.rating = 0
                    }
                    
                    self.reviewcountAPICall(profileid: ((self.viewListingArray.user?.profile?.profileId!)!))
                self.getreviewAPICall(listId: listid, hostId: "\(self.viewListingArray.userId!)")
                    self.similarListingAPICall(lat:self.viewListingArray.lat!, lng: self.viewListingArray.lng!, lisId: self.viewListingArray.id!)
                    self.lottieView.isHidden = true
                    if((Utility.shared.getCurrentUserID() != nil) && ("\(self.viewListingArray.userId!)" == "\(String(describing: Utility.shared.getCurrentUserID()!))"))
                    {
                        self.moreBtn.isHidden = true
                        self.moreBtnImage.isHidden = true
                        self.shareBtn.frame = self.moreBtn.frame
                    }
                    else
                    {
                        self.moreBtn.isHidden = false
                        self.moreBtnImage.isHidden = false
                    }
                    
                    if(Utility.shared.getCurrentUserID() != nil && ("\(Utility.shared.getCurrentUserID()!)" == "\(self.viewListingArray.userId!)"))
                    {
                        self.likeBtn.isHidden = true
                        self.heartImg.isHidden = true
                    }
                    else
                    {
                        self.likeBtn.isHidden = false
                        self.heartImg.isHidden = false
                        
                    }
            }else{
                
                self.navigationView.backgroundColor = .white
                 self.BackImg.frame = CGRect(x:10, y: 12, width:18, height:18)
                 self.BackImg.image = #imageLiteral(resourceName: "back_white")
                 self.BackImg.backgroundColor = UIColor.clear
                 self.backBtn.backgroundColor = UIColor.clear
                 //BackBtn.addTarget(self, action: #selector(BackBtnTapped(_:)), for: .touchUpInside)
                 self.backBtn.addSubview(self.BackImg)
                 self.navigationView.addSubview(self.backBtn)
                 self.moreBtnImage.isHidden = true
                 self.BackImg.image = self.BackImg.image?.withRenderingMode(.alwaysTemplate)
                 self.BackImg.tintColor = UIColor.black
                 self.likeBtn.isHidden = true
                 self.shareBtn.isHidden = true
                 self.moreBtn.isHidden = true
                 self.Error_View.isHidden = false
                 self.lottieView.isHidden = true
                 self.bottomView.isHidden = true
                
            }

                
            }

        
    
        }
        else
       {
        self.lottieView.isHidden = true
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
    
    func similarListingAPICall(lat:Double,lng:Double,lisId:Int)
    {
     let similarlistingquery = GetSimilarListingQuery(lat: lat, lng: lng, listId: lisId)
        apollo_headerClient.fetch(query: similarlistingquery,cachePolicy:.fetchIgnoringCacheData){(result,error) in
            guard (result?.data?.getSimilarListing?.results) != nil else{
                print("Missing Data")
                return
            }
            self.similarlistingArray = ((result?.data?.getSimilarListing?.results)!) as! [GetSimilarListingQuery.Data.GetSimilarListing.Result]
             self.detailTable.reloadData()
        }
    }
    
    func billingListAPICall(startDate:String,endDate:String)
    {
        var currency = String()
        if(Utility.shared.getPreferredCurrency() == nil &&  Utility.shared.getPreferredCurrency() == "")
        {
           currency = self.currencyvalue_from_API_base
        }
        else{
            
           currency = Utility.shared.getPreferredCurrency()!
        }
        
        let billingListquery = GetBillingCalculationQuery(listId:listID, startDate: startDate, endDate: endDate, guests: 1, convertCurrency:currency)
        apollo_headerClient.fetch(query: billingListquery){(result,error) in
            guard (result?.data?.getBillingCalculation?.result) != nil else{
                print("Missing Data")
                if(result?.data?.getBillingCalculation?.errorMessage != nil)
                {
                self.infoView.isHidden = false
                self.infoView.frame.origin.y = self.bottomView.frame.origin.y-60
                let attributedString: NSMutableAttributedString = NSMutableAttributedString(string:"\((Utility.shared.getLanguage()?.value(forKey: "info"))!) \((result?.data?.getBillingCalculation?.errorMessage!)!)")
                attributedString.setColor(color: UIColor.black, forText:"\((result?.data?.getBillingCalculation?.errorMessage!)!)")   // or use direct value for text "red"
                attributedString.setColor(color:Theme.TERTIARY_COLOR, forText:"\((Utility.shared.getLanguage()?.value(forKey: "info"))!)")   // or use direct value f
                       self.infoLabel.attributedText = attributedString
                }
                //self.infoLabel.text = "info \((result?.data?.getBillingCalculation?.errorMessage!)!)"
                return
            }
  
            self.getbillingArray = (result?.data?.getBillingCalculation?.result)!
            
            
    }
        
    }
     
    @IBAction func shareBtnTapped(_ sender: Any) {
         if Utility().isConnectedToNetwork(){
        if((Utility.shared.getCurrentUserToken()) == nil || (Utility.shared.getCurrentUserToken()) == "")
        {
            let welcomeObj = SignInViewController()
             welcomeObj.modalPresentationStyle = .fullScreen
            self.present(welcomeObj, animated:false, completion: nil)
            //  appDelegate.setInitialViewController(initialView: welcomeObj)
        }
        else
        {
        let pageObj = ShareProductVC()
        pageObj.viewListingArray = viewListingArray
         pageObj.modalPresentationStyle = .fullScreen
        self.present(pageObj, animated: true, completion: nil)
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
    
    @IBAction func backBtnTapped(_ sender: Any) {
        Utility.shared.isfromdetailpage = false
        Utility.shared.booking_message = ""
        delegate?.removeWhishlistAPICall()

        
       // self.navigationController?.popViewController(animated: true)
//        let explorePageVC = ExplorePageVC()
//        explorePageVC.modalPresentationStyle = .fullScreen
//        self.present(explorePageVC, animated: false, completion: nil)
        self.dismiss(animated:true, completion: nil)
        
    }
    @IBAction func likeBtnTapped(_ sender: Any) {
        
        if Utility().isConnectedToNetwork(){
        if((Utility.shared.getCurrentUserToken()) == nil || (Utility.shared.getCurrentUserToken()) == "")
        {
            let welcomeObj = SignInViewController()
            welcomeObj.modalPresentationStyle = .fullScreen
            self.present(welcomeObj, animated:false, completion: nil)
            //  appDelegate.setInitialViewController(initialView: welcomeObj)
        }
        else
        {
            let headerView = WhishlistPageVC()
            headerView.listID = viewListingArray.id!
            headerView.listimage = viewListingArray.listPhotoName!
            headerView.delegate = self
            self.addChild(headerView)
            self.view.addSubview(headerView.view)
            headerView.didMove(toParent: self)
            self.tabBarController?.tabBar.isHidden = true
            headerView.view.frame = self.view.frame
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
    
    //MARK:*************************************************** TABLEVIEW DELEGATE & DATASOURCE METHODS ************************************************>
    func numberOfSections(in tableView: UITableView) -> Int {
        if(viewListingArray.listingPhotos != nil)
        {
        return 10
        }
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?
      {
        
          if(section == 4){
              if(viewListingArray.userAmenities!.count > 4)
              {
              if(!isamenityTapped){
                                  return  "\((Utility.shared.getLanguage()?.value(forKey:"showallamenities"))!)"
                                  }
                return "\((Utility.shared.getLanguage()?.value(forKey:"closeallamenities"))!)"
                
                
              }
              else
              {
                  return ""
              }
          }
          else if(section == 5){
               if(viewListingArray.userSpaces!.count > 4)
               {
                     if(!isuserspaceTapped){
                     return  "Show all shared spaces"
                     }
                    return "Close all shared spaces"
              }
              else
              
               {
                  return  ""
              }
                 }
          else if(section == 6){
              if(viewListingArray.userSafetyAmenities!.count > 4)
              {
              if(viewListingArray.userSafetyAmenities!.count > 0)
              {
                     if(!isusersafetyamenityTapped){
                     return  "Show all Safety Amenities"
                     }
                    return "Close all Safety Amenities"
              }
              else
              {
                  return ""
              }
              }
              else
              {
                  return ""
              }
                 }
          
          
       
          return ""
      }
    
    @objc func addBtnTapped(_ sender: UIButton){
              let btnsendtag: UIButton = sender
           
             if(btnsendtag.tag == 4){
             if(btnsendtag.currentTitle == "\((Utility.shared.getLanguage()?.value(forKey:"closeallamenities"))!)"){
                 isamenityTapped = false
             }
             else {
                 isamenityTapped = true

             }
               detailTable.reloadData()
             }
             else if(btnsendtag.tag == 5){
                 if(btnsendtag.currentTitle == "Close all shared spaces"){
                     isuserspaceTapped = false
                 }
                 else {
                     isuserspaceTapped = true

                 }
               detailTable.reloadData()
             }
             else if(btnsendtag.tag == 6)
             {
                 if(btnsendtag.currentTitle == "Close all Safety Amenities"){
                     isusersafetyamenityTapped = false
                 }
                 else {
                     isusersafetyamenityTapped = true

                 }
               detailTable.reloadData()
             }
             
            // detailTable.reloadData()
            
             
         }
      func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
      {
          let footerView = UIView()
          footerView.backgroundColor = UIColor.white
        
        if((section == 4 && (viewListingArray.userAmenities!.count > 4)) || (section == 5 && (viewListingArray.userSpaces!.count > 4)) || (section == 6 && (viewListingArray.userSafetyAmenities!.count > 4))) {
          let showmore = UIButton()
          showmore.frame = CGRect(x:15, y:0, width:tableView.bounds.size.width-40, height:45)
          showmore.backgroundColor = UIColor.white
          showmore.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
          showmore.titleLabel?.font =  UIFont(name: "Circular-Medium", size:17)
          showmore.contentHorizontalAlignment = .left
          showmore.setTitle(self.tableView(tableView, titleForFooterInSection: section), for: .normal)
          showmore.tag = section
          showmore.addTarget(self, action: #selector(addBtnTapped(_:)), for: .touchUpInside)
          footerView.addSubview(showmore)
              
              return footerView
           }else{
              footerView.backgroundColor = UIColor.white
              return footerView}
      }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if((section==4) || (section==5) || (section==6)) {
            
              if((section == 4) && (viewListingArray.userAmenities!.count > 4)) {
                return 50
                
              }
            else if((section == 5) && (viewListingArray.userSpaces!.count > 4)) {
                return 50
                
              }
             
            else if((section == 6) && (viewListingArray.userSafetyAmenities!.count > 4)) {
                return 50
                
              }
              else{
                
               return .leastNormalMagnitude
            }
        }
        else{
            return .leastNormalMagnitude
        }
    }
      
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 0){
            return 1
        }
        else if(section == 1){
            return 1
        }
        else if(section == 2){
            return 1
        }
        else if(section == 3){
            if viewListingArray.listingData != nil{
                if(viewListingArray.listingData!.minNight! > 0 && viewListingArray.listingData!.maxNight! > 0)
                {
                    return 2
                }else if viewListingArray.listingData!.minNight! == 0 && viewListingArray.listingData!.maxNight! > 0{
                    
                    
                    return 1
                    
                }
                    return 0
            }
            return 0

        }
       else if(section == 4){
            if(viewListingArray.userAmenities!.count > 0)
                     {
                     if(isamenityTapped)
                     {
                    return viewListingArray.userAmenities!.count
                     }
                     else
                     {
                         
                         if(viewListingArray.userAmenities!.count > 4)
                         {
                         return 4
                         }
                         else
                         {
                             return viewListingArray.userAmenities!.count
                         }
                     }
                     }else
                     {
                         return 0
                     }
           
        }
        else if(section == 5){
            if(viewListingArray.userSpaces!.count > 0)
             {
             if(isuserspaceTapped)
             {
            return viewListingArray.userSpaces!.count
             }
             else
             {
                 
                 if(viewListingArray.userSpaces!.count > 4)
                 {
                 return 4
                 }
                 else
                 {
                     return viewListingArray.userSpaces!.count
                 }
             }
             }else
             {
                 return 0
             }
           
        }
        else if(section == 6){
            
            if(viewListingArray.userSafetyAmenities!.count > 0)
                        {
                        if(isusersafetyamenityTapped)
                        {
                       return viewListingArray.userSafetyAmenities!.count
                        }
                        else
                        {
                            
                            if(viewListingArray.userSafetyAmenities!.count > 4)
                            {
                            return 4
                            }
                            else
                            {
                                return viewListingArray.userSafetyAmenities!.count
                            }
                        }
                        }else
                        {
                            return 0
                        }
                      
          
        }
        else if(section == 7){
            return 1
        }
        else if(section == 8){
            if(viewListingArray.reviewsCount == 0)
            {
                if(viewListingArray.houseRules?.count == 0)
                {
                    if((Utility.shared.getCurrentUserID() != nil) && ("\(viewListingArray.userId!)" == "\(String(describing: Utility.shared.getCurrentUserID()!))"))
                    {
                        return 4
                    }
                    return 5
                }
                else {
                    if((Utility.shared.getCurrentUserID() != nil) && ("\(viewListingArray.userId!)" == "\(String(describing: Utility.shared.getCurrentUserID()!))"))
                    {
                        return 5
                    }
                    return 6
                }
            
            }
            else {
                if(viewListingArray.houseRules?.count == 0)
                {
                    if((Utility.shared.getCurrentUserID() != nil) && ("\(viewListingArray.userId!)" == "\(String(describing: Utility.shared.getCurrentUserID()!))"))
                    {
                        return 5
                    }
                    return 6
                }
                else{
                    if((Utility.shared.getCurrentUserID() != nil) && ("\(viewListingArray.userId!)" == "\(String(describing: Utility.shared.getCurrentUserID()!))"))
                    {
                        return 6
                    }
                    return 7
                }
            }
           
        }
        else if(section == 9){
            return 1
        }
        else {
            return 0
        }
    }
    
    func tableView( _ tableView : UITableView,  titleForHeaderInSection section: Int)->String?
    {
        if(section == 3){
            if(viewListingArray.listingData!.minNight! >= 0 && viewListingArray.listingData!.maxNight! > 0)
                           {
            return "\((Utility.shared.getLanguage()?.value(forKey:"minmaxnights"))!)"
            }
            else{
                return ""
            }
        }
        if(section == 4){
            if(viewListingArray.userAmenities!.count > 0){
                return "\((Utility.shared.getLanguage()?.value(forKey:"amenities"))!)"}
            else{
                return ""
            }
        }
        else if(section == 5 ){
              if(viewListingArray.userSpaces!.count > 0){
            return "\((Utility.shared.getLanguage()?.value(forKey:"userspace"))!)"
              }else{
                return ""
            }
        }
        else if(section == 6){
            if(viewListingArray.userSafetyAmenities!.count > 0){
            return "\((Utility.shared.getLanguage()?.value(forKey:"usersafety"))!)"
            }else{
                return ""
            }
        }
       
        return ""
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         if((section == 3 && (viewListingArray.listingData!.minNight! >= 0 && viewListingArray.listingData!.maxNight! > 0)) || (section == 4 && (viewListingArray.userAmenities!.count > 0)) || (section == 5 && (viewListingArray.userSpaces!.count > 0)) || (section == 6 && (viewListingArray.userSafetyAmenities!.count > 0))){
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        
        let lineLabel = UILabel(frame: CGRect(x:15, y: 0, width:
            tableView.bounds.size.width-30, height: 1.0))
        lineLabel.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        headerView.addSubview(lineLabel)
        
        let headerLabel = UILabel(frame: CGRect(x:15, y:10, width:
            tableView.bounds.size.width, height: 40))
        headerLabel.font = UIFont(name: "Circular-Medium", size:19)
        headerLabel.textColor = UIColor.black
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
        }
         else{
            let headerView = UIView()
            
            return headerView
            
        }
    }
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        return self.headerView
//    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if((section == 0)||(section == 1) || (section == 2) || (section == 7) || (section == 8) || (section == 9)) {
            return .leastNormalMagnitude
        }
        else if(section == 3)
        {

            if(viewListingArray.listingData!.minNight! >= 0 && viewListingArray.listingData!.maxNight! > 0)
            {
                return 40
            }
            return .leastNormalMagnitude

            if viewListingArray.listingData != nil{
                if(viewListingArray.listingData!.minNight! >= 0 && viewListingArray.listingData!.maxNight! > 0)
                {
                     return 40
                }
                return .leastNormalMagnitude
            }

        }
        else if(section == 4)
        {
            if(viewListingArray.userAmenities!.count == 0)
            {
                return .leastNormalMagnitude
            }
        return 40
        }
        else if(section == 5)
        {
            if(viewListingArray.userSpaces!.count == 0)
            {
                return .leastNormalMagnitude
            }
            return 40
        }
        else if(section == 6)
        {
            if(viewListingArray.userSafetyAmenities!.count == 0)
            {
                return .leastNormalMagnitude
            }
            return 40
        }
        
        
        return 40
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if((indexPath.section == 3) || (indexPath.section == 4) || (indexPath.section == 5) || (indexPath.section == 6))
        {
            return 50
        }
        else if(indexPath.section == 0){
            return 280
        }
        else if(indexPath.section == 1 ){
            if(viewListingArray.title!.count<=19)
            {
                return 160
            }
            return 215
        }
        else if(indexPath.section == 2){
            if(viewListingArray.description?.count ?? 0 <= 30){
                return 175
            }
            
            return 230
        }
        else if(indexPath.section == 7){
            return 350
        }
        else if(indexPath.section == 8)
        {
            if(viewListingArray.reviewsCount == 0)
            {
                if(viewListingArray.houseRules?.count == 0)
                {
                    if(indexPath.row == 4)
                    {
                        if((Utility.shared.getCurrentUserID() != nil) && ("\(viewListingArray.userId!)" == "\(String(describing: Utility.shared.getCurrentUserID()!))"))
                        {
                            return .leastNormalMagnitude
                        }
                        
                        return 70
                    }
                    else
                    {
                        return 70
                    }
                }
                else
                {
                    if(indexPath.row == 5)
                    {
                        if((Utility.shared.getCurrentUserID() != nil) && ("\(viewListingArray.userId!)" == "\(String(describing: Utility.shared.getCurrentUserID()!))"))
                        {
                            return .leastNormalMagnitude
                        }
                        return 70
                    }
                    else
                    {
                        return 70
                    }
                    
                }
               
            }
            else {
                if(indexPath.row == 2)
                {
                    return UITableView.automaticDimension
                }
                if(viewListingArray.houseRules?.count == 0)
                {
                    if(indexPath.row == 5)
                    {
                        if((Utility.shared.getCurrentUserID() != nil) && ("\(viewListingArray.userId!)" == "\(String(describing: Utility.shared.getCurrentUserID()!))"))
                        {
                            return .leastNormalMagnitude
                        }
                        return 70
                    }
                    else
                    {
                        return 70
                    }
                }
                else
                {
                    if(indexPath.row == 6)
                    {
                        if((Utility.shared.getCurrentUserID() != nil) && ("\(viewListingArray.userId!)" == "\(String(describing: Utility.shared.getCurrentUserID()!))"))
                        {
                            return .leastNormalMagnitude
                        }
                        return 70
                    }
                    else
                    {
                        return 70
                    }
                    
                }
               
            }
        }
        
        else if(indexPath.section == 9){
            if(similarlistingArray.count > 0)
            {
            return 320
            }
            return 0
        }
        return 80
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       if scrollView == detailTable {
         if (self.lastContentOffset < scrollView.contentOffset.y) {
                   alphaval = Float((200-scrollView.contentOffset.y)/100)
//            if alphaval >= 0.0
//            {
//                navigationView.alpha = CGFloat(1 - alphaval)
//            }
            navigationView.backgroundColor = UIColor.white
            self.BackImg.image = self.BackImg.image?.withRenderingMode(.alwaysTemplate)
            self.BackImg.tintColor = UIColor.black
            if(viewListingArray.wishListStatus == true)
            {
                self.heartImg.image = #imageLiteral(resourceName: "like").withRenderingMode(.alwaysOriginal)
            }
            else
            {
            self.heartImg.image = #imageLiteral(resourceName: "Heart").withRenderingMode(.alwaysTemplate)
            self.heartImg.tintColor = UIColor.black
            }
            self.moreBtnImage.image = self.moreBtnImage.image?.withRenderingMode(.alwaysTemplate)
            self.moreBtnImage.tintColor = UIColor.black
            self.shareImg.image = self.shareImg.image?.withRenderingMode(.alwaysTemplate)
            self.shareImg.tintColor = UIColor.black
        } else {
            navigationView.backgroundColor = UIColor.clear
            
//            if(self.Error_View.isHidden == false)
//            {
//
//           self.BackImg.image = #imageLiteral(resourceName: "back_white")
//            }
//            else{
//                self.BackImg.image = self.BackImg.image?.withRenderingMode(.alwaysTemplate)
//                self.BackImg.tintColor = UIColor.black
//            }
          //FOR REASON OF HIDING WHISHLIST
            if(viewListingArray.wishListStatus == false)
            {
              self.heartImg.image = #imageLiteral(resourceName: "Heart").withRenderingMode(.alwaysOriginal)
            }
            else{
                self.heartImg.image = #imageLiteral(resourceName: "like").withRenderingMode(.alwaysOriginal)

            }
          self.moreBtnImage.image = #imageLiteral(resourceName: "show-more.png").withRenderingMode(.alwaysOriginal)
            self.shareImg.image = #imageLiteral(resourceName: "share.png").withRenderingMode(.alwaysOriginal)
      
        }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "cellIdentifier"
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        for subView in (cell?.contentView.subviews)!
        {
            subView.removeFromSuperview()
        }
        cell?.selectionStyle = UITableViewCell.SelectionStyle.none
        cell?.backgroundColor = UIColor.white
        cell!.tag = 2000+indexPath.row
        let contentview = UIView()
        if(indexPath.section == 0){
           
            contentview.frame = CGRect(x: 0, y: 0, width:FULLWIDTH, height: 280)
            //if (self.sampleImages.count > 0){
            
            navigationView.backgroundColor = UIColor.clear
            
    
            BackImg.frame = CGRect(x:10, y: 12, width:18, height:18)
            self.BackImg.image = #imageLiteral(resourceName: "back_white")
            BackImg.backgroundColor = UIColor.clear
            backBtn.backgroundColor = UIColor.clear
            //BackBtn.addTarget(self, action: #selector(BackBtnTapped(_:)), for: .touchUpInside)
            backBtn.addSubview(BackImg)
            navigationView.addSubview(backBtn)
            
            
            heartImg.frame = CGRect(x: 0, y:15, width: 20, height: 20)
             //FOR REASON OF HIDING WHISHLIST
            if(viewListingArray.wishListStatus == false)
            {
            self.heartImg.image = #imageLiteral(resourceName: "Heart")
            }
            else{
                self.heartImg.image = #imageLiteral(resourceName: "like")
            }
            likeBtn.backgroundColor = UIColor.clear
            heartImg.backgroundColor = UIColor.clear
            //  heartBtn.addTarget(self, action: #selector(heartBtnTapped(_:)), for: .touchUpInside)
            likeBtn.addSubview(heartImg)
            navigationView.addSubview(likeBtn)
            
            
            shareImg.frame = CGRect(x: 0, y: 15, width: 20, height: 20)
            shareImg.image = #imageLiteral(resourceName: "share")
            shareBtn.addTarget(self, action: #selector(shareBtnTapped(_:)), for: .touchUpInside)
            shareBtn.backgroundColor = UIColor.clear
            shareImg.backgroundColor = UIColor.clear
            shareBtn.addSubview(shareImg)
            navigationView.addSubview(shareBtn)
            
            
            let imageScroller = ImageScroller()
            imageScroller.frame = CGRect(x: 0, y: 0, width:FULLWIDTH, height: 280)
            imageScroller.delegate = self
            imageScroller.isAutoScrollEnabled = false
            imageScroller.scrollTimeInterval = 2.0 //time interval
            imageScroller.scrollView.bounces = false
            
            
           
           
           
            
            
            
            let array = viewListingArray.listingPhotos
            
            for j in array!
            {
                if(viewListingArray.listPhotoName == viewListingArray.listingPhotos?[0]?.name)
                {
                    if(filteredImageArray.contains("\(IMAGE_LISTING_MEDIUM)\(j?.name ?? "0")" as Any))
                    {
                     //self.filteredImageArray.remove("\(IMAGE_LISTING_MEDIUM)\(j?.name ?? "0")" as Any)
                    }
                    else
                    {
                     self.filteredImageArray.add("\(IMAGE_LISTING_MEDIUM)\(j?.name ?? "0")" as Any)
                    }
                }
                else
                {
                
                    if(filteredImageArray.contains("\(IMAGE_LISTING_MEDIUM)\(j?.name ?? "0")" as Any))
                    {
                       // self.filteredImageArray.remove("\(IMAGE_LISTING_MEDIUM)\(j?.name ?? "0")" as Any)
                    }
                    else
                    {
                        self.filteredImageArray.add("\(IMAGE_LISTING_MEDIUM)\(j?.name ?? "0")" as Any)
                    }
                }
                
            }
            if(self.filteredImageArray != nil){
               imageScroller.setupScrollerWithImages(images:self.filteredImageArray as! [String])
                 Pagecontrol = ISPageControl(frame: CGRect(x: FULLWIDTH/2-110, y:230, width: 200, height: 30), numberOfPages: self.filteredImageArray.count)
                Pagecontrol.radius = 5
                Pagecontrol.padding = 8
                Pagecontrol.inactiveTintColor = TextBorderColor
                Pagecontrol.currentPageTintColor = Theme.PRIMARY_COLOR
                Pagecontrol.inactiveTransparency = 1
                //Pagecontrol.borderWidth = 0.5
                //Pagecontrol.borderColor = UIColor.black.withAlphaComponent(0.5)
                Pagecontrol.tag = indexPath.row
                
                if(self.filteredImageArray.count > 1){
                imageScroller.addSubview(Pagecontrol)
                }
                let swipeRight = UISwipeGestureRecognizer(target: self, action:#selector(pageChanged(_:)))
                swipeRight.direction = UISwipeGestureRecognizer.Direction.right
                swipeRight.numberOfTouchesRequired = 1
               imageScroller.tag = indexPath.row
                imageScroller.addGestureRecognizer(swipeRight)
                self.setupTestData()
                
            }
        
            let tap = UITapGestureRecognizer(target: self, action: #selector(imageScrollerTapped))
            tap.numberOfTapsRequired = 1
            tap.view?.tag = pageNumber //indexPath.row
           imageScroller.addGestureRecognizer(tap)
            
            contentview.addSubview(imageScroller)
            cell?.contentView.addSubview(contentview)
            cell!.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell!
       // }
           
        }
        if(indexPath.section == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderDetailCell", for: indexPath)as! HeaderDetailCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.entireLabel.text = viewListingArray.roomType ?? ""
            cell.itemTitleLabel.text = viewListingArray.title!.condensingWhitespace()
            cell.customcountryLabel.text = "\(viewListingArray.city!), \(viewListingArray.state!), \(viewListingArray.country!)"
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
           if(viewListingArray.user?.profile?.picture != nil)
           {
            let profImage = viewListingArray.user?.profile?.picture!
            cell.profileImage.sd_setImage(with: URL(string:"\(IMAGE_AVATAR_MEDIUM)\(String(describing: profImage!))"),placeholderImage: #imageLiteral(resourceName: "unknown"))
            }
            else
           {
            cell.profileImage.image = #imageLiteral(resourceName: "unknown")
            }
            
            let displayname = viewListingArray.user?.profile?.displayName!
            cell.hostedLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"hostedby"))!) \(displayname!)"
           
            cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.width/2
            cell.profileImage.clipsToBounds = true
            
            cell.backBtn.addTarget(self, action: #selector(backBtnTapped(_:)), for: .touchUpInside)
            
            if(cell.itemTitleLabel?.text?.count ?? 0 <= 19){
                
                cell.itemTitleLabel.frame = CGRect(x:15, y: 35, width: (FULLWIDTH - 25), height:40)
                cell.customcountryLabel.frame = CGRect(x: 15, y:80, width: (FULLWIDTH - 125), height:25)
                cell.profileImage.frame = CGRect(x: FULLWIDTH-100, y: 80, width: 80, height: 80)
                cell.hostedLabel.frame = CGRect(x: 15, y:105, width: (FULLWIDTH - 25), height:25)
            }
            cell.profileImg.layer.cornerRadius = cell.profileImg.frame.size.width/2
            cell.profileImg.clipsToBounds = true
            cell.profileImg.addTarget(self, action: #selector(profileTapped), for: .touchUpInside)
            return cell
            
        }
        else if(indexPath.section == 2){
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath)as! DescriptionCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
            
            cell.descriptionLabel.text = viewListingArray.description?.condensingWhitespace()
          //  cell.descriptionLabel.text = viewListingArray.description!
           if(viewListingArray.personCapacity == 1)
           {
           cell.guestLabel.text = "\(viewListingArray.personCapacity!) \((Utility.shared.getLanguage()?.value(forKey:"guestsmall"))!)"
            }
           else{
            cell.guestLabel.text = "\(viewListingArray.personCapacity!) \((Utility.shared.getLanguage()?.value(forKey:"guestssmall"))!)"
            }
            if(viewListingArray.beds == 1)
            {
               cell.bedLabel.text = "\(viewListingArray.beds!) \((Utility.shared.getLanguage()?.value(forKey:"bed"))!)"
            }
            else{
                cell.bedLabel.text = "\(viewListingArray.beds!) \((Utility.shared.getLanguage()?.value(forKey:"beds"))!)"
            }
            if(viewListingArray.bedrooms == "1")
            {
                cell.bedroomLabel.text = "\(viewListingArray.bedrooms!) \((Utility.shared.getLanguage()?.value(forKey:"bedroom"))!)"
            }
            else{
                cell.bedroomLabel.text = "\(viewListingArray.bedrooms!) \((Utility.shared.getLanguage()?.value(forKey:"bedrooms"))!)"
            }
            
            if(viewListingArray.bathrooms == 1)
            {
                cell.privateBathLabel.text = "1 \((Utility.shared.getLanguage()?.value(forKey:"privatebath"))!)"
            }
            else{
                cell.privateBathLabel.text = "\((viewListingArray.bathrooms?.clean)!) \((Utility.shared.getLanguage()?.value(forKey:"privatebaths"))!)"
            }
            
            
            
            if(cell.descriptionLabel?.text?.count ?? 0 <= 30){
                cell.descriptionLabel.frame = CGRect(x: 16, y: 120, width: FULLWIDTH-25, height: 20)
                cell.readmoreBtn.isHidden = true
            }
            else if(cell.descriptionLabel?.text?.count ?? 0 > 35  && cell.descriptionLabel?.text?.count ?? 0 < 110){
                cell.descriptionLabel.frame = CGRect(x: 16, y: 120, width: FULLWIDTH-25, height:85)
                cell.readmoreBtn.isHidden = true
            }
            else{
               // cell.descriptionLabel.frame = CGRect(x: 16, y: 120, width: FULLWIDTH-25, height: 85)
               cell.readmoreBtn.isHidden = false
            }
            //cell.descriptionLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            cell.readmoreBtn.addTarget(self, action: #selector(readmoreTapped), for: .touchUpInside)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
        else if(indexPath.section == 3){
            let cell = tableView.dequeueReusableCell(withIdentifier: "AmenityDetailCell", for: indexPath) as! AmenityDetailCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            // cell.amenityLabel.text = (amenitiesArray[indexPath.row] as! String)
            if(indexPath.row == 0 &&  viewListingArray.listingData!.minNight! != 0)
            {
                cell.amenityLabel.text = "\((viewListingArray.listingData?.minNight!)!) \((Utility.shared.getLanguage()?.value(forKey:"minnight"))!)\(((viewListingArray.listingData?.minNight!)!) > 1 ? "": "")"
            }
                
            else if(viewListingArray.listingData!.maxNight! != 0)
            {
                cell.amenityLabel.text = "\((viewListingArray.listingData?.maxNight)!) \((Utility.shared.getLanguage()?.value(forKey:"maxnight"))!)\(((viewListingArray.listingData?.maxNight!)!) > 1 ? "": "")"
            }
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
        else if(indexPath.section == 4){
            let cell = tableView.dequeueReusableCell(withIdentifier: "AmenityDetailCell", for: indexPath) as! AmenityDetailCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
           // cell.amenityLabel.text = (amenitiesArray[indexPath.row] as! String)
            cell.amenityLabel.text = viewListingArray.userAmenities![indexPath.row]?.itemName!
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
        else if(indexPath.section == 5){
            let cell = tableView.dequeueReusableCell(withIdentifier: "AmenityDetailCell", for: indexPath) as! AmenityDetailCell
            //cell.amenityLabel.text = (userSpaceArray[indexPath.row] as! String)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.amenityLabel.text = viewListingArray.userSpaces![indexPath.row]?.itemName!
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
        else if(indexPath.section == 6){
            let cell = tableView.dequeueReusableCell(withIdentifier: "AmenityDetailCell", for: indexPath) as! AmenityDetailCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.amenityLabel.text = viewListingArray.userSafetyAmenities![indexPath.row]?.itemName!
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
             return cell
        }
        else if(indexPath.section == 7){
            let cell = tableView.dequeueReusableCell(withIdentifier: "MapCell", for: indexPath) as! MapCell
            cell.centerCircleView.frame = CGRect(x: cell.mapView.frame.size.width/2-75, y:cell.mapView.frame.size.height-250, width: 150, height: 150)
            cell.centerCircleView.layer.borderColor = Theme.PRIMARY_COLOR.cgColor
            cell.centerCircleView.layer.borderWidth = 1.5
            cell.centerCircleView.layer.cornerRadius = 75
            cell.centerCircleView.clipsToBounds = true
            cell.mapMarkerView.layer.cornerRadius = 5.0
            cell.mapMarkerView.clipsToBounds = true
            let shadowSize : CGFloat = 3.0
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                       y: -shadowSize / 2,
                                                       width: cell.mapMarkerView.frame.size.width + shadowSize,
                                                       height: cell.mapMarkerView.frame.size.height + shadowSize))
            
            cell.mapMarkerView.layer.masksToBounds = false
            cell.mapMarkerView.layer.shadowColor = TextLightColor.cgColor
            cell.mapMarkerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            cell.mapMarkerView.layer.shadowOpacity = 0.3
            cell.mapMarkerView.layer.shadowPath = shadowPath.cgPath
            let lat = "\(viewListingArray.lat!)"
            let long = "\(viewListingArray.lng!)"
            cell.mapView .addSubview(cell.centerCircleView)
           
            let staticMapUrl: String = "https://maps.googleapis.com/maps/api/staticmap?key=\(GOOGLE_API_KEY)&center=\(lat),\(long)&\("zoom=15&size=\(2 * Int(cell.mapView.frame.size.width))x\(2 * Int(cell.mapView.frame.size.height))")&sensor=true&language=en"
            cell.centerCircleView.backgroundColor = UIColor(red: 0.0/255.0, green: 132.0/255.0, blue: 135.0/255.0, alpha:0.3)
            let mapUrl: NSURL = NSURL(string: staticMapUrl)!
            cell.mapView.sd_setImage(with: mapUrl as URL, placeholderImage: UIImage(named: "palceholder"))
            cell.mapLabel.text = "\(viewListingArray.city!), \(viewListingArray.state!), \(viewListingArray.country!) \((Utility.shared.getLanguage()?.value(forKey:"exactlocation"))!)"
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
           
            return cell
        }
        else if(indexPath.section == 8) {
            
           
            
           
            
            if(viewListingArray.reviewsCount == 0)
            {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "CheckingCell", for: indexPath) as! CheckingCell
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                cell.flexLabel.textColor = Theme.PRIMARY_COLOR
                if(viewListingArray.houseRules?.count == 0)
            {
                cell.checkLabel.text = (checkArray[indexPath.row] as! String)
                
                if(indexPath.row == 0)
                {
                    if(viewListingArray.listingData?.checkInStart == "Flexible")
                    {
                    cell.flexLabel.text = viewListingArray.listingData?.checkInStart!
                    }
                    else
                    {
                    if(viewListingArray.listingData?.checkInStart != nil)
                        {
                     cell.flexLabel.text = self.conversionRailwaytime(time: (viewListingArray.listingData?.checkInStart!)!)
                        }
                    }
                    return cell
                }
                else if(indexPath.row == 1)
                {
                    if(viewListingArray.listingData?.checkInEnd == "Flexible")
                    {
                        cell.flexLabel.text = viewListingArray.listingData?.checkInEnd!
                    }
                    else
                    {
                        if(viewListingArray.listingData?.checkInEnd != nil)
                        {
                        cell.flexLabel.text = self.conversionRailwaytime(time: (viewListingArray.listingData?.checkInEnd!)!)
                        }
                    }
    
                      return cell
                }
                else if(indexPath.row == 2)
                {
                 
                    
                cell.flexLabel.text = viewListingArray.listingData?.cancellation?.policyName!
                      return cell
                }
                else if(indexPath.row == 3)
                {
                    cell.flexLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"check"))!)"
                      return cell
                }
                else if(indexPath.row == 4)
                {
                cell.flexLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"message"))!)"
                      return cell
                }
                }
            else{
                    cell.checkLabel.text = (checkleftSideArray[indexPath.row] as! String)
                    cell.selectionStyle = UITableViewCell.SelectionStyle.none
                    if(indexPath.row == 0)
                    {
                        if(viewListingArray.listingData?.checkInStart == "Flexible")
                        {
                            cell.flexLabel.text = viewListingArray.listingData?.checkInStart!
                        }
                        else
                        {
                            if(viewListingArray.listingData?.checkInStart != nil)
                                {
                            cell.flexLabel.text = self.conversionRailwaytime(time: (viewListingArray.listingData?.checkInStart!)!)
                            }
                            else
                                {
                                cell.flexLabel.text = "Гибкий График"
                            }
                        }
                          return cell
                    }
                    else if(indexPath.row == 1)
                    {
                        if(viewListingArray.listingData?.checkInEnd == "Flexible")
                        {
                            cell.flexLabel.text = viewListingArray.listingData?.checkInEnd!
                        }
                        else
                        {
                            if(viewListingArray.listingData?.checkInStart != nil)
                            {
                            cell.flexLabel.text = self.conversionRailwaytime(time: (viewListingArray.listingData?.checkInEnd!)!)
                            }
                            else
                            {
                              cell.flexLabel.text = "Гибкий График"
                            }
                        }
                          return cell
                    }
                    else if(indexPath.row == 2)
                    {
                        cell.flexLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"read"))!)"
                          return cell
                    }
                    else if(indexPath.row == 3)
                    {
                        
                        cell.flexLabel.text = viewListingArray.listingData?.cancellation?.policyName!
                          return cell
                    }
                    else if(indexPath.row == 4)
                    {
                        cell.flexLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"check"))!)"
                          return cell
                    }
                    else if(indexPath.row == 5)
                    {
                        cell.flexLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"message"))!)"
                          return cell
                    }
                
                }
                
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                
                return cell
            }
            else{
                
                if(viewListingArray.houseRules?.count == 0)
                {
                    
                    if(indexPath.row == 0)
                    {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckingCell", for: indexPath) as! CheckingCell
                        cell.selectionStyle = UITableViewCell.SelectionStyle.none
                        cell.flexLabel.textColor = Theme.PRIMARY_COLOR
                        cell.checkLabel.text =  "\((Utility.shared.getLanguage()?.value(forKey:"checkintime"))!)"
                        if(viewListingArray.listingData?.checkInStart == "Flexible")
                        {
                            cell.flexLabel.text = viewListingArray.listingData?.checkInStart!
                        }
                        else
                        {
                            cell.flexLabel.text = self.conversionRailwaytime(time: (viewListingArray.listingData?.checkInStart!)!)
                        }
                        return cell
                    }
                    else if(indexPath.row == 1)
                    {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckingCell", for: indexPath) as! CheckingCell
                        cell.selectionStyle = UITableViewCell.SelectionStyle.none
                        cell.flexLabel.textColor = Theme.PRIMARY_COLOR
                        cell.checkLabel.text =  "\((Utility.shared.getLanguage()?.value(forKey:"checkouttime"))!)"
                        if(viewListingArray.listingData?.checkInEnd == "Flexible")
                        {
                            cell.flexLabel.text = viewListingArray.listingData?.checkInEnd!
                        }
                        else
                        {
                            cell.flexLabel.text = self.conversionRailwaytime(time: (viewListingArray.listingData?.checkInEnd!)!)
                        }
                        return cell
                    }
                    else if(indexPath.row == 2)
                    {
                        let cell1 = tableView.dequeueReusableCell(withIdentifier: "ReviewCell") as! ReviewCell
                        cell1.selectionStyle = UITableViewCell.SelectionStyle.none
                        if(self.getreviewArray.count > 0)
                        {
                        cell1.reviewLabel.text = self.getreviewArray[0].reviewContent!
                        cell1.reviewDateLabel.text = reviewDate
                        cell1.reviewCountLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"readall"))!) \(viewListingArray.reviewsCount!) \((Utility.shared.getLanguage()?.value(forKey:"views"))!)"
                        cell1.reviewRateView.rating = self.getreviewArray[0].rating!
                         
                            
                        }
                        else{
                            
                        }
                        if(viewListingArray.reviewsCount  != nil)
                        {
                        if((viewListingArray.reviewsCount!) > 1)
                        {
                              cell1.readallBtn.setTitle("\(self.viewListingArray.reviewsCount!) \((Utility.shared.getLanguage()?.value(forKey:"reviews"))!)", for: .normal)
                        }
                        else{
                              cell1.readallBtn.setTitle("\(self.viewListingArray.reviewsCount!) \((Utility.shared.getLanguage()?.value(forKey:"review"))!)", for: .normal)
                        }
                        }else{
                            
                        }
                        if(self.getreviewArray[0].isAdmin! == true){
                            cell1.profileImg.image = #imageLiteral(resourceName: "adminAvatar")
                            cell1.verifyLabel.text = "Verify by RentALL"
                        }
                        else
                        {
                            let profImage = (getreviewArray[0].authorData?.picture)!
                             cell1.profileImg.sd_setImage(with: URL(string:"\(IMAGE_AVATAR_MEDIUM)\(String(describing: profImage))"),placeholderImage: #imageLiteral(resourceName: "adminAvatar"))
                            cell1.verifyLabel.text = "\((getreviewArray[0].authorData?.firstName!)!) \((getreviewArray[0].authorData?.lastName!)!)"
                        }
                        return cell1
                    }
                        
                    else if(indexPath.row == 3)
                    {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckingCell", for: indexPath) as! CheckingCell
                        cell.selectionStyle = UITableViewCell.SelectionStyle.none
                        cell.flexLabel.textColor = Theme.PRIMARY_COLOR
                        cell.checkLabel.text =  "\((Utility.shared.getLanguage()?.value(forKey:"cancellationPolicy"))!)"
                       
                        cell.flexLabel.text = viewListingArray.listingData?.cancellation?.policyName!
                        return cell
                    }
                    else if(indexPath.row == 4)
                    {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckingCell", for: indexPath) as! CheckingCell
                        cell.selectionStyle = UITableViewCell.SelectionStyle.none
                        cell.flexLabel.textColor = Theme.PRIMARY_COLOR
                        cell.checkLabel.text =  "\((Utility.shared.getLanguage()?.value(forKey:"availability"))!)"
                        cell.flexLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"check"))!)"
                        return cell
                    }
                    else {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckingCell", for: indexPath) as! CheckingCell
                        cell.selectionStyle = UITableViewCell.SelectionStyle.none
                        cell.flexLabel.textColor = Theme.PRIMARY_COLOR
                    
                         cell.checkLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"contacthost"))!)"
                        cell.flexLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"message"))!)"
                        return cell
                    }
                }
                else {
                    if(indexPath.row == 0)
                    {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckingCell", for: indexPath) as! CheckingCell
                        cell.selectionStyle = UITableViewCell.SelectionStyle.none
                        cell.flexLabel.textColor = Theme.PRIMARY_COLOR
                         cell.checkLabel.text =  "\((Utility.shared.getLanguage()?.value(forKey:"checkintime"))!)"
                        if(viewListingArray.listingData?.checkInStart == "Flexible")
                        {
                            cell.flexLabel.text = viewListingArray.listingData?.checkInStart!
                        }
                        else
                        {
                            cell.flexLabel.text = self.conversionRailwaytime(time: (viewListingArray.listingData?.checkInStart!)!)
                        }
                        return cell
                    }
                    else if(indexPath.row == 1)
                    {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckingCell", for: indexPath) as! CheckingCell
                        cell.selectionStyle = UITableViewCell.SelectionStyle.none
                        cell.flexLabel.textColor = Theme.PRIMARY_COLOR
                        cell.checkLabel.text =  "\((Utility.shared.getLanguage()?.value(forKey:"checkouttime"))!)"
                        if(viewListingArray.listingData?.checkInEnd == "Flexible")
                        {
                            cell.flexLabel.text = viewListingArray.listingData?.checkInEnd!
                        }
                        else
                        {
                            cell.flexLabel.text = self.conversionRailwaytime(time: (viewListingArray.listingData?.checkInEnd!)!)
                        }
                        return cell
                    }
                    else if(indexPath.row == 2)
                    {
                        
                        
                        let cell2 = tableView.dequeueReusableCell(withIdentifier: "ReviewCell")as! ReviewCell
                        cell2.selectionStyle = UITableViewCell.SelectionStyle.none
                         if(self.getreviewArray.count > 0)
                                               {
                                               cell2.reviewLabel.text = self.getreviewArray[0].reviewContent!
                                               cell2.reviewDateLabel.text = reviewDate
                                               cell2.reviewCountLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"readall"))!) \(viewListingArray.reviewsCount!) \((Utility.shared.getLanguage()?.value(forKey:"views"))!)"
                                               cell2.reviewRateView.rating = self.getreviewArray[0].rating!
                                               }
                         else{
                            
                        }
                        if(viewListingArray.reviewsCount != nil)
                                               {
                                               if((viewListingArray.reviewsCount!) > 1)
                                               {
                                                     cell2.readallBtn.setTitle("\(self.viewListingArray.reviewsCount!) \((Utility.shared.getLanguage()?.value(forKey:"reviews"))!)", for: .normal)
                                               }
                                               else{
                                                     cell2.readallBtn.setTitle("\(self.viewListingArray.reviewsCount!) \((Utility.shared.getLanguage()?.value(forKey:"review"))!)", for: .normal)
                                               }
                        }else{
                            
                            
                        }
                        if(self.getreviewArray[0].isAdmin! == true){
                            cell2.profileImg.image = #imageLiteral(resourceName: "adminAvatar")
                            cell2.verifyLabel.text = "Verify by RentALL"
                        }
                        else
                        {
                            let profImage = (getreviewArray[0].authorData?.picture)!
                             cell2.profileImg.sd_setImage(with: URL(string:"\(IMAGE_AVATAR_MEDIUM)\(String(describing: profImage))"),placeholderImage: #imageLiteral(resourceName: "adminAvatar"))
                            cell2.verifyLabel.text = "\((getreviewArray[0].authorData?.firstName!)!) \((getreviewArray[0].authorData?.lastName!)!)"
                        }
                        return cell2
//                       review cell
                    }
                    else if(indexPath.row == 3)
                    {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckingCell", for: indexPath) as! CheckingCell
                        cell.selectionStyle = UITableViewCell.SelectionStyle.none
                        cell.flexLabel.textColor = Theme.PRIMARY_COLOR
                        cell.checkLabel.text =  "\((Utility.shared.getLanguage()?.value(forKey:"houserules"))!)"
                        cell.flexLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"read"))!)"
                        return cell
                    }
                    else if(indexPath.row == 4)
                    {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckingCell", for: indexPath) as! CheckingCell
                        cell.selectionStyle = UITableViewCell.SelectionStyle.none
                        cell.flexLabel.textColor = Theme.PRIMARY_COLOR
                        cell.checkLabel.text =  "\((Utility.shared.getLanguage()?.value(forKey:"cancellationPolicy"))!)"
                      
                        cell.flexLabel.text = viewListingArray.listingData?.cancellation?.policyName!
                        return cell
                    }
                    else if(indexPath.row == 5)
                    {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckingCell", for: indexPath) as! CheckingCell
                        cell.selectionStyle = UITableViewCell.SelectionStyle.none
                        cell.flexLabel.textColor = Theme.PRIMARY_COLOR
                         cell.checkLabel.text =  "\((Utility.shared.getLanguage()?.value(forKey:"availability"))!)"
                        cell.flexLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"check"))!)"
                        return cell
                    }
                    else{
//                    else if(indexPath.row == 6)
//                    {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckingCell", for: indexPath) as! CheckingCell
                        cell.selectionStyle = UITableViewCell.SelectionStyle.none
                        cell.flexLabel.textColor = Theme.PRIMARY_COLOR
                        cell.checkLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"contacthost"))!)"
                        cell.flexLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"message"))!)"
                        return cell
                   // }
                    }
                }
                
            }
            
        
           
        }
        else {
            contentview.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height: 320)
            contentview.backgroundColor = UIColor.white
            let titleLabel = UILabel()
            titleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"similarlsiting"))!)"
            titleLabel.frame = CGRect(x:15, y: 5, width: FULLWIDTH - 40, height: 40)
            titleLabel.tintColor = UIColor.black
            titleLabel.textColor = UIColor.black
            titleLabel.font =  UIFont(name: "Circular-Medium", size:25)
            contentview.addSubview(titleLabel)
            
    
            let layout = UICollectionViewFlowLayout()
        
            explorecollectionView = UICollectionView(frame: CGRect(x:15, y: 50, width: FULLWIDTH-30, height:270), collectionViewLayout: layout)
        
            explorecollectionView?.tag = indexPath.row
            layout.scrollDirection = .horizontal
            explorecollectionView?.dataSource = self
            explorecollectionView?.delegate = self
            explorecollectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellIdentifier")
            explorecollectionView?.backgroundColor = UIColor.white
            explorecollectionView?.showsHorizontalScrollIndicator = false
            if let aView = explorecollectionView {
                contentview.addSubview(aView)
            }
            explorecollectionView?.register(UINib(nibName: "FloatCollectionCell", bundle: nil), forCellWithReuseIdentifier: "FloatCollectionCell")
            
            DispatchQueue.main.async {
                self.explorecollectionView?.reloadData()
            }
        cell?.contentView.addSubview(contentview)
        return cell!
        }
        
        
        
    }
    
    @objc func profileTapped()
    {
        if Utility().isConnectedToNetwork(){
      if(((Utility.shared.getCurrentUserToken()) != nil) && (Utility.shared.getCurrentUserToken() != ""))
        {
        let editprofileobj = HostProfileViewPage()
        editprofileobj.reiewListingArray = reiewListingArray
        editprofileobj.profileid = ((viewListingArray.user?.profile?.profileId!)!)
            editprofileobj.profilename = (viewListingArray.user?.profile?.firstName!)!
        editprofileobj.showprofileAPICall(profileid:(viewListingArray.user?.profile?.profileId!)!)
        editprofileobj.modalPresentationStyle = .fullScreen
        self.present(editprofileobj, animated: true, completion: nil)
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
       if(indexPath.section == 7){
            let mapPageObj = MapPageVC()
            mapPageObj.mapArray = viewListingArray
         mapPageObj.modalPresentationStyle = .fullScreen
            self.present(mapPageObj, animated: true, completion: nil)
            
            
        }
        else if(indexPath.section == 8)
       {
        
        if(viewListingArray.reviewsCount == 0)
        {
            if(viewListingArray.houseRules?.count == 0)
            {
                if(indexPath.row == 2)
                {
                    let cancellationObj = CancellationVC()
                  Utility.shared.cancelpolicy = (viewListingArray.listingData?.cancellation?.policyName!)!
                    cancellationObj.cancelpolicy = (viewListingArray.listingData?.cancellation?.policyName!)!
                    if((viewListingArray.listingData?.cancellation?.policyContent!) != nil)
                    {
                    
                    cancellationObj.cancelpolicy_content = (viewListingArray.listingData?.cancellation?.policyContent!)!
                    }
                    cancellationObj.modalPresentationStyle = .fullScreen
                    self.present(cancellationObj, animated: true, completion: nil)
                }
                if(indexPath.row == 3)
                {
                    Utility.shared.blocked_date_month.removeAllObjects()
                    for i in viewListingArray.blockedDates!
                    {
                        let timestamp = i?.blockedDates
                        let timestamValue = Int(timestamp!)!/1000
                        let newTime = Date(timeIntervalSince1970: TimeInterval(timestamValue))
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd-LL-yyyy" //Specify your format that you want
                        let dateFormatter1 = DateFormatter()
                        dateFormatter1.dateFormat = "LL"
                       // let newdate = Calendar.current.date(byAdding: .day, value: 1, to: newTime)
                        let date = "\(dateFormatter.string(from: newTime))"
                        if(i?.calendarStatus != "available")
                        {
                        Utility.shared.blocked_date_month.add("\(date)")
                        }
                        Utility.shared.blockedDates.add(dateFormatter.string(from: newTime))
                    }
                    Utility.shared.minimumstay = (viewListingArray.listingData?.minNight!)!
                    Utility.shared.isfromcheckingPage = true
                    let datePickerViewController = AirbnbDatePickerViewController(dateFrom: selectedStartDate, dateTo: selectedEndDate)
                    datePickerViewController.delegate = self
                    datePickerViewController.viewListingArray = viewListingArray
                    let navigationController = UINavigationController(rootViewController: datePickerViewController)
                    navigationController.modalPresentationStyle = .fullScreen
                    self.present(navigationController, animated: true, completion: nil)
                }
                if(indexPath.row == 4)
                {
                    if Utility().isConnectedToNetwork(){
                        if((Utility.shared.getCurrentUserToken()) == nil || (Utility.shared.getCurrentUserToken()) == "")
                        {
                            let welcomeObj = SignInViewController()
                            welcomeObj.modalPresentationStyle = .fullScreen
                            self.present(welcomeObj, animated:false, completion: nil)
                            //  appDelegate.setInitialViewController(initialView: welcomeObj)
                        }
                        else
                        {
                    let contactpageObj = ContacthostVC()
                    contactpageObj.currency_Dict = currency_Dict
                    contactpageObj.viewListingArray = viewListingArray
                    contactpageObj.currencyvalue_from_API_base = currencyvalue_from_API_base
                    Utility.shared.booking_message = ""
                    contactpageObj.selectedStartDate = selectedStartDate
                    contactpageObj.selectedEndDate = selectedEndDate
                    contactpageObj.getbillingArray = getbillingArray
                    contactpageObj.delegate = self
                    contactpageObj.modalPresentationStyle = .fullScreen
                    self.present(contactpageObj, animated: true, completion: nil)
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
            }
            else{
                if(indexPath.row == 2)
                {
                    let houserulesObj = HouseRulesVC()
                    houserulesObj.houserulesArray = self.viewListingArray.houseRules! as! [ViewListingDetailsQuery.Data.ViewListing.Result.HouseRule]
                    houserulesObj.modalPresentationStyle = .fullScreen
                    self.present(houserulesObj, animated: true, completion: nil)
                }
                
                else if(indexPath.row == 3)
                {
                    let cancellationObj = CancellationVC()
                  Utility.shared.cancelpolicy = (viewListingArray.listingData?.cancellation?.policyName!)!
                    cancellationObj.cancelpolicy = (viewListingArray.listingData?.cancellation?.policyName!)!
                    if((viewListingArray.listingData?.cancellation?.policyContent!) != nil)
                    {
                        
                        cancellationObj.cancelpolicy_content = (viewListingArray.listingData?.cancellation?.policyContent!)!
                    }
                    cancellationObj.modalPresentationStyle = .fullScreen
                    self.present(cancellationObj, animated: true, completion: nil)
                }
                if(indexPath.row == 4)
                {
                    Utility.shared.blocked_date_month.removeAllObjects()
                    for i in viewListingArray.blockedDates!
                    {
                        let timestamp = i?.blockedDates
                        let timestamValue = Int(timestamp!)!/1000
                        let newTime = Date(timeIntervalSince1970: TimeInterval(timestamValue))
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd-LL-yyyy" //Specify your format that you want
                        let dateFormatter1 = DateFormatter()
                        dateFormatter1.dateFormat = "LL"
                       let newdate = Calendar.current.date(byAdding: .day, value: 0, to: newTime)
                        let date = "\(dateFormatter.string(from: newTime))"
                        let newDate = "\(dateFormatter.string(from: newdate!))"
                        if(i?.calendarStatus != "available")
                        {
                        Utility.shared.blocked_date_month.add("\(date)")
                        }
                        Utility.shared.blockedDates.add(dateFormatter.string(from: newTime))
                    }
                    Utility.shared.minimumstay = (viewListingArray.listingData?.minNight!)!
                    Utility.shared.isfromcheckingPage = true
                    let datePickerViewController = AirbnbDatePickerViewController(dateFrom: selectedStartDate, dateTo: selectedEndDate)
                    datePickerViewController.delegate = self
                    datePickerViewController.viewListingArray = viewListingArray
                    let navigationController = UINavigationController(rootViewController: datePickerViewController)
                     navigationController.modalPresentationStyle = .fullScreen
                    self.present(navigationController, animated: true, completion: nil)
                }
                if(indexPath.row == 5)
                {
                    if Utility().isConnectedToNetwork(){
                        if((Utility.shared.getCurrentUserToken()) == nil || (Utility.shared.getCurrentUserToken()) == "")
                        {
                            let welcomeObj = SignInViewController()
                            welcomeObj.modalPresentationStyle = .fullScreen
                            self.present(welcomeObj, animated:false, completion: nil)
                            //  appDelegate.setInitialViewController(initialView: welcomeObj)
                        }
                        else
                        {
                    let contactpageObj = ContacthostVC()
                    contactpageObj.currency_Dict = currency_Dict
                    contactpageObj.viewListingArray = viewListingArray
                    contactpageObj.currencyvalue_from_API_base = currencyvalue_from_API_base
                    Utility.shared.booking_message = ""
                    contactpageObj.selectedStartDate = selectedStartDate
                    contactpageObj.selectedEndDate = selectedEndDate
                    contactpageObj.getbillingArray = getbillingArray
                    contactpageObj.delegate = self
                     contactpageObj.modalPresentationStyle = .fullScreen
                    self.present(contactpageObj, animated: true, completion: nil)
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
            }
            
        }
        else
        {
                if(viewListingArray.houseRules?.count == 0)
                {
                    if(indexPath.row == 3)
                    {
                        let cancellationObj = CancellationVC()
                       cancellationObj.cancelpolicy = (viewListingArray.listingData?.cancellation?.policyName!)!
                        Utility.shared.cancelpolicy = (viewListingArray.listingData?.cancellation?.policyName!)!
                        if((viewListingArray.listingData?.cancellation?.policyContent!) != nil)
                        {
                            
                            cancellationObj.cancelpolicy_content = (viewListingArray.listingData?.cancellation?.policyContent!)!
                        }
                         cancellationObj.modalPresentationStyle = .fullScreen
                        self.present(cancellationObj, animated: true, completion: nil)
                    }
                    else if(indexPath.row == 4)
                    {
                        Utility.shared.blocked_date_month.removeAllObjects()
                        for i in viewListingArray.blockedDates!
                        {
                            let timestamp = i?.blockedDates
                            let timestamValue = Int(timestamp!)!/1000
                            let newTime = Date(timeIntervalSince1970: TimeInterval(timestamValue))
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "dd-LL-yyyy" //Specify your format that you want
                            let dateFormatter1 = DateFormatter()
                            dateFormatter1.dateFormat = "LL"
                           // let newdate = Calendar.current.date(byAdding: .day, value: 1, to: newTime)
                            let date = "\(dateFormatter.string(from: newTime))"
                            if(i?.calendarStatus != "available")
                            {
                            Utility.shared.blocked_date_month.add("\(date)")
                            }
                            Utility.shared.blockedDates.add(dateFormatter.string(from: newTime))
                        }
                        Utility.shared.minimumstay = (viewListingArray.listingData?.minNight!)!
                        Utility.shared.isfromcheckingPage = true
                        let datePickerViewController = AirbnbDatePickerViewController(dateFrom: selectedStartDate, dateTo: selectedEndDate)
                        datePickerViewController.delegate = self
                        datePickerViewController.viewListingArray = viewListingArray
                        let navigationController = UINavigationController(rootViewController: datePickerViewController)
                         navigationController.modalPresentationStyle = .fullScreen
                        self.present(navigationController, animated: true, completion: nil)
                    }
                    if(indexPath.row == 5)
                    {
                        if Utility().isConnectedToNetwork(){
                            if((Utility.shared.getCurrentUserToken()) == nil || (Utility.shared.getCurrentUserToken()) == "")
                            {
                                let welcomeObj = SignInViewController()
                                 welcomeObj.modalPresentationStyle = .fullScreen
                                self.present(welcomeObj, animated:false, completion: nil)
                                //  appDelegate.setInitialViewController(initialView: welcomeObj)
                            }
                            else
                            {
                        let contactpageObj = ContacthostVC()
                        contactpageObj.currency_Dict = currency_Dict
                        contactpageObj.viewListingArray = viewListingArray
                        contactpageObj.currencyvalue_from_API_base = currencyvalue_from_API_base
                        Utility.shared.booking_message = ""
                        contactpageObj.selectedStartDate = selectedStartDate
                        contactpageObj.selectedEndDate = selectedEndDate
                        contactpageObj.getbillingArray = getbillingArray
                        contactpageObj.delegate = self
                        contactpageObj.modalPresentationStyle = .fullScreen
                        self.present(contactpageObj, animated: true, completion: nil)
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
                }
            else{
                    if(indexPath.row == 3)
                    {
                        let houserulesObj = HouseRulesVC()
                        houserulesObj.houserulesArray = self.viewListingArray.houseRules! as! [ViewListingDetailsQuery.Data.ViewListing.Result.HouseRule]
                        houserulesObj.modalPresentationStyle = .fullScreen
                        self.present(houserulesObj, animated: true, completion: nil)
                    }
            
                    if(indexPath.row == 4)
                    {
                        let cancellationObj = CancellationVC()
                      Utility.shared.cancelpolicy = (viewListingArray.listingData?.cancellation?.policyName!)!
                        cancellationObj.cancelpolicy = (viewListingArray.listingData?.cancellation?.policyName!)!
                        if((viewListingArray.listingData?.cancellation?.policyContent!) != nil)
                        {
                            
                            cancellationObj.cancelpolicy_content = (viewListingArray.listingData?.cancellation?.policyContent!)!
                        }
                        cancellationObj.modalPresentationStyle = .fullScreen
                        self.present(cancellationObj, animated: true, completion: nil)
                    }
                    if(indexPath.row == 5)
                    {
                        Utility.shared.blocked_date_month.removeAllObjects()
                        for i in viewListingArray.blockedDates!
                        {
                            let timestamp = i?.blockedDates
                            let timestamValue = Int(timestamp!)!/1000
                            let newTime = Date(timeIntervalSince1970: TimeInterval(timestamValue))
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "dd-LL-yyyy" //Specify your format that you want
                            let dateFormatter1 = DateFormatter()
                            dateFormatter1.dateFormat = "LL"
                            //let newdate = Calendar.current.date(byAdding: .day, value: 1, to: newTime)
                            let date = "\(dateFormatter.string(from: newTime))"
                            if(i?.calendarStatus != "available")
                            {
                            Utility.shared.blocked_date_month.add("\(date)")
                            }
                            Utility.shared.blockedDates.add(dateFormatter.string(from: newTime))
                        }
                        Utility.shared.minimumstay = (viewListingArray.listingData?.minNight!)!
                        Utility.shared.isfromcheckingPage = true
                        let datePickerViewController = AirbnbDatePickerViewController(dateFrom: selectedStartDate, dateTo: selectedEndDate)
                        datePickerViewController.delegate = self
                        datePickerViewController.viewListingArray = viewListingArray
                        let navigationController = UINavigationController(rootViewController: datePickerViewController)
                         navigationController.modalPresentationStyle = .fullScreen
                        self.present(navigationController, animated: true, completion: nil)
                    }
                    if(indexPath.row == 6)
                    {
                         if Utility().isConnectedToNetwork(){
                            if((Utility.shared.getCurrentUserToken()) == nil || (Utility.shared.getCurrentUserToken()) == "")
                            {
                                let welcomeObj = SignInViewController()
                                welcomeObj.modalPresentationStyle = .fullScreen
                                self.present(welcomeObj, animated:false, completion: nil)
                                //  appDelegate.setInitialViewController(initialView: welcomeObj)
                            }
                            else
                            {
                        let contactpageObj = ContacthostVC()
                        contactpageObj.currency_Dict = currency_Dict
                        contactpageObj.viewListingArray = viewListingArray
                        contactpageObj.currencyvalue_from_API_base = currencyvalue_from_API_base
                        Utility.shared.booking_message = ""
                        contactpageObj.selectedStartDate = selectedStartDate
                        contactpageObj.selectedEndDate = selectedEndDate
                        contactpageObj.getbillingArray = getbillingArray
                        contactpageObj.delegate = self
                             contactpageObj.modalPresentationStyle = .fullScreen
                        self.present(contactpageObj, animated: true, completion: nil)
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
            
                }
        }
        
    }
        
    }
    @objc func imageScrollerTapped(_ sender: UITapGestureRecognizer) {
        let browser = SKPhotoBrowser(photos: images, initialPageIndex: Pagecontrol.currentPage)
        browser.delegate = self
        
        present(browser, animated: true, completion: {})
    }
    @IBAction func retryBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            self.lottieAnimation()
            offlineView.isHidden = true
            self.bottomView.isHidden = false
            self.viewDetailAPICall(listid:listID)
            let fmt = DateFormatter()
            fmt.dateFormat = "yyyy-MM-dd"
            if(selectedStartDate != nil)
            {
            billingListAPICall(startDate: fmt.string(from: selectedStartDate!), endDate: fmt.string(from: selectedEndDate!))
            }
        }
    }
    
    func createLocalPhotos() -> [SKPhotoProtocol] {
        return (0..<filteredImageArray.count).map { (i: Int) -> SKPhotoProtocol in
            let photo = SKPhoto.photoWithImageURL(filteredImageArray[i] as! String)
            
            return photo
        }
    }
    
    func setupTestData() {
        images = createLocalPhotos()
    }
    
    @objc func pageChanged(_ sender: UISwipeGestureRecognizer) {

        pageNumber = sender.view!.tag
        pageindexForImageScrolled = pageNumber
    }
    
    @objc func readmoreTapped()
    {
        let readmoreObj = ReadmoreVC()
        readmoreObj.ReadmoreText = self.viewListingArray.description!
         readmoreObj.modalPresentationStyle = .fullScreen
        self.present(readmoreObj, animated: true, completion: nil)
        
    }
    
    @objc func reviewreadmoreTapped(value:String)
       {
           let readmoreObj = ReadmoreVC()
           readmoreObj.ReadmoreText = value
            readmoreObj.modalPresentationStyle = .fullScreen
           self.present(readmoreObj, animated: true, completion: nil)
           
       }
    
    //MARK:**************************************************** COLLECTIONVIEW DELEGATE & DATASOURCE METHODS **********************************************************>
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:FULLWIDTH/2+60, height:270)
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(similarlistingArray.count > 0)
        {
            return similarlistingArray.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FloatCollectionCell", for: indexPath)as! FloatCollectionCell
        if similarlistingArray[indexPath.row].roomType != nil
        {
        cell.entirehomeLabel.text = similarlistingArray[indexPath.row].roomType!
        }else
        {
         cell.entirehomeLabel.text = ""
        }
        cell.entirehomeLabel.sizeToFit()
        let profImage = similarlistingArray[indexPath.row].listPhotoName!
        cell.homeImage.sd_setImage(with: URL(string:"\(IMAGE_LISTING_MEDIUM)\(String(describing: profImage))"),placeholderImage: #imageLiteral(resourceName: "ItemTransparentImg"))
        
        cell.tag = indexPath.item+1000
        cell.selectedItem.tag = indexPath.item
        cell.selectedItem.backgroundColor = .white
        
        cell.titleLabel.text = similarlistingArray[indexPath.row].title!.condensingWhitespace()
        if(Utility.shared.getPreferredCurrency() != nil &&  Utility.shared.getPreferredCurrency() != "")
        {
            let currencysymbol = Utility.shared.getSymbol(forCurrencyCode: Utility.shared.getPreferredCurrency()!)
            let from_currency = self.similarlistingArray[indexPath.row].listingData?.currency
            let currency_amount = self.similarlistingArray[indexPath.row].listingData?.basePrice
            let price_value = self.getCurrencyRate(basecurrency:currencyvalue_from_API_base, fromCurrency:from_currency!, toCurrency:Utility.shared.getPreferredCurrency()!, CurrencyRate:Utility.shared.currency_Dict, amount:currency_amount!)
            let restricted_price =  Double(String(format: "%.2f",price_value))
            cell.priceLabel.text =  "\(currencysymbol!)\(restricted_price!.clean) \((Utility.shared.getLanguage()?.value(forKey:"pernight"))!)"
        }
        else
        {
            let currencysymbol = Utility.shared.getSymbol(forCurrencyCode:self.currencyvalue_from_API_base)
            let from_currency = self.similarlistingArray[indexPath.row].listingData?.currency
            let currency_amount = self.similarlistingArray[indexPath.row].listingData?.basePrice
            let price_value = self.getCurrencyRate(basecurrency:currencyvalue_from_API_base, fromCurrency:from_currency!, toCurrency:currencyvalue_from_API_base, CurrencyRate:Utility.shared.currency_Dict, amount:currency_amount!)
            let restricted_price =  Double(String(format: "%.2f",price_value))
            cell.priceLabel.text =  "\(currencysymbol!)\(restricted_price!.clean) \((Utility.shared.getLanguage()?.value(forKey:"pernight"))!)"
        }
        if("\(similarlistingArray[indexPath.row].bookingType!)" == "instant")
        {
            cell.instantView.isHidden = false
        }
        else{
            cell.instantView.isHidden = true
         
        }
         //FOR REASON OF HIDING WHISHLIST
        if("\(similarlistingArray[indexPath.row].wishListStatus!)" == "false"){
            cell.likeBtn.setImage(#imageLiteral(resourceName: "Heart"), for: .normal)
           
        }
        else {
            cell.likeBtn.setImage(#imageLiteral(resourceName: "like"), for:.normal)
        }
        cell.likeBtn.tag = indexPath.row
        cell.likeBtn.addTarget(self, action: #selector(whishlistBtnTapped), for: .touchUpInside)
        let value1 = (similarlistingArray[indexPath.row].reviewsCount)
        let value2 = (similarlistingArray[indexPath.row].reviewsStarRating)
        if(value2 != nil){
            let reviewcount = (value2!/value1!)
            cell.ratingView.rating = Double(reviewcount)
        }
        else{
            cell.ratingView.rating = 0
        }
        if(similarlistingArray[indexPath.row].isListOwner == false)
        {
            cell.likeBtn.isHidden = false
        }
        else
        {
            cell.likeBtn.isHidden = true
            
        }
        
        
        cell.homeImage.layer.cornerRadius = 4.0
        cell.homeImage.layer.masksToBounds = true
        
      
        if(cell.titleLabel?.text?.count ?? 0 <= 29){
            cell.titleLabel.frame = CGRect(x: 0, y: 184, width: (FULLWIDTH - 25), height:25)
            cell.priceLabel.frame = CGRect(x: 0, y: 205, width: (FULLWIDTH - 25), height:20)
            cell.ratingView.frame = CGRect(x: 0, y: 225, width: 70, height:18)
        }

        
        cell.instantView.frame = CGRect(x:cell.entirehomeLabel.frame.origin.x+cell.entirehomeLabel.frame.size.width+3, y: 172, width: 10, height: 12)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let guestdetailObj = GuestDetailVC()
        guestdetailObj.listID = similarlistingArray[indexPath.row].id!
        guestdetailObj.currencyvalue_from_API_base = currencyvalue_from_API_base
        Utility.shared.unpublish_preview_check = false
        guestdetailObj.currency_Dict = currency_Dict
        guestdetailObj.modalPresentationStyle = .fullScreen
       // guestdetailObj.viewDetailAPICall(listid: similarlistingArray[indexPath.row].id!)
        self.present(guestdetailObj, animated: true, completion: nil)
    }
   
    
    func timestampconvert(timestamp:String)
    {
        let timestamValue = Int(timestamp)!/1000
        let newTime = Date(timeIntervalSince1970: TimeInterval(timestamValue))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy" //Specify your format that you want
        
        self.reviewDate = dateFormatter.string(from: newTime)
    }
    
    
    func reviewcountAPICall(profileid:Int)
    {
        let reviewListquery = UserReviewsQuery(ownerType: "others", currentPage: 1, profileId: profileid)
        
        apollo_headerClient.fetch(query: reviewListquery){(result,error) in
            
            
            guard (result?.data?.userReviews?.results) != nil else{
                print("Missing Data")
                return
            }
            self.reiewListingArray = (result?.data?.userReviews?.results)! as! [UserReviewsQuery.Data.UserReview.Result]
           
              //  self.timestampconvert(timestamp:self.reiewListingArray[0].createdAt!)
           
          // self.timestampconvert(timestamp:)
        }
        
    }
    
    func getreviewAPICall(listId:Int,hostId:String){
        
        let getreviewquery = GetReviewsListQuery(listId: listId, currentPage: 1, hostId: hostId)
        apollo_headerClient.fetch(query: getreviewquery){(result,error) in
            if(result?.data?.getReviews?.status == 200){
                self.getreviewArray = (result?.data?.getReviews?.results!)! as! [GetReviewsListQuery.Data.GetReview.Result]
                if(self.getreviewArray.count > 0){
                self.timestampconvert(timestamp:self.getreviewArray[0].createdAt!)
                }
            }
        }
    }
    
    
    @objc func whishlistBtnTapped(_ sender: UIButton!)
    {
        if((Utility.shared.getCurrentUserToken()) == nil || (Utility.shared.getCurrentUserToken()) == "")
        {
            let welcomeObj = SignInViewController()
             welcomeObj.modalPresentationStyle = .fullScreen
            self.present(welcomeObj, animated:false, completion: nil)
            //  appDelegate.setInitialViewController(initialView: welcomeObj)
        }
        else
        {
            let headerView = WhishlistPageVC()
            headerView.listID = similarlistingArray[sender.tag].id!
            headerView.listimage = similarlistingArray[sender.tag].listPhotoName!
            headerView.delegate = self
            self.addChild(headerView)
            self.view.addSubview(headerView.view)
            headerView.didMove(toParent: self)
            self.tabBarController?.tabBar.isHidden = true
            headerView.view.frame = self.view.frame
        }
    }
    func datePickerController(_ datePickerController: AirbnbDatePickerViewController, didSaveStartDate startDate: Date?, endDate: Date?) {
        if(startDate != nil)
        {
       // let newstartdate = Calendar.current.date(byAdding: .day, value: 1, to: startDate!)
       // let newenddate = Calendar.current.date(byAdding: .day, value: 1, to: endDate!)
        selectedStartDate = startDate
        selectedEndDate = endDate
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        if(startDate != nil && endDate != nil){
            print(dateFormatterGet.string(from: startDate!))
        }
        
        if selectedStartDate == nil && selectedEndDate == nil {
            chkAvailabiltyBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"checkavailability"))!)", for: .normal)
        } else {
            let fmt = DateFormatter()
            fmt.dateFormat = "yyyy-MM-dd"
            billingListAPICall(startDate: fmt.string(from: startDate!), endDate: fmt.string(from: endDate!))
            if(viewListingArray.bookingType! == "instant")
            {
            chkAvailabiltyBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"book"))!)", for: .normal)
            }
            else
            {
               chkAvailabiltyBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"requestbook"))!)", for: .normal)
            }
        }
        }
        else
        {
            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"selectdate"))!)")
        }
    }
    
    //MARK***************************************************** CURRENCY CONVERSION FUNCTION *******************************************************************>
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
    
    func passSelectedStartDate(selectedstartDate: Date) {
        selectedStartDate = selectedstartDate
    }
    
    func passSelectedEndDate(selectedenddate: Date) {
        selectedEndDate = selectedenddate
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
extension GuestDetailVC : ImageScrollerDelegate{
    
    
    
    
    func pageChanged(index: Int, indexpath: Int) {
        //pageNumber = index
       // cell?.Pagecontrol.currentPage = sender.view!.tag
        Pagecontrol.currentPage = index
        
       
    }
}
extension Float {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
extension String {
    func condensingWhitespace() -> String {
        return self.components(separatedBy: .whitespacesAndNewlines)
            .filter { !$0.isEmpty }
            .joined(separator: " ")
    }
}


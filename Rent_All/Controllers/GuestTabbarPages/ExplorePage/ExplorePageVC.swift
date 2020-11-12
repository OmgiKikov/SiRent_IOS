//
//  ExplorePageVC.swift
//  Rent_All
//
//  Created by RADICAL START on 22/03/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons
import JJFloatingActionButton
import Lottie
import Apollo
import Alamofire
import SwiftyJSON
import ISPageControl

class ExplorePageVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,AirbnbDatePickerDelegate,AirbnbOccupantFilterControllerDelegate,UIScrollViewDelegate,WhishlistPageVCProtocol {
  
  func didupdateWhishlistStatus(status: Bool) {
    
  }
  
  //MARK:*********************************** IBOUTLET CONNECTIONS **************************************>
  
  @IBOutlet weak var contentWholeView: UIView!
  @IBOutlet var exploreTV: UITableView!
  
  @IBOutlet var headerView: UIView!
  
  var lottieView: LOTAnimationView!
  
  @IBOutlet weak var searchBackBtn: UIButton!
  @IBOutlet weak var NoresultView: UIView!
  @IBOutlet var lineView: UIView!
  @IBOutlet var filterView: UIView!
  @IBOutlet var searchBtn: UIButton!
  @IBOutlet var searchView: UIView!
  @IBOutlet weak var offlineView: UIView!
  
  @IBOutlet weak var NoViewNoresult: UILabel!
  @IBOutlet weak var noViewFirstText: UILabel!
  @IBOutlet weak var noViewSecondText: UILabel!
  @IBOutlet weak var NoViewthirdText: UILabel!
  @IBOutlet weak var retry_button: UIButton!
  @IBOutlet weak var error_label: UILabel!
  
  @IBOutlet var locationLabel: UILabel!
  
  
  var pageNumber : Int = 0
  var fetchingMore = false
  var PageIndex : Int = 1
  
  var Pagecontrol:ISPageControl!
  
  //MARK:*********************************** GLOBAL VARIABLE DECLARATIONS **************************************>
  var entirehomeArray = NSMutableArray()
  var homeImageArray = NSMutableArray()
  var homeTitleArray = NSMutableArray()
  var homePriceArray = NSMutableArray()
  var reviewcount_Array = NSMutableArray()
  var reviewStart_ratingArray = NSMutableArray()
  var wishlistArray = NSMutableArray()
  var mosthomeImageArray = NSMutableArray()
  var mosthomeTitleArray = NSMutableArray()
  var mosthomePriceArray = NSMutableArray()
  var mostreviewcount_Array = NSMutableArray()
  var most_entirehomeArray = NSMutableArray()
  var mostreviewStart_ratingArray = NSMutableArray()
  var mostwishlist_Array = NSMutableArray()
  var filteredImageArray = NSMutableArray()
  var filteredTitleArray = NSMutableArray()
  var filteredPriceArray = NSMutableArray()
  var filtered_reviewcountArray = NSMutableArray()
  var filtered_reviewstartArray = NSMutableArray()
  var filtered_entirehomeArray = NSMutableArray()
  var filtered_whishlistArray = NSMutableArray()
  var bookingTypeArray = NSMutableArray()
  var mostbookingTypeArray = NSMutableArray()
  let dateBtn = UIButton()
  let guestBtn = UIButton()
  let filterBtn = UIButton()
  public var selectedStartDate: Date?
  public var selectedEndDate: Date?
  var currencyCode_for_mostListing = String()
  var currencyCode_for_recommendedListing = String()
  var currencyCode_for_filteredListing = String()
  var currencysymbol_mostListing = String()
  var currencysymbol_recommendedListing = String()
  var currencysymbol_filteredListing = String()
  var sampleImages = NSMutableArray()
  var FilterArray = [SearchListingQuery.Data.SearchListing.Result]()
  var recommendListingArray = [GetDefaultSettingQuery.Data.GetRecommend.Result]()
  var mostListingArray = [GetDefaultSettingQuery.Data.GetMostViewedListing.Result]()
  var currencyvalue_from_API = GetDefaultSettingQuery.Data.Currency.Result()
  var RoomsFilterArray = [GetDefaultSettingQuery.Data.GetListingSettingsCommon.Result]()
  var getsearchPriceArray = GetDefaultSettingQuery.Data.GetSearchSetting.Result()
  
  var populardestinationArray = [GetDefaultSettingQuery.Data.GetMostViewedListing.Result.PopularLocationListing]()
  var totalDict = NSDictionary()
  var currency_Dict = NSDictionary()
  var adultCount: Int = 1
  var childrenCount: Int = 0
  var infantCount: Int = 0
  var hasPet: Bool = false
  var isFilterEnable:Bool = false
  var totalListcount:Int = 0
  var explorecollectionView: UICollectionView?
  let actionButton = JJFloatingActionButton()
  var dateFormatter: DateFormatter {
    get {
      let f = DateFormatter()
      f.dateFormat = "MMM d"
      if(Utility.shared.getAppLanguageCode() != nil)
      {
        f.locale = NSLocale(localeIdentifier:Utility.shared.getAppLanguageCode()!) as Locale
      }
      return f
    }
  }
  var selectedstartDate_filter = String()
  var selectedEndDate_filter = String()
  var guest_filter = Int()
  var lastContentOffset: CGFloat = 0
  var apollo_headerClient:ApolloClient!
  override func viewDidLoad() {
    super.viewDidLoad()
    self.checkApolloStatus()
    
    //self.tabBarController?.delegate = self
    self.lottieAnimation()
    self.initialSetup()
    //` self.collectionSetup()
    self.configFloatingBtn()
    self.tabBarController?.tabBar.isHidden = false
    actionButton.isHidden = true
    //  self.lottieView.isHidden = false
    // Do any additional setup after loading the view.
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
  override func viewWillAppear(_ animated: Bool) {
    
    //        guard let statusBarView = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else {
    //            return
    //        }
    //        statusBarView.backgroundColor = UIColor.clear
    
    self.tabBarController?.tabBar.isHidden = false
    if ((Utility.shared.getCurrentUserToken()) == nil || (Utility.shared.getCurrentUserToken()) == ""){
      
      self.lottieAnimation()
    }
    
    
    if(!Utility.shared.isfromdetailpage)
    {
      self.FilterArray.removeAll()
    }
    else
    {
      self.lottieView.isHidden = true
    }
    
    if(Utility.shared.locationfromSearch != "" && Utility.shared.locationfromSearch != nil){
      locationLabel.text = Utility.shared.locationfromSearch
      self.searchListingAPICall()
    }
    else {
      locationLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"losangeles"))!)"
      
    }
    
    
    if(Utility.shared.isfromsearchLocationFilter || (Utility.shared.locationfromSearch != "" && Utility.shared.locationfromSearch != nil))
    {
      searchBackBtn.setImage(#imageLiteral(resourceName: "back_black"), for: .normal)
    }
    else {
      searchBackBtn.setImage(#imageLiteral(resourceName: "Magnyfy_glass"), for: .normal)
    }
    if selectedStartDate == nil || selectedEndDate == nil && Utility.shared.locationfromSearch == "" {
      if(!Utility.shared.isfromfloatmap_Page && Utility.shared.TotalFilterCount == 0)
      {
        dateBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"dates"))!)", for: .normal)
        dateBtn.setTitleColor(TextDarkColor, for: .normal)
        dateBtn.backgroundColor = UIColor.white
        dateBtn.frame = CGRect(x:20, y: 5, width: 90, height: 33)
        guestBtn.frame = CGRect(x:(self.dateBtn.frame.origin.x+self.dateBtn.frame.size.width + 10), y: 5, width:110, height: 33)
        if(guest_filter == 0 && Utility.shared.searchLocationDict.count == 0){
          isFilterEnable = false
          filterBtn.isHidden = true
          
          actionButton.isHidden = true
        }
        else{
          filterBtn.isHidden = false
          filterBtn.frame = CGRect(x:(self.guestBtn.frame.origin.x+self.guestBtn.frame.size.width + 10), y: 5, width: 70, height: 33)
          isFilterEnable = true
          // actionButton.isHidden = false
          if(!Utility.shared.isfromdetailpage)
          {
            PageIndex = 1
            self.searchListingAPICall()
          }
        }
      }
      else
      {
        filterBtn.isHidden = false
        dateBtn.setTitleColor(TextDarkColor, for: .normal)
        dateBtn.backgroundColor = UIColor.white
        dateBtn.frame = CGRect(x:20, y: 5, width: 90, height: 33)
        guestBtn.frame = CGRect(x:(self.dateBtn.frame.origin.x+self.dateBtn.frame.size.width + 10), y: 5, width:110, height: 33)
        //filterBtn.frame = CGRect(x:240, y: 5, width: 70, height: 33)
        filterBtn.frame = CGRect(x:(self.guestBtn.frame.origin.x+self.guestBtn.frame.size.width + 10), y: 5, width: 70, height: 33)
        isFilterEnable = true
        // actionButton.isHidden = false
        if(!Utility.shared.isfromdetailpage)
        {
          PageIndex = 1
          self.searchListingAPICall()
        }
      }
      
      
    }
    else{
      if(!Utility.shared.isfromdetailpage)
      {
        isFilterEnable = true
        PageIndex = 1
        self.searchListingAPICall()
      }
      isFilterEnable = true
      
    }
    
    if(Utility.shared.isfromFilterPage) {
      
      filterBtn.setTitleColor(UIColor.white, for: .normal)
      if(Utility.shared.TotalFilterCount == 1){
        filterBtn.setTitle("\(Utility.shared.TotalFilterCount) \((Utility.shared.getLanguage()?.value(forKey:"filter"))!)", for: .normal)
        filterBtn.backgroundColor = Theme.PRIMARY_COLOR
      }
      else if(Utility.shared.TotalFilterCount == 0)
      {
        filterBtn.backgroundColor = UIColor.white
        filterBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"filter"))!)", for: .normal)
        filterBtn.setTitleColor(TextDarkColor, for: .normal)
      }
      else{
        filterBtn.setTitle("\(Utility.shared.TotalFilterCount) \((Utility.shared.getLanguage()?.value(forKey:"filters"))!)", for: .normal)
        filterBtn.backgroundColor = Theme.PRIMARY_COLOR
      }
      
      
    }
    if(!isFilterEnable)
    {
      actionButton.isHidden = true
      self.MostViewedListingAPICall()
    }
    
    
  }
  func APIMethodCall() {
    self.lottieAnimation()
    if(isFilterEnable)
    {
      FilterArray.removeAll()
      PageIndex = 1
      self.searchListingAPICall()
    }
    else
    {
      self.MostViewedListingAPICall()
    }
    self.scrollToBottom()
  }
  func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    print("Test")
  }
  
  //MARK:*********************************** METHODS & FUNCTIONS *****************************************>
  
  func lottieAnimation(){
    lottieView = LOTAnimationView.init(name:"animation")
    lottieView.isHidden = false
    self.lottieView.frame = CGRect(x:FULLWIDTH/2-40, y:FULLHEIGHT/2-50, width:100, height:100)
    self.view.addSubview(self.lottieView)
    self.lottieView.backgroundColor = UIColor.clear
    self.lottieView.layer.cornerRadius = 6.0
    self.lottieView.clipsToBounds = true
    self.lottieView.play()
    //  self.lottieView.isHidden = true
    Timer.scheduledTimer(timeInterval:0.5, target: self, selector: #selector(autoscroll), userInfo: nil, repeats: true)
  }
  @objc func autoscroll()
  {
    self.lottieView.play()
  }
  func initialSetup()
  {
    //Top searchView layer design
    self.offlineView.isHidden = true
    self.NoresultView.isHidden = true
    headerView.backgroundColor = UIColor.clear
    searchView.backgroundColor = UIColor.white
    searchView.frame = CGRect(x:20, y: 20, width: FULLWIDTH-40, height: 50)
    headerView.frame = CGRect(x: 0, y: 30, width: FULLWIDTH, height: 130)
    searchBtn.addTarget(self, action: #selector(searchBtnTapped), for: .touchUpInside)
    let shadowSize : CGFloat = 3.0
    let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                               y: -shadowSize / 2,
                                               width: self.searchView.frame.size.width + shadowSize,
                                               height: self.searchView.frame.size.height + shadowSize))
    
    self.searchView.layer.masksToBounds = false
    self.searchView.layer.shadowColor = TextLightColor.cgColor
    self.searchView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    self.searchView.layer.shadowOpacity = 0.3
    self.searchView.layer.shadowPath = shadowPath.cgPath
    filterView.backgroundColor = UIColor.white
    filterView.frame = CGRect(x: 0, y: 80, width:FULLWIDTH, height: 45)
    lineView.frame = CGRect(x: 0, y: 125, width: FULLWIDTH, height: 2)
    
    
    let shadowPath1 = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                y: 125,
                                                width: self.lineView.frame.size.width + shadowSize,
                                                height: self.lineView.frame.size.height + shadowSize))
    self.headerView.layer.masksToBounds = false
    self.headerView.layer.shadowColor = TextLightColor.cgColor
    self.headerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    self.headerView.layer.shadowOpacity = 0.3
    self.headerView.layer.shadowPath = shadowPath1.cgPath
    
    dateBtn.frame = CGRect(x:20, y: 5, width: 90, height: 33)
    dateBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"dates"))!)", for: .normal)
    dateBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"dates"))!)", for: .selected)
    dateBtn.setTitleColor(TextDarkColor, for: .normal)
    dateBtn.setTitleColor(TextDarkColor, for: .selected)
    dateBtn.titleLabel?.font = UIFont(name: "Circular-Medium", size: 14)
    // dateBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
    dateBtn.layer.borderColor = TextBorderColor.cgColor
    dateBtn.layer.borderWidth = 1
    dateBtn.layer.cornerRadius = 5.0
    dateBtn.addTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
    dateBtn.layer.masksToBounds = true
    
    
    guestBtn.frame = CGRect(x:(self.dateBtn.frame.origin.x+self.dateBtn.frame.size.width + 10), y: 5, width:110, height: 33)
    guestBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"guest"))!)", for: .normal)
    guestBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"guest"))!)", for: .selected)
    guestBtn.setTitleColor(TextDarkColor, for: .normal)
    guestBtn.setTitleColor(TextDarkColor, for: .selected)
    guestBtn.layer.borderColor = TextBorderColor.cgColor
    guestBtn.titleLabel?.font = UIFont(name: "Circular-Medium", size: 14)
    guestBtn.layer.borderWidth = 1
    guestBtn.layer.cornerRadius = 5.0
    guestBtn.layer.masksToBounds = true
    guestBtn.addTarget(self, action: #selector(showOccupantFilter), for: .touchUpInside)
    filterView.addSubview(dateBtn)
    filterView.addSubview(guestBtn)
    
    filterBtn.frame = CGRect(x:220, y: 5, width: 70, height: 33)
    filterBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"filter"))!)", for: .normal)
    filterBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"filter"))!)", for: .selected)
    filterBtn.setTitleColor(TextDarkColor, for: .normal)
    filterBtn.setTitleColor(TextDarkColor, for: .selected)
    filterBtn.layer.borderColor = TextBorderColor.cgColor
    filterBtn.titleLabel?.font = UIFont(name: "Circular-Medium", size: 14)
    filterBtn.layer.borderWidth = 1
    filterBtn.layer.cornerRadius = 5.0
    filterBtn.layer.masksToBounds = true
    filterBtn.addTarget(self, action: #selector(moreFilter), for: .touchUpInside)
    filterView.addSubview(filterBtn)
    filterBtn.isHidden = true
    if(IS_IPHONE_XR || IS_IPHONE_X)
    {
      exploreTV.frame = CGRect(x: 0, y: headerView.frame.size.height+headerView.frame.origin.y+5, width: FULLWIDTH, height:FULLHEIGHT-400)
    }
    else if(IS_IPHONE_PLUS)
    {
      exploreTV.frame = CGRect(x: 0, y: headerView.frame.size.height+headerView.frame.origin.y+5, width: FULLWIDTH, height:FULLHEIGHT-230)
    }
    else if(IS_IPHONE_XS_MAX)
    {
      exploreTV.frame = CGRect(x: 0, y: headerView.frame.size.height+headerView.frame.origin.y+5, width: FULLWIDTH, height:FULLHEIGHT-400)
    }
    else if (IS_IPHONE_5)
    {
      exploreTV.frame = CGRect(x: 0, y: headerView.frame.size.height+headerView.frame.origin.y+5, width: FULLWIDTH+55, height:FULLHEIGHT-110)
    }
    
    else
    {
      exploreTV.frame = CGRect(x: 0, y: headerView.frame.size.height+headerView.frame.origin.y+5, width: FULLWIDTH, height:FULLHEIGHT-160)
    }
    exploreTV.register(UINib(nibName: "ExploreCell", bundle: nil), forCellReuseIdentifier: "ExploreCell")
    explorecollectionView?.register(UINib(nibName: "ExploreCollectionFilterCell", bundle: nil), forCellWithReuseIdentifier: "ExploreCollectionFilterCell")
    explorecollectionView?.register(UINib(nibName: "popularcollectionCell", bundle: nil), forCellWithReuseIdentifier: "popularcollectionCell")
    explorecollectionView?.register(UINib(nibName: "ExploreCollectioncell", bundle: nil), forCellWithReuseIdentifier: "ExploreCollectioncell")
    //self.exploreTV.isHidden = true
    NoViewNoresult.text = "\((Utility.shared.getLanguage()?.value(forKey:"noresults"))!)"
    noViewFirstText.text = "\((Utility.shared.getLanguage()?.value(forKey:"tryadjustingsearch"))!)"
    noViewSecondText.text = "\((Utility.shared.getLanguage()?.value(forKey:"changefiltersdates"))!)"
    NoViewthirdText.text = "\((Utility.shared.getLanguage()?.value(forKey:"specificaddresscity"))!)"
    
    error_label.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
    
    retry_button.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
  }
  @objc func moreFilter()
  {
    let morefilterObj = MoreFilterVC()
    morefilterObj.RoomsFilterArray = RoomsFilterArray
    morefilterObj.getsearchPriceArray = getsearchPriceArray
    Utility.shared.isfromfloatmap_Page = false
    morefilterObj.modalPresentationStyle = .fullScreen
    self.present(morefilterObj, animated: true, completion: nil)
    //self.navigationController?.pushViewController(loginObj, animated: true)
    
  }
  
  
  //config floating chat new btn
  func configFloatingBtn()  {
    
    if IS_IPHONE_XR || IS_IPHONE_X {
      actionButton.frame = CGRect.init(x: FULLWIDTH-75, y: FULLHEIGHT-190, width: 55, height: 55)
    }
    else{
      actionButton.frame = CGRect.init(x: FULLWIDTH-75, y: FULLHEIGHT-140, width: 55, height: 55)
    }
    actionButton.layer.cornerRadius = actionButton.frame.size.height / 2
    actionButton.buttonColor = UIColor.white
    actionButton.buttonImage = #imageLiteral(resourceName: "maps_location")
    actionButton.addTarget(self, action: #selector(mapFloat), for: .touchUpInside)
    self.view.addSubview(actionButton)
  }
  @objc func mapFloat()
  {
    let mapFloatObj = FloatMapVC()
    if(FilterArray.count > 0)
    {
      mapFloatObj.getsearchPriceArray = getsearchPriceArray
      mapFloatObj.RoomsFilterArray = RoomsFilterArray
      mapFloatObj.currencyvalue_from_API_base = Utility.shared.currencyvalue_from_API_base
      mapFloatObj.currency_Dict = Utility.shared.currency_Dict
      mapFloatObj.FloatSearchArray = FilterArray
      mapFloatObj.modalPresentationStyle = .fullScreen
      self.view.window?.rootViewController?.present(mapFloatObj, animated: true, completion: nil)
    }
    //self.present(mapFloatObj, animated: true, completion: nil)
  }
  
  @IBAction func searchBackBtnTapped(_ sender: Any) {
    self.lottieAnimation()
    
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
    actionButton.isHidden = true
    selectedStartDate = nil
    selectedEndDate = nil
    adultCount = 1
    Utility.shared.isfromsearchLocationFilter = false
    AirbnbDatePickerViewController().handleClearInput()
    Utility.shared.TotalFilterCount = 0
    self.NoresultView.isHidden = true
    guest_filter = 0
    PageIndex = 1
    Utility.shared.selectedstartDate_filter = ""
    Utility.shared.selectedEndDate_filter = ""
    Utility.shared.isSwitchEnable = false
    locationLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"losangeles"))!)"
    searchBackBtn.setImage(#imageLiteral(resourceName: "Magnyfy_glass"), for: .normal)
    Utility.shared.locationfromSearch = ""
    dateBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"dates"))!)", for: .normal)
    dateBtn.setTitleColor(TextDarkColor, for: .normal)
    dateBtn.backgroundColor = UIColor.white
    dateBtn.frame = CGRect(x:20, y: 5, width:90, height: 33)
    guestBtn.frame = CGRect(x: (self.dateBtn.frame.origin.x+self.dateBtn.frame.size.width + 10), y: 5, width:110, height: 33)
    guestBtn.setTitleColor(TextDarkColor, for: .normal)
    guestBtn.backgroundColor = UIColor.white
    guestBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"guest"))!)", for: .normal)
    self.exploreTV.isHidden = false
    isFilterEnable = false
    filterBtn.isHidden = true
    self.lottieView.isHidden = true
    if(Utility.shared.searchLocationDict.count > 0)
    {
      Utility.shared.searchLocationDict.setValue(nil, forKey: "lat")
      Utility.shared.searchLocationDict.setValue(nil, forKey: "lon")
    }
    
    filterBtn.backgroundColor = UIColor.white
    filterBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"filter"))!)", for: .normal)
    filterBtn.setTitleColor(TextDarkColor, for: .normal)
    
    self.MostViewedListingAPICall()
    //self.exploreTV.reloadData()
  }
  
  @objc func searchBtnTapped(_ sender: UIButton!) {
    
    
    let pageObj = SearchPageVC()
    PageIndex = 1
    Utility.shared.isfromExplorePage = true
    pageObj.modalPresentationStyle = .fullScreen
    self.present(pageObj, animated: true, completion: nil)
    
    
  }
  @IBAction func retyBtnTapped(_ sender: Any) {
    if Utility().isConnectedToNetwork(){
      
      if guest_filter != 0 || Utility.shared.selectedEndDate_filter != "" || Utility.shared.selectedstartDate_filter != "" || isFilterEnable == true{
        offlineView.isHidden = true
        searchListingAPICall()
      }else{
        offlineView.isHidden = true
        self.exploreTV.isHidden = false
        isFilterEnable = false
        self.MostViewedListingAPICall()
      }
      
      
    }
  }
  
  @objc func dateBtnTapped()
  {
    let input = AirbnbDatePicker()
    AirbnbDatePickerViewController().handleClearInput()
    input.translatesAutoresizingMaskIntoConstraints = false
    input.dateInputButton.backgroundColor = Theme.INPUT_COLOR
    input.delegate = self
    //        input.delegate = self.delegate
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
extension ExplorePageVC:UITableViewDataSource,UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if(!isFilterEnable){
      
      if(homeImageArray.count>0 || mosthomeImageArray.count>0 || populardestinationArray.count > 0){
        return 3
      }
      return 0
    }
    else if(isFilterEnable){
      if(FilterArray.count>0){
        return 1
      }
      
    }
    return 0
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
    let contentview = UIView()
    //  contentview.frame = CGRect(x: 0, y: 0, width:FULLWIDTH, height: 180)
    
    contentview.backgroundColor = UIColor.white
    
    if((indexPath.row==0)) {
      if(isFilterEnable){
        contentview.frame = CGRect(x: 0, y: 0, width: Int(FULLWIDTH), height:((405 * (FilterArray.count))))
        contentview.clipsToBounds = true
      }
      else{
        contentview.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height:220)
      }
      contentview.backgroundColor = UIColor.white
      let titleLabel = UILabel()
      if(!isFilterEnable)
      {
        
        titleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"populardest"))!)"
      }
      else
      {
        titleLabel.text = ""
      }
      titleLabel.frame = CGRect(x:15, y: 5, width: FULLWIDTH-40, height:30)
      titleLabel.tintColor = UIColor.black
      titleLabel.textColor = UIColor.black
      titleLabel.font = UIFont(name: "Circular-Medium", size: 22)
      contentview.addSubview(titleLabel)
      
      let layout = UICollectionViewFlowLayout()
      if(isFilterEnable){
        explorecollectionView = UICollectionView(frame: CGRect(x:20, y:0, width: Int(FULLWIDTH-40), height: ((405 * (FilterArray.count)))), collectionViewLayout: layout)
      }
      else
      {
        explorecollectionView = UICollectionView(frame: CGRect(x:15, y:50, width: FULLWIDTH-30, height:150), collectionViewLayout: layout)
      }
      
      explorecollectionView?.tag = 0
      layout.scrollDirection = .horizontal
      layout.minimumLineSpacing = 10.0
      layout.minimumInteritemSpacing = 10.0
      explorecollectionView?.dataSource = self
      explorecollectionView?.delegate = self
      
      explorecollectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellIdentifier")
      explorecollectionView?.backgroundColor = UIColor.white
      explorecollectionView?.showsHorizontalScrollIndicator = false
      if let aView = explorecollectionView {
        contentview.addSubview(aView)
      }
      if(isFilterEnable){
        explorecollectionView?.register(UINib(nibName: "ExploreCollectionFilterCell", bundle: nil), forCellWithReuseIdentifier: "ExploreCollectionFilterCell")
        
      }
      else{
        explorecollectionView?.register(UINib(nibName: "popularcollectionCell", bundle: nil), forCellWithReuseIdentifier: "popularcollectionCell")
      }
      
      
      self.explorecollectionView?.reloadData()
      cell?.contentView.addSubview(contentview)
      return cell!
    }
    
    else if((indexPath.row==1)) {
      if(isFilterEnable){
        contentview.frame = CGRect(x: 0, y: 0, width: Int(FULLWIDTH), height:((405 * (FilterArray.count))))
        contentview.clipsToBounds = true
      }
      else{
        if(homeImageArray.count % 2 == 0){
          contentview.frame = CGRect(x: 0, y: 0, width: Int(FULLWIDTH), height:(220 * (homeImageArray.count/2))+50)
        }
        else{
          contentview.frame = CGRect(x: 0, y: 0, width: Int(FULLWIDTH), height:((220 * (homeImageArray.count/2))+280))
        }
      }
      contentview.backgroundColor = UIColor.white
      let titleLabel = UILabel()
      
      if(homeImageArray.count>0 && !isFilterEnable)
      {
        titleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"recommended"))!)"
      }
      else
      {
        titleLabel.text = ""
      }
      //titleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"recommended"))!)"
      titleLabel.font = UIFont(name: "Circular-Medium", size: 22)
      titleLabel.frame = CGRect(x:20, y: 0, width: FULLWIDTH - 40, height: 40)
      //titleLabel.textColor = UIColor(red: 111.0/255.0, green: 113.0/255.0, blue: 121.0/255.0, alpha: 1.0)
      contentview.addSubview(titleLabel)
      
      
      let layout = UICollectionViewFlowLayout()
      if(isFilterEnable){
        explorecollectionView = UICollectionView(frame: CGRect(x:20, y:0, width: Int(FULLWIDTH-40), height: ((405 * (FilterArray.count)))), collectionViewLayout: layout)
      }
      else{
        if(homeImageArray.count % 2 == 0){
          explorecollectionView = UICollectionView(frame: CGRect(x:20, y:50, width: Int(FULLWIDTH-40), height:((220 * (homeImageArray.count/2)))), collectionViewLayout: layout)
        }
        else{
          explorecollectionView = UICollectionView(frame: CGRect(x:20, y: 50, width: Int(FULLWIDTH-40), height:((220 * (homeImageArray.count/2))+220)), collectionViewLayout: layout)
        }
      }
      explorecollectionView?.tag = 1
      explorecollectionView?.isScrollEnabled = false
      
      // layout.scrollDirection = .vertical
      explorecollectionView?.dataSource = self
      explorecollectionView?.delegate = self
      explorecollectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellIdentifier")
      explorecollectionView?.backgroundColor = UIColor.white
      if let aView = explorecollectionView {
        contentview.addSubview(aView)
      }
      if(isFilterEnable){
        explorecollectionView?.register(UINib(nibName: "ExploreCollectionFilterCell", bundle: nil), forCellWithReuseIdentifier: "ExploreCollectionFilterCell")
        
      }
      else{
        explorecollectionView?.register(UINib(nibName: "ExploreCollectioncell", bundle: nil), forCellWithReuseIdentifier: "ExploreCollectioncell")
      }
      //   DispatchQueue.main.async {
      self.explorecollectionView?.reloadData()
      //    }
      
      cell?.contentView.addSubview(contentview)
      cell?.contentView.layer.cornerRadius = 5.0
      cell?.contentView.clipsToBounds = true
      
      return cell!
    }
    else{
      if(isFilterEnable){
        contentview.frame = CGRect(x: 0, y: 0, width: Int(FULLWIDTH), height:((405 * (FilterArray.count))))
        
      }
      else{
        if(mosthomeImageArray.count % 2 == 0){
          contentview.frame = CGRect(x: 0, y: 0, width: Int(FULLWIDTH), height: ((220 * (mosthomeImageArray.count/2))+50))
        }
        else{
          contentview.frame = CGRect(x: 0, y: 0, width: Int(FULLWIDTH), height:((220 * (mosthomeImageArray.count/2))+270))
        }
      }
      contentview.backgroundColor = UIColor.white
      let titleLabel = UILabel()
      if(mosthomeImageArray.count > 0 && !isFilterEnable)
      {
        titleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"mostviewed"))!)"
      }
      else
      {
        titleLabel.text = ""
      }
      titleLabel.frame = CGRect(x:20, y: 0, width: FULLWIDTH - 40, height: 40)
      titleLabel.tintColor = UIColor.black
      titleLabel.textColor = UIColor.black
      titleLabel.font = UIFont(name: "Circular-Medium", size: 22)
      contentview.addSubview(titleLabel)
      
      
      let layout = UICollectionViewFlowLayout()
      if(isFilterEnable){
        explorecollectionView = UICollectionView(frame: CGRect(x:20, y:0, width: Int(FULLWIDTH-40), height: (405 * (FilterArray.count))), collectionViewLayout: layout)
      }
      else{
        if(mosthomeImageArray.count % 2 == 0){
          explorecollectionView = UICollectionView(frame: CGRect(x:20, y:50, width: Int(FULLWIDTH-40), height: (220 * (mosthomeImageArray.count/2))), collectionViewLayout: layout)
        }
        else{
          explorecollectionView = UICollectionView(frame: CGRect(x:20, y:50, width: Int(FULLWIDTH-40), height:((220 * (mosthomeImageArray.count/2))+220)), collectionViewLayout: layout)
        }
      }
      explorecollectionView?.tag = 2
      explorecollectionView?.isScrollEnabled = false
      //explorecollectionView?.isScrollEnabled = true
      //layout.scrollDirection = .vertical
      explorecollectionView?.dataSource = self
      explorecollectionView?.delegate = self
      explorecollectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellIdentifier")
      explorecollectionView?.backgroundColor = UIColor.white
      if let aView = explorecollectionView {
        contentview.addSubview(aView)
      }
      if(isFilterEnable){
        explorecollectionView?.register(UINib(nibName: "ExploreCollectionFilterCell", bundle: nil), forCellWithReuseIdentifier: "ExploreCollectionFilterCell")
        
      }
      else{
        explorecollectionView?.register(UINib(nibName: "ExploreCollectioncell", bundle: nil), forCellWithReuseIdentifier: "ExploreCollectioncell")
      }
      //DispatchQueue.main.async {
      self.explorecollectionView?.reloadData()
      //   }
      
      cell?.contentView.addSubview(contentview)
      cell?.contentView.layer.cornerRadius = 5.0
      cell?.contentView.clipsToBounds = true
      return cell!
    }
    
    
    
  }
  
  func numberOfSections(in tableView: UITableView) -> Int{
    return 1
  }
  @objc(collectionView:didSelectItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if(isFilterEnable && collectionView.tag != 0 && FilterArray.count > 0)
    {
      let guestdetailObj = GuestDetailVC()
      
      Utility.shared.unpublish_preview_check = false
      guestdetailObj.listID = FilterArray[indexPath.row].id!
      guestdetailObj.currencyvalue_from_API_base = Utility.shared.currencyvalue_from_API_base
      guestdetailObj.currency_Dict = Utility.shared.currency_Dict
      //guestdetailObj.checkApolloStatus()
      
      guestdetailObj.modalPresentationStyle = .fullScreen
      
      self.present(guestdetailObj, animated: true, completion: nil)
    }
    else {
      if(collectionView.tag == 0)
      {
        
        Utility.shared.locationfromSearch = populardestinationArray[indexPath.row].locationAddress!
        locationLabel.text = Utility.shared.locationfromSearch
        isFilterEnable = true
        self.searchBackBtn.setImage(#imageLiteral(resourceName: "back_black"), for: .normal)
        self.searchListingAPICall()
      }
      else if(collectionView.tag == 1)
      {
        let guestdetailObj = GuestDetailVC()
        Utility.shared.unpublish_preview_check = false
        guestdetailObj.listID = recommendListingArray[indexPath.row].id!
        guestdetailObj.currencyvalue_from_API_base = Utility.shared.currencyvalue_from_API_base
        guestdetailObj.currency_Dict = Utility.shared.currency_Dict
        guestdetailObj.modalPresentationStyle = .fullScreen
        if let imageCell = collectionView.cellForItem(at: indexPath) as? ExploreCollectioncell {
          imageCell.contentView.backgroundColor = UIColor.white
          guestdetailObj.cc_setZoomTransition(originalView:imageCell.contentView)
        }
        self.present(guestdetailObj, animated: true, completion: nil)
      }
      else{
        let guestdetailObj = GuestDetailVC()
        Utility.shared.unpublish_preview_check = false
        guestdetailObj.listID = mostListingArray[indexPath.row].id!
        guestdetailObj.currencyvalue_from_API_base = Utility.shared.currencyvalue_from_API_base
        guestdetailObj.currency_Dict = Utility.shared.currency_Dict
        guestdetailObj.modalPresentationStyle = .fullScreen
        if let imageCell = collectionView.cellForItem(at: indexPath) as? ExploreCollectioncell {
          imageCell.contentView.backgroundColor = UIColor.white
          guestdetailObj.cc_setZoomTransition(originalView:imageCell.contentView)
        }
        self.present(guestdetailObj, animated: true, completion: nil)
      }
    }
    
    
  }
  
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
  {
    if(!isFilterEnable){
      if(indexPath.row==0){
        if(populardestinationArray.count == 0)
        {
          return 0
        }
        else
        {
          return 150+60
        }
      }
      else if(indexPath.row==1){
        if(homeImageArray.count % 2 == 0){
          if(homeImageArray.count == 0){
            return 0
          }
          return (CGFloat(220 * (homeImageArray.count/2))+50)
        }
        return (CGFloat((220 * (homeImageArray.count/2))+280))
      }
      else if(indexPath.row == 2)
      {
        if(mosthomeImageArray.count % 2 == 0){
          return (CGFloat((220 * (mosthomeImageArray.count/2))+50))
        }
        return (CGFloat((220 * (mosthomeImageArray.count/2))+300))
      }
      
    }
    if(FilterArray.count > 0){
      //        if(FilterArray[indexPath.row].title!.count <= 29)
      //        {
      //            return ((CGFloat(395 * (FilterArray.count)))+430)
      //
      //        }
      
      return ((CGFloat(405 * (FilterArray.count))+130))
      //  return UITableView.automaticDimension
    }
    return 0
  }
  override func viewDidAppear(_ animated: Bool) {
    //        self.viewDidLayoutSubviews()
    DispatchQueue.main.async {
      self.scrollToBottom()
    }
  }
  override func viewDidLayoutSubviews() {
    self.view.clipsToBounds = true
    
    self.scrollToBottom()
  }
  @objc func scrollToBottom() {
    if self.FilterArray.count != 0 && isFilterEnable == true {
      isFilterEnable = true
      let indexPath = IndexPath(row:0,section:0)
      self.exploreTV.scrollToRow(at: indexPath, at: .top, animated: false)
      
    }
    else if (self.FilterArray.count != 0 && isFilterEnable != true)
    {
      isFilterEnable = false
      //DispatchQueue.main.async {
      let indexPath = IndexPath(row:0,section: 0)
      self.exploreTV.scrollToRow(at: indexPath, at: .top, animated: false)
    }
  }
  
  
  //MARK****************************************COLLECTIONVIEW DELEGATE & DATASOURCE METHODS *********************************************>
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if(!isFilterEnable){
      if(homeImageArray.count>0 || mosthomeImageArray.count>0){
        if(collectionView.tag == 0){
          return populardestinationArray.count
        }
        else if(collectionView.tag == 1){
          return homeImageArray.count
        }
        else if(collectionView.tag == 2){
          return mosthomeImageArray.count
        }
      }
      return 0
    }
    else {
      if(FilterArray.count>0){
        return FilterArray.count
      }
      return 0
    }
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if(!isFilterEnable){
      
      if(collectionView.tag == 0){
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularcollectionCell", for: indexPath)as! popularcollectionCell
        let listimage = populardestinationArray[indexPath.row].image!
        cell.contentView.backgroundColor = .white
        cell.backgroundColor = .white
        cell.popularImage.frame = CGRect(x: 0, y: 0, width:150, height: 150)
        cell.popularLabel.frame = CGRect(x:0, y: 90, width: 150, height: 60)
        cell.shadowView.frame = CGRect(x:0, y:0, width: 150, height: 150)
        //
        cell.popularImage.sd_setImage(with: URL(string: "\(POPULAR_LOCATION_IMAGE)\(listimage)"), placeholderImage: #imageLiteral(resourceName: "ItemTransparentImg"))
        cell.popularLabel.text = "\(populardestinationArray[indexPath.row].location!)"
        cell.popularLabel.textAlignment = .center
        cell.popularImage.layer.cornerRadius = 8.0
        cell.popularImage.layer.masksToBounds = true
        cell.shadowView.layer.cornerRadius = 8.0
        cell.shadowView.layer.masksToBounds = true
        
        
        return cell
      }
      else if(collectionView.tag == 1){
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreCollectioncell", for: indexPath)as! ExploreCollectioncell
        if(recommendListingArray[indexPath.row].roomType != nil)
        {
          cell.entirehomeLabel.text = recommendListingArray[indexPath.row].roomType!
        }
        cell.entirehomeLabel.sizeToFit()
        let listimage = homeImageArray[indexPath.row]
        cell.homeImage.sd_setImage(with: URL(string: "\(IMAGE_LISTING_MEDIUM)\(listimage)"), placeholderImage: #imageLiteral(resourceName: "ItemTransparentImg"))
        cell.titleLabel.text = (homeTitleArray[indexPath.row] as? String)!.condensingWhitespace()
        if(Utility.shared.getPreferredCurrency() != nil &&  Utility.shared.getPreferredCurrency() != "")
        {
          let currencysymbol = Utility.shared.getSymbol(forCurrencyCode: Utility.shared.getPreferredCurrency()!)
          let from_currency = self.recommendListingArray[indexPath.row].listingData?.currency
          let currency_amount = self.recommendListingArray[indexPath.row].listingData?.basePrice
          let price_value = self.getCurrencyRate(basecurrency:currencyvalue_from_API.base!, fromCurrency:from_currency!, toCurrency:Utility.shared.getPreferredCurrency()!, CurrencyRate: self.currency_Dict, amount:currency_amount!)
          let restricted_price =  Double(String(format: "%.2f",price_value))
          cell.priceLabel.text =  "\(currencysymbol!)\(restricted_price!.clean) \((Utility.shared.getLanguage()?.value(forKey:"pernight"))!)"
        }
        else
        {
          let currencysymbol = Utility.shared.getSymbol(forCurrencyCode:self.currencyvalue_from_API.base!)
          let from_currency = self.recommendListingArray[indexPath.row].listingData?.currency
          let currency_amount = self.recommendListingArray[indexPath.row].listingData?.basePrice
          let price_value = self.getCurrencyRate(basecurrency:currencyvalue_from_API.base!, fromCurrency:from_currency!, toCurrency:self.currencyvalue_from_API.base!, CurrencyRate: self.currency_Dict, amount:currency_amount!)
          let restricted_price =  Double(String(format: "%.2f",price_value))
          cell.priceLabel.text = "\(currencysymbol!)\(restricted_price!.clean) \((Utility.shared.getLanguage()?.value(forKey:"pernight"))!)"
        }
        let shadowSize : CGFloat = 3.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: cell.frame.size.width + shadowSize,
                                                   height: cell.frame.size.height + shadowSize))
        cell.homeImage.layer.cornerRadius = 4.0
        cell.homeImage.clipsToBounds = true
        
        if((cell.titleLabel.text!.count) <= 19){
          
          cell.titleLabel.frame = CGRect(x: 0, y: 120, width: (FULLWIDTH - 25), height:30)
          cell.priceLabel.frame = CGRect(x: 0, y: 145, width: (FULLWIDTH - 25), height:20)
          cell.ratingView.frame = CGRect(x: 0, y: 170, width: 60, height:12)
          
        }
        //Review Count
        let value1 = Double("\(reviewcount_Array[indexPath.row])")
        let value2 = Double("\(reviewStart_ratingArray[indexPath.row])")
        if(value2 != nil){
          let reviewcount = Int(value2!/value1!)
          cell.ratingView.rating = Double(reviewcount)
          cell.countLabel.isHidden = false
          cell.countLabel.frame = CGRect(x: cell.ratingView.frame.origin.x+cell.ratingView.frame.size.width+5, y:cell.ratingView.frame.origin.y, width: 12, height: 12)
          
          cell.countLabel.text = "\(reviewcount_Array[indexPath.row])"
        }
        else{
          cell.ratingView.rating = 0
          cell.countLabel.isHidden = true
          
        }
        
        cell.thunderImage.isHidden = true
        if("\(bookingTypeArray[indexPath.row])" == "instant")
        {
          cell.thunderImage.frame = CGRect(x:cell.entirehomeLabel.frame.origin.x+cell.entirehomeLabel.frame.width, y:108, width:15, height: 12)
          cell.thunderImage.isHidden = false
          
        }
        else{
          cell.thunderImage.isHidden = true
        }
        
        //FOR REASON OF HIDING WHISHLIST
        if((recommendListingArray[indexPath.row].isListOwner!) == false)
        {
          if("\(wishlistArray[indexPath.row])" == "0"){
            cell.likeBtn.setImage(#imageLiteral(resourceName: "Heart"), for: .normal)
          }
          else{
            cell.likeBtn.setImage(#imageLiteral(resourceName: "like"), for: .normal)
          }
          cell.likeBtn.tag = indexPath.row
          cell.likeBtn.addTarget(self, action: #selector(likeBtnTapped), for: .touchUpInside)
        }
        else
        {
          cell.likeBtn.isHidden = true
        }
        
        return cell
      }
      else{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreCollectioncell", for: indexPath)as! ExploreCollectioncell
        if(mostListingArray[indexPath.row].roomType != nil)
        {
          cell.entirehomeLabel.text = mostListingArray[indexPath.row].roomType!
        }
        
        cell.entirehomeLabel.sizeToFit()
        cell.homeImage.sd_setImage(with: URL(string: "\(IMAGE_LISTING_MEDIUM)\(mosthomeImageArray[indexPath.row])"),placeholderImage: #imageLiteral(resourceName: "ItemTransparentImg"))
        
        cell.titleLabel.text = "\(mostListingArray[indexPath.row].title!)"
        
        if(Utility.shared.getPreferredCurrency() != nil &&  Utility.shared.getPreferredCurrency() != "")
        {
          let currencysymbol = Utility.shared.getSymbol(forCurrencyCode: Utility.shared.getPreferredCurrency()!)
          let from_currency = self.mostListingArray[indexPath.row].listingData?.currency
          let currency_amount = self.mostListingArray[indexPath.row].listingData?.basePrice
          let price_value = self.getCurrencyRate(basecurrency:currencyvalue_from_API.base!, fromCurrency:from_currency!, toCurrency:Utility.shared.getPreferredCurrency()!, CurrencyRate: self.currency_Dict, amount:currency_amount!)
          let restricted_price =  Double(String(format: "%.2f",price_value))
          cell.priceLabel.text = "\(currencysymbol!)\(restricted_price!.clean) \((Utility.shared.getLanguage()?.value(forKey:"pernight"))!)"
        }
        else
        {
          let currencysymbol = Utility.shared.getSymbol(forCurrencyCode:self.currencyvalue_from_API.base!)
          let from_currency = self.mostListingArray[indexPath.row].listingData?.currency
          let currency_amount = self.mostListingArray[indexPath.row].listingData?.basePrice
          let price_value = self.getCurrencyRate(basecurrency:currencyvalue_from_API.base!, fromCurrency:from_currency!, toCurrency:self.currencyvalue_from_API.base!, CurrencyRate: self.currency_Dict, amount:currency_amount!)
          let restricted_price =  Double(String(format: "%.2f",price_value))
          cell.priceLabel.text = "\(currencysymbol!)\(restricted_price!.clean) \((Utility.shared.getLanguage()?.value(forKey:"pernight"))!)"
        }
        let shadowSize : CGFloat = 3.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: cell.frame.size.width + shadowSize,
                                                   height: cell.frame.size.height + shadowSize))
        cell.homeImage.layer.cornerRadius = 4.0
        cell.homeImage.clipsToBounds = true
        
        if((cell.titleLabel.text!.count) <= 19){
          
          cell.titleLabel.frame = CGRect(x: 0, y: 120, width: cell.titleLabel.frame.size.width+5, height:30)
          cell.priceLabel.frame = CGRect(x: 0, y: 145, width: (FULLWIDTH - 25), height:20)
          cell.ratingView.frame = CGRect(x: 0, y: 170, width: 60, height:12)
          
        }
        let value1 = Double("\(mostreviewcount_Array[indexPath.row])")
        let value2 = Double("\(mostreviewStart_ratingArray[indexPath.row])")
        if(value2 != nil){
          let reviewcount = Int(value2!/value1!)
          cell.ratingView.rating = Double(reviewcount)
          cell.countLabel.isHidden = false
          cell.countLabel.frame = CGRect(x: cell.ratingView.frame.origin.x+cell.ratingView.frame.size.width+5, y: cell.ratingView.frame.origin.y, width: 12, height: 12)
          cell.countLabel.text = "\(mostreviewcount_Array[indexPath.row])"
        }
        else{
          cell.ratingView.rating = 0
          cell.countLabel.isHidden = true
        }
        
        if("\(mostbookingTypeArray[indexPath.row])" == "instant")
        {
          cell.thunderImage.frame = CGRect(x:cell.entirehomeLabel.frame.origin.x+cell.entirehomeLabel.frame.width, y:108, width:15, height: 12)
          cell.thunderImage.isHidden = false
        }
        else{
          cell.thunderImage.isHidden = true
          
        }
        if((mostListingArray[indexPath.row].isListOwner!) == false)
        {
          cell.likeBtn.tag = indexPath.row
          cell.likeBtn.addTarget(self, action: #selector(most_likeBtnTapped), for: .touchUpInside)
          //FOR REASON OF HIDING WHISHLIST
          if(mostListingArray[indexPath.row].wishListStatus! == false){
            cell.likeBtn.setImage(#imageLiteral(resourceName: "Heart"), for: .normal)
          }
          else{
            cell.likeBtn.setImage(#imageLiteral(resourceName: "like"), for: .normal)
          }
        }
        else
        {
          cell.likeBtn.isHidden = true
        }
        cell.layer.cornerRadius = 4.0
        cell.layer.masksToBounds = true
        cell.clipsToBounds = true
        return cell
      }
    }
    
    else
    {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreCollectionFilterCell", for: indexPath)as! ExploreCollectionFilterCell
      if(FilterArray[indexPath.row].roomType != nil)
      {
        cell.entirehomeLabel.text = FilterArray[indexPath.row].roomType!
      }
      let array = FilterArray[indexPath.row].listingPhotos
      
      self.filteredImageArray.removeAllObjects()
      
      for j in array!
      {
        
        self.filteredImageArray.add("\(IMAGE_LISTING_MEDIUM)\(j?.name ?? "0")" as Any)
        
        
      }
      cell.imageScroller.isAutoScrollEnabled = false
      cell.imageScroller.scrollTimeInterval = 2.0 //time interval
      cell.imageScroller.scrollView.bounces = false
      
      cell.imageScroller.frame = CGRect(x:0, y: 0, width: cell.frame.width, height: 230)
      if(self.filteredImageArray != nil) {
        cell.imageScroller.setupScrollerWithImages(images:self.filteredImageArray as! [String])
        cell.Pagecontrol.frame = CGRect(x: cell.imageScroller.frame.size.width/2-100, y:200, width: 200, height: 30)
        cell.Pagecontrol.numberOfPages = self.filteredImageArray.count
        cell.Pagecontrol.radius = 4
        cell.Pagecontrol.padding = 6
        cell.Pagecontrol.inactiveTintColor = TextBorderColor
        cell.Pagecontrol.currentPageTintColor = Theme.PRIMARY_COLOR
        cell.Pagecontrol.tag = indexPath.item
        
        cell.imageScroller.tag = indexPath.row
        cell.imageScroller.addSubview(cell.Pagecontrol)
      }
      cell.imageScroller.frame = CGRect(x: 2, y: 0, width: cell.frame.width-4, height: 230)
      cell.imageScroller.layer.cornerRadius = 5.0
      cell.imageScroller.layer.masksToBounds = true
      cell.imageScroller.clipsToBounds = true
      
      cell.tag = indexPath.row + 2000
      let tap = UITapGestureRecognizer(target: self, action: #selector(imageScrollerTapped))
      tap.numberOfTapsRequired = 1
      tap.view?.tag = indexPath.row
      cell.imageScroller.addGestureRecognizer(tap)
      
      if("\(FilterArray[indexPath.row].bookingType!)" == "instant")
      {
        cell.instantImg.isHidden = false
      }
      else{
        cell.instantImg.isHidden = true
      }
      
      // cell.homeImage.image = UIImage(named: "\(homeImageArray[indexPath.row]).png")
      let title = (FilterArray[indexPath.row]).title
      cell.titleLabel.text = ("\(String(describing: title!))").condensingWhitespace()
      cell.entirehomeLabel.sizeToFit()
      let currencycode = FilterArray[indexPath.row].listingData?.currency
      
      
      if(Utility.shared.getPreferredCurrency() != nil &&  Utility.shared.getPreferredCurrency() != "")
      {
        let currencysymbol = Utility.shared.getSymbol(forCurrencyCode: Utility.shared.getPreferredCurrency()!)
        let from_currency = self.FilterArray[indexPath.row].listingData?.currency
        let currency_amount = self.FilterArray[indexPath.row].listingData?.basePrice
        if(Utility.shared.currencyvalue_from_API_base != nil)
        {
          let price_value = self.getCurrencyRate(basecurrency:Utility.shared.currencyvalue_from_API_base, fromCurrency:from_currency!, toCurrency:Utility.shared.getPreferredCurrency()!, CurrencyRate:Utility.shared.currency_Dict, amount:currency_amount!)
          let restricted_price =  Double(String(format: "%.2f",price_value))
          cell.priceLabel.text = "\(currencysymbol!)\(restricted_price!.clean) \((Utility.shared.getLanguage()?.value(forKey:"pernight"))!)"
        }
      }
      else
      {
        let currencysymbol = Utility.shared.getSymbol(forCurrencyCode:Utility.shared.currencyvalue_from_API_base)
        let from_currency = self.FilterArray[indexPath.row].listingData?.currency
        let currency_amount = self.FilterArray[indexPath.row].listingData?.basePrice
        let price_value = self.getCurrencyRate(basecurrency:Utility.shared.currencyvalue_from_API_base, fromCurrency:from_currency!, toCurrency:Utility.shared.currencyvalue_from_API_base, CurrencyRate:Utility.shared.currency_Dict, amount:currency_amount!)
        let restricted_price =  Double(String(format: "%.2f",price_value))
        cell.priceLabel.text = "\(currencysymbol!)\(restricted_price!.clean) \((Utility.shared.getLanguage()?.value(forKey:"pernight"))!)"
      }
      let shadowSize : CGFloat = 3.0
      let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                 y: -shadowSize / 2,
                                                 width: cell.frame.size.width + shadowSize,
                                                 height: cell.frame.size.height + shadowSize))
      
      cell.likeBtn.frame = CGRect(x: FULLWIDTH-80, y: 10, width: 30, height: 30)
      //FOR REASON OF HIDING WHISHLIST
      
      
      if(cell.titleLabel.text!.count <= 29){
        
        cell.titleLabel.frame = CGRect(x: 0, y: 254, width: (cell.frame.size.width - 10), height:35)
        cell.priceLabel.frame = CGRect(x: 0, y: 290, width: (cell.frame.size.width - 10), height:20)
        cell.ratingView.frame = CGRect(x: 0, y: 315, width: 70, height:18)
        cell.countLabel.frame = CGRect(x:72, y: 317, width: 12, height:12)
      }
      else
      {
        cell.titleLabel.frame = CGRect(x: 0, y: 259, width: (cell.frame.size.width - 10), height:70)
        cell.priceLabel.frame = CGRect(x: 0, y: 330, width: (cell.frame.size.width - 10), height:20)
        cell.ratingView.frame = CGRect(x: 0, y: 357, width: 70, height:18)
        cell.countLabel.frame = CGRect(x:72, y: 359, width: 12, height:12)
      }
      //Review Count
      let value1 = (FilterArray[indexPath.row].reviewsCount)
      let value2 = (FilterArray[indexPath.row].reviewsStarRating)
      if(value2 != nil){
        let reviewcount = (value2!/value1!)
        cell.ratingView.rating = Double(reviewcount)
        cell.countLabel.isHidden = false
        // cell.countLabel.frame = CGRect(x: cell.ratingView.frame.origin.x+cell.ratingView.frame.size.width+15, y: cell.ratingView.frame.origin.y+3, width: 12, height: 12)
        cell.countLabel.text = "\(FilterArray[indexPath.row].reviewsCount!)"
        
      }
      else{
        cell.countLabel.isHidden = true
        cell.ratingView.rating = 0
      }
      
      cell.instantImg.frame = CGRect(x:cell.entirehomeLabel.frame.origin.x+cell.entirehomeLabel.frame.width, y:241, width:15, height: 12)
      if((FilterArray[indexPath.row].isListOwner!) == false)
      {
        cell.likeBtn.tag = indexPath.row
        if(FilterArray[indexPath.row].wishListStatus! == false){
          cell.likeBtn.setImage(#imageLiteral(resourceName: "Heart"), for: .normal)
        }
        else{
          cell.likeBtn.setImage(#imageLiteral(resourceName: "like"), for: .normal)
        }
        cell.likeBtn.addTarget(self, action: #selector(filter_likeBtnTapped), for: .touchUpInside)
      }
      else
      {
        cell.likeBtn.isHidden = true
      }
      cell.layer.cornerRadius = 5.0
      cell.layer.masksToBounds = true
      cell.clipsToBounds = true
      return cell
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
    UIView.animate(withDuration: 0.5) {
      if let cell = collectionView.cellForItem(at: indexPath) as? ExploreCollectioncell {
        cell.transform = .init(scaleX: 0.90, y: 0.90)
        cell.contentView.backgroundColor = UIColor.white
      }
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
    UIView.animate(withDuration: 0.5) {
      if let cell = collectionView.cellForItem(at: indexPath) as? ExploreCollectioncell {
        
        cell.transform = .identity
        cell.contentView.backgroundColor = .clear
      }
    }
  }
  
  
  @objc func imageScrollerTapped(_ sender: UITapGestureRecognizer) {
    if(FilterArray.count > 0)
    {
      let guestdetailObj = GuestDetailVC()
      Utility.shared.unpublish_preview_check = false
      guestdetailObj.listID = FilterArray[sender.view!.tag].id!
      guestdetailObj.currencyvalue_from_API_base = Utility.shared.currencyvalue_from_API_base
      guestdetailObj.currency_Dict = currency_Dict
      guestdetailObj.modalPresentationStyle = .fullScreen
      self.present(guestdetailObj, animated: true, completion: nil)
    }
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    if(isFilterEnable){
      //        if((FilterArray[indexPath.row]).title!.count <= 30)
      //                   {
      //                       return CGSize(width: (FULLWIDTH-40), height:335)
      //        }else{
      return CGSize(width: (FULLWIDTH-40), height:390)
      // }
      
    }
    else
    {
      if(collectionView.tag == 0)
      {
        
        return CGSize(width:(150), height:150)
      }
      else
      {
        return CGSize(width: (FULLWIDTH - 50)/2, height:215)
      }
    }
  }
  
  
  //MARK**************************************** AIRBNB DATEPICKER DELEGATE METHODS *********************************************>
  
  @objc func showDatePicker() {
    Utility.shared.isfromcheckingPage = false
    let datePickerViewController = AirbnbDatePickerViewController(dateFrom: selectedStartDate, dateTo: selectedEndDate)
    
    datePickerViewController.delegate = self
    let navigationController = UINavigationController(rootViewController: datePickerViewController)
    navigationController.modalPresentationStyle = .fullScreen
    self.present(navigationController, animated: true, completion: nil)
  }
  
  func datePickerController(_ datePickerController: AirbnbDatePickerViewController, didSaveStartDate startDate: Date?, endDate: Date?) {
    
    
    selectedStartDate = startDate
    selectedEndDate = endDate
    
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd"
    if(startDate != nil && endDate != nil){
      Utility.shared.selectedstartDate_filter = (dateFormatterGet.string(from: startDate!))
      Utility.shared.selectedEndDate_filter = (dateFormatterGet.string(from: endDate!))
    }
    else
    {
      Utility.shared.selectedstartDate_filter = ""
      Utility.shared.selectedEndDate_filter = ""
    }
    
    if selectedStartDate == nil && selectedEndDate == nil {
      dateBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"dates"))!)", for: .normal)
      dateBtn.setTitleColor(TextDarkColor, for: .normal)
      dateBtn.backgroundColor = UIColor.white
      guestBtn.frame = CGRect(x:(self.dateBtn.frame.origin.x+self.dateBtn.frame.size.width + 10), y: 5, width:110, height: 33)
      filterBtn.frame = CGRect(x:(self.guestBtn.frame.origin.x+self.guestBtn.frame.size.width + 10), y: 5, width: 70, height: 33)
      // self.actionButton.isHidden = true
    } else {
      self.lottieAnimation()
      dateBtn.setTitle("\(dateFormatter.string(from: startDate!)) - \(dateFormatter.string(from: endDate!))", for: .normal)
      dateBtn.frame = CGRect(x:20, y: 5, width: 130, height: 33)
      dateBtn.backgroundColor = Theme.PRIMARY_COLOR
      dateBtn.setTitleColor(UIColor.white, for: .normal)
      // dateBtn.titleLabel?.font = UIFont(name: "AvenirNextMedium", size: 10.0)
      guestBtn.frame = CGRect(x:(self.dateBtn.frame.origin.x+self.dateBtn.frame.size.width + 10), y: 5, width:110, height: 33)
      filterBtn.isHidden = false
      filterBtn.frame = CGRect(x:(self.guestBtn.frame.origin.x+self.guestBtn.frame.size.width + 10), y: 5, width: 70, height: 33)
      self.isFilterEnable = true
      // self.actionButton.isHidden = false
      self.PageIndex = 1
      
      self.searchListingAPICall()
      
    }
  }
  @objc func likeBtnTapped(_ sender: UIButton!)
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
        let headerView = WhishlistPageVC()
        headerView.listID = recommendListingArray[sender.tag].id!
        headerView.listimage = recommendListingArray[sender.tag].listPhotoName!
        headerView.senderID = sender.tag
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
      self.exploreTV.isHidden = true
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
  @objc func most_likeBtnTapped(_ sender: UIButton!)
  {
    if Utility().isConnectedToNetwork(){
      if((Utility.shared.getCurrentUserToken()) == nil || (Utility.shared.getCurrentUserToken()) == "")
      {
        let welcomeObj = SignInViewController()
        welcomeObj.modalPresentationStyle = .fullScreen
        self.present(welcomeObj, animated:false, completion: nil)
        //  appDelegate.setInitialViewController(initialView: welcomeObj)
      }
      else{
        let headerView = WhishlistPageVC()
        headerView.listID = mostListingArray[sender.tag].id!
        headerView.listimage = mostListingArray[sender.tag].listPhotoName!
        headerView.delegate = self
        self.addChild(headerView)
        self.view.addSubview(headerView.view)
        headerView.didMove(toParent: self)
        self.tabBarController?.tabBar.isHidden = true
        headerView.view.frame = self.view.frame
      }
    }
    else{
      self.exploreTV.isHidden = true
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
  @objc func filter_likeBtnTapped(_ sender: UIButton!)
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
        let headerView = WhishlistPageVC()
        if(FilterArray.count > 0)
        {
          headerView.listID = FilterArray[sender.tag].id!
          headerView.listimage = FilterArray[sender.tag].listPhotoName!
          headerView.delegate = self
          self.addChild(headerView)
          self.view.addSubview(headerView.view)
          headerView.didMove(toParent: self)
          self.tabBarController?.tabBar.isHidden = true
          headerView.view.frame = self.view.frame
        }
      }
    }
    else
    {
      self.exploreTV.isHidden = true
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
  
  //MARK:************************************************* AIRBNB OCCUPANT FILTER DELEGATE METHODS ****************************************>
  
  @objc func showOccupantFilter() {
    Utility.shared.isfromcheckingPage = false
    let occupantController = AirbnbOccupantFilterController(adultCount: adultCount, childrenCount: childrenCount, infantCount: infantCount, hasPet: hasPet)
    occupantController.delegate = self
    let navigationController = UINavigationController(rootViewController: occupantController)
    
    self.present(navigationController, animated: true, completion: nil)
  }
  func occupantFilterController(_ occupantFilterController: AirbnbOccupantFilterController, didSaveAdult adult: Int, children: Int, infant: Int, pet: Bool) {
    self.lottieAnimation()
    self.adultCount = adult
    self.childrenCount = children
    self.infantCount = infant
    self.hasPet = pet
    self.guest_filter = adult
    
    let human = adult + children
    let infant = "\(infant > 0 ? (infant.description + " infant" + (infant > 1 ? "" : "")) : "")"
    let pet = "\(pet ? "pets" : "")"
    
    let text = "\(human) \((Utility.shared.getLanguage()?.value(forKey:"guest"))!)\(human > 1 ? "" : "")" + (infant != "" ? ", " + infant : "") + (pet != "" ? ", " + pet : "")
    var value = String()
    if(human > 1)
    {
      value = "\(human) \((Utility.shared.getLanguage()?.value(forKey:"guests"))!)"
    }
    else
    {
      value = "\(human) \((Utility.shared.getLanguage()?.value(forKey:"guest"))!)"
    }
    guestBtn.backgroundColor = Theme.PRIMARY_COLOR
    guestBtn.setTitleColor(UIColor.white, for: .normal)
    //guestBtn.frame = CGRect(x: 170, y: 5, width: 130, height: 33)
    filterBtn.isHidden = false
    filterBtn.frame = CGRect(x:(self.guestBtn.frame.origin.x+self.guestBtn.frame.size.width + 10), y: 5, width: 70, height: 33)
    guestBtn.setTitle(value, for: .normal)
    
    self.isFilterEnable = true
    // self.actionButton.isHidden = false
    self.PageIndex = 1
    self.searchListingAPICall()
    
  }
  
  
  
  //MARK:************************************************** GRAPHQL API METHOD CALL ********************************************************************>
  
  
  func MostViewedListingAPICall()
  {
    
    if Utility().isConnectedToNetwork(){
      self.exploreTV.isHidden = false
      self.offlineView.isHidden = true
      let mostlistingquery = GetDefaultSettingQuery()
      apollo_headerClient.fetch(query: mostlistingquery,cachePolicy:.fetchIgnoringCacheData){(result,error) in
        //RecommendedListing
        guard let recommendeListingValue = result?.data?.getRecommend?.results else{
          print("Missing Data")
          return
        }
        self.lottieView.isHidden = true
        self.homeTitleArray.removeAllObjects()
        self.homePriceArray.removeAllObjects()
        self.homeImageArray.removeAllObjects()
        self.bookingTypeArray.removeAllObjects()
        self.reviewcount_Array.removeAllObjects()
        self.reviewStart_ratingArray.removeAllObjects()
        self.entirehomeArray.removeAllObjects()
        self.wishlistArray.removeAllObjects()
        self.recommendListingArray = ((result?.data?.getRecommend?.results)!) as! [GetDefaultSettingQuery.Data.GetRecommend.Result]
        
        for i in recommendeListingValue {
          self.homeTitleArray.add(i?.title as Any)
          self.homeImageArray.add(i?.listPhotoName as Any)
          self.homePriceArray.add(i?.listingData?.basePrice as Any)
          self.currencyCode_for_recommendedListing = (i?.listingData?.currency)!
          self.reviewcount_Array.add(i?.reviewsCount as Any)
          self.reviewStart_ratingArray.add(i?.reviewsStarRating as Any)
          self.entirehomeArray.add(i?.roomType as Any)
          self.wishlistArray.add(i?.wishListStatus as Any)
          self.bookingTypeArray.add(i?.bookingType as Any)
          
        }
        if(self.currencyCode_for_recommendedListing != ""){
          print(self.currencysymbol_recommendedListing as Any)
          
        }
        
        
        //MostViewListing
        guard let mostListingValue = result?.data?.getMostViewedListing?.results else {
          print("Missing data")
          return
        }
        self.mosthomeImageArray.removeAllObjects()
        self.mosthomeTitleArray.removeAllObjects()
        self.mosthomePriceArray.removeAllObjects()
        self.mostreviewcount_Array.removeAllObjects()
        self.mostreviewStart_ratingArray.removeAllObjects()
        self.most_entirehomeArray.removeAllObjects()
        self.mostwishlist_Array.removeAllObjects()
        self.mostbookingTypeArray.removeAllObjects()
        
        self.mostListingArray = ((result?.data?.getMostViewedListing?.results)!) as! [GetDefaultSettingQuery.Data.GetMostViewedListing.Result]
        self.populardestinationArray = (self.mostListingArray[0].popularLocationListing) as! [GetDefaultSettingQuery.Data.GetMostViewedListing.Result.PopularLocationListing]
        
        for i in mostListingValue {
          self.mosthomeTitleArray.add(i?.title as Any)
          self.mosthomePriceArray.add(i?.listingData?.basePrice as Any)
          self.mosthomeImageArray.add(i?.listPhotoName as Any)
          self.currencyCode_for_mostListing = (i?.listingData?.currency)!
          self.mostreviewcount_Array.add(i?.reviewsCount as Any)
          self.mostreviewStart_ratingArray.add(i?.reviewsStarRating as Any)
          self.most_entirehomeArray.add(i?.roomType as Any)
          self.mostwishlist_Array.add(i?.wishListStatus as Any)
          self.mostbookingTypeArray.add(i?.bookingType as Any)
          
        }
        if(self.currencyCode_for_mostListing != ""){
          self.currencysymbol_mostListing = Utility.shared.getSymbol(forCurrencyCode: self.currencyCode_for_mostListing)!
        }
        
        
        
        //Currencyvalueget
        
        guard (result?.data?.currency?.result) != nil else {
          print("Missing data")
          return
        }
        self.currencyvalue_from_API = (result?.data?.currency?.result)!
        Utility.shared.currencyvalue_from_API_base = (result?.data?.currency?.result?.base)!
        let currency_value = result?.data?.currency?.result?.rates
        self.currency_Dict = self.convertToDictionary(text: currency_value!)! as NSDictionary
        Utility.shared.currency_Dict = self.convertToDictionary(text: currency_value!)! as NSDictionary
        
        guard (result?.data?.getListingSettingsCommon?.results) != nil else{
          return
        }
        self.RoomsFilterArray = ((result?.data?.getListingSettingsCommon?.results)!) as! [GetDefaultSettingQuery.Data.GetListingSettingsCommon.Result]
        Utility.shared.maximum_guest_count = (self.RoomsFilterArray[1].listSettings?[0]?.endValue!)!
        
        
        self.getsearchPriceArray = ((result?.data?.getSearchSettings?.results)!)
        
        
        
        self.exploreTV?.reloadData()
        
        self.lottieView.isHidden = true
        if((result?.data?.getRecommend?.results?.count == 0) && (result?.data?.getMostViewedListing?.results?.count == 0)) {
          self.exploreTV.isHidden = true
          self.NoresultView.isHidden = false
          self.actionButton.isHidden = true
          self.NoresultView.frame = CGRect(x: 0, y: self.headerView.frame.size.height+self.headerView.frame.origin.y+5, width: FULLWIDTH, height:FULLHEIGHT-110)
        }
        else
        {
          self.exploreTV.isHidden = false
          self.NoresultView.isHidden = true
        }
        self.actionButton.isHidden = true
      }
    }
    
    else{
      self.exploreTV.isHidden = true
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
        offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-140, width: FULLWIDTH, height: 55)
      }else{
        offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
      }
      
    }
    
    
  }
  func convertToDictionary(text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
      do {
        return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
      } catch {
        print(error.localizedDescription)
      }
    }
    return nil
  }
  
  func searchListingAPICall()
  {
    
    if Utility().isConnectedToNetwork(){
      
      self.exploreTV.isHidden = false
      self.offlineView.isHidden = true
      
      var searchListingquery = SearchListingQuery()
      
      var lat = Double()
      var lon = Double()
      var bookingtype = String()
      
      if((Utility.shared.searchLocationDict.value(forKey: "lat") != nil) && (Utility.shared.searchLocationDict.value(forKey: "lon") != nil))
      {
        lat  = Utility.shared.searchLocationDict.value(forKey: "lat") as! Double
        lon  = Utility.shared.searchLocationDict.value(forKey: "lon") as! Double
      }
      else{
        lat = 0.0
        lon = 0.0
      }
      
      if(Utility.shared.amenitiesArray.count == 0)
      {
        Utility.shared.amenitiesArray = []
      }
      if(Utility.shared.roomtypeArray.count == 0)
      {
        Utility.shared.roomtypeArray = []
      }
      if(Utility.shared.facilitiesArray.count == 0)
      {
        Utility.shared.facilitiesArray = []
      }
      if(Utility.shared.houseRulesArray.count == 0)
      {
        Utility.shared.houseRulesArray = []
      }
      if(Utility.shared.roomtypeArray.count == 0)
      {
        Utility.shared.roomtypeArray = []
      }
      if(Utility.shared.priceRangeArray.count == 0)
      {
        Utility.shared.priceRangeArray = []
      }
      if(Utility.shared.locationfromSearch == nil)
      {
        Utility.shared.locationfromSearch = ""
      }
      if(Utility.shared.isSwitchEnable == true)
      {
        bookingtype = "instant"
      }
      var currency = String()
      if(Utility.shared.getPreferredCurrency() == nil)
      {
        currency = Utility.shared.currencyvalue_from_API_base
      }
      else{
        currency = Utility.shared.getPreferredCurrency()!
      }
      
      
      searchListingquery = SearchListingQuery(personCapacity: guest_filter, currentPage: PageIndex, dates: "'\( Utility.shared.selectedstartDate_filter)' AND '\(Utility.shared.selectedEndDate_filter)'", lat: 0, lng: 0, amenities: Utility.shared.amenitiesArray as? [Int], beds: Utility.shared.beds_count as Int, bedrooms: Utility.shared.bedrooms_count as Int, bathrooms:Utility.shared.bathroom_count as Int, roomType: Utility.shared.roomtypeArray as? [Int], spaces:(Utility.shared.facilitiesArray as! [Int]), houseRules:(Utility.shared.houseRulesArray as! [Int]), priceRange:Utility.shared.priceRangeArray as! [Int],bookingType: bookingtype, address:Utility.shared.locationfromSearch!,currency:currency)
      
      apollo_headerClient.fetch(query: searchListingquery,cachePolicy:.fetchIgnoringCacheData){(result,error) in
        
        
        
        guard let searchListingValues = result?.data?.searchListing?.results else{
          print("Missing Data")
          self.lottieView.isHidden = true
          return
        }
        
        if((result?.data?.searchListing?.count)!>0) {
          self.NoresultView.isHidden = true
          self.exploreTV.isHidden = false
          self.actionButton.isHidden = false
          
          if(result?.data?.searchListing?.currentPage == 1){
            self.FilterArray.removeAll()
          }
          
          self.FilterArray.append(contentsOf: ((result?.data?.searchListing?.results)!) as! [SearchListingQuery.Data.SearchListing.Result])
          
          
          self.totalListcount = (result?.data?.searchListing?.count)!
          self.lottieView.isHidden = true
          
          self.exploreTV?.reloadData()
          
          if self.FilterArray.count != 0 {
            self.viewDidLayoutSubviews()
          }
          
        }
        else {
          self.exploreTV.isHidden = true
          self.NoresultView.isHidden = false
          self.actionButton.isHidden = true
          self.lottieView.isHidden = true
          self.NoresultView.frame = CGRect(x: 0, y: self.headerView.frame.size.height+self.headerView.frame.origin.y+5, width: FULLWIDTH, height:FULLHEIGHT-110)
          
        }
        
        
        
      }
    }
    else{
      self.exploreTV.isHidden = true
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
  //MARK ******************************************* IMAGESCROLLER DELEGATE METHODS **************************************************************>
  
  
  @objc func pageChanged(_ sender: UISwipeGestureRecognizer) {
    Pagecontrol.currentPage = sender.view!.tag
    
  }
  //MARK ********************************************* LOADMORE FUNCTIONALITY CALL ***************************************************************>
  
  private func isLoadingIndexPath(_ indexPath: IndexPath) -> Bool {
    return indexPath.row == self.FilterArray.count - 1
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
  {
    
    var totalPages = Int()
    
    let last_element = FilterArray.count - 1
    if(indexPath.item == last_element && isFilterEnable)
    {
      if(self.totalListcount % 10 == 0)
      {
        totalPages = (self.totalListcount/10)
      }
      else{
        totalPages = (self.totalListcount/10) + 1
      }
      if(totalPages >= PageIndex){
        self.PageIndex = self.PageIndex + 1
        self.searchListingAPICall()
        
      }
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
  
}


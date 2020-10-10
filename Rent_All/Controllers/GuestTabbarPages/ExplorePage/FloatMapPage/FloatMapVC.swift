//
//  FloatMapVC.swift
//  Rent_All
//
//  Created by RADICAL START on 01/04/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import JJFloatingActionButton
import GoogleMaps
import GooglePlaces
import GooglePlacePicker
import MaterialComponents
import Lottie

class FloatMapVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CLLocationManagerDelegate,GMSMapViewDelegate,UIScrollViewDelegate{
   
    
    
    //MARK:************************************************ IBOUTLET CONNECTIONS ***************************************************>
    
  //  @IBOutlet var mapCollection: UICollectionView!
    
    //MARK:*********************************** GLOBAL VARIABLE DECLARATIONS **************************************>
    var homeImageArray = NSMutableArray()
    var homeTitleArray = NSMutableArray()
    var homePriceArray = NSMutableArray()
    var mosthomeImageArray = NSMutableArray()
    var mosthomeTitleArray = NSMutableArray()
    var mosthomePriceArray = NSMutableArray()
     var mapCollection: UICollectionView?
    var latArray = NSArray()
    var lonArray = NSArray()
    
    var locationManager = CLLocationManager()
    var locationDetailArray = NSMutableArray()
    var markerPriceLblArray = NSMutableArray()
    var highlightLabelArray = NSMutableArray()
    var TotalArray = NSMutableArray()
    var markerImageArray = NSMutableArray()
    var imageArray = [#imageLiteral(resourceName: "maps_location"),#imageLiteral(resourceName: "fb_logo"),#imageLiteral(resourceName: "settings")]
    var markergms = GMSMarker()
    var layout = UICollectionViewFlowLayout()
    var lottieView: LOTAnimationView!
    var FloatSearchArray = [SearchListingQuery.Data.SearchListing.Result]()
    var didscroll:Bool = false
    var scrollingcount = 0
    var currencyvalue_from_API_base = String()
    var currency_Dict = NSDictionary()
    @IBOutlet weak var FloatingMap: GMSMapView!
    @IBOutlet weak var settingImg: UIImageView!
    @IBOutlet weak var floatingFilterBtn: UIButton!
    @IBOutlet weak var mapBackview:UIImageView!
    var getsearchPriceArray = GetDefaultSettingQuery.Data.GetSearchSetting.Result()
    var RoomsFilterArray = [GetDefaultSettingQuery.Data.GetListingSettingsCommon.Result]()
    var indexforScroll = IndexPath()
    var markerArray = [GMSMarker]()
    var Latitude: Double = 0.0
    var longitude: Double = 0.0
    
    @IBOutlet weak var filterBtnView: UIView!
    
    struct State {
        let name: String
        let long: CLLocationDegrees
        let lat: CLLocationDegrees
    }
   
    
    var markerDict: [String: GMSMarker] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialSetup()
        self.lottieAnimation()
        DispatchQueue.main.async {
            self.addMapFunctionality()
        }
       
        
      
        //self.configureGoogleMap()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
        
        if( Utility.shared.TotalFilterCount > 1)
        {
            floatingFilterBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"filters_floats"))!)(\(Utility.shared.TotalFilterCount))", for: .normal)
        }
        else
        {
            floatingFilterBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"filters_float"))!)(\(Utility.shared.TotalFilterCount))", for: .normal)
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Set up collection view
        layout = mapCollection!.collectionViewLayout as! UICollectionViewFlowLayout
    }
    
    func lottieAnimation() {
        lottieView = LOTAnimationView.init(name:"animation")
        lottieView.isHidden = false
        self.lottieView.frame = CGRect(x:FULLWIDTH/2-40, y:FULLHEIGHT/2-150, width:100, height:100)
        self.FloatingMap.addSubview(self.lottieView)
        self.lottieView.backgroundColor = UIColor.clear
        self.lottieView.layer.cornerRadius = 6.0
        self.lottieView.clipsToBounds = true
        self.lottieView.play()
    }
   
    func initialSetup(){
        FloatingMap.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height:FULLHEIGHT-285)
        mapCollection = UICollectionView(frame: CGRect(x:15, y:FULLHEIGHT-270, width: FULLWIDTH-30, height:270), collectionViewLayout: layout)
        mapBackview.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height:100)
        FloatingMap.addSubview(mapBackview)
        FloatingMap.bringSubviewToFront(mapBackview)
        mapCollection?.showsHorizontalScrollIndicator = false
        filterBtnView.frame = CGRect(x:FULLWIDTH/2-50, y:FloatingMap.frame.size.height+FloatingMap.frame.origin.y - 55, width: 116, height: 37)
        settingImg.frame = CGRect(x:90, y:10, width:15, height: 15)
       //FloatingMap.addSubview(floatingFilterBtn)
        let longGesture = UITapGestureRecognizer(target: self, action: #selector(mapTaphideView))
        longGesture.cancelsTouchesInView = false
        FloatingMap.addGestureRecognizer(longGesture)
       
        layout.scrollDirection = .horizontal
        mapCollection?.decelerationRate = UIScrollView.DecelerationRate.fast
        mapCollection?.dataSource = self
        mapCollection?.delegate = self
        mapCollection?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellIdentifier")
        mapCollection?.backgroundColor = UIColor.white
        //mapCollection?.scrollToNearestVisibleCollectionViewCell()
        if let aView = mapCollection {
            self.view.addSubview(aView)
        }
        
       
            mapCollection?.register(UINib(nibName: "FloatCollectionCell", bundle: nil), forCellWithReuseIdentifier: "FloatCollectionCell")
        DispatchQueue.main.async {
            self.mapCollection?.reloadData()
        }
        //floatingFilterBtn.frame = CGRect.init(x: (FULLWIDTH/2)-50, y:320, width:130, height: 40)
        
    //    settingImg.frame = CGRect(x: floatingFilterBtn.frame.origin.x+90, y: 330, width: 15, height: 15)
        let shadowSize : CGFloat = 3.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.floatingFilterBtn.frame.size.width + shadowSize,
                                                   height: self.floatingFilterBtn.frame.size.height + shadowSize))
        
        self.filterBtnView.layer.masksToBounds = false
        self.filterBtnView.layer.shadowColor = TextLightColor.cgColor
        self.filterBtnView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.filterBtnView.layer.shadowOpacity = 0.3
        self.filterBtnView.layer.shadowPath = shadowPath.cgPath
       self.view.addSubview(filterBtnView)
        filterBtnView.layer.cornerRadius = 20
        filterBtnView.layer.masksToBounds = true
        
        if( Utility.shared.TotalFilterCount > 0)
        {
            floatingFilterBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"filters_float"))!)S(\(Utility.shared.TotalFilterCount))", for: .normal)
        }
        else
        {
          floatingFilterBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"filters_float"))!)", for: .normal)
        }
        floatingFilterBtn.addTarget(self, action: #selector(floatingBtnTapped), for: .touchUpInside)
       filterBtnView.addSubview(settingImg)
        filterBtnView.addSubview(floatingFilterBtn)
        filterBtnView.bringSubviewToFront(settingImg)
        DispatchQueue.main.async {
            self.mapCollection?.reloadData()     
        }
       self.mapCollection!.isHidden = false
        let backBtn = UIButton()
        backBtn.frame = CGRect(x: 20, y: 30, width: 45, height: 45)
        backBtn.imageEdgeInsets = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
        backBtn.setImage(#imageLiteral(resourceName: "close"), for: UIControl.State.normal)
        backBtn.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
        FloatingMap.addSubview(backBtn)
    }
    
    @objc func mapTaphideView()
    {
        
       
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    @objc func floatingBtnTapped()
    {
        let filterObj = MoreFilterVC()
        filterObj.getsearchPriceArray = getsearchPriceArray
        filterObj.RoomsFilterArray = RoomsFilterArray
        Utility.shared.isfromfloatmap_Page = true
         filterObj.modalPresentationStyle = .fullScreen
        self.present(filterObj, animated: true, completion: nil)
    }
    @objc func backBtnTapped(_ sender: UIButton!)
    {
        Utility.shared.isfromdetailpage = true
        self.dismiss(animated: true, completion: nil)
    }
    func configureGoogleMap(){
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 8.0)
        FloatingMap = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: FULLWIDTH, height: FULLHEIGHT-200), camera: camera)
        FloatingMap.isMyLocationEnabled = false
        FloatingMap.settings.myLocationButton = false
        FloatingMap.padding = UIEdgeInsets.init(top: 0, left: 0, bottom: 5, right: 5)
        FloatingMap.mapType = .terrain
        FloatingMap.delegate = self
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        self.view.addSubview(FloatingMap)
        do {
            if let styleURL = Bundle.main.url(forResource: "mapstyle", withExtension: "json") {
                FloatingMap.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                print("Unable to find style.json")
            }
        } catch {
            print("One or more of the map styles failed to load. \(error)")
        }
    }
    func addMapFunctionality()
    {
        var firstFlage : Bool = true
        var selectedIndex : Int = 0
  

        for state in FloatSearchArray {
            let state_marker = GMSMarker()
            if(state.lat != nil && state.lng != nil){
            state_marker.position = CLLocationCoordinate2D(latitude: state.lat!, longitude: state.lng!)
            }
            var price = String()
            var currency = String()
            if(Utility.shared.getPreferredCurrency() != nil && Utility.shared.getPreferredCurrency() != "")
            {
                let currencysymbol = Utility.shared.getSymbol(forCurrencyCode: Utility.shared.getPreferredCurrency()!)
                let from_currency = state.listingData?.currency!
                let currency_amount = state.listingData?.basePrice!
                let price_value = self.getCurrencyRate(basecurrency:currencyvalue_from_API_base, fromCurrency:from_currency!, toCurrency:Utility.shared.getPreferredCurrency()!, CurrencyRate: self.currency_Dict, amount:currency_amount!)
                currency = "\(currencysymbol!)"
//                let price = "\(String(format: "%.2f",price_value))"
                let restricted_price =  Double(String(format: "%.2f",price_value))
                price = (restricted_price!.clean)
                
            }
            else
            {
                let currencysymbol = Utility.shared.getSymbol(forCurrencyCode:self.currencyvalue_from_API_base)
                let from_currency = state.listingData?.currency!
                let currency_amount = state.listingData?.basePrice!
                let price_value = self.getCurrencyRate(basecurrency:currencyvalue_from_API_base, fromCurrency:from_currency!, toCurrency:currencyvalue_from_API_base, CurrencyRate: self.currency_Dict, amount:currency_amount!)
                currency = "\(currencysymbol!)"
                //price = "\(String(format: "%.2f",price_value))"
                let restricted_price =  Double(String(format: "%.2f",price_value))
                price = (restricted_price!.clean)
            }
           
            markerDict["\(String(describing: currency))\(String(describing: price))"] = state_marker
            state_marker.userData = selectedIndex
            //state_marker.title = "$5.56"
            var customImage = UIImage(named: "price_tag.png") as UIImage?
            
            let nameLbl = UILabel()
            homeTitleArray.add(state.title!)
            nameLbl.textAlignment = .center
            nameLbl.textColor = TextDarkColor
            //nameLbl.font = smallFont
            nameLbl.text = "\(String(describing: currency))\(String(describing: price))"
            nameLbl.frame = CGRect(x: 0, y: 4, width: nameLbl.intrinsicContentSize.width+20, height: 20)
            
            nameLbl.backgroundColor = UIColor.clear
            
            let markerImage = UIImageView()
            markerImage.frame = CGRect(x: 0, y: 0, width: nameLbl.intrinsicContentSize.width+20, height: 40)
           markerImage.image = customImage
            
            let customView = UIView()
            customView.frame = CGRect(x: 0, y: 0, width: nameLbl.intrinsicContentSize.width+20, height: 40)
            customView.backgroundColor = UIColor.clear
            customView.addSubview(markerImage)
            customView.addSubview(nameLbl)
            state_marker.iconView = customView
            
            markerPriceLblArray.add(nameLbl as UILabel)
            markerImageArray.add(markerImage as UIImageView)
            markerArray.append(state_marker as GMSMarker)
            
            print("Lattitude & Longitude \(state.lat) - \(state.lng)")
            
            Latitude = state.lat!
            longitude = state.lng!
            
            state_marker.map = FloatingMap
            state_marker.zIndex = Int32(0.1)
            selectedIndex += 1
            if(state.lat != nil && state.lng != nil){
            let camera = GMSCameraPosition.camera(withLatitude: state.lat!, longitude: state.lng!, zoom:10.0)
            
            self.FloatingMap.animate(to: camera)
            }
            
        }
        self.mapCollection?.reloadData()
        self.lottieView.isHidden = true

    }
    
    //MARK:********************************************** COLLECTIONVIEW DELEGATE & DATASOURCE ******************************************************************>
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
                let visibleRect = CGRect(origin: mapCollection!.contentOffset, size: (mapCollection?.bounds.size)!)
                let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
                guard let visibleIndexpath = mapCollection!.indexPathForItem(at: visiblePoint) else{
                    return
                }
                indexforScroll = visibleIndexpath
                
        //        DispatchQueue.main.async {
        //            self.mapCollection?.scrollToNearestVisibleCollectionViewCell()
        //        }
                mapCollection?.reloadData()
    }
    
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        let visibleRect = CGRect(origin: mapCollection!.contentOffset, size: (mapCollection?.bounds.size)!)
//        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
//        guard let visibleIndexpath = mapCollection!.indexPathForItem(at: visiblePoint) else{
//            return
//        }
//        indexforScroll = visibleIndexpath
//        
////        DispatchQueue.main.async {
////            self.mapCollection?.scrollToNearestVisibleCollectionViewCell()
////        }
//        mapCollection?.reloadData()
//      
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(FloatSearchArray.count > 0)
        {
            return FloatSearchArray.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FloatCollectionCell", for: indexPath)as! FloatCollectionCell
        cell.tag = indexPath.item+1000
        
        
        if FloatSearchArray.count > indexPath.row {
            if(FloatSearchArray[indexPath.row].roomType != nil)
            {
            cell.entirehomeLabel.text = FloatSearchArray[indexPath.row].roomType!
            }
            else{
                  cell.entirehomeLabel.text = ""
            }
            cell.entirehomeLabel.sizeToFit()
            cell.likeBtn.isHidden = true
            //cell.homeImage.image = UIImage(named: "\(homeImageArray[indexPath.row]).png")
            cell.homeImage.sd_setImage(with: URL(string: "\(IMAGE_LISTING_MEDIUM)\(FloatSearchArray[indexPath.row].listPhotoName!)"),placeholderImage: #imageLiteral(resourceName: "ItemTransparentImg"))
           
            if(homeTitleArray.count > 0 && homeTitleArray.count > indexPath.row)
            {
                cell.titleLabel.text = "\(homeTitleArray[indexPath.row])".condensingWhitespace()
            }
            if(Utility.shared.getPreferredCurrency() != nil && Utility.shared.getPreferredCurrency() != "")
            {
                let currencysymbol = Utility.shared.getSymbol(forCurrencyCode: Utility.shared.getPreferredCurrency()!)
                let from_currency = self.FloatSearchArray[indexPath.row].listingData?.currency
                let currency_amount = self.FloatSearchArray[indexPath.row].listingData?.basePrice
                let price_value = self.getCurrencyRate(basecurrency:currencyvalue_from_API_base, fromCurrency:from_currency!, toCurrency:Utility.shared.getPreferredCurrency()!, CurrencyRate: self.currency_Dict, amount:currency_amount!)
                let restricted_price =  Double(String(format: "%.2f",price_value))
                cell.priceLabel.text =  "\(currencysymbol!)\(restricted_price!.clean) \((Utility.shared.getLanguage()?.value(forKey:"pernight"))!)"
                // cell.priceLabel.text =  "\(currencysymbol!)\(String(format: "%.2f",price_value)) per night"
            }
            else
            {
                let currencysymbol = Utility.shared.getSymbol(forCurrencyCode:self.currencyvalue_from_API_base)
                let from_currency = self.FloatSearchArray[indexPath.row].listingData?.currency
                let currency_amount = self.FloatSearchArray[indexPath.row].listingData?.basePrice
                let price_value = self.getCurrencyRate(basecurrency:currencyvalue_from_API_base, fromCurrency:from_currency!, toCurrency:currencyvalue_from_API_base, CurrencyRate: self.currency_Dict, amount:currency_amount!)
                let restricted_price =  Double(String(format: "%.2f",price_value))
                cell.priceLabel.text =  "\(currencysymbol!)\(restricted_price!.clean) \((Utility.shared.getLanguage()?.value(forKey:"pernight"))!)"
                // cell.priceLabel.text =  "\(currencysymbol!)\(String(format: "%.2f",price_value)) per night"
            }
            //        let price = FloatSearchArray[indexPath.row].listingData?.basePrice
            //        let currency = Utility.shared.getSymbol(forCurrencyCode: (FloatSearchArray[indexPath.row].listingData?.currency!)!)
            //        cell.priceLabel.text = "\(currency!)\(price!) Per night"
            let value1 = (FloatSearchArray[indexPath.row].reviewsCount)
            let value2 = (FloatSearchArray[indexPath.row].reviewsStarRating)
            
            cell.instantView.isHidden = true
            if("\(FloatSearchArray[indexPath.row].bookingType!)" == "instant")
            {
                cell.instantView.isHidden = false
            }
            else{
                cell.instantView.isHidden = true
            }
            if(value2 != nil){
                let reviewcount = (value2!/value1!)
                cell.ratingView.rating = Double(reviewcount)
            }
            else{
                cell.ratingView.rating = 0
            }
            if (indexforScroll.isEmpty){
                if let backgroundindex = collectionView.indexPathsForVisibleItems.first{
                    if indexPath.row == backgroundindex.row{
                        cell.selectedItem.isHidden = false
                        cell.selectedItem.backgroundColor = Theme.PRIMARY_COLOR
                    }else{
                        cell.selectedItem.isHidden = true
                        cell.selectedItem.backgroundColor = .white
                    }
                }
            }else {
                if indexPath.row == indexforScroll.row{
                    cell.selectedItem.isHidden = false
                    cell.selectedItem.backgroundColor = Theme.PRIMARY_COLOR
                }else{
                    cell.selectedItem.backgroundColor = .white
                    cell.selectedItem.isHidden = true
                }
            }
        }else{
            //self.view.makeToast("Something went wrong")
        }
 
        cell.homeImage.layer.cornerRadius = 3.0
        cell.homeImage.layer.masksToBounds = true
        
//        if(cell.selectedItem.backgroundColor == Theme.PRIMARY_COLOR)
//        {
        cell.homeImage.addSubview(cell.selectedItem)
        cell.homeImage.bringSubviewToFront(cell.selectedItem)
        cell.homeImage.frame.origin.y = 0
        cell.selectedItem.frame = CGRect(x: 0, y: 0, width: cell.homeImage.frame.size.width, height:4)

        DispatchQueue.main.async {
            
        cell.titleLabel.frame = CGRect(x: 0, y: 184, width: (FULLWIDTH/2)+40, height:25)
            
        }
    
       // if(cell.titleLabel?.text?.count ?? 0 <= 29){
            //cell.selectedItem.frame.origin.y = 5
            
            
            
            cell.priceLabel.frame = CGRect(x: 0, y: 205, width: (FULLWIDTH - 25), height:20)
            cell.ratingView.frame = CGRect(x: 0, y: 225, width: 70, height:18)
        //}
        
        cell.instantView.frame = CGRect(x:cell.entirehomeLabel.frame.origin.x+cell.entirehomeLabel.frame.size.width+3, y: 172, width: 10, height: 12)
        
        scrollingcount = indexPath.row
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:FULLWIDTH/2+40, height:270)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let guestdetailObj = GuestDetailVC()
        Utility.shared.unpublish_preview_check = false
        guestdetailObj.currencyvalue_from_API_base = currencyvalue_from_API_base
        guestdetailObj.currency_Dict = currency_Dict
        guestdetailObj.listID = FloatSearchArray[indexPath.row].id!
         guestdetailObj.modalPresentationStyle = .fullScreen
        self.present(guestdetailObj, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        var latArr: Double = 0
        var lonArr: Double = 0
    
        print("float Search array\(FloatSearchArray.count)")
        
       if  FloatSearchArray.count > indexPath.row {
        
//        DispatchQueue.main.async {
//            collectionView.scrollToNearestVisibleCollectionViewCell()
//        }
        

       // collectionView.scrollToNearestVisibleCollectionViewCell()
            if FloatSearchArray.count == 1{
                //   if let indexLAtLong = collectionView.indexPathsForVisibleItems.max(){
                latArr = FloatSearchArray[indexPath.row].lat!
                lonArr = FloatSearchArray[indexPath.row].lng!
                for i in 0 ..< FloatSearchArray.count{
                    let dummyMarkerImage  = markerImageArray.object(at: i) as! UIImageView
                    let dummyPriceLbl = markerPriceLblArray.object(at: i) as! UILabel
                    let marker = markerArray[i] as! GMSMarker
                    var markImage =  UIImage(named: "price_tag.png")as! UIImage
                    dummyPriceLbl.textColor = TextDarkColor
                    marker.zIndex = Int32(0.5)
                    if i == indexPath.row
                    {
                        markImage = UIImage(named: "price_tag_color.png") as! UIImage
                        dummyPriceLbl.textColor = UIColor.white
                        marker.zIndex = 1
                    }
                    dummyMarkerImage.image = markImage
                }
                //   }
            }
            if indexforScroll.isEmpty{
                if let mapindex = collectionView.indexPathsForVisibleItems.max(){
                    latArr = FloatSearchArray[mapindex.row].lat!
                    lonArr = FloatSearchArray[mapindex.row].lng!
                    for i in 0..<self.FloatSearchArray.count
                    {
                        if(markerImageArray.count > 0 && markerPriceLblArray.count > 0)
                        {
                        if(markerImageArray.count > 0 && markerPriceLblArray.count > 0)
                        {
                        let dummyMarkerImage  = markerImageArray.object(at: i) as! UIImageView
                        let dummyPriceLbl = markerPriceLblArray.object(at: i) as! UILabel
                        let marker = markerArray[i] as! GMSMarker
                        var markImage =  UIImage(named: "price_tag.png")as! UIImage
                        dummyPriceLbl.textColor = TextDarkColor
                        marker.zIndex = Int32(0.5)
                        if i == mapindex.row
                        {
                            markImage = UIImage(named: "price_tag_color.png") as! UIImage
                            dummyPriceLbl.textColor = UIColor.white
                            marker.zIndex = 1
                        }
                        dummyMarkerImage.image = markImage
                            }
                        }
                    }
                }
                
            }else{
                latArr = FloatSearchArray[indexforScroll.row].lat!
                lonArr = FloatSearchArray[indexforScroll.row].lng!
                for i in 0..<self.FloatSearchArray.count
                {
                    let dummyMarkerImage  = markerImageArray.object(at: i) as! UIImageView
                    let dummyPriceLbl = markerPriceLblArray.object(at: i) as! UILabel
                    let marker = markerArray[i] as! GMSMarker
                    var markImage =  UIImage(named: "price_tag.png")as! UIImage
                    dummyPriceLbl.textColor = TextDarkColor
                    marker.zIndex = Int32(0.2)
                    if i == indexforScroll.row
                    {
                        markImage = UIImage(named: "price_tag_color.png") as! UIImage
                        dummyPriceLbl.textColor = UIColor.white
                        marker.zIndex = 1
                    }
                    dummyMarkerImage.image = markImage
                }
            }
            let newPosition = CLLocationCoordinate2D(latitude:latArr as CLLocationDegrees, longitude: lonArr as CLLocationDegrees)
            var point = FloatingMap.projection.point(for: newPosition)
            //point.y = point.y - 150
            let cell = view.viewWithTag(indexPath.row + 1000) as? FloatCollectionCell
            if(TotalArray.contains(FloatSearchArray[indexPath.row].title as Any))
            {
                TotalArray.remove(FloatSearchArray[indexPath.row].title as Any)
            }
            else
            {
                TotalArray.add(FloatSearchArray[indexPath.row].title as Any)
                // mapCollection?.isPagingEnabled = true
            }
            
            print("lattitude and Logitude: \(latArr) - \(lonArr)")
            let camera = GMSCameraPosition.camera(withLatitude:latArr as CLLocationDegrees, longitude:lonArr as CLLocationDegrees, zoom:10.0)
            //self.FloatingMap.camera = camera
            self.FloatingMap.animate(to: camera)

        }
    }
    @objc func scrollToNextCell(){
        //get cell size
        let cellSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        
        //get current content Offset of the Collection view
        let contentOffset = mapCollection!.contentOffset;
        
        //scroll to next cell
        mapCollection?.scrollRectToVisible(CGRect(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true)
       
       // collectionView.scrollRectToVisible(CGRectMake(contentOffset.x + cellSize.width, contentOffset.y, cellSize.width, cellSize.height), animated: true);
        
        
    }
    
    /**
     Invokes Timer to start Automatic Animation with repeat enabled
     */
    func startTimer() {
        Timer.scheduledTimer(timeInterval:3.0, target: self, selector: #selector(scrollToNextCell), userInfo: nil, repeats: true)
        
    }
    
    //MARK:************************************************* MAPVIEW DELEGATE & DATASOURCE METHODS *******************************************>

    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let cell = view.viewWithTag((marker.userData as! Int) + 1000) as? FloatCollectionCell
        var point = mapView.projection.point(for: marker.position)
         point.y = point.y - 150
        let markerIndex :Int = marker.userData as! Int
       
                let count = self.FloatSearchArray.count
                for i in 0..<count
                {
                    let dummyMarkerImage  = markerImageArray.object(at: i) as! UIImageView
                    let dummyPriceLbl = markerPriceLblArray.object(at: i) as! UILabel
                    let dummymarker = markerArray[i] as GMSMarker
                    dummyPriceLbl.textColor = TextDarkColor
        
                    var customImage = UIImage(named: "price_tag.png") as UIImage?
                    dummymarker.zIndex = Int32(0.2)
                    if i == markerIndex
                    {
                        customImage = UIImage(named: "price_tag_color.png") as UIImage?
                        dummyPriceLbl.textColor = UIColor.white
                        dummymarker.zIndex = Int32(1)
                    }
                    dummyMarkerImage.image = customImage
                }
        let camera = GMSCameraUpdate.setTarget(mapView.projection.coordinate(for: point))
        FloatingMap.animate(with: camera)
        FloatingMap.selectedMarker = marker
        
        mapCollection?.reloadData()
      //  self.mapCollection!.scrollToItem(at:IndexPath(item: markerIndex, section: 0), at: .right, animated: false)
        if self.mapCollection!.isHidden == true {
            FloatingMap.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height: FULLHEIGHT-285)
            filterBtnView.frame = CGRect(x:FULLWIDTH/2-50, y:FloatingMap.frame.size.height+FloatingMap.frame.origin.y - 55, width: 116, height: 37)
            //floatingFilterBtn.frame = CGRect.init(x: (FULLWIDTH/2)-50, y:FloatingMap.frame.size.height+FloatingMap.frame.origin.y - 55, width:130, height: 40)
          //  settingImg.frame = CGRect(x: floatingFilterBtn.frame.origin.x+90, y: FULLHEIGHT-320, width: 15, height: 15)
            settingImg.frame = CGRect(x:90, y:10, width:15, height: 15)
            //filterBtnView.addSubview(settingImg)
           // filterBtnView.addSubview(floatingFilterBtn)
           self.mapCollection!.isHidden = false
        }else{
        self.mapCollection?.scrollToItem(at: IndexPath(item: markerIndex, section: 0), at: .centeredHorizontally, animated: false)
        }
        return true
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        //Write your code here...
        if self.mapCollection!.isHidden == true {
            FloatingMap.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height: FULLHEIGHT-285)
            filterBtnView.frame = CGRect(x:FULLWIDTH/2-50, y:FloatingMap.frame.size.height+FloatingMap.frame.origin.y - 55, width: 116, height: 37)
            settingImg.frame = CGRect(x:90, y:10, width:15, height: 15)
            //floatingFilterBtn.frame = CGRect.init(x: (FULLWIDTH/2)-50, y:FULLHEIGHT-330, width:130, height: 40)
            //settingImg.frame = CGRect(x: floatingFilterBtn.frame.origin.x+90, y: FULLHEIGHT-320, width: 15, height: 15)
            self.mapCollection!.isHidden = false
        } else {
            self.mapCollection!.isHidden = true
            FloatingMap.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height: FULLHEIGHT)
            filterBtnView.frame = CGRect(x:FULLWIDTH/2-50, y:FULLHEIGHT-80, width: 116, height: 37)
            settingImg.frame = CGRect(x:90, y:10, width:15, height: 15)

        }
    }
//    func snapToNearestCell(_ collectionView: UICollectionView) {
//        for i in 0..<collectionView.numberOfItems(inSection: 0) {
//
//            let itemWithSpaceWidth = layout.itemSize.width + layout.minimumLineSpacing
//            let itemWidth = layout.itemSize.width
//
//            if collectionView.contentOffset.x <= CGFloat(i) * itemWithSpaceWidth + itemWidth / 2 {
//                let indexPath = IndexPath(item: i, section: 0)
//                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//                break
//            }
//        }
//    }

//   func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//
//       let cell = view.viewWithTag(scrollingcount + 1000) as? FloatCollectionCell
//       //cell?.selectedItem.backgroundColor = Theme.PRIMARY_COLOR
//       print("item end")
//     //   snapToNearestCell(scrollView as! UICollectionView)
//    }
    
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
extension UICollectionView {
    func scrollToNearestVisibleCollectionViewCell() {
        self.decelerationRate = UIScrollView.DecelerationRate.fast
        let visibleCenterPositionOfScrollView = Float(self.contentOffset.x + (self.bounds.size.width / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        for i in 0..<self.visibleCells.count {
            let cell = self.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)
            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = self.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex != -1 {
            self.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}

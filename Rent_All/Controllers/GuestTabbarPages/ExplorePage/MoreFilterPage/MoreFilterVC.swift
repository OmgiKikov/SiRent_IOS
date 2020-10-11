//
//  MoreFilterVC.swift
//  Rent_All
//
//  Created by RADICAL START on 28/03/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Lottie
import RangeSeekSlider
import Apollo

class MoreFilterVC: UIViewController,UITableViewDelegate,UITableViewDataSource,RangeSeekSliderDelegate {
   
    
    
    //MARK:************************************************ IBOUTLET CONNECTIONS **************************************************>
    
    @IBOutlet weak var fitertitleLabel: UILabel!
    @IBOutlet var bottomView: UIView!
    @IBOutlet var topView: UIView!
    
    @IBOutlet var seemoreBtn: UIButton!
    @IBOutlet var closeBtn: UIButton!
    
    @IBOutlet var filterTV: UITableView!
    @IBOutlet var clearBtn: UIButton!
    
    //MARK:************************************************ GLOBAL VARIABLE DECLARATIONS **************************************************>
    
    var homeTypeArray = NSArray()
    var roomsTypeArray = NSArray()
    var amenitiesTitleArray = NSArray()
    var FacilitiesTitleArray = NSArray()
    var houseRulesArray = NSArray()
    var isShowmoreClicked:Bool = false
    var isfacilitiesmoreClicked:Bool = false
    var ishousemoreClicked:Bool = false
    var count = Int()
    var minCount = Int()
    var maxCount = Int()
    var minsliderValue = String()
    var maxsliderValue = String()
    var getsearchPriceArray = GetDefaultSettingQuery.Data.GetSearchSetting.Result()
    var RoomsFilterArray = [GetDefaultSettingQuery.Data.GetListingSettingsCommon.Result]()
    
    var lottieView: LOTAnimationView!
    
    var apollo_headerClient: ApolloClient!
    
    
    
    var roomtypeArray = NSMutableArray()
    var amenitiesArray = NSMutableArray()
    var facilitiesArray = NSMutableArray()
    var housingRulesArray = NSMutableArray()
    var priceRangeArray = NSMutableArray()
    var instantBook = String()
    var bedrooms_count = Int()
    var beds_count = Int()
    var bathroom_count = Int()
    var TotalFilterCount : Int = 0
    var isSwitchEnable:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkApolloStatus()
       // self.lottieAnimation()
        self.initialSetup()
        self.registerCells()
        if(RoomsFilterArray.count == 0)
        {
            self.lottieAnimation()
            self.FilterAPICall()
        }
        //self.FilterAPICall()
        
        
        filterTV.estimatedSectionFooterHeight = 40

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
    func registerCells(){
        filterTV.register(UINib(nibName: "InstantBookCell", bundle: nil), forCellReuseIdentifier: "InstantBookCell")
        filterTV.register(UINib(nibName: "PriceRangeCell", bundle: nil), forCellReuseIdentifier: "PriceRangeCell")
        filterTV.register(UINib(nibName: "HometypeCell", bundle: nil), forCellReuseIdentifier: "HometypeCell")
        filterTV.register(UINib(nibName: "RoomsCell", bundle: nil), forCellReuseIdentifier: "RoomsCell")
        filterTV.register(UINib(nibName: "AmenitiesCell", bundle: nil), forCellReuseIdentifier: "AmenitiesCell")
        filterTV.register(UINib(nibName: "HouseRulesCell", bundle: nil), forCellReuseIdentifier: "HouseRulesCell")
        filterTV.register(UINib(nibName: "FacilitiesCell", bundle: nil), forCellReuseIdentifier: "FacilitiesCell")
    }
    
    func lottieAnimation(){
        lottieView = LOTAnimationView.init(name:"animation")
        lottieView.isHidden = false
        self.lottieView.frame = CGRect(x:FULLWIDTH/2-40, y:FULLHEIGHT/2-150, width:100, height:100)
        self.filterTV.addSubview(self.lottieView)
        self.lottieView.backgroundColor = UIColor.clear
        self.lottieView.layer.cornerRadius = 6.0
        self.lottieView.clipsToBounds = true
        self.lottieView.play()
        Timer.scheduledTimer(timeInterval:0.2, target: self, selector: #selector(autoscrolling), userInfo: nil, repeats: true)
    }
    
    
    @objc func autoscrolling()
    {
        self.lottieView.play()
    }
    func initialSetup(){
        
        seemoreBtn.layer.cornerRadius = 5.0
        seemoreBtn.layer.masksToBounds = true
        seemoreBtn.backgroundColor = Theme.PRIMARY_COLOR

       if IS_IPHONE_XR
        {
        self.topView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH-40, height: 80)
        filterTV.frame = CGRect(x: 0, y: 85, width: FULLWIDTH-40, height: FULLHEIGHT-380)
            
        }
        let shadowSize : CGFloat = 3.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.bottomView.frame.size.width + shadowSize,
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
        
          roomtypeArray = Utility.shared.roomtypeArray
          amenitiesArray =  Utility.shared.amenitiesArray
       facilitiesArray =  Utility.shared.facilitiesArray
         housingRulesArray =  Utility.shared.houseRulesArray
         isSwitchEnable = Utility.shared.isSwitchEnable
        seemoreBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"seeresults"))!)", for: .normal)
        clearBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"clearall"))!)", for: .normal)
        fitertitleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"filters"))!)"
        
        
    }
    
    func FilterAPICall()
    {
         if Utility().isConnectedToNetwork(){
        let priceRangequery = GetDefaultSettingQuery()
        apollo_headerClient.fetch(query: priceRangequery){(result,error) in
            //RecommendedListing
            guard (result?.data?.getSearchSettings?.results) != nil else{
                print("Missing Data")
                return
            }
            self.getsearchPriceArray = ((result?.data?.getSearchSettings?.results)!)
            
            
            
            
            guard (result?.data?.getListingSettingsCommon?.results) != nil else{
                return
            }
            self.RoomsFilterArray = ((result?.data?.getListingSettingsCommon?.results)!) as! [GetDefaultSettingQuery.Data.GetListingSettingsCommon.Result]
            
            self.filterTV.reloadData()
            self.lottieView.isHidden = true
            
        }
            
            
            
            
            
            
        }
            
    }
    
    @IBAction func clearBtnTapped(_ sender: Any) {
          if(RoomsFilterArray.count > 0)
          {
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
        if(isSwitchEnable)
        {
            isSwitchEnable = false
            Utility.shared.isSwitchEnable = false
        }
        Utility.shared.TotalFilterCount = 0
        filterTV.reloadData()
        let indexPath = IndexPath(item: 0, section: 0)
        filterTV.reloadRows(at: [indexPath], with: .top)
        self.lottieView.isHidden = true
        }
        
    }
    
    
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        Utility.shared.priceRangeArray.removeAllObjects()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func seeMoreTapped(_ sender: Any) {
        Utility.shared.isfromFilterPage = true
        Utility.shared.isfromMoreFilter = true
        
          Utility.shared.roomtypeArray = roomtypeArray
          Utility.shared.amenitiesArray = amenitiesArray
         Utility.shared.facilitiesArray = facilitiesArray
        Utility.shared.houseRulesArray =  housingRulesArray
        Utility.shared.isSwitchEnable =  isSwitchEnable
        Utility.shared.isfromdetailpage = false
        
        Utility.shared.TotalFilterCount = Utility.shared.amenitiesArray.count + Utility.shared.houseRulesArray.count + Utility.shared.facilitiesArray.count+Utility.shared.roomtypeArray.count
        if(Utility.shared.isSwitchEnable){
         Utility.shared.TotalFilterCount += 1
        }
        if(Utility.shared.bedrooms_count != 0){
            Utility.shared.TotalFilterCount += 1
        }
         if(Utility.shared.bathroom_count != 0){
            Utility.shared.TotalFilterCount += 1
        }
         if(Utility.shared.beds_count != 0){
            Utility.shared.TotalFilterCount += 1
        }
         if(Utility.shared.priceRangeArray.count != 0){
            Utility.shared.TotalFilterCount += 1
        }
        if(Utility.shared.isfromfloatmap_Page)
        {
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        }
        else
        {
        self.dismiss(animated: true, completion: nil)
        }
        
    }
    //MARK:************************************************ TABLEVIEW DELEGATE/DATASOURCE METHODS*********************************************>
    
     func numberOfSections(in tableView: UITableView) -> Int {
        if(RoomsFilterArray.count > 0)
        {
        return 7
        }
        else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0)
        {
            if(RoomsFilterArray.count > 0)
            {
            return 1
            }
            return 0
        }
        else if(section == 1){
            if(((getsearchPriceArray.minPrice) != nil)&&((getsearchPriceArray.maxPrice) != nil))
            {
                if(Utility.shared.priceRangeArray.count != 0){
                    return 1
                }
                return 1
            }
            return 0
        }
        if(section == 2){
            if(RoomsFilterArray.count > 0)
            {
                return RoomsFilterArray[0].listSettings!.count
            }
            return 0
        }
        else if(section == 3){
            if(RoomsFilterArray.count > 0)
            {
            return 3
            }
            return 0
        }
        else if(section == 4){
            if(RoomsFilterArray.count>0){
            if(isShowmoreClicked){
            return RoomsFilterArray[9].listSettings!.count
            }
            
                return 2
            }
            return 0
            
        }
        else if(section == 5){
            if(RoomsFilterArray.count>0){
             if(isfacilitiesmoreClicked){
            return RoomsFilterArray[11].listSettings!.count
            }
            return 2
            }
            return 0
        }
        else if(section == 6)
        {
            if(RoomsFilterArray.count>0){
             if(ishousemoreClicked){
            return RoomsFilterArray[13].listSettings!.count
            }
            return 2
            }
            return 0
        }
        return 0
    }
    func tableView( _ tableView : UITableView,  titleForHeaderInSection section: Int)->String?
    {
        if(section == 1){
            return "\((Utility.shared.getLanguage()?.value(forKey:"pricerange"))!)"
        }
        else if(section == 2 ){
            return "\((Utility.shared.getLanguage()?.value(forKey:"hometype"))!)"
        }
        else if(section == 3){
            return "\((Utility.shared.getLanguage()?.value(forKey:"roomsandbeds"))!)"
        }
        else if(section == 4){
            return  "\((Utility.shared.getLanguage()?.value(forKey:"amenities"))!)"
        }
        else if(section == 5){
            return "\((Utility.shared.getLanguage()?.value(forKey:"facilities"))!)"
        }
        else if(section == 6){
            return "\((Utility.shared.getLanguage()?.value(forKey:"houserules"))!)"
        }
        return ""
    }
    
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        
        let lineLabel = UILabel(frame: CGRect(x:15, y:0, width:FULLWIDTH-30, height: 1.0))
        lineLabel.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        headerView.addSubview(lineLabel)
        
        let headerLabel = UILabel(frame: CGRect(x: 20, y:10, width:
        tableView.bounds.size.width, height: 40))
        headerLabel.font = UIFont(name: "Circular-Medium", size:19)
        headerLabel.textColor = TextDarkColorOne
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    
   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    if(section==0){
        return 0
    }
        return 50
    }
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?
    {
        if(section == 4){
            if(!isShowmoreClicked){
            return  "\((Utility.shared.getLanguage()?.value(forKey:"showallamenities"))!)"
            }
           return "\((Utility.shared.getLanguage()?.value(forKey:"closeallamenities"))!)"
        }
        else if(section == 5){
            if(!isfacilitiesmoreClicked){
            return "\((Utility.shared.getLanguage()?.value(forKey:"showallfacilities"))!)"
            }
            return "\((Utility.shared.getLanguage()?.value(forKey:"closeallfacilities"))!)"
        }
        else if(section == 6){
            if(!ishousemoreClicked){
            return "\((Utility.shared.getLanguage()?.value(forKey:"showallhouserules"))!)"
            }
            else{
                return "\((Utility.shared.getLanguage()?.value(forKey:"closeallhouserules"))!)"
            }
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.white
         if((section==4)||(section==5)||(section==6)){
        let showmore = UIButton()
        showmore.frame = CGRect(x:20, y:0, width:tableView.bounds.size.width, height:45)
        showmore.backgroundColor = UIColor.white
        showmore.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
        showmore.titleLabel?.font =  UIFont(name: "Circular-Medium", size:17)
        showmore.contentHorizontalAlignment = .left
        showmore.setTitle(self.tableView(tableView, titleForFooterInSection: section), for: .normal)
        showmore.tag = section
        showmore.addTarget(self, action: #selector(addBtnTapped(_:)), for: .touchUpInside)
        footerView.addSubview(showmore)
        }
        
        return footerView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if((section==4)||(section==5)||(section==6)){
            return 50
        }
        return 0
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
  
        if(indexPath.section == 0)
        {
            return 40
        }
        else if(indexPath.section==1){
           return 60
        }
       else if((indexPath.section==2)){
            return 70
        }

        return 60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if(indexPath.section == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "InstantBookCell", for: indexPath)as! InstantBookCell
            cell.instantbookLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"instantbook"))!)"

            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
            
            cell.tag = indexPath.row+8000
 
            if(isSwitchEnable){
                cell.lotSwitch.isOn = true
            }
            else{
                cell.lotSwitch.isOn = false
            }

             // image = (image.tint(with: Theme.PRIMARY_COLOR))
            //cell.lotSwitch.onTintColor = UIColor(patternImage: image)
            cell.lotSwitch.addTarget(self, action: #selector(switchToggled), for: .valueChanged)
           // cell.lotSwitch.thumbTintColor = UIColor(patternImage: image)
            
            cell.isHidden = true
            return cell
        }
        else if(indexPath.section == 1) {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PriceRangeCell", for: indexPath)as! PriceRangeCell
            cell.sliderView.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
          //  cell.priceLabel.text = "$10-$549"
            cell.tag = 9000
            
            
            if(Utility.shared.getPreferredCurrency() != nil && Utility.shared.getPreferredCurrency() != "")
            {
                let currencysymbol = Utility.shared.getSymbol(forCurrencyCode: Utility.shared.getPreferredCurrency()!)
                let from_currency = (getsearchPriceArray.priceRangeCurrency!)
                let currency_amount = CGFloat(getsearchPriceArray.minPrice!)
                let max_currency_amount = CGFloat(getsearchPriceArray.maxPrice!)
                let price_value = self.getCurrencyRate(basecurrency:Utility.shared.currencyvalue_from_API_base, fromCurrency:from_currency, toCurrency:Utility.shared.getPreferredCurrency()!, CurrencyRate:Utility.shared.currency_Dict, amount:Double(currency_amount))
                
                let price_value1 = self.getCurrencyRate(basecurrency:Utility.shared.currencyvalue_from_API_base, fromCurrency:from_currency, toCurrency:Utility.shared.getPreferredCurrency()!, CurrencyRate:Utility.shared.currency_Dict, amount:Double(max_currency_amount))
                    let restricted_price =  Double(String(format: "%.2f",price_value))
                if(Utility.shared.priceRangeArray.count != 0){
                    cell.sliderView.minValue = CGFloat(restricted_price!)
                    cell.sliderView.maxValue = CGFloat(price_value1)
                    cell.sliderView.selectedMinValue = Utility.shared.priceRangeArray[0] as! CGFloat
                    cell.sliderView.selectedMaxValue = Utility.shared.priceRangeArray[1] as! CGFloat
                }
                else{
                    cell.sliderView.minValue = CGFloat(restricted_price!)
                    cell.sliderView.maxValue = CGFloat(price_value1)
                    cell.sliderView.selectedMinValue = CGFloat(restricted_price!)
                    cell.sliderView.selectedMaxValue = CGFloat(price_value1)
                    
                }
                cell.sliderView.numberFormatter.positivePrefix = Utility.shared.getSymbol(forCurrencyCode: (Utility.shared.getPreferredCurrency()!))
               
            }
            else
            {
                let currencysymbol = Utility.shared.getSymbol(forCurrencyCode:Utility.shared.currencyvalue_from_API_base)
                let from_currency = (getsearchPriceArray.priceRangeCurrency!)
                let currency_amount = CGFloat(getsearchPriceArray.minPrice!)
                let max_currency_amount = CGFloat(getsearchPriceArray.maxPrice!)
                let price_value = self.getCurrencyRate(basecurrency:Utility.shared.currencyvalue_from_API_base, fromCurrency:from_currency, toCurrency:Utility.shared.currencyvalue_from_API_base, CurrencyRate:Utility.shared.currency_Dict, amount:Double(currency_amount))
                let restricted_price =  Double(String(format: "%.2f",price_value))
                var currency = String()
                 if(Utility.shared.getPreferredCurrency() != nil && Utility.shared.getPreferredCurrency() != "")
                           {
                    currency = Utility.shared.currencyvalue_from_API_base
                }
                else
                {
                     currency = Utility.shared.getPreferredCurrency()!
                }
                let price_value1 = self.getCurrencyRate(basecurrency:Utility.shared.currencyvalue_from_API_base, fromCurrency:from_currency, toCurrency:currency, CurrencyRate:Utility.shared.currency_Dict, amount:Double(max_currency_amount))
                if(Utility.shared.priceRangeArray.count != 0){
                    cell.sliderView.minValue = CGFloat(price_value)
                    cell.sliderView.maxValue = CGFloat(price_value1)
                    cell.sliderView.selectedMinValue = Utility.shared.priceRangeArray[0] as! CGFloat
                    cell.sliderView.selectedMaxValue = Utility.shared.priceRangeArray[1] as! CGFloat
                }
                else{
                    cell.sliderView.minValue = CGFloat(restricted_price!)
                    cell.sliderView.maxValue = CGFloat(price_value1)
                    cell.sliderView.selectedMinValue = CGFloat(restricted_price!)
                    cell.sliderView.selectedMaxValue = CGFloat(price_value1)
                    
                }
                cell.sliderView.numberFormatter.positivePrefix = Utility.shared.getSymbol(forCurrencyCode: (Utility.shared.currencyvalue_from_API_base))
            }
            
            
            cell.sliderView.delegate = self
            
            cell.sliderView.numberFormatter.maximumFractionDigits = 2
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.sliderView.numberFormatter.numberStyle = .currency
            cell.sliderView.minLabelFont = UIFont.boldSystemFont(ofSize:14)
            cell.sliderView.maxLabelFont = UIFont.boldSystemFont(ofSize:14)
    
            return cell
        }
        else if(indexPath.section == 2){
            let cell = tableView.dequeueReusableCell(withIdentifier: "HometypeCell", for: indexPath)as! HometypeCell
           // cell.homeTypeLabel.text = homeTypeArray[indexPath.row] as? String
            cell.homeTypeLabel.text = RoomsFilterArray[0].listSettings![indexPath.row]?.itemName
            cell.homeTypeLabel.textColor = TextDarkColorOne
            cell.tag = indexPath.row+2000
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            if(roomtypeArray.contains(RoomsFilterArray[0].listSettings![indexPath.row]?.id as Any))
            {
                cell.checkBtn.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
            }
            else{
                cell.checkBtn.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
            }
            cell.checkBtn.tag = indexPath.row
            cell.checkBtn.addTarget(self, action: #selector(checkBtnTapped), for: .touchUpInside)
            return cell
            
        }
        else if(indexPath.section == 3){
            count = 0
           minCount = 0
            let cell = tableView.dequeueReusableCell(withIdentifier: "RoomsCell", for: indexPath)as! RoomsCell
            if(indexPath.row == 0){
                
                
                cell.roomsTitleLabel.text = "Жилая Комната"//RoomsFilterArray[4].typeLabel
                cell.countshowLabel.text =  String(Utility.shared.bedrooms_count)
            }
            else if(indexPath.row == 1){

                cell.roomsTitleLabel.text = "Спальная Комната"//RoomsFilterArray[5].typeLabel
                cell.countshowLabel.text = String(Utility.shared.beds_count)
            }
            else{
               
                cell.roomsTitleLabel.text = "Санузел"//RoomsFilterArray[7].typeLabel
                cell.countshowLabel.text =  String(Utility.shared.bathroom_count)
            }
            
            cell.roomsTitleLabel.textColor = TextDarkColorOne
            cell.plusBtn.layer.cornerRadius = cell.plusBtn.frame.size.width/2
            cell.plusBtn.layer.borderWidth = 1.0
            cell.plusBtn.tag = indexPath.row
            cell.minusBtn.tag = indexPath.row
            
            cell.plusBtn.addTarget(self, action: #selector(plusBtnTapped), for: .touchUpInside)
            cell.plusBtn.layer.borderColor = Theme.PRIMARY_COLOR.cgColor
            cell.minusBtn.layer.cornerRadius = cell.minusBtn.frame.size.width/2
            cell.minusBtn.layer.borderWidth = 1.0
            cell.minusBtn.layer.borderColor = Theme.PRIMARY_COLOR.cgColor
            cell.minusBtn.addTarget(self, action: #selector(minusBtnTapped), for: .touchUpInside)
            cell.tag = indexPath.row+6000
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
            
            return cell

        }
        else if(indexPath.section == 4){

            let cell = tableView.dequeueReusableCell(withIdentifier: "AmenitiesCell", for: indexPath)as! AmenitiesCell
            
            cell.amenitieslistTile.text = RoomsFilterArray[9].listSettings![indexPath.row]?.itemName
            cell.tag = indexPath.row+3000
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            if(cell.amenitieslistTile.text!.count > 25)
            {
                cell.amenitieslistTile.frame = CGRect(x: 20, y: 5, width:250, height:70)
                cell.amenitieslistTile.numberOfLines = 2
                
            }
            else {
                cell.amenitieslistTile.frame = CGRect(x: 20, y:25, width:250, height:26)
                cell.amenitieslistTile.numberOfLines = 2
            }
            if(amenitiesArray.contains(RoomsFilterArray[9].listSettings![indexPath.row]?.id as Any))
            {
                
                cell.checkBtn.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
            }
            else{
                cell.checkBtn.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
            }
            cell.checkBtn.tag = indexPath.row
            cell.checkBtn.addTarget(self, action: #selector(amenitiescheckBtnTapped(_:)), for: .touchUpInside)
            return cell
            
        }
        else if(indexPath.section == 5){

            let cell = tableView.dequeueReusableCell(withIdentifier: "FacilitiesCell", for: indexPath)as! FacilitiesCell
            cell.amenitieslistTile.text = RoomsFilterArray[11].listSettings![indexPath.row]?.itemName
            cell.tag = indexPath.row+4000
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            if(cell.amenitieslistTile.text!.count > 25)
            {
                cell.amenitieslistTile.frame = CGRect(x: 20, y: 5, width:250, height:60)
                cell.amenitieslistTile.numberOfLines = 2
                
            }
            else {
                cell.amenitieslistTile.frame = CGRect(x: 20, y:25, width:250, height:26)
                cell.amenitieslistTile.numberOfLines = 2
            }
            if(facilitiesArray.contains(RoomsFilterArray[11].listSettings![indexPath.row]?.id as Any))
            {
                cell.checkBtn.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
            }
            else{
                cell.checkBtn.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
            }
            cell.checkBtn.tag = indexPath.row
            cell.checkBtn.addTarget(self, action: #selector(facilitiescheckBtnTapped(_:)), for: .touchUpInside)
            return cell
        }
  
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HouseRulesCell", for: indexPath)as! HouseRulesCell
            cell.amenitieslistTile.text = RoomsFilterArray[13].listSettings![indexPath.row]?.itemName
            cell.tag = indexPath.row+5000
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
            if(cell.amenitieslistTile.text!.count > 25)
            {
                cell.amenitieslistTile.frame = CGRect(x: 20, y: 5, width:250, height:60)
                cell.amenitieslistTile.numberOfLines = 2
                
            }
            else {
                cell.amenitieslistTile.frame = CGRect(x: 20, y:25, width:250, height:26)
                cell.amenitieslistTile.numberOfLines = 2
            }
            if(housingRulesArray.contains(RoomsFilterArray[13].listSettings![indexPath.row]?.id as Any))
            {
                cell.checkBtn.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
            }
            else{
                cell.checkBtn.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
            }
            cell.checkBtn.tag = indexPath.row
            cell.checkBtn.addTarget(self, action: #selector(houseRulescheckBtnTapped(_:)), for: .touchUpInside)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if((indexPath.section == 0) || (indexPath.section == 1) || (indexPath.section == 3))
        {
            print("clicked")
        }
        else if(indexPath.section == 2)
        {
            let cell = view.viewWithTag(indexPath.row + 2000) as? HometypeCell
            if(cell?.checkBtn.currentImage == #imageLiteral(resourceName: "checked")){
                
                if(roomtypeArray.contains(RoomsFilterArray[0].listSettings![indexPath.row]?.id as Any))
                {
                     roomtypeArray.remove(RoomsFilterArray[0].listSettings![indexPath.row]?.id as Any)
                }
                cell?.checkBtn.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
            }
            else{

                    roomtypeArray.add(RoomsFilterArray[0].listSettings![indexPath.row]?.id as Any)
           
               cell?.checkBtn.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
            }
            
        }
        else if(indexPath.section == 4){
           let cell = view.viewWithTag(indexPath.row + 3000) as? AmenitiesCell
            if(cell?.checkBtn.currentImage == #imageLiteral(resourceName: "checked")){
                if(amenitiesArray.contains(RoomsFilterArray[9].listSettings![indexPath.row]?.id as Any))
                {
                   amenitiesArray.remove(RoomsFilterArray[9].listSettings![indexPath.row]?.id as Any)
                }
                cell?.checkBtn.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
            }
            else{
                
                
                  amenitiesArray.add(RoomsFilterArray[9].listSettings![indexPath.row]?.id as Any)
               
                cell?.checkBtn.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
            }
        }
        else if(indexPath.section == 5){
            let cell = view.viewWithTag(indexPath.row + 4000) as? FacilitiesCell
            if(cell?.checkBtn.currentImage == #imageLiteral(resourceName: "checked")){
                if(facilitiesArray.contains(RoomsFilterArray[11].listSettings![indexPath.row]?.id as Any))
                {
                    facilitiesArray.remove(RoomsFilterArray[11].listSettings![indexPath.row]?.id as Any)
                }
                cell?.checkBtn.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
            }
            else{
                
                
                    facilitiesArray.add(RoomsFilterArray[11].listSettings![indexPath.row]?.id as Any)
                
                cell?.checkBtn.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
            }
        }
        else {
            
            let cell = view.viewWithTag(indexPath.row + 5000) as? HouseRulesCell
            if(cell?.checkBtn.currentImage == #imageLiteral(resourceName: "checked")){
                if(housingRulesArray.contains(RoomsFilterArray[13].listSettings![indexPath.row]?.id as Any))
                {
                    housingRulesArray.remove(RoomsFilterArray[13].listSettings![indexPath.row]?.id as Any)
                }
                cell?.checkBtn.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
            }
            else{
                
                
                    housingRulesArray.add(RoomsFilterArray[13].listSettings![indexPath.row]?.id as Any)
                
                cell?.checkBtn.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
            }
        }
    }
    
    @objc func checkBtnTapped(_ sender: UIButton)
    {
        
        let cell = view.viewWithTag(sender.tag + 2000) as? HometypeCell
        if(cell?.checkBtn.currentImage == #imageLiteral(resourceName: "checked")){
            if(roomtypeArray.contains(RoomsFilterArray[0].listSettings![sender.tag]?.id as Any))
            {
                roomtypeArray.remove(RoomsFilterArray[0].listSettings![sender.tag]?.id as Any)
            }
            cell?.checkBtn.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        }
        else{
            
                roomtypeArray.add(RoomsFilterArray[0].listSettings![sender.tag]?.id as Any)
            
            cell?.checkBtn.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        }
    }
    
    @objc func amenitiescheckBtnTapped(_ sender: UIButton)
    {
        
        let cell = view.viewWithTag(sender.tag + 3000) as? AmenitiesCell
        if(cell?.checkBtn.currentImage == #imageLiteral(resourceName: "checked")){
            if(amenitiesArray.contains(RoomsFilterArray[9].listSettings![sender.tag]?.id as Any))
            {
                amenitiesArray.remove(RoomsFilterArray[9].listSettings![sender.tag]?.id as Any)
            }
            cell?.checkBtn.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        }
        else{
            
            amenitiesArray.add(RoomsFilterArray[9].listSettings![sender.tag]?.id as Any)
            
            cell?.checkBtn.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        }
    }
    
    @objc func facilitiescheckBtnTapped(_ sender: UIButton)
    {
        let cell = view.viewWithTag(sender.tag + 4000) as? FacilitiesCell
        if(cell?.checkBtn.currentImage == #imageLiteral(resourceName: "checked")){
            if(facilitiesArray.contains(RoomsFilterArray[11].listSettings![sender.tag]?.id as Any))
            {
                facilitiesArray.remove(RoomsFilterArray[11].listSettings![sender.tag]?.id as Any)
            }
            cell?.checkBtn.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        }
        else{
            
               facilitiesArray.add(RoomsFilterArray[11].listSettings![sender.tag]?.id as Any)
            
            cell?.checkBtn.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        }
    }
    
    @objc func houseRulescheckBtnTapped(_ sender: UIButton)
    {
        let cell = view.viewWithTag(sender.tag + 5000) as? HouseRulesCell
        if(cell?.checkBtn.currentImage == #imageLiteral(resourceName: "checked")){
            if(housingRulesArray.contains(RoomsFilterArray[13].listSettings![sender.tag]?.id as Any))
            {
                housingRulesArray.remove(RoomsFilterArray[13].listSettings![sender.tag]?.id as Any)
            }
            cell?.checkBtn.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        }
        else{
            
            
           housingRulesArray.add(RoomsFilterArray[13].listSettings![sender.tag]?.id as Any)
            
            cell?.checkBtn.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        }
        
    }
    @objc func addBtnTapped(_ sender: UIButton){
         let btnsendtag: UIButton = sender
        if(btnsendtag.tag == 4){
        if(btnsendtag.currentTitle == "\((Utility.shared.getLanguage()?.value(forKey:"closeallamenities"))!)"){
            isShowmoreClicked = false
        }
        else {
            isShowmoreClicked = true
            
        }
        }
        else if(btnsendtag.tag == 5){
            if(btnsendtag.currentTitle == "\((Utility.shared.getLanguage()?.value(forKey:"closeallfacilities"))!)"){
                isfacilitiesmoreClicked = false
            }
            else {
                isfacilitiesmoreClicked = true
                
            }
        }
        else if(btnsendtag.tag == 6)
        {
            if(btnsendtag.currentTitle == "\((Utility.shared.getLanguage()?.value(forKey:"closeallhouserules"))!)"){
                ishousemoreClicked = false
            }
            else {
                ishousemoreClicked = true
                
            }
        }
  
        
        filterTV.reloadData()
       //  isShowmoreClicked = !isShowmoreClicked
        
    }
    
    @objc func switchToggled(_ sender:LOTAnimatedSwitch) {
        
        
        let cell = view.viewWithTag(sender.tag + 8000) as! InstantBookCell
        
        cell.lotSwitch.setOn(!sender.isOn, animated: false)
        if(cell.lotSwitch.isOn){
            cell.lotSwitch.isOn = false
            isSwitchEnable = false
        }
        else{
            cell.lotSwitch.isOn = true
            isSwitchEnable = true
        }
        
      //  self.lotSwitch.setOn(!value.isOn, animated: false)
        
        
    }
    
    @objc func plusBtnTapped(_ sender: UIButton){
        
        let cell = view.viewWithTag(sender.tag + 6000) as! RoomsCell
        count = Int(cell.countshowLabel.text!)!
        count += 1
        if(sender.tag == 0){
            maxCount = RoomsFilterArray[4].listSettings![0]!.endValue!
        }
        else if(sender.tag == 1)
        {
            maxCount = RoomsFilterArray[5].listSettings![0]!.endValue!
        }
        else{
            maxCount = RoomsFilterArray[7].listSettings![0]!.endValue!
        }
        
        if count <= maxCount {
            if((count >= minCount) && (count <= maxCount)){
                cell.minusBtn.isEnabled = true
                cell.minusBtn.alpha = 1
                cell.countshowLabel.text = String(count)
                if(sender.tag == 0){
                Utility.shared.bedrooms_count = count
                }
                else if(sender.tag == 1)
                {
                    Utility.shared.beds_count = count
                }
                else{
                  Utility.shared.bathroom_count = count
                }
                
            }
            cell.plusBtn.isEnabled = true
            cell.plusBtn.alpha = 1
            cell.countshowLabel.text = String(count)
            if(sender.tag == 0){
                Utility.shared.bedrooms_count = count
            }
            else if(sender.tag == 1)
            {
                Utility.shared.beds_count = count
            }
            else{
                Utility.shared.bathroom_count = count
            }
            
           
        }
      else {
      if((count >= minCount) && (count <= maxCount)){
      cell.minusBtn.isEnabled = true
      cell.minusBtn.alpha = 1
      cell.countshowLabel.text = String(count)
        
        if(sender.tag == 0){
            Utility.shared.bedrooms_count = count
        }
        else if(sender.tag == 1)
        {
            Utility.shared.beds_count = count
        }
        else{
            Utility.shared.bathroom_count = count
        }
         }
    
            cell.plusBtn.isEnabled = false
            cell.plusBtn.alpha = 0.5
        }
        
      //  filterTV.reloadData()
    }
    @objc func minusBtnTapped(_ sender: UIButton){
        
        let cell = view.viewWithTag(sender.tag + 6000) as! RoomsCell
        count = Int(cell.countshowLabel.text!)!
         count -= 1
        cell.plusBtn.isEnabled = true
        cell.plusBtn.alpha = 1
        if(sender.tag == 0){
            maxCount = RoomsFilterArray[4].listSettings![0]!.endValue!
        }
        else if(sender.tag == 1)
        {
            maxCount = RoomsFilterArray[5].listSettings![0]!.endValue!
        }
        else{
            maxCount = RoomsFilterArray[7].listSettings![0]!.endValue!
        }
        
        if count >= minCount {
            if(count <= maxCount){
                cell.minusBtn.isEnabled = true
                cell.minusBtn.alpha = 1
                cell.countshowLabel.text = String(count)
                if(sender.tag == 0){
                    Utility.shared.bedrooms_count = count
                }
                else if(sender.tag == 1)
                {
                    Utility.shared.beds_count = count
                }
                else{
                    Utility.shared.bathroom_count = count
                }
            }
            cell.minusBtn.isEnabled = true
            cell.minusBtn.alpha = 1
            cell.countshowLabel.text = String(count)
            if(sender.tag == 0){
                Utility.shared.bedrooms_count = count
            }
            else if(sender.tag == 1)
            {
                Utility.shared.beds_count = count
            }
            else{
                Utility.shared.bathroom_count = count
            }
        }
        
        else {

            
            cell.minusBtn.isEnabled = false
            cell.minusBtn.alpha = 0.5
        }
//filterTV.reloadData()
    }
    @objc func sliderValueChanged(_ sender: Any) {
//        let cell = view.viewWithTag((sender as AnyObject).tag + 9000) as! PriceRangeCell
//        let value = (sender as AnyObject).value
//        cell.priceLabel.text = "$\(value)"

    }
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        Utility.shared.priceRangeArray.removeAllObjects()
        let minimumvalue = Int(minValue)
        let maximumvalue = Int(maxValue)
        Utility.shared.priceRangeArray.add(minimumvalue)
        Utility.shared.priceRangeArray.add(maximumvalue)
       // filterTV.reloadData()
    }
    
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

@IBDesignable

class UISwitchCustom: UISwitch {
    @IBInspectable var OffTint: UIColor? {
        didSet {
            self.tintColor = OffTint
            self.layer.cornerRadius = 16
            self.backgroundColor = OffTint
        }
    }
    
    @IBInspectable var onthumbTintImage: UIImage? {
        didSet {
            self.layer.cornerRadius = 16
            self.thumbTintColor = UIColor(patternImage: onthumbTintImage!)
            self.onImage = onthumbTintImage
            self.layer.masksToBounds = true
            
            //self.backgroundColor = OffTint
        }
    }
    
    
}

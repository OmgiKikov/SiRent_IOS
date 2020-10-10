//
//  HostListingVC.swift
//  Rent_All
//
//  Created by RadicalStart on 24/07/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Apollo
import Lottie

class HostListingVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate{
   
    
    
    //MARK: - IBOUTLET & GLOBAL VARIABLE CONNECTIONS#imageLiteral(resourceName: "IMG_0872.JPG")
    
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var listingTitleLabel: UILabel!
    @IBOutlet weak var youdntlistLabel: UILabel!
    
    @IBOutlet weak var nodataLabel: UILabel!
    @IBOutlet weak var retryBtn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var offlineView: UIView!
    @IBOutlet weak var listAddBtn: UIButton!
    
    @IBOutlet weak var postnewBtn: UIButton!
    @IBOutlet weak var becomeListingTable: UITableView!
    @IBOutlet weak var topView: UIView!
    var lottieView: LOTAnimationView!
    
    var lottieViewbtn: LOTAnimationView!
    var ispublish:Bool = false
    
    var apollo_headerClient: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
        
        let url = URL(string:graphQLEndpoint)!
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()
    var manageListingArray = [ManageListingsQuery.Data.ManageListing.Result]()
    var inprogress_List_Array = [ManageListingsQuery.Data.ManageListing.Result]()
    var completed_List_Array = [ManageListingsQuery.Data.ManageListing.Result]()
  //  var longPressGesture = UILongPressGestureRecognizer()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        self.GetListSettingAPICall()
        self.CountryAPICAll()
        
        let  longPressGesture =  UILongPressGestureRecognizer(target: self, action: #selector(handlingLongTap(sender:)))
        longPressGesture.minimumPressDuration = 0.5
        longPressGesture.delegate = self
        // self.view.addGestureRecognizer(longPressGesture)
        becomeListingTable?.addGestureRecognizer(longPressGesture)
        
        // Do any additional setup after loading the view.
    }
   override func viewWillAppear(_ animated: Bool) {
    
    
        self.manageListingAPICall()
    }
//MARK: -  IBACTIONS & FUNCTIONS DECLARATIONS
    @IBAction func ListAddBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            if Utility.shared.getListSettingsArray.personCapacity != nil{
        let baseHost = BaseHostTableviewController()
        baseHost.getListSettingsArray = Utility.shared.getListSettingsArray
        Utility.shared.createId = Int()
        Utility.shared.createId = 0
        Utility.shared.host_basePrice = 0
        Utility.shared.step1_inactivestatus  = ""
        Utility.shared.isfrombecomehoststep1Edit = false
        Utility.shared.selectedAmenityIdList.removeAllObjects()
        Utility.shared.selectedspaceAmenityIdList.removeAllObjects()
        Utility.shared.selectedsafetyAmenityIdList.removeAllObjects()
        Utility.shared.selectedRules.removeAllObjects()
        Utility.shared.step2_Description = ""
        Utility.shared.step2_Title = ""
        Utility.shared.currencyvalue = ""
        Utility.shared.step1ValuesInfo = [String : Any]()
        self.view.window?.backgroundColor = UIColor.white
       baseHost.modalPresentationStyle = .fullScreen
        self.present(baseHost, animated:false, completion: nil)
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
            if IS_IPHONE_X || IS_IPHONE_XR{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-130, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
            }
            
        }
    }
    
    @IBAction func newListingBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            if Utility.shared.getListSettingsArray.personCapacity != nil{
            let baseHost = BaseHostTableviewController()
            baseHost.getListSettingsArray = Utility.shared.getListSettingsArray
            Utility.shared.createId = Int()
            Utility.shared.createId = 0
            Utility.shared.host_basePrice = 0
            Utility.shared.step1_inactivestatus = ""
            Utility.shared.isfrombecomehoststep1Edit = false
            Utility.shared.selectedAmenityIdList.removeAllObjects()
            Utility.shared.selectedspaceAmenityIdList.removeAllObjects()
            Utility.shared.selectedsafetyAmenityIdList.removeAllObjects()
            Utility.shared.selectedRules.removeAllObjects()
            Utility.shared.step2_Description = ""
            Utility.shared.step2_Title = ""
            Utility.shared.currencyvalue = ""
            Utility.shared.step1ValuesInfo = [String : Any]()
            self.view.window?.backgroundColor = UIColor.white
           baseHost.modalPresentationStyle = .fullScreen
            self.present(baseHost, animated:false, completion: nil)
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
            if IS_IPHONE_X || IS_IPHONE_XR{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-130, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
            }
            
        }
    }
    
    func initialSetup()
    {
        let shadowSize : CGFloat = 3.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.topView.frame.size.width+40 + shadowSize,
                                                   height: self.topView.frame.size.height + shadowSize))
        
        self.topView.layer.masksToBounds = false
        self.topView.layer.shadowColor = TextLightColor.cgColor
        self.topView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.topView.layer.shadowOpacity = 0.3
        self.topView.layer.shadowPath = shadowPath.cgPath
        if(IS_IPHONE_XR || IS_IPHONE_PLUS)
        {
            self.becomeListingTable.frame.size.width = FULLWIDTH+40
        }
        becomeListingTable.register(UINib(nibName: "InProgressCell", bundle: nil), forCellReuseIdentifier: "InProgressCell")
        becomeListingTable.register(UINib(nibName: "CompletedCell", bundle: nil), forCellReuseIdentifier: "CompletedCell")
        postnewBtn.backgroundColor = Theme.TERTIARY_COLOR
        self.offlineView.isHidden = true
        self.noDataView.isHidden = true
        self.postnewBtn.layer.cornerRadius = 6.0
        self.postnewBtn.layer.masksToBounds = true
        inprogress_List_Array.removeAll()
        completed_List_Array.removeAll()
        lottieViewbtn = LOTAnimationView.init(name: "animation_white")
        errorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
        retryBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
        listingTitleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"listings"))!)"
        youdntlistLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"nolistings"))!)"
        nodataLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"nolistdesc"))!)"
        postnewBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"postnewlisting"))!)", for:.normal)
        

    }
    //MARK: - CALL COUNTRYLIST API
    func CountryAPICAll()
    {
        let getcountrycodeQuery = GetCountrycodeQuery()
        apollo.fetch(query: getcountrycodeQuery){(result,error) in
            guard (result?.data?.getCountries?.results) != nil else{
                self.view.makeToast("Missing Data")
                return
            }
            Utility.shared.countrylist =  ((result?.data?.getCountries?.results)!) as! [GetCountrycodeQuery.Data.GetCountry.Result]
        }
    }
    
    
    //MARK: - Getlistsettingcall Function
    func GetListSettingAPICall()
    {
        let getlistsettingsquery = GetListingSettingQuery()
        apollo_headerClient.fetch(query: getlistsettingsquery){(result,error) in
            
            
            guard (result?.data?.getListingSettings?.results) != nil else{
                

                
                return
            }
            Utility.shared.getListSettingsArray = (result?.data?.getListingSettings?.results)!
        }
    }
    
    @objc func deleteBtnTapped(_ sender: UIButton)
    {
        if Utility().isConnectedToNetwork(){
           // self.deleteListingAPICall(listId: self.inprogress_List_Array[(sender.tag)].id!)
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
            if IS_IPHONE_X || IS_IPHONE_XR{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-130, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
            }
        }
        
        
    }
    
    @objc func indeleteBtnTapped(_ sender: UIButton)
    {
        if Utility().isConnectedToNetwork(){
            self.deleteListingAPICall(listId: self.completed_List_Array[(sender.tag)].id!)
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
            if IS_IPHONE_X || IS_IPHONE_XR{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-130, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
            }
        }
        
        
    }

    
    @objc func handlingLongTap(sender: UILongPressGestureRecognizer){
        
        if Utility.shared.isConnectedToNetwork(){
            
            let pointTouched = sender.location(in: self.becomeListingTable)
            let indexValue = self.becomeListingTable.indexPathForRow(at: pointTouched)
            
            
            if sender.state == .ended {
                let touchPoint = sender.location(in: self.becomeListingTable)
                if let indexPath = self.becomeListingTable.indexPathForRow(at: touchPoint) {
                    if(indexPath.section == 0)
                    {
                        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                        let DeleteAction: UIAlertAction = UIAlertAction(title: "\((Utility.shared.getLanguage()?.value(forKey:"delete"))!)", style: .destructive) { action in
                            
                            if indexPath.row == nil{
                                return
                            }else{
                                self.deleteListingAPICall(listId: self.inprogress_List_Array[(indexPath.row)].id!)
                            }
                            
                        }
                        let cancelAction: UIAlertAction = UIAlertAction(title: "\((Utility.shared.getLanguage()?.value(forKey:"cancel"))!)", style: .cancel) { action -> Void in }
                        actionSheetController.addAction(DeleteAction)
                        actionSheetController.addAction(cancelAction)
                        
                        // present an actionSheet...
                        present(actionSheetController, animated: true, completion: nil)
                    }
                    else
                    {
                        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                        let DeleteAction: UIAlertAction = UIAlertAction(title: "\((Utility.shared.getLanguage()?.value(forKey:"delete"))!)", style: .destructive) { action in
                            
                            if indexPath.row == nil{
                                return
                            }else{
                                self.deleteListingAPICall(listId: self.completed_List_Array[(indexPath.row)].id!)
                            }
                            
                        }
                        let cancelAction: UIAlertAction = UIAlertAction(title: "\((Utility.shared.getLanguage()?.value(forKey:"cancel"))!)", style: .cancel) { action -> Void in }
                        actionSheetController.addAction(DeleteAction)
                        actionSheetController.addAction(cancelAction)
                        
                        // present an actionSheet...
                        present(actionSheetController, animated: true, completion: nil)
                    }
                }
                
            }
            
        }else{
            
            offlineView.isHidden = false
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
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-130, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
            }
        }
    }

    
    
    
    func manageListingAPICall()
    {
        if Utility.shared.isConnectedToNetwork(){
            self.lottieAnimation()
            
            let manageListingquery = ManageListingsQuery()
            apollo_headerClient.fetch(query: manageListingquery,cachePolicy:.fetchIgnoringCacheData){(result,error) in
                if  result?.data?.manageListings?.status == 200 {
                    guard (result?.data?.manageListings?.results) != nil else{
                        print("Missing Data")
                        self.becomeListingTable.isHidden = true
                        self.noDataView.isHidden = false
                        return
                    }
                    self.becomeListingTable.isHidden = false
                    self.noDataView.isHidden = true
                    self.inprogress_List_Array.removeAll()
                    self.completed_List_Array.removeAll()
                    self.becomeListingTable.isHidden = false
                    self.manageListingArray = ((result?.data?.manageListings?.results)!) as! [ManageListingsQuery.Data.ManageListing.Result]
                    
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
                    
                    self.lottieView.isHidden = true
                    if(!self.ispublish){
                        self.becomeListingTable.reloadData()
                    }
                    else{
                        self.ispublish = false
                    }
                    if(self.manageListingArray.count == 0 )
                    {
                        self.becomeListingTable.isHidden = true
                        self.noDataView.isHidden = false
                    }
                    
                }else{
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                     let welcomeObj = WelcomePageVC()
                    // self.present(welcomeObj, animated:false, completion: nil)
                     appDelegate.setInitialViewController(initialView: welcomeObj)
                    //self.view.makeToast("Something went wrong")
                }
                
                
            }
        }else{
            offlineView.isHidden = false
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
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-130, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
            }
        }
        
    }
    
    func deleteListingAPICall(listId:Int)
    {
        if Utility.shared.isConnectedToNetwork() {
            
            let deleteListingMutation = RemoveListingMutation(listId: listId)
            apollo_headerClient.perform(mutation: deleteListingMutation){(result,error) in
                if(result?.data?.removeListing?.status == 200)
                {
                    self.lottieAnimation()
                    self.manageListingAPICall()
                }else{
                    self.view.makeToast(result?.data?.removeListing?.errorMessage)
                }
            }
        }else{
            offlineView.isHidden = false
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
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-130, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
            }
        }
        
    }
    
    @IBAction func retryBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            self.offlineView.isHidden = true
        }
        
    }
    func lottieAnimation(){
        lottieView = LOTAnimationView.init(name:"animation")
        lottieView.isHidden = false
        self.lottieView.frame = CGRect(x:FULLWIDTH/2-40, y:FULLHEIGHT/2-150, width:100, height:100)
        self.becomeListingTable.addSubview(self.lottieView)
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
    
    //MARK: -  TABLEVIEW DELEGATE & DATASOURCE METHODS
    
    func numberOfSections(in tableView: UITableView) -> Int{
        if(manageListingArray.count > 0)
        {
        return 2
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0)
        {
        if(inprogress_List_Array.count > 0)
        {
        return inprogress_List_Array.count
        }
        return 0
        }
        else{
            if(completed_List_Array.count > 0)
            {
                return completed_List_Array.count
            }
            return 0
        }
    }
    func tableView( _ tableView : UITableView,  titleForHeaderInSection section: Int)->String?
    {
        if(section == 0){
            if(manageListingArray.count > 0 &&  inprogress_List_Array.count > 0)
            {
            return "\((Utility.shared.getLanguage()?.value(forKey:"inprogress"))!)"
            }
            return ""
        }
        else if(section == 1 ){
            if(manageListingArray.count > 0 && completed_List_Array.count > 0)
            {
            return "\((Utility.shared.getLanguage()?.value(forKey:"completed"))!)"
            }
            return ""
        }
        
        return ""
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
         let headerLabel = UILabel()
        if(section == 0){
         headerLabel.frame = CGRect(x: 20, y:20, width:
            tableView.bounds.size.width, height:30)
        }
        else
        {
        headerLabel.frame = CGRect(x: 20, y:-10, width:
                tableView.bounds.size.width, height:30)
        }
        headerLabel.font = UIFont(name: "Circular-Medium", size:25)
        headerLabel.addCharacterSpacing(kernValue: 1.3)
        headerLabel.textColor = UIColor.black
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0)
        {
         if(inprogress_List_Array.count > 0)
            {
          return 60
            }
              return CGFloat.leastNormalMagnitude
        }
        else
        {
            if(completed_List_Array.count > 0)
            {
                return 30
            }
             return CGFloat.leastNormalMagnitude
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0)
        {
            return 205
        }
        return 275
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier:"InProgressCell", for: indexPath)as! InProgressCell
            cell.selectionStyle = .none
            //cell.backgroundColor = Red_color
            if(inprogress_List_Array[indexPath.row].title != nil)
            {
            cell.titleLabel.text = inprogress_List_Array[indexPath.row].title!
            }
            else{
                if(inprogress_List_Array[indexPath.row].settingsData!.count > 0)
                {
                cell.titleLabel.text = "\((inprogress_List_Array[indexPath.row].settingsData![0]!.listsettings!.itemName)!) \((Utility.shared.getLanguage()?.value(forKey:"in"))!) \(inprogress_List_Array[indexPath.row].city!)"
                }
                else
                {
                 cell.titleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"entireplacein"))!) \(inprogress_List_Array[indexPath.row].city!)"
                }
            }
            cell.updateDateLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"lastupdatedon"))!) \(getdateValue(timestamp: inprogress_List_Array[indexPath.row].updatedAt!))"
            if(inprogress_List_Array[indexPath.row].listPhotoName != nil)
            {
                let listimage = inprogress_List_Array[indexPath.row].listPhotoName!
                cell.listImage.sd_setImage(with: URL(string: "\(IMAGE_LISTING_MEDIUM)\(listimage)"), placeholderImage: #imageLiteral(resourceName: "ItemTransparentImg"))
            }
             else
            {
                cell.listImage.image = #imageLiteral(resourceName: "camera-50")
            }
            var image = String()
            if(inprogress_List_Array[indexPath.row].listPhotoName != nil){
             image = inprogress_List_Array[indexPath.row].listPhotoName!
            }
            else
            {
              image = ""
            }

            if(inprogress_List_Array[indexPath.row].listingSteps?.step1 != nil && inprogress_List_Array[indexPath.row].listingSteps?.step2  != nil && inprogress_List_Array[indexPath.row].listingSteps?.step3 != nil )
            {
            let listValue = getistPercentage(ready: inprogress_List_Array[indexPath.row].isReady!, step1:(inprogress_List_Array[indexPath.row].listingSteps?.step1!)!, step2:(inprogress_List_Array[indexPath.row].listingSteps?.step2!)!, step3: (inprogress_List_Array[indexPath.row].listingSteps?.step3!)!, imagename:image)
            cell.completeStateLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"youre"))!) \(listValue)% \((Utility.shared.getLanguage()?.value(forKey:"donelisting"))!)"
            cell.progressBar.progress = Float(listValue)/Float (100)
            }
            cell.deleteBtn.tag = indexPath.row
            cell.deleteBtn.addTarget(self, action: #selector(indeleteBtnTapped),for:.touchUpInside)
            
//           let longPressGesture =  UILongPressGestureRecognizer(target: self, action: #selector(HostListingVC.longTap))
//            longPressGesture.minimumPressDuration = 1.0
//            longPressGesture.delegate = self
//            cell.addGestureRecognizer(longPressGesture)
            //becomeListingTable.addGestureRecognizer(longPressGesture)
            

            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompletedCell", for: indexPath)as! CompletedCell
            cell.selectionStyle = .none
            if(completed_List_Array[indexPath.row].title != nil)
            {
                cell.titleLabel.text = completed_List_Array[indexPath.row].title!
            }
            else{
                if(completed_List_Array[indexPath.row].settingsData!.count > 0)
                {
                cell.titleLabel.text = "\((completed_List_Array[indexPath.row].settingsData![0]!.listsettings!.itemName)!) \((Utility.shared.getLanguage()?.value(forKey:"in"))!) \(completed_List_Array[indexPath.row].city!)"
                }
                else
                {
                  cell.titleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"entireplacein"))!) \(completed_List_Array[indexPath.row].city!)"
                }
            }
            cell.updateDateLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"lastupdatedon"))!) \(getdateValue(timestamp: completed_List_Array[indexPath.row].updatedAt!))"
            if(completed_List_Array[indexPath.row].listPhotoName != nil)
            {
                let listimage = completed_List_Array[indexPath.row].listPhotoName!
                cell.listImage.sd_setImage(with: URL(string: "\(IMAGE_LISTING_MEDIUM)\(listimage)"), placeholderImage: #imageLiteral(resourceName: "ItemTransparentImg"))
            }
            else
            {
               cell.listImage.image = #imageLiteral(resourceName: "camera-50")
            }
            var image = String()
            if(completed_List_Array[indexPath.row].listPhotoName != nil)
            {
                image = completed_List_Array[indexPath.row].listPhotoName!
            }
            else
            {
                image = ""
            }
            let listValue = getistPercentage(ready: completed_List_Array[indexPath.row].isReady!, step1:(completed_List_Array[indexPath.row].listingSteps?.step1!)!, step2:(completed_List_Array[indexPath.row].listingSteps?.step2!)!, step3: (completed_List_Array[indexPath.row].listingSteps?.step3!)!, imagename:image)
             cell.listingprogressLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"youre"))!) \(listValue)% \((Utility.shared.getLanguage()?.value(forKey:"donelisting"))!)"
            cell.progressBarView.progress = Float(listValue)/Float (100)
            cell.publishBtn.tag = indexPath.row
            cell.previewBtn.tag = indexPath.row
            if(completed_List_Array[indexPath.row].isPublished! == true)
            {
                cell.publishBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"unpublishnow"))!)", for: .normal)
                Utility.shared.unpublish_preview_check = false
            }
            else{
                cell.publishBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"publishnow"))!)", for: .normal)
                Utility.shared.unpublish_preview_check = true
            }
            cell.deleteBtn.tag = indexPath.row
            cell.publishBtn.addTarget(self, action: #selector(PublishBtnTapped),for:.touchUpInside)
            cell.previewBtn.addTarget(self, action: #selector(previewBtnTapped),for:.touchUpInside)
            cell.deleteBtn.addTarget(self, action: #selector(deleteBtnTapped),for:.touchUpInside)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if Utility().isConnectedToNetwork(){
        if(indexPath.section == 0)
        {
        let becomeHostObj = BecomeHostVC()
            if(inprogress_List_Array.count > 0)
            {
        becomeHostObj.listID = "\(inprogress_List_Array[indexPath.row].id!)"
        becomeHostObj.showListingStepsAPICall(listID: "\(inprogress_List_Array[indexPath.row].id!)")
                becomeHostObj.modalPresentationStyle = .fullScreen
        self.view.window?.rootViewController?.present(becomeHostObj, animated:false, completion: nil)
        //self.present(becomeHostObj, animated: true, completion: nil)
            }
        }
        else{
            let becomeHostObj = BecomeHostVC()
            if(completed_List_Array.count > 0)
            {
            becomeHostObj.listID = "\(completed_List_Array[indexPath.row].id!)"
            becomeHostObj.showListingStepsAPICall(listID: "\(completed_List_Array[indexPath.row].id!)")
             becomeHostObj.modalPresentationStyle = .fullScreen
            self.view.window?.rootViewController?.present(becomeHostObj, animated: false, completion: nil)
            //self.present(becomeHostObj, animated: true, completion: nil)
            }
        }
        }
        else
        {
             self.lottieView.isHidden = true
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
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-130, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
            }
            
        }
    }
    @objc func autoscrolling()
    {
        self.lottieViewbtn.play()
    }
    
    func lottienextAnimation(sender:UIButton)
    {
        lottieViewbtn = LOTAnimationView.init(name: "animation_white")
        self.lottieViewbtn.isHidden = false
        self.lottieViewbtn.frame = CGRect(x:sender.frame.size.width/2-50, y:-25, width:100, height:100)
        self.lottieViewbtn.backgroundColor = .red
        sender.addSubview(self.lottieViewbtn)
        self.lottieViewbtn.backgroundColor = UIColor.clear
        sender.setTitle("", for:.normal)
        self.lottieViewbtn.play()
        Timer.scheduledTimer(timeInterval:0.2, target: self, selector: #selector(autoscrolling), userInfo: nil, repeats: true)
    }
     @objc func PublishBtnTapped(_ sender: UIButton)
    {
        if Utility().isConnectedToNetwork(){
        let btnsendtag: UIButton = sender
            
            
            if(btnsendtag.currentTitle == "\((Utility.shared.getLanguage()?.value(forKey:"publishnow"))!)"){
                Utility.shared.unpublish_preview_check = false
                self.lottienextAnimation(sender: btnsendtag)
                PublishAPICall(listid: completed_List_Array[sender.tag].id!, action: "publish", sender: sender)
                
//                btnsendtag.setTitle("UnPublish Now", for: .normal)
            }
            else {
                Utility.shared.unpublish_preview_check = true
                self.lottienextAnimation(sender: btnsendtag)
                PublishAPICall(listid: completed_List_Array[sender.tag].id!, action: "unPublish", sender: sender)
//
//               btnsendtag.setTitle("Publish Now", for: .normal)
            }
        }
        else
        {
            self.lottieView.isHidden = true
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
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-130, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
            }
        }
       
    }
   
    func PublishAPICall(listid:Int,action:String,sender:UIButton)
    {
        let managepublishstatusMutation = ManagePublishStatusMutation(listId: listid, action: action)
        apollo_headerClient.perform(mutation: managepublishstatusMutation){(result,error) in
             let btnsendtag: UIButton = sender
    
           if(result?.data?.managePublishStatus?.status == 200)
           {
            self.lottieViewbtn.isHidden = true
            self.ispublish = true
            self.manageListingAPICall()
            if(!Utility.shared.unpublish_preview_check){
             btnsendtag.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"unpublishnow"))!)", for: .normal)
            }
            else
            {
            btnsendtag.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"publishnow"))!)", for: .normal)
            }
            }else
           {
            self.lottieViewbtn.isHidden = true
            btnsendtag.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"unpublishnow"))!)", for: .normal)
            self.view.makeToast(result?.data?.managePublishStatus?.errorMessage!)
            }
            
        }
    }
    
    @objc func previewBtnTapped(_ sender: UIButton)
    {
         if Utility().isConnectedToNetwork(){
        let guestdetailObj = GuestDetailVC()
        Utility.shared.unpublish_preview_check = true
            print(completed_List_Array[sender.tag].id!)
        guestdetailObj.listID = completed_List_Array[sender.tag].id!
        guestdetailObj.currencyvalue_from_API_base = Utility.shared.currencyvalue_from_API_base
        guestdetailObj.currency_Dict = Utility.shared.currency_Dict
        guestdetailObj.modalPresentationStyle = .fullScreen
        self.present(guestdetailObj, animated: true, completion: nil)
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
            if IS_IPHONE_X || IS_IPHONE_XR{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-130, width: FULLWIDTH, height: 55)
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
        dateFormatter.locale = NSLocale(localeIdentifier:Utility.shared.getAppLanguageCode()!) as Locale
        let date = dateFormatter.string(from: showDate)
        return date
    }
    
    func getistPercentage(ready:Bool,step1:String,step2:String,step3:String,imagename:String) -> Int
    {
        if(ready) {
            return 100
        } else if (step1 == "completed" && step2 == "completed" &&
            step3 == "completed" && !ready) {
            if (imagename == "") {
                return 90
            } else {
                return 100
            }
        } else if (step1 == "active") {
           return 20
        } else if(step1 == "completed"){
            if (step2 == "completed") {
                if (imagename == "") {
                    if (step3 == "completed") {
                       return 60
                    } else {
                        return 50
                    }
                } else {
                    return 60
                }
            } else if (imagename != "") {
                return 40
            } else {
                return 30
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

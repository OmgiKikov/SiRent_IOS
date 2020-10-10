//
//  SaveGroupPageVC.swift
//  Rent_All
//
//  Created by RadicalStart on 09/07/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Lottie
import Apollo

protocol SaveGroupPageVCDelegate: class {
    func whishDeleteAPIcall()
}

class SaveGroupPageVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,GuestDetailVCDelegate{
   
   
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "SaveGroupPageVC", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @IBOutlet weak var retryBtn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var startexploringBtn: UIButton!
    @IBOutlet weak var nothingsaveLabel: UILabel!
    @IBOutlet weak var nothingsavedesLabel: UILabel!
    @IBOutlet weak var nowhishlistView: UIView!
    @IBOutlet weak var wishlistTitle: UILabel!
    var groupwhishlistArray = [GetWishListGroupQuery.Data.GetWishListGroup.Result.WishList]()
    @IBOutlet weak var offlineView: UIView!
    @IBOutlet weak var groupCollection: UICollectionView!
    @IBOutlet weak var topView: UIView!
    var lottieView: LOTAnimationView!
    var groupID = Int()
    var delegate: SaveGroupPageVCDelegate?
    var whishlistTitle = String()
    
    var totalListcount:Int = 0
    var PageIndex : Int = 1
    
    
    let apollo_headerClient: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
        
        let url = URL(string:graphQLEndpoint)!
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lottieAnimation()
        self.initialsetup()
        //self.savedGroupAPICall(groupID:308, PageIndex: 1)
        // Do any additional setup after loading the view.
    }
   
    @IBAction func startExploringtapped(_ sender: Any) {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        Utility.shared.setTab(index: 0)
//        Utility.shared.isfromfloatmap_Page = false
//
//        self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
//        appDelegate.GuestTabbarInitialize(initialView: CustomTabbar())
        self.dismiss(animated: true, completion: nil)
        if let tabBarController = self.view.window!.rootViewController as? CustomTabbar {
             Utility.shared.setTab(index: 0)
            tabBarController.selectedIndex = 0
        }

    
    }
    
    func removeWhishlistAPICall() {
       // self.initialsetup()
        self.groupwhishlistArray.removeAll()
         self.savedGroupAPICall(groupID: groupID, PageIndex: 1)
     
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    @IBAction func backBtnTapped(_ sender: Any) {
      
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        self.dismiss(animated: false, completion: {
//            self.navigationController?.popToRootViewController(animated: true)
//            if let tabBarController = appDelegate.window!.rootViewController as? CustomTabbar {
//                Utility.shared.setTab(index: 1)
//                tabBarController.selectedIndex = 1
//            }
//        })
        self.delegate?.whishDeleteAPIcall()
        
        self.dismiss(animated: true, completion: nil)

//        Utility.shared.setTab(index: 1)
//        Utility.shared.isfromfloatmap_Page = false
//        self.view.window?.rootViewController?.dismiss(animated:false, completion: nil)
//        self.view.window?.backgroundColor = .white
//        appDelegate.GuestTabbarInitialize(initialView: CustomTabbar())
        
       //
    }
    @IBAction func moreBtnTapped(_ sender: Any) {
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // create an action
        let firstAction: UIAlertAction = UIAlertAction(title: "\((Utility.shared.getLanguage()?.value(forKey:"delete"))!)", style: .destructive) { action -> Void in
            self.deleteAPICall()
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "\((Utility.shared.getLanguage()?.value(forKey:"cancel"))!)", style: .cancel) { action -> Void in }
        
        // add actions
        actionSheetController.addAction(firstAction)
        actionSheetController.addAction(cancelAction)
        
        // present an actionSheet...
        present(actionSheetController, animated: true, completion: nil)
    }
    func initialsetup()
    {
        groupCollection.register(UINib(nibName: "ExploreCollectioncell", bundle: nil), forCellWithReuseIdentifier: "ExploreCollectioncell")
        groupCollection.register(UINib(nibName: "whishheaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "whishheaderView")
        
         groupCollection.contentSize.height = FULLHEIGHT
        
       // groupCollection.backgroundColor = .black
        self.view.bringSubviewToFront(groupCollection)
        if let flowLayout = groupCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            
            if IS_IPHONE_X{
                flowLayout.estimatedItemSize = CGSize(width:FULLWIDTH-40,height:320)
            }else{
                flowLayout.estimatedItemSize = CGSize(width:FULLWIDTH-40,height:300)
            }
            
            flowLayout.scrollDirection = .vertical
            flowLayout.headerReferenceSize = CGSize(width: FULLWIDTH-40, height:60)
            flowLayout.sectionInset = UIEdgeInsets(top:0, left:0, bottom: 0, right:0)
            
        }
       // groupCollection.delegate = self
        self.offlineView.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        
        errorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
        retryBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
        nothingsaveLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"nothingsaveyet"))!)"
        nothingsavedesLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"savedescription"))!)"
        startexploringBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"startexploring"))!)", for:.normal)
        
        //groupCollection.reloadData()
      //  self.nowhishlistView.isHidden = true
    }
    
    // Lottie AnimationView ******
    
    func lottieAnimation(){
        lottieView = LOTAnimationView.init(name:"animation")
        lottieView.isHidden = false
        self.lottieView.frame = CGRect(x:FULLWIDTH/2-40, y:FULLHEIGHT/2-150, width:100, height:100)
        self.groupCollection.addSubview(self.lottieView)
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
        self.offlineView.isHidden = true
        }
    }
    
    func savedGroupAPICall(groupID:Int,PageIndex:Int)
    {
        if Utility().isConnectedToNetwork(){
            let getwhishlistgroupquery = GetWishListGroupQuery(id: groupID, currentPage: PageIndex)
            apollo_headerClient.fetch(query: getwhishlistgroupquery,cachePolicy:.fetchIgnoringCacheData){ (result,error) in
                guard (result?.data?.getWishListGroup?.results) != nil else{
                    print("Missing Data")
                    self.nowhishlistView.isHidden = false
                    self.groupCollection.isHidden = true
                    return
                }
                if result?.data?.getWishListGroup?.status == 200 {
                    if((result?.data?.getWishListGroup?.results?.wishLists!.count)! > 0)
                    {
                        self.nowhishlistView.isHidden = true
                        
                        self.groupwhishlistArray.append(contentsOf:(((result?.data?.getWishListGroup?.results?.wishLists!)!) as! [GetWishListGroupQuery.Data.GetWishListGroup.Result.WishList]))
                        
                        self.whishlistTitle = (result?.data?.getWishListGroup?.results?.name!)!
                        self.totalListcount = ((result?.data?.getWishListGroup?.results?.wishListCount!)!)
                        
                        self.groupCollection.reloadData()
                    }
                    else
                    {
                        if(self.groupwhishlistArray.count == 0)
                        {
                            self.nowhishlistView.isHidden = false
                            self.groupCollection.isHidden = true
                        }
                    }
                }else{
                    self.nowhishlistView.isHidden = false
                    self.groupCollection.isHidden = true
                }
 
            
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
                self.offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-130, width: FULLWIDTH, height: 55)
            }else{
                self.offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
            }
        }
    }
    
    func createWhishlistAPICall(listId:Int,wishListGroupId:Int,eventKey:Bool)
    {
        let createWhishlistMutation = CreateWishListMutation(listId: listId, wishListGroupId: wishListGroupId, eventKey: eventKey)
        apollo_headerClient.perform(mutation: createWhishlistMutation){ (result,error) in
            if(result?.data?.createWishList?.status == 200) {
                self.groupwhishlistArray.removeAll()
                self.savedGroupAPICall(groupID: self.groupID, PageIndex:1)
            }
            else{
                self.view.makeToast(result?.data?.createWishList?.errorMessage!)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    func deleteAPICall()
    {
        if Utility().isConnectedToNetwork(){
            let deletewhishlistMutation = DeleteWishListGroupMutation(id: groupID)
            apollo_headerClient.perform(mutation: deletewhishlistMutation){ (result,error) in
                if(result?.data?.deleteWishListGroup?.status == 200) {
                    self.delegate?.whishDeleteAPIcall()
                    self.dismiss(animated: true, completion: nil)
                }
                else
                {
                 self.view.makeToast(result?.data?.deleteWishListGroup?.errorMessage!)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                  self.dismiss(animated: true, completion: nil)
                    }
                }
                
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
                self.offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-130, width: FULLWIDTH, height: 55)
            }else{
                self.offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
            }
        }
        
    }

    
    
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if(groupwhishlistArray.count > 0)
            {

                return groupwhishlistArray.count
            }
           return 0
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableview: UICollectionReusableView? = nil
        if kind == UICollectionView.elementKindSectionHeader {
            reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "whishheaderView", for: indexPath) // cellHea is your identifier
            let labelHeader = UILabel()
            
            if(groupwhishlistArray.count > 0)
            {

                labelHeader.text = whishlistTitle
            }
            labelHeader.font = UIFont(name: "Circular-Medium", size:28)
            labelHeader.frame = CGRect(x: 20, y:5, width: (reusableview?.frame.size.width)!, height:35)
            reusableview?.addSubview(labelHeader)
//
        }
        return reusableview!
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreCollectioncell", for: indexPath)as! ExploreCollectioncell
        if (groupwhishlistArray.count > 0)
        {
        if(groupwhishlistArray[indexPath.row].listData?.roomType != nil)
        {
            cell.entirehomeLabel.text = groupwhishlistArray[indexPath.row].listData?.roomType!
        }
        cell.homeImage.clipsToBounds = true
        cell.tag = indexPath.row + 2000
        cell.homeImage.frame.size.height = 200
        cell.entirehomeLabel.frame.origin.y = cell.homeImage.frame.size.height+cell.homeImage.frame.origin.y+10
        cell.titleLabel.frame.size.height = 25
        cell.titleLabel.frame.origin.y = cell.entirehomeLabel.frame.size.height+cell.entirehomeLabel.frame.origin.y
        cell.priceLabel.frame.origin.y = cell.titleLabel.frame.size.height+cell.titleLabel.frame.origin.y
        cell.ratingView.frame.origin.y = cell.priceLabel.frame.size.height+cell.priceLabel.frame.origin.y+5
        cell.entirehomeLabel.sizeToFit()
        let listimage = groupwhishlistArray[indexPath.row].listData?.listPhotoName!
        cell.homeImage.sd_setImage(with: URL(string: "\(IMAGE_LISTING_MEDIUM)\(listimage!)"),placeholderImage: #imageLiteral(resourceName: "ItemTransparentImg"))
        
        cell.titleLabel.text = groupwhishlistArray[indexPath.row].listData?.title!
        
        if(Utility.shared.getPreferredCurrency() != nil && Utility.shared.getPreferredCurrency() != "")
        {
            let currencysymbol = Utility.shared.getSymbol(forCurrencyCode: Utility.shared.getPreferredCurrency()!)
            let from_currency = groupwhishlistArray[indexPath.row].listData?.listingData?.currency!
            let currency_amount = groupwhishlistArray[indexPath.row].listData?.listingData?.basePrice!
            let price_value = self.getCurrencyRate(basecurrency:Utility.shared.currencyvalue_from_API_base,fromCurrency:from_currency!, toCurrency:Utility.shared.getPreferredCurrency()!, CurrencyRate:Utility.shared.currency_Dict, amount:currency_amount!)
            let restricted_price =  Double(String(format: "%.2f",price_value))
            cell.priceLabel.text = "\(currencysymbol!)\(restricted_price!.clean) \((Utility.shared.getLanguage()?.value(forKey:"pernight"))!)"
        }
        else
        {
            let currencysymbol = Utility.shared.getSymbol(forCurrencyCode:Utility.shared.currencyvalue_from_API_base)
            let from_currency = groupwhishlistArray[indexPath.row].listData?.listingData?.currency!
            let currency_amount = groupwhishlistArray[indexPath.row].listData?.listingData?.basePrice!
            let price_value = self.getCurrencyRate(basecurrency:Utility.shared.currencyvalue_from_API_base, fromCurrency:from_currency!, toCurrency:Utility.shared.currencyvalue_from_API_base, CurrencyRate:Utility.shared.currency_Dict, amount:currency_amount!)
            let restricted_price =  Double(String(format: "%.2f",price_value))
            cell.priceLabel.text = "\(currencysymbol!)\(restricted_price!.clean) \((Utility.shared.getLanguage()?.value(forKey:"pernight"))!)"
        }
        //cell.priceLabel.text = "\(currencysymbol_mostListing)\(mosthomePriceArray[indexPath.row]) per night"
        
        let shadowSize : CGFloat = 3.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: cell.frame.size.width + shadowSize,
                                                   height: cell.frame.size.height + shadowSize))
        cell.homeImage.layer.cornerRadius = 5.0
        cell.homeImage.layer.masksToBounds = true
        cell.likeBtn.tag = indexPath.row
        
        if(groupwhishlistArray[indexPath.row].listData?.reviewsStarRating != nil){
            let reviewcount = ((groupwhishlistArray[indexPath.row].listData?.reviewsStarRating!)!/(groupwhishlistArray[indexPath.row].listData?.reviewsCount!)!)
            cell.ratingView.rating = Double(reviewcount)
         
        }
        else{
            cell.ratingView.rating = 0
        }
       
         cell.likeBtn.tag = indexPath.row
         cell.likeBtn.addTarget(self, action: #selector(likeBtnTapped),for:.touchUpInside)
       
            cell.likeBtn.setImage(#imageLiteral(resourceName: "like"), for: .normal)
       
       self.lottieView.isHidden = true
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let guestdetailObj = GuestDetailVC()
        if groupwhishlistArray.count > 0 {
        guestdetailObj.delegate = self
        Utility.shared.unpublish_preview_check = false
        print((groupwhishlistArray[indexPath.row].listId!))
        guestdetailObj.listID = (groupwhishlistArray[indexPath.row].listId!)
        guestdetailObj.currencyvalue_from_API_base = Utility.shared.currencyvalue_from_API_base
        guestdetailObj.currency_Dict = Utility.shared.currency_Dict
        guestdetailObj.modalPresentationStyle = .fullScreen
        self.present(guestdetailObj, animated: true, completion: nil)
        }
    }
   
    @objc func likeBtnTapped(_ sender:UIButton!)
    {
        if Utility().isConnectedToNetwork(){
            if((groupwhishlistArray.count > sender.tag) && groupwhishlistArray[sender.tag].listId != nil)
            {
            self.createWhishlistAPICall(listId:(groupwhishlistArray[sender.tag].listId!), wishListGroupId:groupID, eventKey:false)
            }
        }
        else
        {
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
            if(CurrencyRate.count > 0)
            {
            return amount * ((CurrencyRate.object(forKey: toCurrency)as! Double) * ((1 / (CurrencyRate.object(forKey: fromCurrency)as! Double))))
            }
            return 0.0
        }
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        if Utility().isConnectedToNetwork(){
         //   if (decelerate){
                
           
           
                let totalPages = (self.totalListcount/10)
                let height = scrollView.frame.size.height+5
                let contentYoffset = scrollView.contentOffset.y
                let distanceFromBottom = scrollView.contentSize.height - contentYoffset
                if((self.groupCollection.contentOffset.y + self.groupCollection.bounds.height) >= self.groupCollection.contentSize.height)
                {
                    if(totalPages >= PageIndex){
                        self.PageIndex = self.PageIndex + 1
                        self.savedGroupAPICall(groupID:groupID,PageIndex:self.PageIndex)
                        
                    }
                }
           
        }
        else{
            self.view.addSubview(offlineView)
            self.groupCollection.bringSubviewToFront(offlineView)
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
   // }
    
    
   
}
 

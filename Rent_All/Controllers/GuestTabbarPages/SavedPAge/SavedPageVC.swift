//
//  SavedPageVC.swift
//  Rent_All
//
//  Created by RadicalStart on 16/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Lottie
import Apollo

class SavedPageVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,SaveGroupPageVCDelegate{
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: "SavedPageVC", bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  @IBOutlet weak var startexploreBtn: UIButton!
  @IBOutlet weak var nolistDescriptionLabel: UILabel!
  @IBOutlet weak var nolistsaveTitleLabel: UILabel!
  @IBOutlet weak var retryBtn: UIButton!
  @IBOutlet weak var errorLabel: UILabel!
  @IBOutlet weak var nowhishlistView: UIView!
  
  @IBOutlet weak var offlineView: UIView!
  @IBOutlet weak var savedTable: UICollectionView!
  @IBOutlet weak var topView: UIView!
  var lottieView: LOTAnimationView!
  var apollo_headerClient:ApolloClient!
  
  var whishlistarray = [GetAllWishListGroupQuery.Data.GetAllWishListGroup.Result]()
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.lottieAnimation()
    self.initialSetup()
    self.checkApolloStatus()
    //  self.WhishlistAPICall()
    
    // Do any additional setup after loading the view.
  }
  override func viewWillAppear(_ animated: Bool) {
    
    
    
    self.WhishlistAPICall()
    
    
  }
  override func viewDidAppear(_ animated: Bool) {
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
  
  func initialSetup()
  {
    savedTable.register(UINib(nibName: "WhishlistCell", bundle: nil), forCellWithReuseIdentifier: "WhishlistCell")
    savedTable.register(UINib(nibName: "whishheaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "whishheaderView")
    //   whishlistView.frame = CGRect(x: 0, y: FULLHEIGHT-320, width: FULLWIDTH, height: 320)
    self.nowhishlistView.isHidden = true
    
    if let flowLayout = savedTable.collectionViewLayout as? UICollectionViewFlowLayout {
      
      flowLayout.estimatedItemSize = CGSize(width:FULLWIDTH-40,height:260)
      flowLayout.scrollDirection = .vertical
      flowLayout.headerReferenceSize = CGSize(width: FULLWIDTH-40, height:100)
      flowLayout.sectionInset = UIEdgeInsets(top:0, left:0, bottom:0, right:0)
      
    }
    self.tabBarController?.tabBar.isHidden = false
    self.topView.isHidden = true
    self.offlineView.isHidden = true
    startexploreBtn.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
    
    errorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
    retryBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
    nolistsaveTitleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"saved"))!)"
    nolistDescriptionLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"savedescription"))!)"
    startexploreBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"startexploring"))!)", for:.normal)
    
  }
  @IBAction func startexploringTapped(_ sender: Any) {
    
    
    Utility.shared.setTab(index: 0)
    CustomTabbar().tabBarController?.selectedIndex = 0
    self.tabBarController?.selectedIndex = 0
    
    
    
  }
  func lottieAnimation(){
    lottieView = LOTAnimationView.init(name:"animation")
    lottieView.isHidden = false
    self.lottieView.frame = CGRect(x:FULLWIDTH/2-40, y:FULLHEIGHT/2-50, width:100, height:100)
    self.view.addSubview(self.lottieView)
    self.lottieView.backgroundColor = UIColor.clear
    self.lottieView.layer.cornerRadius = 6.0
    self.lottieView.clipsToBounds = true
    self.lottieView.play()
    //self.lottieView.isHidden = true
    Timer.scheduledTimer(timeInterval:0.3, target: self, selector: #selector(autoscroll), userInfo: nil, repeats: true)
  }
  @objc func autoscroll()
  {
    self.lottieView.play()
  }
  func whishDeleteAPIcall() {
    self.initialSetup()
    self.lottieAnimation()
    self.checkApolloStatus()
    self.WhishlistAPICall()
  }
  
  @IBAction func retryBtnTapped(_ sender: Any) {
    if Utility().isConnectedToNetwork(){
      self.lottieAnimation()
      self.savedTable.isHidden = false
      offlineView.isHidden = true
      self.WhishlistAPICall()
    }
  }
  
  func WhishlistAPICall()
  {
    
    if Utility().isConnectedToNetwork(){
      let whishlistQuery = GetAllWishListGroupQuery()
      apollo_headerClient.fetch(query: whishlistQuery,cachePolicy:.fetchIgnoringCacheData){ (result,error) in
        guard (result?.data?.getAllWishListGroup?.results) != nil else{
          print("Missing Data")
          self.topView.isHidden = false
          self.nowhishlistView.isHidden = false
          self.lottieView.isHidden = true
          self.savedTable.isHidden = true
          self.lottieView.isHidden = true
          return
        }
        self.nowhishlistView.isHidden = true
        self.savedTable.isHidden = false
        self.whishlistarray = ((result?.data?.getAllWishListGroup?.results)!) as! [GetAllWishListGroupQuery.Data.GetAllWishListGroup.Result]
        self.lottieView.isHidden = true
        self.savedTable.reloadData()
        
      }
    }
    else
    {
      self.lottieView.isHidden = true
      self.savedTable.isHidden = true
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
  
  //MARK:****************************************** COLLECTIONVIEW DATASOURCE & DELEGATE METHODS **********************************>
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if(whishlistarray.count>0)
    {
      return whishlistarray.count
    }
    return 0
  }
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    var reusableview: UICollectionReusableView? = nil
    if kind == UICollectionView.elementKindSectionHeader {
      reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "whishheaderView", for: indexPath) //
      let labelHeader = UILabel()
      labelHeader.text = "\((Utility.shared.getLanguage()?.value(forKey:"saved"))!)"
      
      labelHeader.font = UIFont(name: "Circular-Medium",size:28)
      labelHeader.frame = CGRect(x: 20, y:30, width: (reusableview?.frame.size.width)!, height:35)
      reusableview?.addSubview(labelHeader)
      
    }
    return reusableview!
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WhishlistCell", for: indexPath)as! WhishlistCell
    cell.tag = indexPath.item + 2000
    
    if(whishlistarray[indexPath.row].wishListCount! >= 1)
    {
      cell.homeLabel.isHidden = false
      cell.titleLabel.text = "\(whishlistarray[indexPath.row].name!)"
      cell.homeLabel.text =  "\(whishlistarray[indexPath.row].wishListCount!) \((Utility.shared.getLanguage()?.value(forKey:"home"))!)\(whishlistarray[indexPath.row].wishListCount! > 1 ? "" : "")"
      
    }
    else
    {
      cell.homeLabel.isHidden = true
      cell.titleLabel.attributedText = Utility.shared.getAtrributedstring(fullString: "\(whishlistarray[indexPath.row].name!) \((Utility.shared.getLanguage()?.value(forKey:"nothingsaveyet"))!)", ChangedString: "\((Utility.shared.getLanguage()?.value(forKey:"nothingsaveyet"))!)")
    }
    
    
    cell.whishImage.layer.cornerRadius = 5.0
    cell.whishImage.layer.masksToBounds = true
    cell.whishImage.frame.size.height = 200
    cell.titleLabel.frame.origin.y = 215
    cell.homeLabel.frame.origin.y = 215
    cell.homeLabel.frame.origin.x = cell.titleLabel.frame.origin.x + cell.titleLabel.frame.size.width
    
    
    cell.likeImage.isHidden = true
    if(whishlistarray[indexPath.row].wishListCount!>0)
    {
      let listimage = whishlistarray[indexPath.row].wishListCover?.listData?.listPhotoName!
      if(listimage != nil)
      {
        cell.whishImage.sd_setImage(with: URL(string:"\(IMAGE_LISTING_MEDIUM)\(listimage!)"), placeholderImage: #imageLiteral(resourceName: "ItemTransparentImg"))
      }
      else{
        cell.whishImage.image = #imageLiteral(resourceName: "box-with-like")
      }
    }
    else
    {
      cell.likeImage.isHidden = true
      cell.whishImage.image = #imageLiteral(resourceName: "box-with-like")
    }
    
    
    return cell
  }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if Utility().isConnectedToNetwork(){
      let savedPageObj = SaveGroupPageVC()
      savedPageObj.groupID = whishlistarray[indexPath.row].id!
      savedPageObj.savedGroupAPICall(groupID:whishlistarray[indexPath.row].id!, PageIndex: 1)
      savedPageObj.delegate = self
      self.definesPresentationContext = true
      savedPageObj.modalPresentationStyle = .overCurrentContext
      savedPageObj.modalPresentationStyle = .fullScreen
      self.present(savedPageObj, animated: true, completion: nil)
    }
    else
    {
      self.lottieView.isHidden = true
      self.savedTable.isHidden = true
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
  
}

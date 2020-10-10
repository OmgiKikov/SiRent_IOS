//
//  WhishlistPageVC.swift
//  Rent_All
//
//  Created by RadicalStart on 03/07/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Apollo
import Lottie

protocol WhishlistPageVCProtocol
{
    func APIMethodCall()
    func didupdateWhishlistStatus(status:Bool)
    
    
}

class WhishlistPageVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate {
    
    
    //MARK*********************************** IBOUTLET CONNECTIONS & GLOBAL VARIABLE DECLARATIONS *******************************************>
    
    @IBOutlet weak var noWhishlistView: UILabel!
    @IBOutlet weak var whishlistView: UIView!
    @IBOutlet weak var chooseLabel: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var whishlistCollection: UICollectionView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "WhishlistPageVC", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let apollo_headerClient: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
        
        let url = URL(string:graphQLEndpoint)!
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()
    var whishlistarray = [GetAllWishListGroupQuery.Data.GetAllWishListGroup.Result]()
    var listID = Int()
    var listimage = String()
    var senderID = Int()
    var Whishlist_status = Bool()
    var lottieView: LOTAnimationView!
    
    var delegate: WhishlistPageVCProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
       // self.WhishlistAPICall()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.lottieAnimation()
        self.whishlistarray.removeAll()
        self.WhishlistAPICall()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
  func initialSetup()
  {
    whishlistCollection.register(UINib(nibName: "WhishlistCell", bundle: nil), forCellWithReuseIdentifier: "WhishlistCell")
 //   whishlistView.frame = CGRect(x: 0, y: FULLHEIGHT-320, width: FULLWIDTH, height: 320)
    noWhishlistView.isHidden = true
    if let flowLayout = whishlistCollection.collectionViewLayout as? UICollectionViewFlowLayout {
        
        flowLayout.estimatedItemSize = CGSize(width:(FULLWIDTH/2)+50,height:205)
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
        
    }
    chooseLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"chooselist"))!)"
    noWhishlistView.text = "\((Utility.shared.getLanguage()?.value(forKey:"nowhishlistdesc"))!)"
}
    func lottieAnimation(){
        lottieView = LOTAnimationView.init(name:"animation")
        lottieView.isHidden = false
        self.lottieView.frame = CGRect(x:FULLWIDTH/2-40, y:whishlistCollection.frame.size.height/2-50, width:100, height:100)
        self.whishlistCollection.addSubview(self.lottieView)
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
    func WhishlistAPICall()
    {
        let whishlistQuery = GetAllWishListGroupQuery()
            apollo_headerClient.fetch(query: whishlistQuery,cachePolicy:.fetchIgnoringCacheData){ (result,error) in
            guard (result?.data?.getAllWishListGroup?.results) != nil else{
                print("Missing Data")
              //  self.lottieView1.isHidden = true
               
                self.lottieView.isHidden = true
                self.noWhishlistView.isHidden = false
                self.whishlistCollection.isHidden = true
                return
            }
        self.whishlistarray = ((result?.data?.getAllWishListGroup?.results)!) as! [GetAllWishListGroupQuery.Data.GetAllWishListGroup.Result]
                if(self.whishlistarray.count>0)
                {
                  //  self.lottieView1.isHidden = true
                    
                    self.lottieView.isHidden = true
                    self.noWhishlistView.isHidden = true
                    self.whishlistCollection.isHidden = false
                    let cell = self.view.viewWithTag(2000) as? WhishlistCell
                    cell?.lottieView1 = LOTAnimationView.init(name:"animation_white")
                    cell?.lottieView1.isHidden = true
                     self.whishlistCollection.reloadData()
                }
                else
                {
                   // self.lottieView1.isHidden = true
                    self.lottieView.isHidden = true
                    self.noWhishlistView.isHidden = false
                    self.whishlistCollection.isHidden = true
                }
        
    }
    }
    func createWhishlistAPICall(listId:Int,wishListGroupId:Int,eventKey:Bool)
    {
        let createWhishlistMutation = CreateWishListMutation(listId: listId, wishListGroupId: wishListGroupId, eventKey: eventKey)
        apollo_headerClient.perform(mutation: createWhishlistMutation){ (result,error) in
            if(result?.data?.createWishList?.status == 200) {
                self.WhishlistAPICall()
            }
            else{
        
            }
    }
    }
    
    @IBAction func addBtnTapped(_ sender: Any) {
        let createListObj = CreateListVC()
        createListObj.modalPresentationStyle = .fullScreen
        self.present(createListObj, animated: true, completion: nil)
    }
    
    @objc func dismissView()
    {
        self.tabBarController?.tabBar.isHidden = false
        delegate?.didupdateWhishlistStatus(status:Whishlist_status)
        delegate?.APIMethodCall()
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if whishlistView.bounds.contains(touch.location(in: whishlistView)) {
            return false
        }
        return true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(whishlistarray.count>0)
        {
        return whishlistarray.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WhishlistCell", for: indexPath)as! WhishlistCell
        cell.tag = indexPath.item + 2000
       // cell.titleLabel.frame.size.width = 350
        if(whishlistarray.count>0)
        {
        if(whishlistarray[indexPath.row].wishListCount! >= 1)
        {

           
            cell.homeLabel.isHidden = false

             cell.titleLabel.text = "\(whishlistarray[indexPath.row].name!)"
            
            DispatchQueue.main.async {
                cell.titleLabel.frame.size.width = 261
            }
            
            cell.homeLabel.text =  "\(whishlistarray[indexPath.row].wishListCount!) \((Utility.shared.getLanguage()?.value(forKey:"home"))!)\(whishlistarray[indexPath.row].wishListCount! > 1 ? "s" : "")"
        }
        else
        {
            cell.titleLabel.attributedText = Utility.shared.getAtrributedstring(fullString: "\(whishlistarray[indexPath.row].name!) \((Utility.shared.getLanguage()?.value(forKey:"nothingsaveyet"))!)", ChangedString: "\((Utility.shared.getLanguage()?.value(forKey:"nothingsaveyet"))!)")
            DispatchQueue.main.async {
                   cell.titleLabel.frame.size.width = 350
            }
         
            cell.homeLabel.isHidden = true
            
        }
        //
        cell.whishImage.layer.cornerRadius = 5.0
        cell.whishImage.layer.masksToBounds = true
        cell.whishImage.clipsToBounds = true
        cell.lineLabel.isHidden = true
        cell.likeImage.isHidden = false
        cell.lottieView1 = LOTAnimationView.init(name:"animation")
        cell.lottieView1.isHidden = true
        if(whishlistarray[indexPath.row].wishListCount!>0)
        {
            let listimage = whishlistarray[indexPath.row].wishListCover?.listData?.listPhotoName!
            if(listimage != nil)
            {
           cell.whishImage.sd_setImage(with: URL(string: "\(IMAGE_LISTING_MEDIUM)\(listimage!)"), placeholderImage: #imageLiteral(resourceName: "box-with-like"))
            }
            else
            {
                cell.whishImage.image = #imageLiteral(resourceName: "box-with-like")
            }
            
           
         
            if((whishlistarray[indexPath.row].wishListIds?.contains(listID))!)
             {
                cell.likeImage.isHidden = false
                cell.likeImage.image = #imageLiteral(resourceName: "whish_red_like")
            }
             else{
                cell.likeImage.isHidden = false
                cell.likeImage.image = #imageLiteral(resourceName: "whishlike")
            }
        }
        else
        {
            cell.likeImage.isHidden = true
            cell.whishImage.image = #imageLiteral(resourceName: "box-with-like")
        }
        
       
        }
       
       
       
        //cell.homeImage.sd_setImage(with: URL(string: "\(IMAGE_LISTING_MEDIUM)\(listimage)"), placeholderImage: #imageLiteral(resourceName: "home-1"))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         if Utility().isConnectedToNetwork(){
        let cell = view.viewWithTag(indexPath.item + 2000) as? WhishlistCell
           cell?.lottieAnimationView()
        // Timer.scheduledTimer(timeInterval:0.3, target: self, selector: #selector(cell?.autoscroll), userInfo: nil, repeats: true)
            //cell?.likeImage.isHidden = false
            
         if(whishlistarray.count > 0)
         {
        if((whishlistarray[indexPath.row].wishListIds?.contains(listID))!)
        {
        self.createWhishlistAPICall(listId: listID, wishListGroupId: whishlistarray[indexPath.row].id!, eventKey: false)
        Whishlist_status = false
        }
        else
        {
        self.createWhishlistAPICall(listId: listID, wishListGroupId: whishlistarray[indexPath.row].id!, eventKey: true)
        Whishlist_status = true

        }
        }
        }
         else{
            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)")
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

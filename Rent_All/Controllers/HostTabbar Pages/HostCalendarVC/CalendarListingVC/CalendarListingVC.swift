//
//  CalendarListingVC.swift
//  Rent_All
//
//  Created by RadicalStart on 02/08/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Apollo
import Lottie

protocol CalendarListingVCProtocol
{
    func manageListingAPICall()
    func BlockedlistAPICall(listId:Int)
    func APICall(listImage:String,title:String,entireTitle:String,listId:Int)
    
    
}

class CalendarListingVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate{
    
    
    @IBOutlet weak var offlineView: UIView!
    
    @IBOutlet weak var retryBtn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var CalendarListingTable: UITableView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var CalendarPopView: UIView!
    var manageListingArray = [ManageListingsQuery.Data.ManageListing.Result]()
    var inprogress_List_Array = [ManageListingsQuery.Data.ManageListing.Result]()
    var completed_List_Array = [ManageListingsQuery.Data.ManageListing.Result]()
    var apollo_headerClient: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
        
        let url = URL(string:graphQLEndpoint)!
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()
  //  var selected_Array  = NSMutableArray()
     var lottieView: LOTAnimationView!
    var deleagte:CalendarListingVCProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        self.lottieAnimation()
        self.manageListingAPICall()
        
//        let aSelector : Selector = #selector(removeSubview)
//        let tapGesture = UITapGestureRecognizer(target:self, action: aSelector)
//        tapGesture.delegate = self
//        self.view.addGestureRecognizer(tapGesture)
//
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

        // Do any additional setup after loading the view.
    }

    @IBAction func closeBtnTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func retryBtnTapped(_ sender: Any) {
    }
//    @objc func removeSubview(){
//        
//        
//        
//        self.tabBarController?.tabBar.isHidden = false
//        
//        self.view.removeFromSuperview()
//        self.willMove(toParent: nil)
//        self.removeFromParent()
//        
//        //self.removeSubview()
//    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if CalendarPopView.bounds.contains(touch.location(in: CalendarPopView)) {
            return false
        }
        return true
    }
    
    func lottieAnimation(){
        lottieView = LOTAnimationView.init(name:"animation")
        lottieView.isHidden = false
        self.lottieView.frame = CGRect(x:FULLWIDTH/2-60, y:FULLHEIGHT/2-50, width:100, height:100)
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
    func manageListingAPICall()
    {
        let manageListingquery = ManageListingsQuery()
        apollo_headerClient.fetch(query: manageListingquery,cachePolicy:.fetchIgnoringCacheData){(result,error) in
            guard (result?.data?.manageListings?.results) != nil else{
                print("Missing Data")
                return
            }
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
            self.CalendarPopView.isHidden = false
            if(IS_IPHONE_XR || IS_IPHONE_XS_MAX || IS_IPHONE_X || IS_IPHONE_PLUS)
            {
                self.CalendarPopView.frame.origin.y = 100
            }
//            self.CalendarPopView.frame.size.height =  CGFloat(self.completed_List_Array.count * 90)
//            self.CalendarListingTable.frame.size.height = CGFloat(self.completed_List_Array.count * 90)
            
            self.CalendarListingTable.reloadData()
            
        }
        
    }
    
    func initialSetup()
    {
        CalendarListingTable.register(UINib(nibName: "CalendarListCell", bundle: nil), forCellReuseIdentifier: "CalendarListCell")
        inprogress_List_Array.removeAll()
        completed_List_Array.removeAll()
        //self.CalendarPopView.layer.cornerRadius = 6.0
       // self.CalendarPopView.layer.masksToBounds = true
        if IS_IPHONE_XR
        {
            self.CalendarPopView.frame = CGRect(x:30, y: 50, width:FULLWIDTH-60, height:FULLHEIGHT-150)
        }
        self.CalendarPopView.isHidden = true
        self.offlineView.isHidden = true
        errorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
        retryBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(completed_List_Array.count > 0)
        {
        return completed_List_Array.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(completed_List_Array.count > 0)
        {
            return 95
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarListCell", for: indexPath)as! CalendarListCell
        cell.selectionStyle = .none
        if(completed_List_Array[indexPath.row].listPhotoName != nil)
        {
            let listimage = completed_List_Array[indexPath.row].listPhotoName!
            cell.listimage.sd_setImage(with: URL(string: "\(IMAGE_LISTING_MEDIUM)\(listimage)"), placeholderImage: #imageLiteral(resourceName: "ItemTransparentImg"))
        }
        else
        {
            cell.listimage.image = #imageLiteral(resourceName: "camera-50")
        }
        if(completed_List_Array[indexPath.row].title != nil)
        {
            cell.titleLabel.text = completed_List_Array[indexPath.row].title!
        }
        else{
            cell.titleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"entireplacein"))!) \(completed_List_Array[indexPath.row].city!)"
        }
        if(completed_List_Array[indexPath.row].settingsData!.count > 0)
        {
        cell.entireLabel.text = completed_List_Array[indexPath.row].settingsData![0]?.listsettings?.itemName!
        }
        else
        {
         cell.entireLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"entireplace"))!)"
        }
        if(Utility.shared.host_selected_Array.contains(completed_List_Array[indexPath.row].id!))
        {
            cell.tickImage.isHidden  = false
        }
        else
        {
            if(Utility.shared.host_selected_Array.count == 0)
            {
                if(indexPath.row == 0)
                {
               cell.tickImage.isHidden  = false
                }
                else
                {
                  cell.tickImage.isHidden  = true
                }
            }
            else
            {
              cell.tickImage.isHidden  = true
            }
          
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(Utility.shared.host_selected_Array.contains(completed_List_Array[indexPath.row].id!))
        {
            Utility.shared.host_selected_Array.remove(completed_List_Array[indexPath.row].id!)
        }
        else
        {
        Utility.shared.host_selected_Array.removeAllObjects()
        Utility.shared.host_selected_Array.add(completed_List_Array[indexPath.row].id!)
        }
        //CalendarListingTable.reloadData()
        
        var entireTitle = String()
        if(completed_List_Array[indexPath.row].settingsData!.count > 0 && completed_List_Array[indexPath.row].settingsData![0]?.listsettings?.itemName != nil)
        {
          entireTitle = (completed_List_Array[indexPath.row].settingsData![0]?.listsettings?.itemName!)!
        }
        else
        {
          entireTitle = "\((Utility.shared.getLanguage()?.value(forKey:"entireplace"))!)"
        }
        Utility.shared.isfrom_availability_calendar = true
        deleagte?.BlockedlistAPICall(listId: completed_List_Array[indexPath.row].id!)
    deleagte?.APICall(listImage:completed_List_Array[indexPath.row].listPhotoName!,title:completed_List_Array[indexPath.row].title!,entireTitle:entireTitle, listId: completed_List_Array[indexPath.row].id!)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func offlineViewShow()
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

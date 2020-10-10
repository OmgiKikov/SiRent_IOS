//
//  TripsMessageVC.swift
//  Rent_All
//
//  Created by RADICAL START on 22/03/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Apollo
import Lottie
class TripsMessageVC: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    
    //MARK******************************************* IBOUTLET CONNECTIONS & VARIABLE DECLARATIONS ********************************************>
    
    @IBOutlet weak var retryBtn: UIButton!
    @IBOutlet weak var errorLAbel: UILabel!
    @IBOutlet weak var inboxnoLabel: UILabel!
    @IBOutlet weak var nomessageLabel: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var noMessageView: UIView!
    
    @IBOutlet weak var offlineView: UIView!
    @IBOutlet weak var inboxTable: UITableView!
    var totalListcount:Int = 0
    var PageIndex : Int = 1
    var getallMessageArray = [GetAllThreadsQuery.Data.GetAllThread.Result]()
  
    var apollo_headerClient:ApolloClient!
     var lottieView: LOTAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = false
        self.checkApolloStatus()
        self.initialsetup()
        self.lottieAnimation()
//        DispatchQueue.main.async {
//            self.noMessageView.isHidden = true
//            self.getallMessageArray.removeAll()
//            self.PageIndex = 1
//            self.getMessageAPICall()
//        }
        // Do any additional setup after loading the view.
        
//
//        if let tabBarController = self.view.window!.rootViewController as? CustomHostTabbar {
//            Utility.shared.setHostTab(index: 3)
//            tabBarController.selectedIndex = 3
//        }
//
            Utility.shared.isFromMessageListingPage_host = false
            Utility.shared.isFromMessageListingPage_guest = false
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
        //self.initialsetup()
        Utility.shared.timer.invalidate()
        self.lottieAnimation()
        DispatchQueue.main.async {
            self.noMessageView.isHidden = true
            self.getallMessageArray.removeAll()
            self.PageIndex = 1
            self.getMessageAPICall()
        }

    }
  func initialsetup()
  {
    
//    if IS_IPHONE_XR
//    {
//        inboxTable.frame = CGRect(x: 0, y:40, width: FULLWIDTH-20, height: FULLHEIGHT-400)
//        
//    }
    inboxTable.register(UINib(nibName: "InboxCell", bundle: nil), forCellReuseIdentifier: "InboxCell")
    inboxTable.register(UINib(nibName: "InboxContentCell", bundle: nil), forCellReuseIdentifier: "InboxContentCell")
    inboxTable.register(UINib(nibName: "NomessageCell", bundle: nil), forCellReuseIdentifier: "NomessageCell")
    self.offlineView.isHidden = true
    lottieView = LOTAnimationView.init(name:"animation")
    loginBtn.isHidden = true
    
    if(Utility.shared.getTabbar()!)
    {
      self.nomessageLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"nomessageguest"))!)"
    }
    else
    {
      self.nomessageLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"nomessagehost"))!)"
    }
    }
    func lottieAnimation(){
        
        lottieView = LOTAnimationView.init(name:"animation")
        lottieView.isHidden = false
        self.lottieView.frame = CGRect(x:FULLWIDTH/2-40, y:FULLHEIGHT/2-50, width:100, height:100)
        //self.lottieView.frame = CGRect(x:FULLWIDTH/2-40, y:FULLHEIGHT/2-150, width:100, height:100)
        self.view.addSubview(self.lottieView)
        self.lottieView.backgroundColor = UIColor.clear
        self.lottieView.layer.cornerRadius = 6.0
        self.lottieView.clipsToBounds = true
        self.lottieView.play()
        // Timer.scheduledTimer(timeInterval:0.3, target: self, selector: #selector(autoscroll), userInfo: nil, repeats: true)
        
        loginBtn.setBorder(color: Theme.PRIMARY_COLOR)
        loginBtn.layer.cornerRadius = 6.0
        loginBtn.layer.masksToBounds = true
        noMessageView.isHidden = true
        
            errorLAbel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
        retryBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
        loginBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"login_string"))!)", for: .normal)
            inboxnoLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"inbox"))!)"
        
    }

  //MARK******************************************************* TABLEVIEW DELEGATE &DATASOURCE METHODS *************************************************>
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0)
        {
        return 1
        }
        else{
            if(getallMessageArray.count > 0)
            {
                return getallMessageArray.count
            }
            else{
            return 0
            }
           
        }
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0)
        {
            return 90
        }
        else{
            if(getallMessageArray.count > 0)
            {
        return 120
            }
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InboxCell", for: indexPath)as!InboxCell
            cell.selectionStyle = .none
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "InboxContentCell", for: indexPath)as!InboxContentCell
            cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.width/2
            cell.profileImage.layer.masksToBounds = true
            cell.approvedLabel.layer.cornerRadius = 6.0
            cell.approvedLabel.layer.masksToBounds = true
            cell.selectionStyle = .none
            if(getallMessageArray.count > 0)
            {
                if(Utility.shared.getTabbar()!)
                {
                  cell.nameLAbel.text = getallMessageArray[indexPath.row].guestProfile?.displayName!
                }
                else
                {
            cell.nameLAbel.text = getallMessageArray[indexPath.row].hostProfile?.displayName!
                }
            if(getallMessageArray[indexPath.row].hostProfile?.picture != nil)
            {
                var listimage = String()
                if(Utility.shared.getTabbar()!)
                {
                    if(getallMessageArray[indexPath.row].guestProfile?.picture != nil)
                    {
                        listimage = (getallMessageArray[indexPath.row].guestProfile?.picture!)!
                      
                    }
                    
                }
                else
                {
                   listimage = (getallMessageArray[indexPath.row].hostProfile?.picture!)!
                }
            cell.profileImage.sd_setImage(with: URL(string: "\(IMAGE_AVATAR_MEDIUM)\(listimage)"), placeholderImage: #imageLiteral(resourceName: "unknown"))
            }
            else
            {
            cell.profileImage.image = #imageLiteral(resourceName: "unknown")
            }
            
             if((getallMessageArray[indexPath.row].threadItem?.type == "message") || (getallMessageArray[indexPath.row].threadItem?.type == "intantBooking"))
             {
                
                cell.approvedLabel.isHidden = true
                cell.dateLabel.text = getdateValue(timestamp:(getallMessageArray[indexPath.row].threadItem?.createdAt!)!)
            }else
             {
                //if(cell.messageLabel.isHidden){
            cell.approvedLabel.isHidden = false
                cell.approvedLabel.text = Utility.shared.getbookingtype(type:(getallMessageArray[indexPath.row].threadItem?.type!)!)
                //}
            //cell.approvedLabel.backgroundColor = Utility.shared.getcolorcode(type:(getallMessageArray[indexPath.row].threadItem?.type!.firstUppercased)!)
            cell.dateLabel.text = getdateValue(timestamp:(getallMessageArray[indexPath.row].threadItem?.createdAt!)!)
            //cell.approvedLabel.textAlignment = .center
            }
                if((getallMessageArray[indexPath.row].threadItem?.content == nil) || (getallMessageArray[indexPath.row].threadItem?.content == ""))
                {
                    cell.messageLabel.isHidden = true
                    if(getallMessageArray[indexPath.row].threadItem?.type == "requestToBook" || getallMessageArray[indexPath.row].threadItem?.type == "cancelledByGuest" || getallMessageArray[indexPath.row].threadItem?.type == "cancelledByHost" || getallMessageArray[indexPath.row].threadItem?.type == "confirmed" || getallMessageArray[indexPath.row].threadItem?.type == "preApproved")
                    {
                        cell.approvedLabel.frame = CGRect(x: cell.approvedLabel.frame.origin.x, y: 45, width:220, height: cell.approvedLabel.frame.size.height)
                    }
                    else
                    {
                       cell.approvedLabel.frame = CGRect(x: cell.approvedLabel.frame.origin.x, y: 45, width:220, height: cell.approvedLabel.frame.size.height)
                    }
                   
                  
                }
                else
                {
                    if(getallMessageArray[indexPath.row].threadItem?.type == "requestToBook" || getallMessageArray[indexPath.row].threadItem?.type == "cancelledByGuest" || getallMessageArray[indexPath.row].threadItem?.type == "cancelledByHost" || getallMessageArray[indexPath.row].threadItem?.type == "confirmed" || getallMessageArray[indexPath.row].threadItem?.type == "preApproved")
                    {
                        cell.approvedLabel.frame = CGRect(x: cell.approvedLabel.frame.origin.x, y: 70, width:220, height: cell.approvedLabel.frame.size.height)
                    }
                    else
                    {
                        cell.approvedLabel.frame = CGRect(x: cell.approvedLabel.frame.origin.x, y: 70, width:220, height: cell.approvedLabel.frame.size.height)
                    }
                    cell.messageLabel.isHidden = false
                    
                    cell.messageLabel.text = getallMessageArray[indexPath.row].threadItem?.content!
                }
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 1)
        {
            if Utility().isConnectedToNetwork(){
        let InboxListingObj = InboxListingVC()
                if(getallMessageArray.count > 0)
                {
        InboxListingObj.threadId = (getallMessageArray[indexPath.row].threadItem?.threadId!)!
        InboxListingObj.getmessageListquery.removeAll()
        InboxListingObj.getMessageListAPICall(threadId:(getallMessageArray[indexPath.row].threadItem?.threadId!)!)
        Utility.shared.PreapproveValue.removeAllObjects()
        Utility.shared.PreapproveValue.add(getallMessageArray[indexPath.row])
        Utility.shared.ListID = "\((getallMessageArray[indexPath.row].listId)!)"
        InboxListingObj.modalPresentationStyle = .fullScreen
        self.present(InboxListingObj, animated: true, completion: nil)
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
                    offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-140, width: FULLWIDTH, height: 55)
                }else{
                    offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
                }
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
    
    @IBAction func retryBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
        self.offlineView.isHidden = true
        self.getallMessageArray.removeAll()
        PageIndex = 1
        self.getMessageAPICall()
        }
       
    }
    func getMessageAPICall()
    {
        if Utility().isConnectedToNetwork(){
            var threadtype = String()

            if(Utility.shared.getTabbar()! || Utility.shared.isfromNotificationHost || Utility.shared.isfromBackroundBooking || Utility.shared.isfromOfflineNotification || Utility.shared.isfromOfflineBooking)

            {
              threadtype = HOST
            }
            else{
                threadtype = GUEST
            }
            
            let getmessagequery = GetAllThreadsQuery(threadType:threadtype,currentPage:PageIndex)
            
            apollo_headerClient.fetch(query:getmessagequery,cachePolicy:.fetchIgnoringCacheData){(result,error) in
                guard (result?.data?.getAllThreads?.results) != nil else{
                    print("Missing Data")
                    if(self.getallMessageArray.count == 0)
                    {
                        self.inboxTable.isHidden = true
                        self.noMessageView.isHidden = false
                    }
                    else
                    {
                        self.inboxTable.isHidden = false
                        self.noMessageView.isHidden = true
                    }
                   
                    return
                }
                self.offlineView.isHidden = true
                self.inboxTable.isHidden = false
                self.lottieView.isHidden = true
                self.totalListcount = (result?.data?.getAllThreads?.count)!
                //self.getallreservationquery = (result?.data?.getAllReservation?.result)! as! [GetAllReservationQuery.Data.GetAllReservation.Result]
                //            if(result?.data?.searchListing?.currentPage == 1){
                //                self.FilterArray.removeAll()
                //            }
                 self.getallMessageArray.append(contentsOf: ((result?.data?.getAllThreads?.results)!) as! [GetAllThreadsQuery.Data.GetAllThread.Result])
                
                
               self.inboxTable.reloadData()
                
            }
        }
        else{
            // self.previousTable.isHidden = true
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
            if IS_IPHONE_XR {
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-140, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
            }
            
        }
        
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
            let totalPages = (self.totalListcount/10)
            let height = scrollView.frame.size.height
            let contentYoffset = scrollView.contentOffset.y
            let distanceFromBottom = scrollView.contentSize.height - contentYoffset
            if((self.inboxTable.contentOffset.y + self.inboxTable.bounds.height) >= self.inboxTable.contentSize.height)
            {
                //   if distanceFromBottom < height {
                if(totalPages >= PageIndex){
                    self.PageIndex = self.PageIndex + 1
                    self.getMessageAPICall()
                    
                }
            }
        
        
    }

}

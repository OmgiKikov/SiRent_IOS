//
//  ProfilePageVC.swift
//  Rent_All
//
//  Created by RADICAL START on 22/03/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Apollo
import  Lottie





class ProfilePageVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UITabBarControllerDelegate,UITabBarDelegate{
    
    
    
    //***************************************IBOUTLET CONNECTIONS  & GLOBAL DECLARATIONS *********************************************************>
    @IBOutlet weak var profileTable: UITableView!
    
    @IBOutlet weak var profileBackImage: UIImageView!
    @IBOutlet weak var offlineView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var profileName: UILabel!
    
    var ProfileArray = NSMutableArray()
    var ProfileTickImageArray = NSMutableArray()
     var lottieView: LOTAnimationView!
    let webview = UIWebView()
    var ProfileAPIArray = GetProfileQuery.Data.UserAccount.Result()
    
    var apollo_headerClient:ApolloClient!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkApolloStatus()
        CustomTabbar().delegate = self
       webview.frame = profileTable.frame
        
       // profileTable.addSubview(webview)
       

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
        self.initialSetup()
        self.lottieAnimation()
        self.profileAPICall()
        
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController)
    {
         print("Test")
    }
//    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        print("Test")
//    }

    
    func initialSetup()
    {
         self.offlineView.isHidden = true
        profileTable.frame = CGRect(x: 0, y:0, width: FULLWIDTH, height: FULLHEIGHT)
        profileTable.register(UINib(nibName: "HeaderProfileCell", bundle: nil), forCellReuseIdentifier: "HeaderProfileCell")
        profileTable.register(UINib(nibName: "SwitchtohostCell", bundle: nil), forCellReuseIdentifier: "SwitchtohostCell")
       // ProfileArray = ["Connect Email","Connect Facebook","Connect Google","Verify Phone Number","Logout","VERSION 1.0"]
        ProfileArray = ["Terms & Privacy","Get help","About Us","Version 1.0","Logout"]
        ProfileTickImageArray = [#imageLiteral(resourceName: "profile_Verify_Tick"),#imageLiteral(resourceName: "profile_NotVerify_Tick"),#imageLiteral(resourceName: "profile_NotVerify_Tick"),#imageLiteral(resourceName: "profile_NotVerify_Tick"),#imageLiteral(resourceName: "profile_NotVerify_Tick")]
    }
    
    func lottieAnimation(){
        lottieView = LOTAnimationView.init(name:"animation")
        lottieView.isHidden = false
        self.lottieView.frame = CGRect(x:FULLWIDTH/2-40, y:FULLHEIGHT/2-150, width:100, height:100)
        self.profileTable.addSubview(self.lottieView)
        self.lottieView.backgroundColor = UIColor.clear
        self.lottieView.layer.cornerRadius = 6.0
        self.lottieView.clipsToBounds = true
        self.lottieView.play()
    }
    
    func profileAPICall()
    {
         if Utility().isConnectedToNetwork(){
        let profileQuery = GetProfileQuery()
        
        apollo_headerClient.fetch(query:profileQuery,cachePolicy:.fetchIgnoringCacheData){(result,error) in
            
            guard (result?.data?.userAccount?.result) != nil else
        {
            print("Missing Data")
            return
        }
            
            print(result?.data?.userAccount?.result as Any)
            
            self.ProfileAPIArray = ((result?.data?.userAccount?.result)!)
            self.profileTable.reloadData()
            self.lottieView.isHidden = true
        }
        }
        
         else{
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

    @IBAction func backBtnTapped(_ sender: Any) {
    }
    @IBAction func editprofileTapped(_ sender: Any) {
    }
    
    
    
    
    
    //******************************************************** TABLEVIEW DELEGATE & DATASOURCE METHODS ********************************************>

    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if(ProfileAPIArray.userId != nil)
    {
      if(section == 0)
      {
        return 1
        }
      else {
        return ProfileArray.count
        }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(ProfileAPIArray.userId != nil)
        {
        if(indexPath.section == 0)
        {
            return 170
        }
        else{
           return 80
        }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderProfileCell", for: indexPath) as! HeaderProfileCell
            cell.profileName.text = "\(ProfileAPIArray.displayName!)".firstUppercased
            if(ProfileAPIArray.picture != nil)
            {
            let profImage = ProfileAPIArray.picture!
            cell.profileImage.sd_setImage(with: URL(string:"\(IMAGE_AVATAR_MEDIUM)\(profImage)"), placeholderImage: #imageLiteral(resourceName: "unknown"))
          
            }
            else
            {
              cell.profileImage.image = #imageLiteral(resourceName: "unknown")
        
            }
            
            cell.profileImage.cornerViewRadius()
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }

        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchtohostCell", for: indexPath) as! SwitchtohostCell
            cell.lineLabel.frame = CGRect(x: 15, y: 79.5, width: FULLWIDTH-40, height: 0.5)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.profileSettingLabel.text = ProfileArray[indexPath.row] as! String
        //    cell.profilesettingImage.image = ProfileTickImageArray[indexPath.row] as! UIImage
            if(indexPath.row == 0)
            {
            cell.profilesettingImage.image =  #imageLiteral(resourceName: "right-arrow")
//                if((ProfileAPIArray.verification!.isEmailConfirmed!) == true)
//                {
//                cell.profilesettingImage.image = #imageLiteral(resourceName: "profile_Verify_Tick")
//                }
//                else
//                {
//                    cell.profilesettingImage.image = #imageLiteral(resourceName: "profile_NotVerify_Tick")
//                }
            }
            else if(indexPath.row == 1)
            {
                cell.profilesettingImage.image =  #imageLiteral(resourceName: "right-arrow")
//                if((ProfileAPIArray.verification!.isFacebookConnected!) == true)
//                {
//                    cell.profilesettingImage.image = #imageLiteral(resourceName: "profile_Verify_Tick")
//                }
//                else
//                {
//                  cell.profilesettingImage.image = #imageLiteral(resourceName: "profile_NotVerify_Tick")
//                }
            }
            else if(indexPath.row == 2)
            {
                cell.profilesettingImage.image =  #imageLiteral(resourceName: "right-arrow")
//                if((ProfileAPIArray.verification!.isGoogleConnected!) == true)
//                {
//                    cell.profilesettingImage.image = #imageLiteral(resourceName: "profile_Verify_Tick")
//                }
//                else{
//                   cell.profilesettingImage.image = #imageLiteral(resourceName: "profile_NotVerify_Tick")
//                }
                
            }
//            else if(indexPath.row == 3)
//            {
//                if((ProfileAPIArray.verification!.isPhoneVerified!) == true)
//                {
//                    cell.profilesettingImage.image = #imageLiteral(resourceName: "profile_Verify_Tick")
//                }
//                else
//                {
//                    cell.profilesettingImage.image = #imageLiteral(resourceName: "profile_NotVerify_Tick")
//
//                }
//
//            }
            else if(indexPath.row == 3)
            {
                cell.profilesettingImage.isHidden = true
            }
            else if(indexPath.row == 4)
            {
                cell.profilesettingImage.image = nil
                cell.profileSettingLabel.textColor = Theme.PRIMARY_COLOR
                cell.lineLabel.isHidden = true
            }
//            else
//            {
//                cell.profilesettingImage.image = nil
//                cell.profileSettingLabel.frame = CGRect(x: cell.frame.size.width/2-75, y: 25, width: 150, height: 30)
//
//            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 0)
        {
        if(indexPath.row == 0)
        {
             if Utility().isConnectedToNetwork(){
            let editprofileobj = EditProfileVC()
           editprofileobj.EditProfileArray = ProfileAPIArray


            self.present(editprofileobj, animated: true, completion: nil)
            }
             else{
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
        else{
            if(indexPath.row == 0)
            {
                let webviewObj = WebviewVC()
                webviewObj.webstring = TERMS_URL
                self.present(webviewObj, animated: true, completion: nil)
    
            }
             if(indexPath.row == 1)
            {
                let webviewObj = BaseHostTableviewController()
                Utility.shared.step1ValuesInfo = [String : Any]()
                self.present(webviewObj, animated: true, completion: nil)

            }
           if(indexPath.row == 2)
            {
                let webviewObj = WebviewVC()
                webviewObj.webstring = ABOUT_URL
                self.navigationController?.pushViewController(webviewObj, animated: true)
                
            }
        if(indexPath.row == 4)
        {
            
            let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            // create an action
            let firstAction: UIAlertAction = UIAlertAction(title: "Log out", style: .destructive) { action -> Void in
                Utility().userLogout()
                Utility.shared.selectedLanguage = ""
                Utility.shared.selectedphoneNumber = ""
                Utility.shared.selectedCurrency = ""
                Utility.shared.locationfromSearch = ""
                print("First Action pressed")
            }
            
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }
            
            // add actions
            actionSheetController.addAction(firstAction)
            actionSheetController.addAction(cancelAction)
            
            // present an actionSheet...
            present(actionSheetController, animated: true, completion: nil)
        }
        }
    }
    
    @IBAction func retryBtnTapped(_ sender: Any){
        self.offlineView.isHidden = true
        if(ProfileAPIArray != nil)
        {
        let editprofileobj = EditProfileVC()
        editprofileobj.EditProfileArray = ProfileAPIArray

        self.present(editprofileobj, animated: true, completion: nil)
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
extension StringProtocol {
    var firstUppercased: String {
        return prefix(1).uppercased() + dropFirst()
    }
    var firstCapitalized: String {
        return String(prefix(1)).capitalized + dropFirst()
    }
}

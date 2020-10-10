//
//  BookingstepOneVC.swift
//  Rent_All
//
//  Created by RadicalStart on 28/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Apollo

class BookingstepOneVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    
    
    
    //MARK:******************************************* IBOUTLET CONNECTIONS & VARIABLE DECLARATIONS **************************************************>
    
    @IBOutlet weak var topview: UIView!
    @IBOutlet weak var bookingstepOneTV: UITableView!
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var priceLAbel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    var addDateinLabel = String()
    var addDateoutLabel = String()
    var totalPriceLabel = String()
    
    
    var houserulesArray = [ViewListingDetailsQuery.Data.ViewListing.Result.HouseRule]()
    var viewListingArray = ViewListingDetailsQuery.Data.ViewListing.Result()
    
    var apollo_client: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
        
        let url = URL(string:graphQLEndpoint)!
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.profileAPICall()
        self.initialSetup()

    }
    
    func initialSetup()
    {
        
        if IS_IPHONE_XR
        {
            self.topview.frame = CGRect(x: 0, y: 0, width: FULLWIDTH-40, height: 80)
            bookingstepOneTV.frame = CGRect(x: 0, y: 85, width: FULLWIDTH-40, height: FULLHEIGHT-300)
            
        }
        nextBtn.backgroundColor = Theme.PRIMARY_COLOR
        bookingstepOneTV.register(UINib(nibName: "bookinoneCell", bundle: nil), forCellReuseIdentifier: "bookinoneCell")
        bookingstepOneTV.register(UINib(nibName: "EditAboutCell", bundle: nil), forCellReuseIdentifier: "EditAboutCell")
        let shadowSize : CGFloat = 3.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.bottomView.frame.size.width+40 + shadowSize,
                                                   height: self.bottomView.frame.size.height + shadowSize))
        
        self.bottomView.layer.masksToBounds = false
        self.bottomView.layer.shadowColor = TextLightColor.cgColor
        self.bottomView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.bottomView.layer.shadowOpacity = 0.3
        self.bottomView.layer.shadowPath = shadowPath.cgPath
        
        
        let shadowPath1 = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                    y: -shadowSize / 2,
                                                    width: self.topview.frame.size.width+40 + shadowSize,
                                                    height: self.topview.frame.size.height + shadowSize))
        
        self.topview.layer.masksToBounds = false
        self.topview.layer.shadowColor = TextLightColor.cgColor
        self.topview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.topview.layer.shadowOpacity = 0.3
        self.topview.layer.shadowPath = shadowPath1.cgPath
        nextBtn.layer.cornerRadius = 5.0
        nextBtn.layer.masksToBounds = true
        let main_string = "\(totalPriceLabel)  \((Utility.shared.getLanguage()?.value(forKey:"for"))!) \(Utility.shared.numberofnights_Selected) \((Utility.shared.getLanguage()?.value(forKey:"night"))!)\(Utility.shared.numberofnights_Selected > 1 ? "s" : "")"
        let string_to_color = "\((Utility.shared.getLanguage()?.value(forKey:"for"))!) \(Utility.shared.numberofnights_Selected) \((Utility.shared.getLanguage()?.value(forKey:"night"))!)\(Utility.shared.numberofnights_Selected > 1 ? "s" : "")"
        
        let range = (main_string as NSString).range(of: string_to_color)
        
        let attribute = NSMutableAttributedString.init(string: main_string)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: TextDarkColor , range: range)
        priceLAbel.attributedText = attribute
        nextBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"next"))!)", for:.normal)
        //priceLAbel.text = "\(totalPriceLabel) for \(Utility.shared.numberofnights_Selected) night\(Utility.shared.numberofnights_Selected > 1 ? "s" : "")"
        
        
    }

    @IBAction func backBtnTapped(_ sender: Any) {
        Utility.shared.PreApprovedID = false
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        
        self.profileAPICall()
       // self.initialSetup()
        let bookingtwoObj = BookingsteptwoVC()
        bookingtwoObj.viewListingArray = viewListingArray
        bookingtwoObj.modalPresentationStyle = .fullScreen
        self.present(bookingtwoObj, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0)
        {
            return 1
        }
        else{
             if(houserulesArray.count>0)
             {
                return houserulesArray.count
            }
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0)
        {
            return 335
        }
        else{
            if(houserulesArray.count>0)
            {
                return 80
            }
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "bookinoneCell", for: indexPath)as! bookinoneCell
            cell.selectionStyle = .none
            cell.checkinLabel.text = addDateinLabel
            cell.checkoutLabel.text = addDateoutLabel
            if(Utility.shared.isprofilepictureVerified)
            {
                cell.stepLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"step1of4"))!)"
            }
            else{
                
                cell.stepLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"step1of3"))!)"
            }
            if(houserulesArray.count>0)
            {
                cell.thingsLabel.isHidden = false
            }
            else{
                cell.thingsLabel.isHidden = true
            }
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EditAboutCell", for: indexPath)as! EditAboutCell
            cell.selectionStyle = .none
            cell.rightArrowimg.isHidden = true
            cell.editLabel.isHidden = true
            cell.aboutLabel.text = houserulesArray[indexPath.row].itemName!
            return cell
        }
    }
    
    func profileAPICall() {
        
        if Utility.shared.isConnectedToNetwork() {
            
            if (Utility.shared.getCurrentUserID() != nil){
                
                let profileQuery = GetProfileQuery()
                apollo_client = {
                    let configuration = URLSessionConfiguration.default
                    // Add additional headers as needed
                    configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
                    
                    let url = URL(string:graphQLEndpoint)!
                    
                    return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
                    
                }()
                
                apollo_client.fetch(query: profileQuery, cachePolicy: .fetchIgnoringCacheData){ (result, error) in
                    
                    guard (result?.data?.userAccount?.result) != nil else {
                        
                        
                        print("Missing Data")
                        return
                    }
                   
    
                    if (result?.data?.userAccount?.result?.picture) == nil {
                        Utility.shared.isprofilepictureVerified = true
                    }else{
                        
                        Utility.shared.isprofilepictureVerified = false
                    }
                    
                    self.bookingstepOneTV.reloadData()
                }
            }
        }else{
            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey: "error_field"))!)")
            
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

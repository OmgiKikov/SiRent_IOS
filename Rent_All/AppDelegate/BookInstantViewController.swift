//
//  BookInstantViewController.swift
//  Rent_All
//
//  Created by RadicalStart on 07/08/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Lottie

class BookInstantViewController: BaseHostTableviewController {
    
    @IBOutlet weak var retryButn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveandExitBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var nextArrow: UIImageView!
    @IBOutlet weak var offlineUIView: UIView!
    var lottieView1: LOTAnimationView!
    var reviewGuestBooks = [Any]()
    
    //MARK: - View Controller Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        errorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
        retryButn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
        saveandExitBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"saveexit"))!)", for:.normal)
        saveandExitBtn.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
        nextBtn.backgroundColor = Theme.PRIMARY_COLOR
        // Do any additional setup after loading the view.
    }
    
    override func setUpUI() {
        offlineUIView.isHidden = true
        callListingSettingsAPI(oflineView: offlineUIView, nextButton: nextBtn)
        tableView.isHidden = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension

      nextBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"next"))!)", for: .normal)

        nextBtn.layer.cornerRadius = 5
        nextBtn.clipsToBounds = true
        nextArrow.image = nextArrow.image?.withRenderingMode(.alwaysTemplate)
        nextArrow.tintColor = UIColor.white
        if(Utility.shared.step3_Edit)
        {
            self.saveandExitBtn.isHidden = false
        }
        else{
            self.saveandExitBtn.isHidden = true
        }
    }
    
    override func setDropdownList() {
        
        let reviewGuestBook = (Utility.shared.getListSettingsArray.reviewGuestBook?.listSettings!)!
        for i in 0..<reviewGuestBook.count
        {
            var amenityInfo = [String : Any]()
            amenityInfo.updateValue(reviewGuestBook[i]!.itemName!, forKey: "itemName")
            amenityInfo.updateValue(reviewGuestBook[i]!.id!, forKey: "id")
            reviewGuestBooks.append(amenityInfo)
        }
        tableView.reloadData()
    }
    
    override func registerCells() {
        tableView.register(UINib(nibName: "AmenitiesCell", bundle: nil), forCellReuseIdentifier: "AmenitiesCell")
    }
    
    //MARK: - Progress Indicator
    
    override func addLottieViewAsSubview()
    {
        self.view.addSubview(self.lottieView)
    }
    
    func lottieViewanimation()
    {
        saveandExitBtn.setTitle("", for:.normal)
        lottieView1 = LOTAnimationView.init(name: "animation")
        self.lottieView1.isHidden = false
        self.lottieView1.frame = CGRect(x:80, y:-35, width:100, height:100)
        self.saveandExitBtn.addSubview(self.lottieView1)
        self.view.bringSubviewToFront(self.lottieView1)
        self.lottieView1.backgroundColor = UIColor.clear
        self.lottieView1.play()
        Timer.scheduledTimer(timeInterval:0.3, target: self, selector: #selector(autoscrolling), userInfo: nil, repeats: true)
    }
    @objc func autoscrolling()
    {
        self.lottieView1.play()
    }
    func offlineviewShow()
    {
        self.offlineUIView.isHidden = false
        let shadowSize2 : CGFloat = 3.0
        let shadowPath2 = UIBezierPath(rect: CGRect(x: -shadowSize2 / 2,
                                                    y: -shadowSize2 / 2,
                                                    width: self.offlineUIView.frame.size.width + shadowSize2,
                                                    height: self.offlineUIView.frame.size.height + shadowSize2))
        
        self.offlineUIView.layer.masksToBounds = false
        self.offlineUIView.layer.shadowColor = TextLightColor.cgColor
        self.offlineUIView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.offlineUIView.layer.shadowOpacity = 0.3
        self.offlineUIView.layer.shadowPath = shadowPath2.cgPath
        if IS_IPHONE_X || IS_IPHONE_XR{
            offlineUIView.frame = CGRect.init(x: 0, y: FULLHEIGHT-130, width: FULLWIDTH, height: 55)
        }else{
            offlineUIView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
        }
    }
    
    //IBActions
    
    @IBAction func RedirectNextPage(_ sender: Any) {
         if Utility().isConnectedToNetwork(){
           
        let becomeHost = NoticeArrivalViewController()
        self.view.window?.backgroundColor = UIColor.white
        //self.view.window?.layer.add(presentrightAnimation()!, forKey: kCATransition)
        //self.view.layer.add(presentrightAnimation()!, forKey: kCATransition)
        becomeHost.modalPresentationStyle = .fullScreen
        self.present(becomeHost, animated:false, completion: nil)
        }
        else
         {
            self.offlineviewShow()
        }
    }
    
    @IBAction func retryBtnTapped(_ sender: Any) {
         if Utility().isConnectedToNetwork(){
            self.offlineUIView.isHidden = true
        }
    }
    @IBAction func backBtnPressed(_ sender: Any) {
        //self.view?.layer.add(dismissrightAnimation()!, forKey: kCATransition)
        self.dismiss(animated:false, completion: nil)
    }
    
    @IBAction func saveandExitaction(_ sender: Any) {
         if Utility().isConnectedToNetwork(){
            
            if((Utility.shared.step3ValuesInfo["minNight"] as? Int) != nil && (Utility.shared.step3ValuesInfo["maxNight"] as? Int) != nil)
            {
                let minNight:Int  = (Utility.shared.step3ValuesInfo["minNight"] as? Int)!
                let maxNight:Int = (Utility.shared.step3ValuesInfo["maxNight"] as? Int)!
                if minNight > maxNight
                {
                    self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey: "min_nights_Greaterthan_max"))!)")
                    return
                }
                else if (Utility.shared.step3ValuesInfo["basePrice"] != nil &&  Utility.shared.step3ValuesInfo["basePrice"] as? String == "0")
                {
                    self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey: "invalid_basePrice"))!)")
                    return
                }
                else if (Utility.shared.step3ValuesInfo["cleaningPrice"] != nil &&  Utility.shared.step3ValuesInfo["cleaningPrice"] as? String == "0")
                    
                {
                    self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey: "invalid_cleaningPrice"))!)")
                    return
                }
//                else
//                {
//                    self.lottieViewanimation()
//                    super.updateStep3ListingAPICall()
//                }
            
                
            else if(Utility.shared.step3ValuesInfo["checkInStart"] != nil && ((Utility.shared.step3ValuesInfo["checkInStart"]as? String) != "Flexible") && (Utility.shared.step3ValuesInfo["checkInEnd"] != nil && ((Utility.shared.step3ValuesInfo["checkInEnd"]as? String) != "Flexible")))
            {
                
               
                    
                    let from:Int = Int("\(Utility.shared.step3ValuesInfo["checkInStart"]!)")!
                    let to:Int = Int("\(Utility.shared.step3ValuesInfo["checkInEnd"]!)")!
                    
                    //            let from = Int(convert12HrTo24Hr(hour: fromTime))
                    //            let to = Int(convert12HrTo24Hr(hour: toTime))
                    if(from >= to)
                    {
                        self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"fromtimealert"))!)")
                    }
                    else
                    {
                        self.lottieViewanimation()
                        super.updateStep3ListingAPICall()
                }
                
                
            }
            
            else
            {
            self.lottieViewanimation()
            super.updateStep3ListingAPICall()
            }
            }
        }
        else
         {
            self.offlineviewShow()
        }
    }
    //MARK: - UITAbleViewDatasource and UITableViewDelegates
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\((Utility.shared.getLanguage()?.value(forKey:"howguest"))!)"
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerLabel = UILabel(frame: CGRect(x:15, y: 8, width:FULLWIDTH-40, height: 100))
        
            headerLabel.font =  UIFont(name: "Circular-Medium", size:25)
        headerLabel.addCharacterSpacing()
        headerLabel.textColor = UIColor.black
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        headerLabel.numberOfLines = 0
        headerLabel.sizeToFit()
        
        let headerView = UIView(frame: CGRect(x:15, y: 8, width: tableView.bounds.size.width - 20, height: 100))
        headerView.backgroundColor = UIColor.white
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewGuestBooks.count + 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.selectionStyle = .none
       
        cell.textLabel?.font = UIFont(name:"Circular-Book", size: 18)
        if indexPath.row == 0
        {
            cell.textLabel?.text = "\((Utility.shared.getLanguage()?.value(forKey:"guestcanbook"))!)"
        }else if indexPath.row == reviewGuestBooks.count + 1
        {
            cell.textLabel?.text = "\((Utility.shared.getLanguage()?.value(forKey:"guestrequirement"))!)"
            cell.textLabel?.clipsToBounds = true
            cell.textLabel?.numberOfLines = 2

        }
        else {
            cell.imageView?.image = #imageLiteral(resourceName: "profile_Verify_Tick")
            if let text = reviewGuestBooks[indexPath.row - 1] as? [String : Any]
            {
                cell.textLabel?.text = "\(text["itemName"] ?? "")"
            }
        }
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == reviewGuestBooks.count + 2)
        {
        return 95
        }
        return 75
    }
    
}

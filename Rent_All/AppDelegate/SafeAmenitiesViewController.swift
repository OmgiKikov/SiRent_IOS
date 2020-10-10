//
//  SafeAmenitiesViewController.swift
//  Rent_All
//
//  Created by RadicalStart on 31/07/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Lottie

class SafeAmenitiesViewController: BaseHostTableviewController {
    
    @IBOutlet weak var saveandexit: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var nextarrow: UIImageView!
    @IBOutlet weak var offlineUIView: UIView!
      var lottieView1: LOTAnimationView!
    @IBOutlet weak var retryButn: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    //This Property
    var amenity = ""
    var amenityList = [[String : Any]]()
    //var selectedAmenityIdList = [Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveandexit.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"saveexit"))!)", for:.normal)
        errorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
        retryButn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
        saveandexit.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
        nextBtn.backgroundColor = Theme.PRIMARY_COLOR
    }
    
    override func setUpUI() {
        offlineUIView.isHidden = true
        callListingSettingsAPI(oflineView: offlineUIView, nextButton: nextBtn)
        tableView.isHidden = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        nextBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey: "next"))!)", for: .normal)
        nextBtn.layer.cornerRadius = 5
        nextBtn.clipsToBounds = true
        nextarrow.image = nextarrow.image?.withRenderingMode(.alwaysTemplate)
        nextarrow.tintColor = UIColor.white
        lottieView1 = LOTAnimationView.init(name: "animation")
        if(Utility.shared.step1_inactivestatus == "inactive" || Utility.shared.step1_inactivestatus == "")
        {
            saveandexit.isHidden = true
        }
        else {
            saveandexit.isHidden = false
        }
    }
    
    override func setDropdownList() {
         Utility.shared.selectedsafetyAmenityIdList.removeAllObjects()
        let amenitiesList = (Utility.shared.getListSettingsArray.safetyAmenities?.listSettings!)!
        for i in 0..<amenitiesList.count
        {
            var amenityInfo = [String : Any]()
            amenityInfo.updateValue(amenitiesList[i]!.itemName!, forKey: "itemName")
            amenityInfo.updateValue(amenitiesList[i]!.id!, forKey: "id")
            amenityList.append(amenityInfo)
        }
        
         if let typeInfo = Utility.shared.step1ValuesInfo["safetyAmenities"] as? [Any]
        {
            for i in 0..<typeInfo.count
            {
                if let userAmenityTypes = typeInfo[i] as? GetStep1ListingDetailsQuery.Data.GetListingDetail.Result.UserSafetyAmenity
                {
                    if amenityList.contains(where: { (item) -> Bool in
                        (item["itemName"] as? String == (userAmenityTypes.itemName!))
                    }){
                        Utility.shared.selectedsafetyAmenityIdList.add(userAmenityTypes.id!)
                        
                    }
                }
            }
        }
        else{
        amenity = (amenityList.first! is [String : Any]) ? amenityList.first!["itemName"] as! String : ""
            Utility.shared.selectedsafetyAmenityIdList.removeAllObjects()
        }
        Utility.shared.step1ValuesInfo.updateValue(Utility.shared.selectedsafetyAmenityIdList, forKey: "safetyAmenities")
        tableView.reloadData()
    }
    
    override func registerCells() {
        tableView.register(UINib(nibName: "AmenitiesCell", bundle: nil), forCellReuseIdentifier: "AmenitiesCell")
    }
    
    //MARK: - Progress Indicator
    
    override func addLottieViewAsSubview()
    {
     //   self.view.addSubview(self.lottieView)
    }
    
    //IBActions
    @IBAction func saveandExitTapped(_ sender: Any) {
         if Utility().isConnectedToNetwork(){
        self.lottieViewanimation()
       Utility.shared.step1ValuesInfo.updateValue(Utility.shared.selectedsafetyAmenityIdList, forKey: "safetyAmenities")
        super.updateListingAPICall()
        }
        else
         {
            self.offlineViewShow()
        }
    }
    func offlineViewShow()
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
    
    func lottieViewanimation()
    {
        saveandexit.setTitle("", for:.normal)
        lottieView1 = LOTAnimationView.init(name: "animation")
        self.lottieView1.isHidden = false
        self.lottieView1.frame = CGRect(x:80, y:-35, width:100, height:100)
        self.saveandexit.addSubview(self.lottieView1)
        self.view.bringSubviewToFront(self.lottieView1)
        self.lottieView1.backgroundColor = UIColor.clear
        self.lottieView1.play()
        Timer.scheduledTimer(timeInterval:0.3, target: self, selector: #selector(autoscroll), userInfo: nil, repeats: true)
    }
    @objc func autoscroll()
    {
        self.lottieView1.play()
    }
    @IBAction func retryBtntapped(_ sender: Any) {
         if Utility().isConnectedToNetwork(){
            self.offlineUIView.isHidden = true
        }
        
    }
    @IBAction func RedirectNextPage(_ sender: Any) {
         if Utility().isConnectedToNetwork(){
        Utility.shared.step1ValuesInfo.updateValue(Utility.shared.selectedsafetyAmenityIdList, forKey: "safetyAmenities")
        let spaces = SpaceListViewController()
        self.view.window?.backgroundColor = UIColor.white
    //    self.view.layer.add(presentrightAnimation()!, forKey: kCATransition)
        spaces.modalPresentationStyle = .fullScreen
        self.present(spaces, animated: false, completion: nil)
        }
        else
         {
            self.offlineViewShow()
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        //self.view.layer.add(dismissrightAnimation()!, forKey: kCATransition)
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - UITAbleViewDatasource and UITableViewDelegates
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\((Utility.shared.getLanguage()?.value(forKey: "safe_amenty"))!)"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return amenityList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0
        {
            let cell = tableView
                .dequeueReusableCell(withIdentifier: "AmenitiesCell", for: indexPath) as? AmenitiesCell
            if amenityList.count > 0
            {
                cell?.amenitieslistTile.text = amenityList[indexPath.row]["itemName"] as! String
            }
            cell?.tag = indexPath.row+300
            cell?.amenitieslistTile.font = UIFont(name:"Circular-Book", size: 18.0)
            cell?.amenitieslistTile.textColor = UIColor.darkText
//            if(Utility.shared.step1ValuesInfo.keys.contains("safetyAmenities"))
//            {
//                if let amenity = Utility.shared.step1ValuesInfo["safetyAmenities"] as? [Int]
//                {
//                    if amenity.contains(amenityList[indexPath.row]["id"] as! Int)
//                    {
//
//                        cell?.checkBtn.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
//                    }else
//                    {
//                        cell?.checkBtn.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
//                    }
//                }else{
//                    cell?.checkBtn.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
//                }
//            }
            if(Utility.shared.selectedsafetyAmenityIdList.contains(amenityList[indexPath.row]["id"] as! Int))
            {
                cell?.checkBtn.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
            }
            else{
                cell?.checkBtn.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
            }
            cell?.checkBtn.tag = indexPath.row
            cell?.checkBtn.addTarget(self, action: #selector(amenitiescheckBtnTapped(_:)), for: .touchUpInside)
            cell?.selectionStyle = .none
            return cell!
        }
        return UITableViewCell()
    }
    
    @objc func amenitiescheckBtnTapped(_ sender: UIButton)
    {
        let cell = view.viewWithTag(sender.tag + 300) as? AmenitiesCell
        let celltag = cell?.checkBtn.tag

        if(cell?.checkBtn.currentImage == #imageLiteral(resourceName: "checked")){
            if(Utility.shared.selectedsafetyAmenityIdList.contains(amenityList[sender.tag]["id"] as! Int))
            {
//                let index = Utility.shared.selectedsafetyAmenityIdList.index(where: { (item) -> Bool in
//                    item == amenityList[sender.tag]["id"] as! Int
//                })
                Utility.shared.selectedsafetyAmenityIdList.remove(amenityList[sender.tag]["id"] as! Int)
            }
//            if let index = Utility.shared.selectedsafetyAmenityIdList.index(of:amenityList[celltag!]["id"] as! Int) {
//                Utility.shared.selectedsafetyAmenityIdList.remove(at: index)
//            }
            cell?.checkBtn.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        }
        else{
            Utility.shared.selectedsafetyAmenityIdList.add(amenityList[celltag!]["id"] as! Int)
            cell?.checkBtn.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = view.viewWithTag(indexPath.row + 300) as? AmenitiesCell
        let celltag = cell?.checkBtn.tag

        if(cell?.checkBtn.currentImage == #imageLiteral(resourceName: "checked")){
            if(Utility.shared.selectedsafetyAmenityIdList.contains(amenityList[indexPath.row]["id"] as! Int))
            {
//                let index = Utility.shared.selectedsafetyAmenityIdList.index(where: { (item) -> Bool in
//                    item == amenityList[celltag!]["id"] as! Int
//                })
                Utility.shared.selectedsafetyAmenityIdList.remove(amenityList[indexPath.row]["id"] as! Int)
            }
            cell?.checkBtn.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        }
        else{
            Utility.shared.selectedsafetyAmenityIdList.add(amenityList[celltag!]["id"] as! Int)
            cell?.checkBtn.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
}

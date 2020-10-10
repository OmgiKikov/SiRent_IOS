//
//  SpaceListViewController.swift
//  Rent_All
//
//  Created by RadicalStart on 31/07/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Lottie

class SpaceListViewController: BaseHostTableviewController {
    
    @IBOutlet weak var saveandexit: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var nextArrowBtn: UIImageView!
    @IBOutlet weak var offlineUIView: UIView!
    @IBOutlet weak var retryButn: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    //This Property
    var spaces = ""
    var spacesList = [[String : Any]]()
    //var selectedAmenityIdList = [Int]()
    var updateResultsStep1 = CreateListingMutation.Data.CreateListing.Result()
     var lottieView1: LOTAnimationView!
        
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
        callListingSettingsAPI(oflineView: self.offlineUIView, nextButton: self.nextBtn)
        tableView.isHidden = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        nextBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey: "next"))!)", for: .normal)
        nextBtn.layer.cornerRadius = 5
        nextBtn.clipsToBounds = true
        nextArrowBtn.image = nextArrowBtn.image?.withRenderingMode(.alwaysTemplate)
        nextArrowBtn.tintColor = UIColor.white
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
         Utility.shared.selectedspaceAmenityIdList.removeAllObjects()
        let spaceList = (Utility.shared.getListSettingsArray.spaces?.listSettings!)!
        for i in 0..<spaceList.count
        {
            var amenityInfo = [String : Any]()
            amenityInfo.updateValue(spaceList[i]!.itemName!, forKey: "itemName")
            amenityInfo.updateValue(spaceList[i]!.id!, forKey: "id")
            spacesList.append(amenityInfo)
        }
         if let typeInfo = Utility.shared.step1ValuesInfo["spaces"] as? [Any]
        {
            for i in 0..<typeInfo.count
            {
                if let usertypes = typeInfo[i] as? GetStep1ListingDetailsQuery.Data.GetListingDetail.Result.UserSpace
                {
                    if spacesList.contains(where: { (item) -> Bool in
                        (item["itemName"] as? String == (usertypes.itemName!))
                    }){
                        Utility.shared.selectedspaceAmenityIdList.add(usertypes.id!)
                        
                    }
                }
            }
        }
        else{
        spaces = (spacesList.first! is [String : Any]) ? spacesList.first!["itemName"] as! String : ""
            Utility.shared.selectedspaceAmenityIdList.removeAllObjects()
        }
        Utility.shared.step1ValuesInfo.updateValue(Utility.shared.selectedspaceAmenityIdList, forKey: "spaces")
        tableView.reloadData()
    }
    
    override func registerCells() {
        tableView.register(UINib(nibName: "AmenitiesCell", bundle: nil), forCellReuseIdentifier: "AmenitiesCell")
    }
    
    //MARK: - Update Listing Step 1
    func updateListingAPICallAfterCreate()
    {
        let createlist = CreateListingMutation(listId: Utility.shared.createId,
                                               roomType: "\(Utility.shared.step1ValuesInfo["roomType"] ?? "")",
            houseType: "\(Utility.shared.step1ValuesInfo["houseType"] ?? "")" ,
            residenceType: "\(Utility.shared.step1ValuesInfo["residenceType"] ?? "")",
            bedrooms: "\(Utility.shared.step1ValuesInfo["bedrooms"] ?? "")" ,
            buildingSize: "\(Utility.shared.step1ValuesInfo["buildingSize"] ?? "")",
            bedType: "\(Utility.shared.step1ValuesInfo["bedType"] ?? "")" ,
            beds: Utility.shared.step1ValuesInfo["beds"] as? Int,
            personCapacity: Utility.shared.step1ValuesInfo["personCapacity"] as? Int,
            bathrooms:(Utility.shared.step1ValuesInfo["bathrooms"] as? Double),
            bathroomType: "\(Utility.shared.step1ValuesInfo["bathroomType"] ?? "")",
            country: "\(Utility.shared.step1ValuesInfo["country"] ?? "")",
            street: "\(Utility.shared.step1ValuesInfo["street"] ?? "")",
            buildingName: "\(Utility.shared.step1ValuesInfo["buildingName"] ?? "")",
            city: "\(Utility.shared.step1ValuesInfo["city"] ?? "")",
            state: "\(Utility.shared.step1ValuesInfo["state"] ?? "")",
            zipcode: "\(Utility.shared.step1ValuesInfo["zipcode"] ?? "")",
            lat: (Utility.shared.step1ValuesInfo["lat"] as! Double),
            lng: (Utility.shared.step1ValuesInfo["lng"] as! Double),
            bedTypes: "\(Utility.shared.step1ValuesInfo["bedTypes"] ?? "")" ,
            isMapTouched: Utility.shared.step1ValuesInfo["isMapTouched"] as? Bool,
            amenities: Utility.shared.step1ValuesInfo["amenities"] as? [Int?] ,
            safetyAmenities: Utility.shared.step1ValuesInfo["safetyAmenities"] as? [Int?],
            spaces: Utility.shared.step1ValuesInfo["spaces"] as? [Int?])
        apollo_headerClient.perform(mutation: createlist){ (result,error) in
            
            if(result?.data?.createListing?.status == 200)
            {
                
                self.updateResultsStep1 = (result?.data?.createListing?.results)!
                Utility.shared.createId = (result?.data?.createListing?.id)!
                self.manageListingSteps(listId: "\((result?.data?.createListing?.id)!)", currentStep: 1)
            }
            else{
                self.lottieView1.isHidden = true
                self.nextBtn.setTitle("Next", for:.normal)
                self.nextArrowBtn.isHidden = false
                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey: "somethingwrong"))!)")
                
            }
        }
    }
    
    func manageListingSteps(listId:String,currentStep:Int)
    {
        let manageListingStepsMutation = ManageListingStepsMutation(listId:listId, currentStep:currentStep)
        apollo_headerClient.perform(mutation: manageListingStepsMutation){ (result,error) in
            
            if(result?.data?.manageListingSteps?.status == 200)
            {
                let becomeHost = BecomeHostVC()
                becomeHost.listID = "\(Utility.shared.createId)"
                Utility.shared.step1_inactivestatus = ((result?.data?.manageListingSteps?.results?.step3!)!)
                becomeHost.showListingStepsAPICall(listID:"\(Utility.shared.createId)")
               // self.view.window!.layer.add(presentrightAnimation()!, forKey: kCATransition)
                becomeHost.modalPresentationStyle = .fullScreen
                self.present(becomeHost, animated:false,completion: nil)

            }
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
    
    //MARK: - Progress Indicator
    
    override func addLottieViewAsSubview()
    {
      //  self.view.addSubview(self.lottieView)
    }
    
    //IBActions
    
    @IBAction func retryBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            self.offlineUIView.isHidden = true
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
    
    func lottienextanimation()
    {
        nextArrowBtn.isHidden = true
        nextBtn.setTitle("", for:.normal)
        lottieView1 = LOTAnimationView.init(name: "animation_white")
        self.lottieView1.isHidden = false
        self.lottieView1.frame = CGRect(x:15, y:-25, width:100, height:100)
        self.nextBtn.addSubview(self.lottieView1)
        self.view.bringSubviewToFront(self.lottieView1)
        self.lottieView1.backgroundColor = UIColor.clear
        self.lottieView1.play()
        Timer.scheduledTimer(timeInterval:0.3, target: self, selector: #selector(autoscroll1), userInfo: nil, repeats: true)
    }
    @objc func autoscroll1()
    {
        self.lottieView1.play()
    }
    @IBAction func saveandExitTapped(_ sender: Any) {
         if Utility().isConnectedToNetwork(){
        self.lottieViewanimation()
        Utility.shared.step1ValuesInfo.updateValue(Utility.shared.selectedspaceAmenityIdList, forKey: "spaces")
        super.updateListingAPICall()
        }
        else
         {
            self.offlineViewShow()
        }
    }
    @IBAction func RedirectNextPage(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
         self.lottienextanimation()
        Utility.shared.step1ValuesInfo.updateValue(Utility.shared.selectedspaceAmenityIdList, forKey: "spaces")
        updateListingAPICallAfterCreate()
        }
        else
        {
            self.offlineViewShow()
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - UITAbleViewDatasource and UITableViewDelegates
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\((Utility.shared.getLanguage()?.value(forKey: "space_guest_use"))!)"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spacesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0
        {
            let cell = tableView
                .dequeueReusableCell(withIdentifier: "AmenitiesCell", for: indexPath) as? AmenitiesCell
            if spacesList.count > 0
            {
                cell?.amenitieslistTile.text = spacesList[indexPath.row]["itemName"] as? String
            }
            cell?.tag = indexPath.row+300
            
//            if(Utility.shared.step1ValuesInfo.keys.contains("spaces"))
//            {
//                if let amenity = Utility.shared.step1ValuesInfo["spaces"] as? [Int]
//                {
//                    if amenity.contains(spacesList[indexPath.row]["id"] as! Int)
//                    {
//                        cell?.checkBtn.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
//                    }else
//                    {
//                        cell?.checkBtn.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
//                    }
//                }else{
//                    cell?.checkBtn.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
//                }
//            }
            if(Utility.shared.selectedspaceAmenityIdList.contains(spacesList[indexPath.row]["id"] as! Int))
            {
                cell?.checkBtn.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
            }
            else{
                cell?.checkBtn.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
            }
            cell?.checkBtn.tag = indexPath.row
            cell?.checkBtn.addTarget(self, action: #selector(amenitiescheckBtnTapped(_:)), for: .touchUpInside)
            cell?.selectionStyle = .none
            
            cell?.amenitieslistTile.font = UIFont(name:"Circular-Book", size: 18.0)
            cell?.amenitieslistTile.textColor = UIColor.darkText
            return cell!
        }
        return UITableViewCell()
    }
    
    @objc func amenitiescheckBtnTapped(_ sender: UIButton)
    {
        let cell = view.viewWithTag(sender.tag + 300) as? AmenitiesCell
        let celltag = cell?.checkBtn.tag

        if(cell?.checkBtn.currentImage == #imageLiteral(resourceName: "checked")){
            if(Utility.shared.selectedspaceAmenityIdList.contains(spacesList[sender.tag]["id"] as! Int))
            {
//                let index = Utility.shared.selectedspaceAmenityIdList.index(where: { (item) -> Bool in
//                    item == spacesList[sender.tag]["id"] as! Int
//                })
                Utility.shared.selectedspaceAmenityIdList.remove(spacesList[sender.tag]["id"] as! Int)
            }
            cell?.checkBtn.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        }
        else{
            Utility.shared.selectedspaceAmenityIdList.add(spacesList[celltag!]["id"] as! Int)
//            Utility.shared.step1ValuesInfo.updateValue(selectedAmenityIdList, forKey: "spaces")
            cell?.checkBtn.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = view.viewWithTag(indexPath.row + 300) as? AmenitiesCell
        let celltag = cell?.checkBtn.tag

        if(cell?.checkBtn.currentImage == #imageLiteral(resourceName: "checked")){
            if(Utility.shared.selectedspaceAmenityIdList.contains(spacesList[indexPath.row]["id"] as! Int))
            {
//                let index = Utility.shared.selectedspaceAmenityIdList.index(where: { (item) -> Bool in
//                    item == spacesList[indexPath.row]["id"] as! Int
//                })
                Utility.shared.selectedspaceAmenityIdList.remove(spacesList[indexPath.row]["id"] as! Int)
            }
            cell?.checkBtn.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        }
        else{
            Utility.shared.selectedspaceAmenityIdList.add(spacesList[celltag!]["id"] as! Int)
            cell?.checkBtn.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
}

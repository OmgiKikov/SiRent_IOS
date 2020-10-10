//
//  BecomeHostVC.swift
//  Rent_All
//
//  Created by RadicalStart on 26/07/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Apollo
import Lottie

class BecomeHostVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    
    
    
    //********************************************************** IBOUTLET & GLOBAL VARIABLE CONNECTIONS ************************************************************************ >
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var offlineView: UIView!
    
    @IBOutlet weak var becomeStepsTable: UITableView!
    
    @IBOutlet weak var UHOhLbl: UILabel!
    
    @IBOutlet weak var retryBtn: UIButton!
    @IBOutlet weak var CantSeeLbl: UILabel!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorCode404Lbl: UILabel!
    
    var lottieView: LOTAnimationView!
    var apollo_headerClient: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
        
        let url = URL(string:graphQLEndpoint)!
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()
    var showListingstepArray = ShowListingStepsQuery.Data.ShowListingStep.Result()
    var step1ListingDetails = GetStep1ListingDetailsQuery.Data.GetListingDetail.Result()
    var step3ListingDetails = GetListingDetailsStep3Query.Data.GetListingDetail.Result()
    var listID = String()
    var ispublishenable:Bool = false
    
    var getListingStep2Array = GetListingDetailsStep2Query.Data.GetListingDetail.Result()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.initialSetup()
        self.lottieAnimation()
    }
    
    //********************************************************** IBACTIONS & FUNCTIONS DECLARATIONS ************************************************************************ >
    func initialSetup()
    {
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
        becomeStepsTable.register(UINib(nibName: "StepOneCell", bundle: nil), forCellReuseIdentifier: "StepOneCell")
        becomeStepsTable.register(UINib(nibName: "StepTwoCell", bundle: nil), forCellReuseIdentifier: "StepTwoCell")
        becomeStepsTable.register(UINib(nibName: "StepPublishCell", bundle: nil), forCellReuseIdentifier: "StepPublishCell")
        UHOhLbl.isHidden = true
        CantSeeLbl.isHidden = true
        errorCode404Lbl.isHidden = true
        self.offlineView.isHidden = true
        errorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
        retryBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
        UHOhLbl.text = "\((Utility.shared.getLanguage()?.value(forKey:"uhoh"))!)"
        CantSeeLbl.text = "\((Utility.shared.getLanguage()?.value(forKey:"404alert"))!)"
        errorCode404Lbl.text = "\((Utility.shared.getLanguage()?.value(forKey:"errorCode"))!)"
        
    }
    
    func lottieAnimation(){
        lottieView = LOTAnimationView.init(name:"animation")
        lottieView.isHidden = false
        self.lottieView.frame = CGRect(x:FULLWIDTH/2-40, y:FULLHEIGHT/2-150, width:100, height:100)
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
    
    @IBAction func closeBtnTapped(_ sender: Any) {

        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    func showListingStepsAPICall(listID:String)
    {
        let showListingStepsquery = ShowListingStepsQuery(listId: listID)
        apollo_headerClient.fetch(query: showListingStepsquery,cachePolicy:.fetchIgnoringCacheData){(result,error)in
            guard (result?.data?.showListingSteps?.results) != nil else{
                if let errorMsg = result?.data?.showListingSteps?.errorMessage, let status = result?.data?.showListingSteps?.status, status == 400 || errorMsg  == "Something went wrong"
                {
                    self.UHOhLbl.isHidden = false
                    self.CantSeeLbl.isHidden = false
                    self.errorCode404Lbl.isHidden = false
                    self.becomeStepsTable.isHidden = true
                    
                    print("Missing Data")
                }
                return

            }
            
            //self.becomeStepsTable.isHidden = false
            self.lottieView.isHidden = true
            self.showListingstepArray = (result?.data?.showListingSteps?.results)!
            if(!self.ispublishenable)
            {
            self.becomeStepsTable.reloadData()
            }
            else
            {
            self.ispublishenable = false
            }
        }
    }
    
    
    
    
    func getStep3ListingDetails()
    {
        let step3ListingDetailsquery = GetListingDetailsStep3Query(listId: listID, preview: true)
        apollo_headerClient.fetch(query: step3ListingDetailsquery,cachePolicy:.fetchIgnoringCacheData){(result,error)in
            guard (result?.data?.getListingDetails?.results) != nil else{
                print("Missing Data")
                if(result?.data?.getListingDetails?.status == 400)
                {
                    self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"nolist"))!)")
                    self.UHOhLbl.isHidden = false
                    self.CantSeeLbl.isHidden = false
                    self.errorCode404Lbl.isHidden = false
                    self.becomeStepsTable.isHidden = true
                }
                return
            }
            self.step3ListingDetails = (result?.data?.getListingDetails?.results)!
           
            
            if(self.step3ListingDetails.listingData != nil)
            {
                Utility.shared.step3_Edit = true
                Utility.shared.step3ValuesInfo.updateValue(self.step3ListingDetails.id!, forKey: "id")
                Utility.shared.createId = self.step3ListingDetails.id!
                Utility.shared.step3ValuesInfo.updateValue(self.step3ListingDetails.houseRules!, forKey: "houseRules")
                if(self.step3ListingDetails.listingData?.bookingNoticeTime != nil)
                {
                Utility.shared.step3ValuesInfo.updateValue((self.step3ListingDetails.listingData?.bookingNoticeTime!)!, forKey: "bookingNoticeTime")
                }
                Utility.shared.step3ValuesInfo.updateValue((self.step3ListingDetails.listingData?.checkInStart!)!, forKey: "checkInStart")
                Utility.shared.step3ValuesInfo.updateValue((self.step3ListingDetails.listingData?.checkInEnd!)!, forKey: "checkInEnd")
                
                Utility.shared.step3ValuesInfo.updateValue((self.step3ListingDetails.listingData?.maxDaysNotice!)!, forKey: "maxDaysNotice")
                if(self.step3ListingDetails.listingData?.minNight != nil)
                {
                Utility.shared.step3ValuesInfo.updateValue((self.step3ListingDetails.listingData?.minNight!)!, forKey: "minNight")
                }
                if(self.step3ListingDetails.listingData?.maxNight != nil)
                {
                Utility.shared.step3ValuesInfo.updateValue((self.step3ListingDetails.listingData?.maxNight!)!, forKey: "maxNight")
                }
                if(self.step3ListingDetails.listingData?.basePrice != nil)
                { Utility.shared.step3ValuesInfo.updateValue((self.step3ListingDetails.listingData?.basePrice!)!, forKey: "basePrice")
                    Utility.shared.host_basePrice = (self.step3ListingDetails.listingData?.basePrice!)!
                }
                if(self.step3ListingDetails.listingData?.cleaningPrice != nil)
                {
                Utility.shared.step3ValuesInfo.updateValue((self.step3ListingDetails.listingData?.cleaningPrice!)!, forKey: "cleaningPrice")
                    Utility.shared.host_cleanPrice = (self.step3ListingDetails.listingData?.cleaningPrice!)!
                }
                Utility.shared.step3ValuesInfo.updateValue((self.step3ListingDetails.listingData?.currency!)!, forKey: "currency")
                if(self.step3ListingDetails.listingData?.weeklyDiscount != nil)
                {
                Utility.shared.step3ValuesInfo.updateValue((self.step3ListingDetails.listingData?.weeklyDiscount!)!, forKey: "weeklyDiscount")
                }
                if(self.step3ListingDetails.listingData?.monthlyDiscount != nil)
                {
                Utility.shared.step3ValuesInfo.updateValue((self.step3ListingDetails.listingData?.monthlyDiscount!)!, forKey: "monthlyDiscount")
                }
                if(self.step3ListingDetails.bookingType != nil)
                {
                Utility.shared.step3ValuesInfo.updateValue((self.step3ListingDetails.bookingType!), forKey: "bookingType")
                }
                if(self.step3ListingDetails.listingData?.cancellationPolicy != nil)
                {
                Utility.shared.step3ValuesInfo.updateValue((self.step3ListingDetails.listingData?.cancellationPolicy!)!, forKey: "cancellationPolicy")
                }
                
                let StepTwoObj = ReviewGuestViewController()
                self.view.window?.backgroundColor = UIColor.white
              //  self.view?.layer.add(presentrightAnimation()!, forKey: kCATransition)
                StepTwoObj.modalPresentationStyle = .fullScreen
                self.present(StepTwoObj, animated:false, completion: nil)
            }
            else
            {
             
                let StepTwoObj = ReviewGuestViewController()
                Utility.shared.createId = self.step3ListingDetails.id!
                Utility.shared.step3ValuesInfo.removeAll()
                Utility.shared.step3ValuesInfo.updateValue(self.step3ListingDetails.id!, forKey: "id")
                Utility.shared.selectedRules.removeAllObjects()
                Utility.shared.host_basePrice = 0
                Utility.shared.host_cleanPrice = 0
                self.view.window?.backgroundColor = UIColor.white
               StepTwoObj.modalPresentationStyle = .fullScreen
                self.present(StepTwoObj, animated:false, completion: nil)
            }
        }
    }
    
   
    func getStep1ListingDetails()
    {
        let step1ListingDetailsquery = GetStep1ListingDetailsQuery(listId: listID, preview: true)
        apollo_headerClient.fetch(query: step1ListingDetailsquery,cachePolicy:.fetchIgnoringCacheData){(result,error)in
            guard (result?.data?.getListingDetails?.results) != nil else{
                print("Missing Data")
                if(result?.data?.getListingDetails?.status == 400)
                {
                    self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"nolist"))!)")
                    self.UHOhLbl.isHidden = false
                    self.CantSeeLbl.isHidden = false
                    self.errorCode404Lbl.isHidden = false
                    self.becomeStepsTable.isHidden = true
                }
                return
            }
            self.step1ListingDetails = (result?.data?.getListingDetails?.results)!
            if (result?.data?.getListingDetails?.results?.id!)! != nil
            {
                Utility.shared.step1ValuesInfo.updateValue((result?.data?.getListingDetails?.results?.id!)!, forKey: "listId")
                Utility.shared.createId = (result?.data?.getListingDetails?.results?.id!)!
            }
            Utility.shared.step1ValuesInfo.updateValue((result?.data?.getListingDetails?.results?.country!)!, forKey: "country")
            Utility.shared.step1ValuesInfo.updateValue((result?.data?.getListingDetails?.results?.street!)!, forKey: "street")
            if (result?.data?.getListingDetails?.results?.buildingName) != nil{
                Utility.shared.step1ValuesInfo.updateValue((result?.data?.getListingDetails?.results?.buildingName!)!, forKey: "buildingName")
            }
            Utility.shared.step1ValuesInfo.updateValue((result?.data?.getListingDetails?.results?.city!)!, forKey: "city")
            Utility.shared.step1ValuesInfo.updateValue((result?.data?.getListingDetails?.results?.state!)!, forKey: "state")
            Utility.shared.step1ValuesInfo.updateValue((result?.data?.getListingDetails?.results?.zipcode!)!, forKey: "zipcode")
            if((result?.data?.getListingDetails?.results?.lat != nil) && (result?.data?.getListingDetails?.results?.lng != nil))
            {
            Utility.shared.step1ValuesInfo.updateValue((result?.data?.getListingDetails?.results?.lat!)!, forKey: "lat")
            Utility.shared.step1ValuesInfo.updateValue((result?.data?.getListingDetails?.results?.lng!)!, forKey: "lng")
            }
            Utility.shared.step1ValuesInfo.updateValue((result?.data?.getListingDetails?.results?.isMapTouched!)!, forKey: "isMapTouched")
            Utility.shared.step1ValuesInfo.updateValue((result?.data?.getListingDetails?.results?.bedrooms!)!, forKey: "bedrooms")
            Utility.shared.step1ValuesInfo.updateValue((result?.data?.getListingDetails?.results?.residenceType), forKey: "residenceType")
            Utility.shared.step1ValuesInfo.updateValue((result?.data?.getListingDetails?.results?.beds!)!, forKey: "beds")
            Utility.shared.step1ValuesInfo.updateValue((result?.data?.getListingDetails?.results?.userBedsTypes!)!, forKey: "bedTypes")
            Utility.shared.step1ValuesInfo.updateValue((result?.data?.getListingDetails?.results?.personCapacity!)!, forKey: "personCapacity")
            if let bathroomCount = result?.data?.getListingDetails?.results?.bathrooms
            {
                Utility.shared.step1ValuesInfo.updateValue(bathroomCount, forKey: "bathrooms")
            }
            Utility.shared.step1ValuesInfo.updateValue((result?.data?.getListingDetails?.results?.userAmenities!)!, forKey: "amenities")
            Utility.shared.step1ValuesInfo.updateValue((result?.data?.getListingDetails?.results?.userSafetyAmenities!)!, forKey: "safetyAmenities")
            Utility.shared.step1ValuesInfo.updateValue((result?.data?.getListingDetails?.results?.userSpaces!)!, forKey: "spaces")
            for index in (result?.data?.getListingDetails?.results?.settingsData!)!
            {
                if index?.listsettings?.settingsType?.typeName == "roomType"
                {
                    Utility.shared.step1ValuesInfo.updateValue((index?.listsettings?.id!)!, forKey: "roomType")
                }

                if index?.listsettings?.settingsType?.typeName == "buildingSize"
                {
                    Utility.shared.step1ValuesInfo.updateValue((index?.listsettings?.id!)!, forKey: "buildingSize")
                }
                if index?.listsettings?.settingsType?.typeName == "bathroomType"
                {
                    Utility.shared.step1ValuesInfo.updateValue((index?.listsettings?.id!)!, forKey: "bathroomType")
                }
                if index?.listsettings?.settingsType?.typeName == "bedType"
                {
                    Utility.shared.step1ValuesInfo.updateValue((index?.listsettings?.id!)!, forKey: "bedType")
                }
            }
            if((result?.data?.getListingDetails?.results?.settingsData!.count)! > 0 )
            {
            Utility.shared.step1ValuesInfo.updateValue((result?.data?.getListingDetails?.results?.settingsData![1]?.listsettings?.id!)!, forKey: "houseType")
            }
            Utility.shared.createId = Int(self.listID) ?? 0
            if(self.CheckActiveStateStep1() == "\((Utility.shared.getLanguage()?.value(forKey:"change"))!)")
            {
             Utility.shared.step1_inactivestatus = "completed"
              Utility.shared.isfrombecomehoststep1Edit = true
            }
            else
            {
             Utility.shared.step1_inactivestatus = "inactive"
            }
            let StepOne = PlaceListingViewController()
        StepOne.modalPresentationStyle = .fullScreen
            self.present(StepOne, animated:false, completion: nil)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
     if(showListingstepArray.listId != nil)
     {
        if((showListingstepArray.listing?.isReady)! == true)
        {
        return 3
        }
        return 2
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(showListingstepArray.listId != nil)
        {
        if(section == 0)
        {
        return 1
        }
        else if(section == 1){
            return 2
        }
        else{
            if((showListingstepArray.listing?.isReady)! == true)
            {
                return 1
            }
        }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0)
        {
            return 215
        }
        else if(indexPath.section == 1)
        {
            if (indexPath.row == 0)
            {
               if(CheckActiveStateStep2() == "" || CheckActiveStateStep2() == "\((Utility.shared.getLanguage()?.value(forKey:"change"))!)")
               {
                return 150
                }
                return 165
            }
            else{
                if(CheckActiveStateStep3() == "" || CheckActiveStateStep3() == "\((Utility.shared.getLanguage()?.value(forKey:"change"))!)")
                {
                  return 150
                }
                return 165
            }
        }
        else{
            return 155
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StepOneCell", for: indexPath)as! StepOneCell
            cell.changeBtn.setTitle(CheckActiveStateStep1(), for: .normal)
            cell.selectionStyle = .none
            if(CheckActiveStateStep1() == "\((Utility.shared.getLanguage()?.value(forKey:"continue"))!)")
            {
            cell.verifiedImage.isHidden = true
            }
            else
            {
              cell.verifiedImage.isHidden = false
            }
            cell.changeBtn.addTarget(self, action: #selector(step1BtnTapped),for:.touchUpInside)
            return cell
        }
        else if(indexPath.section == 1){
           let cell = tableView.dequeueReusableCell(withIdentifier: "StepTwoCell", for: indexPath)as! StepTwoCell
            cell.selectionStyle = .none
            if(indexPath.row == 0)
            {
                cell.descriptionLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"photos"))!)"
                cell.titleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"setscene"))!)"
                cell.stepLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"step2"))!)"
                cell.changeBtn.setTitle(CheckActiveStateStep2(), for: .normal)
                if(CheckActiveStateStep2() == "\((Utility.shared.getLanguage()?.value(forKey:"change"))!)")
                {
                    cell.titleLabel.isHidden = true
                    cell.verifyImage.isHidden = false
                    cell.descriptionLabel.frame.origin.y = cell.titleLabel.frame.origin.y
                    cell.verifyImage.frame.origin.y = cell.titleLabel.frame.origin.y
                    cell.changeBtn.frame.origin.y = cell.descriptionLabel.frame.origin.y + cell.descriptionLabel.frame.size.height + 5
                    cell.lineLabel.frame.origin.y = cell.changeBtn.frame.origin.y + cell.changeBtn.frame.size.height+10
                   
                }
                else if(CheckActiveStateStep2() == "\((Utility.shared.getLanguage()?.value(forKey:"continue"))!)")
                {
                    cell.titleLabel.isHidden = false
                    cell.verifyImage.isHidden = true
                }
                else
                {
                    cell.titleLabel.isHidden = false
                    cell.verifyImage.isHidden = true
                    cell.lineLabel.frame.origin.y = cell.changeBtn.frame.origin.y+10
                }
                cell.changeBtn.tag = indexPath.row
                 cell.changeBtn.addTarget(self, action: #selector(step2BtnTapped),for:.touchUpInside)
            }
            else
            {
              
             cell.descriptionLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"bookingsettings"))!)"
             cell.titleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"getready"))!)"
             cell.stepLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"step3"))!)"
             cell.changeBtn.isHidden = false
             cell.changeBtn.setTitle(CheckActiveStateStep3(), for: .normal)
               if(CheckActiveStateStep3() ==  "\((Utility.shared.getLanguage()?.value(forKey:"continue"))!)")
                {
                    cell.verifyImage.isHidden = true
                    cell.titleLabel.isHidden = false
                    
                     Utility.shared.step3_Edit = false
                }
                else if(CheckActiveStateStep3() == "\((Utility.shared.getLanguage()?.value(forKey:"change"))!)")
               {
                cell.verifyImage.isHidden = false
                cell.titleLabel.isHidden = true
                cell.descriptionLabel.frame.origin.y = cell.titleLabel.frame.origin.y
                cell.verifyImage.frame.origin.y = cell.titleLabel.frame.origin.y
                cell.changeBtn.frame.origin.y = cell.descriptionLabel.frame.origin.y + cell.descriptionLabel.frame.size.height + 5
                cell.lineLabel.frame.origin.y = cell.changeBtn.frame.origin.y + cell.changeBtn.frame.size.height+10
                 Utility.shared.step3_Edit = true
               }
                else
                {
                    cell.verifyImage.isHidden = true
                    cell.titleLabel.isHidden = false
                    cell.lineLabel.frame.origin.y = cell.changeBtn.frame.origin.y+10
                    cell.changeBtn.isHidden = true

                }
                cell.changeBtn.tag = indexPath.row
                cell.changeBtn.addTarget(self, action: #selector(step3BtnTapped(_:)), for: .touchUpInside)
            }
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StepPublishCell", for: indexPath)as! StepPublishCell
            cell.selectionStyle = .none
            cell.publishBtn.tag = indexPath.row
            cell.previewBtn.tag = indexPath.row
            cell.tag = indexPath.row + 2000
            if(showListingstepArray.listing?.isPublished! == true)
            {
               
                cell.listnameLabel.text = " \((Utility.shared.getLanguage()?.value(forKey:"listpublish"))!)"
                cell.publishBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"unpublishnow"))!)", for: .normal)
                Utility.shared.unpublish_preview_check = false
            }
            else{
                cell.listnameLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"readypublish"))!)"
                cell.publishBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"publishnow"))!)", for: .normal)
                Utility.shared.unpublish_preview_check = true
            }
            cell.publishBtn.addTarget(self, action: #selector(PublishBtnTapped),for:.touchUpInside)
            cell.previewBtn.addTarget(self, action: #selector(previewBtnTapped),for:.touchUpInside)
            return cell
        }
        
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
    @objc func step1BtnTapped(_ sender: UIButton)
    {
        if Utility().isConnectedToNetwork(){
        getStep1ListingDetails()
        }
        else
        {
            self.offlineViewShow()
        }
    }
    
    @objc func step2BtnTapped(_ sender: UIButton)
    {
        if Utility().isConnectedToNetwork(){
         self.getListingDetailsStep2()
        }
        else
        {
             self.offlineViewShow()
        }
    }
    
    func getListingDetailsStep2()
    {
        let getlistingStep2query = GetListingDetailsStep2Query(listId:"\(showListingstepArray.listId!)", preview: true)
        apollo_headerClient.fetch(query: getlistingStep2query,cachePolicy:.fetchIgnoringCacheData){(result,error) in
            guard (result?.data?.getListingDetails?.results) != nil else{
//                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"nolist"))!)")
//                self.UHOhLbl.isHidden = false
//                self.CantSeeLbl.isHidden = false
//                self.errorCode404Lbl.isHidden = false
//                self.becomeStepsTable.isHidden = true
                return
            }
            self.getListingStep2Array = (result?.data?.getListingDetails?.results)!
            let StepTwoObj = StepTwoVC()
            if ((!self.showListingstepArray.isPhotosAdded! || self.showListingstepArray.isPhotosAdded!) && (self.showListingstepArray.step2 == "completed")) {
                StepTwoObj.saveexit_Activated = "true"
            }
            if(self.showListingstepArray.step2 == "active")
            {
                StepTwoObj.saveexit_Activated = "false"
            }
            Utility.shared.step2_Title = ""
            Utility.shared.step2_Description = ""
            StepTwoObj.showListingstepArray = self.showListingstepArray
            StepTwoObj.getListingDetailsStep2()
            StepTwoObj.modalPresentationStyle = .fullScreen
            self.present(StepTwoObj, animated:false, completion: nil)
        }
    }
    
    @objc func step3BtnTapped(_ sender: UIButton)
    {
        if Utility().isConnectedToNetwork(){
        self.getStep3ListingDetails()
        }
        else
        {
           self.offlineViewShow()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func CheckActiveStateStep1()-> String
    {
        if(showListingstepArray.step1 == "active" && showListingstepArray.step2 == "inactive" && showListingstepArray.step3 == "inactive")
        {
            return "\((Utility.shared.getLanguage()?.value(forKey:"continue"))!)"
        }
        else if(showListingstepArray.step1 == "completed" && (showListingstepArray.step2 == "active" || showListingstepArray.step2 == "inactive" || showListingstepArray.step2 == "completed"))
        {
            return "\((Utility.shared.getLanguage()?.value(forKey:"change"))!)"
        }
        return ""
    }
    
    func CheckActiveStateStep2() ->String
    {
        if (!showListingstepArray.isPhotosAdded! && (showListingstepArray.step2 == "completed" || showListingstepArray.step2 == "active")) {
            
            return "\((Utility.shared.getLanguage()?.value(forKey:"continue"))!)"
        }
      else{
       if(showListingstepArray.step2 == "completed")
        {
            return "\((Utility.shared.getLanguage()?.value(forKey:"change"))!)"
        }
        else if(showListingstepArray.step2 == "active")
       {
        return "\((Utility.shared.getLanguage()?.value(forKey:"continue"))!)"
       }
       else{
          return ""
         }
        }
    }
    
    func CheckActiveStateStep3() ->String
    {
   if (showListingstepArray.step3 == "completed") {
        return "\((Utility.shared.getLanguage()?.value(forKey:"change"))!)"
        }
    else if(showListingstepArray.step3 == "inactive")
   {
    return ""
   }
     else{
    return "\((Utility.shared.getLanguage()?.value(forKey:"continue"))!)"
        }
    }
    
    @objc func PublishBtnTapped(_ sender: UIButton)
    {
         let cell = view.viewWithTag(sender.tag + 2000) as? StepPublishCell
        //if Utility().isConnectedToNetwork(){
            let btnsendtag: UIButton = sender
            if(btnsendtag.currentTitle == "\((Utility.shared.getLanguage()?.value(forKey:"publishnow"))!)"){
                Utility.shared.unpublish_preview_check = false
                PublishAPICall(listid:showListingstepArray.listId!, action: "publish",sender:sender,tag:sender.tag)
//                btnsendtag.setTitle("UnPublish Now", for: .normal)
//
//                cell!.listnameLabel.text = "Your Listing is Published"
                
            }
            else {
                Utility.shared.unpublish_preview_check = true
                PublishAPICall(listid: showListingstepArray.listId!, action: "unPublish",sender:sender,tag:sender.tag)
//                btnsendtag.setTitle("Publish Now", for: .normal)
//
//                cell!.listnameLabel.text = "Your Listing is ready to Publish!"
               
            }
        }
    
    func PublishAPICall(listid:Int,action:String,sender:UIButton,tag:Int)
    {
        let managepublishstatusMutation = ManagePublishStatusMutation(listId: listid, action: action)
        apollo_headerClient.perform(mutation: managepublishstatusMutation){(result,error) in
            let btnsendtag: UIButton = sender
            let cell = self.view.viewWithTag(sender.tag + 2000) as? StepPublishCell
            if(result?.data?.managePublishStatus?.status == 200)
            {
                self.ispublishenable = true
                self.showListingStepsAPICall(listID:self.listID)
                if(!Utility.shared.unpublish_preview_check)
                {
                    btnsendtag.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"unpublishnow"))!)", for: .normal)
                    cell!.listnameLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"listpublish"))!)"
                    
                }
                else
                {
                    btnsendtag.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"publishnow"))!)", for: .normal)
                    cell!.listnameLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"readypublish"))!)"
                }
                
            }else
            {
                self.view.makeToast(result?.data?.managePublishStatus?.errorMessage!)
            }
            
        }
    }
    
    @objc func previewBtnTapped(_ sender: UIButton)
    {

            let guestdetailObj = GuestDetailVC()
        print(showListingstepArray.listId!)
            guestdetailObj.listID = showListingstepArray.listId!

            Utility.shared.unpublish_preview_check = true
            guestdetailObj.currencyvalue_from_API_base = Utility.shared.currencyvalue_from_API_base

        
            guestdetailObj.currency_Dict = Utility.shared.currency_Dict
        guestdetailObj.modalPresentationStyle = .fullScreen
            self.present(guestdetailObj, animated:false, completion: nil)
        }
    @IBAction func retryBtnTapped(_ sender: Any) {
        
        if Utility().isConnectedToNetwork(){
            self.offlineView.isHidden = true
        }
        
    }


}


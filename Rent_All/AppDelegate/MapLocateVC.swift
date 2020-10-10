//
//  MapLocateVC.swift
//  Rent_All
//
//  Created by RadicalStart on 14/11/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Lottie
import Apollo
class MapLocateVC: UIViewController,GMSMapViewDelegate,CLLocationManagerDelegate {
    
    //MARK: - IBOUTLET & GLOBAL VARIABLE DECLARATION
    @IBOutlet weak var mapview: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var retryButn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var titleLAbel: UILabel!
    @IBOutlet weak var headeview: UIView!
    @IBOutlet weak var nextgreenImg: UIImageView!
    var marker:GMSMarker!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet var offlineUIView: UIView!
    @IBOutlet var saveandExit: UIButton!
    var mapGMSView: GMSMapView!
    var cirlce: GMSCircle!
    var centerMapCoordinate:CLLocationCoordinate2D!
    var  locationManager = CLLocationManager()
    
    var lottieView1: LOTAnimationView!
    let saveBtn = UIButton()
    var apollo_headerClient: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
        
        let url = URL(string:graphQLEndpoint)!
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        offlineUIView.isHidden = true
      
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestAlwaysAuthorization()
       
         let camera = GMSCameraPosition.camera(withLatitude:(Utility.shared.step1ValuesInfo["lat"] as! Double), longitude:(Utility.shared.step1ValuesInfo["lng"] as! Double), zoom:15)
        mapGMSView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapGMSView.isMyLocationEnabled = true
        mapGMSView.settings.zoomGestures = true
        mapGMSView.settings.compassButton = true
        mapGMSView.settings.indoorPicker = true
        saveandExit.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
        nextBtn.backgroundColor = Theme.PRIMARY_COLOR
        
        //mapGMSView.settings.myLocationButton = true
        self.view = mapGMSView
       
        if(IS_IPHONE_XR || IS_IPHONE_X)
        {
         headeview.frame = CGRect(x: 0, y:0, width: FULLWIDTH, height:110)
        backBtn.frame = CGRect(x: 5, y:53, width: 45, height:45)
        saveBtn.frame = CGRect(x:FULLWIDTH-185, y:59, width:170, height:33)
        titleView.frame = CGRect(x: 0, y:110, width: FULLWIDTH, height:65)
            
        }
        else{
            headeview.frame = CGRect(x: 0, y:0, width: FULLWIDTH, height:90)
            backBtn.frame = CGRect(x: 5, y:33, width: 45, height:45)
            saveBtn.frame = CGRect(x:FULLWIDTH-185, y:39, width:170, height:33)
            titleView.frame = CGRect(x: 0, y:90, width: FULLWIDTH, height:65)
        }
        //headeview.frame = CGRect(x: 0, y:0, width: FULLWIDTH, height:90)
       // titleView.frame = CGRect(x: 0, y:90, width: FULLWIDTH, height:65)
        mapGMSView.addSubview(headeview)
       
        mapGMSView.bringSubviewToFront(headeview)
        mapGMSView.addSubview(titleView)
        headeview.bringSubviewToFront(titleView)
        headeview.addSubview(saveBtn)
        mapGMSView.bringSubviewToFront(saveBtn)
        errorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
        retryButn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
    
        centerMapCoordinate = CLLocationCoordinate2D(latitude: (Utility.shared.step1ValuesInfo["lat"] as! Double), longitude: (Utility.shared.step1ValuesInfo["lng"] as! Double))
      
       
        self.nextgreenImg.image = self.nextgreenImg.image?.withRenderingMode(.alwaysTemplate)
        self.nextgreenImg.tintColor = UIColor.white
        
        if IS_IPHONE_XR || IS_IPHONE_X
        {
            
            self.nextBtn.frame = CGRect(x:FULLWIDTH-155, y:FULLHEIGHT-85, width:140, height: 45)
            self.nextgreenImg.frame = CGRect(x:FULLWIDTH-40, y:FULLHEIGHT-70, width: 15, height: 15)
        }else {
            self.nextBtn.frame = CGRect(x:FULLWIDTH-155, y:FULLHEIGHT-65, width:140, height: 45)
            self.nextgreenImg.frame = CGRect(x:FULLWIDTH-40, y:FULLHEIGHT-50, width: 15, height: 15)
        }
        mapGMSView.addSubview(nextBtn)
        mapGMSView.addSubview(nextgreenImg)
        nextBtn.layer.cornerRadius = 6.0
        nextBtn.layer.masksToBounds = true
        mapGMSView.delegate = self
        cirlce = GMSCircle(position: camera.target, radius:200)
        cirlce.fillColor = UIColor(red: 0.0/255.0, green: 132.0/255.0, blue: 135.0/255.0, alpha:0.3)
        cirlce.strokeColor = Theme.PRIMARY_COLOR
        cirlce.strokeWidth = 2.0;
        cirlce.map = mapGMSView
        titleLAbel.text = "\((Utility.shared.getLanguage()?.value(forKey:"pinplace"))!)"
        nextBtn.setTitle("\(Utility.shared.getLanguage()?.value(forKey: "next")as! String)", for:.normal)
        saveBtn.setTitle("\(Utility.shared.getLanguage()?.value(forKey: "saveexit")as! String)", for:.normal)
        saveBtn.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
        saveBtn.contentHorizontalAlignment = .right
        saveBtn.titleLabel?.font =  UIFont(name:"Circular-Book", size: 16)
        saveBtn.addTarget(self, action: #selector(saveandexitTapped), for:.touchUpInside)
        if marker == nil {
            
            self.placeMarkerOnCenter(centerMapCoordinate:centerMapCoordinate)
            
        }
        if(Utility.shared.step1_inactivestatus == "inactive" || Utility.shared.step1_inactivestatus == "")
        {
            saveBtn.isHidden = true
        }
        else {
            saveBtn.isHidden = false
        }
        
        // Do any additional setup after loading the view.
    }

    func placeMarkerOnCenter(centerMapCoordinate:CLLocationCoordinate2D) {
        if marker == nil {
            
            marker = GMSMarker()
       
        }
        marker.appearAnimation = GMSMarkerAnimation.pop
        
        marker.map = mapGMSView
        marker.icon = #imageLiteral(resourceName: "map_marker")
        
        //mapGMSView.selectedMarker = marker
        marker.position = centerMapCoordinate
        cirlce.position = centerMapCoordinate
        Utility.shared.step1ValuesInfo.updateValue(Double(centerMapCoordinate.latitude), forKey: "lat")
        Utility.shared.step1ValuesInfo.updateValue(Double(centerMapCoordinate.longitude), forKey: "lng")

        
        marker.map = self.mapGMSView
    }
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        let latitude = mapView.camera.target.latitude
        let longitude = mapView.camera.target.longitude
        centerMapCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
       // cirlce.position = position.target
        if marker == nil {
            
            marker = GMSMarker()
            marker.icon = #imageLiteral(resourceName: "map_marker")
        }

        self.placeMarkerOnCenter(centerMapCoordinate:centerMapCoordinate)
    }
    
    //MRAK: - BUTTON ACTIONS
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func retryBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            self.offlineUIView.isHidden = true
        }
    }
    
    @objc func saveandexitTapped() {
        
         if Utility().isConnectedToNetwork() {
            
            self.lottieViewanimation()
            self.updateListingAPICall()
            
        }
        else
         {
            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)")
           // self.offlineViewShow()
        }
        
    }
    @IBAction func RedirectnextTapped(_ sender: Any) {
        let nextpageObj = AmenitiesViewController()
        self.view.window?.backgroundColor = UIColor.white
         nextpageObj.modalPresentationStyle = .fullScreen
        self.present(nextpageObj, animated: false, completion: nil)
    }
    
    func offlineViewShow()
    {
       // self.offlineUIView.isHidden = false
        offlineUIView = UIView()
        if IS_IPHONE_X || IS_IPHONE_XR{
            offlineUIView.frame = CGRect.init(x: 0, y: FULLHEIGHT-130, width: FULLWIDTH, height: 55)
        }else{
            offlineUIView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
        }
         self.mapGMSView.addSubview(offlineUIView)
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
       
       
    }
    
    func lottieViewanimation()
    {
        saveBtn.setTitle("", for:.normal)
        lottieView1 = LOTAnimationView.init(name: "animation")
        self.lottieView1.isHidden = false
        self.lottieView1.frame = CGRect(x:80, y:-35, width:100, height:100)
        self.saveBtn.addSubview(self.lottieView1)
        self.view.bringSubviewToFront(self.lottieView1)
        self.lottieView1.backgroundColor = UIColor.clear
        self.lottieView1.play()
        Timer.scheduledTimer(timeInterval:0.3, target: self, selector: #selector(autoscroll), userInfo: nil, repeats: true)
    }
    @objc func autoscroll()
    {
        self.lottieView1.play()
    }
    //MARK: - Update Listing Step 1
    func updateListingAPICall()
    {
        
        var bedtypeInfoArr = [[String : Any]]()
        if let bedTypeInfo = Utility.shared.step1ValuesInfo["bedTypes"] as? [Any]
        {
            
            for i in 0..<bedTypeInfo.count
            {
                if let userBedTypes = bedTypeInfo[i] as? GetStep1ListingDetailsQuery.Data.GetListingDetail.Result.UserBedsType
                {
                    
                    var bedTypeInfo = [String : Any]()
                    bedTypeInfo.updateValue((userBedTypes.bedType)!, forKey: "bedType")
                    Utility.shared.step1ValuesInfo.updateValue(userBedTypes.bedType!, forKey: "bedType")
                    bedTypeInfo.updateValue(userBedTypes.bedCount!, forKey: "bedCount")
                    bedtypeInfoArr.append(bedTypeInfo)
                    
                }
                
            }
            let data = try? JSONSerialization.data(withJSONObject: bedtypeInfoArr, options: .prettyPrinted)
            let bedtypes = String(data: data!, encoding: String.Encoding.utf8)!
            var bedTypeString = ""
            if !bedtypes.isEmpty {
                let bedTypesArr = bedtypes.components(separatedBy: "\n")
                for str in bedTypesArr{
                    bedTypeString = bedTypeString + str
                }
            }
            Utility.shared.step1ValuesInfo.updateValue(bedTypeString.trimmingCharacters(in: .whitespaces), forKey: "bedTypes")
        }
        
        
        
        let createlist = CreateListingMutation(listId: Utility.shared.createId,
                                               roomType: "\(Utility.shared.step1ValuesInfo["roomType"] ?? "")",
            houseType: "\(Utility.shared.step1ValuesInfo["houseType"] ?? "")" ,
            residenceType: "\(Utility.shared.step1ValuesInfo["residenceType"] ?? "")",
            bedrooms: "\(Utility.shared.step1ValuesInfo["bedrooms"] ?? "")" ,
            buildingSize: "\(Utility.shared.step1ValuesInfo["buildingSize"] ?? "")",
            bedType: "\(Utility.shared.step1ValuesInfo["bedType"] ?? "")" ,
            beds: Utility.shared.step1ValuesInfo["beds"] as? Int,
            personCapacity: Utility.shared.step1ValuesInfo["personCapacity"] as? Int,
            bathrooms: (Utility.shared.step1ValuesInfo["bathrooms"] as? Double),
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
        apollo_headerClient.perform(mutation: createlist){(result,error) in
            
            if(result?.data?.createListing?.status == 200)
            {
                self.lottieView1.isHidden = true
                Utility.shared.createId = (result?.data?.createListing?.id)!
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    let becomeHost = BecomeHostVC()
                    becomeHost.listID = "\(Utility.shared.createId)"
                    becomeHost.showListingStepsAPICall(listID:"\(Utility.shared.createId)")
                    becomeHost.modalPresentationStyle = .fullScreen
                    self.present(becomeHost, animated:false, completion: nil)
                }
            }
            else{
                self.lottieView1.isHidden = true
                self.saveBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"saveexit"))!)", for:.normal)
                self.view.makeToast("\(Utility.shared.getLanguage()?.value(forKey: "somethingwrong") as! String)")
            }
        }
    }


}

//
//  SearchPageVC.swift
//  Rent_All
//
//  Created by RADICAL START on 26/03/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class SearchPageVC: UIViewController,UITextFieldDelegate,CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var retryBtn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet var placesTable: UITableView!
    
    @IBOutlet weak var offlineView: UIView!
    @IBOutlet var searchView: UIView!
    var locationManager = CLLocationManager()
    var fetcher: GMSAutocompleteFetcher?
    var locationArray = NSMutableArray()
    
    var temporaryLocationArray = NSMutableArray()
    
    
    @IBOutlet var searchText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
      //  searchView.frame = CGRect(x: 20, y: 10, width: FULLWIDTH-40, height: 55)
        // searchText.frame = CGRect(x: 20, y:8, width: FULLWIDTH-140, height: 40)
        searchText.font = UIFont(name: "Circular-Medium", size:17)
        searchText.textColor = TextDarkColor
        searchText.clearButtonMode = UITextField.ViewMode.always
        searchText.becomeFirstResponder()
          searchText.autocorrectionType = UITextAutocorrectionType.no
        if(Utility.shared.locationfromSearch != "" && Utility.shared.locationfromSearch != nil){
            searchText.attributedText = NSAttributedString(string:  Utility.shared.locationfromSearch , attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Medium", size:13)!,NSAttributedString.Key.foregroundColor:UIColor(red: 111.0/255.0, green: 113.0/255.0, blue:121.0/255.0, alpha: 1.0)])
           // searchText.text = ""
           
            
        }
        else {
           searchText.attributedPlaceholder = NSAttributedString(string: "\((Utility.shared.getLanguage()?.value(forKey:"losangeles"))!)", attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Medium", size:13)!,NSAttributedString.Key.foregroundColor:UIColor(red: 111.0/255.0, green: 113.0/255.0, blue:121.0/255.0, alpha: 1.0)])
        }
    
        searchText.delegate = self
        searchText.returnKeyType = .search
        //searchView .addSubview(searchText)
        if(IS_IPHONE_XR)
        {
        let shadowSize : CGFloat = 1.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: (self.searchView.frame.size.width+30) + shadowSize,
                                                   height: self.searchView.frame.size.height + shadowSize))
        
        self.searchView.layer.masksToBounds = false
        self.searchView.layer.shadowColor = TextLightColor.cgColor
        self.searchView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.searchView.layer.shadowOpacity = 0.1
        self.searchView.layer.shadowPath = shadowPath.cgPath
        }
        else
        {
            let shadowSize : CGFloat = 3.0
             let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                        y: -shadowSize / 2,
                                                        width: self.searchView.frame.size.width + shadowSize,
                                                        height: self.searchView.frame.size.height + shadowSize))
            
             self.searchView.layer.masksToBounds = false
             self.searchView.layer.shadowColor = TextLightColor.cgColor
             self.searchView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
             self.searchView.layer.shadowOpacity = 0.3
             self.searchView.layer.shadowPath = shadowPath.cgPath
        }
        
        temporaryLocationArray.add("Nearby")
        temporaryLocationArray.add("Chennai,Tamil Nadu")
        temporaryLocationArray.add("Madurai,Tamil Nadu - Homes")
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        //fetcher = GMSAutocompleteFetcher.init(bounds:bounds , filter:filter)
        fetcher = GMSAutocompleteFetcher.init()
        fetcher?.delegate = self
        
        placesTable.register(UINib(nibName: "SearchPalceCell", bundle: nil), forCellReuseIdentifier: "SearchPalceCell")
        placesTable.separatorColor = UIColor.clear
        placesTable.reloadData()
        
        errorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
        retryBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
        cancelBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"cancel"))!)", for:.normal)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        self.offlineView.isHidden = true
        
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification)
    {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            var tableFrame : CGRect = placesTable.frame
            tableFrame.size.height = FULLHEIGHT-170;
            tableFrame.size.height = tableFrame.size.height - keyboardHeight
            placesTable.frame = tableFrame
          
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
         textField.font = UIFont(name: "Circular-Medium", size:17)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
         textField.font = UIFont(name: "Circular-Medium", size:17)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()

        if textField.returnKeyType == .search{
            textField.font = UIFont(name: "Circular-Medium", size:17)
            self.getLocationDetails(address: textField.text!, primary_text: textField.text!)
            Utility.shared.locationfromSearch = textField.text
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {

        if range.location > 0 && string.count > 0{
            let whitespace = CharacterSet.whitespaces
            //get list of whitespace characters

            let start = string.unicodeScalars.startIndex
            if let textFieldText = textField.text{
                let location = textFieldText.unicodeScalars.index(textFieldText.unicodeScalars.startIndex, offsetBy: range.location - 1)

                //Check if a space follows a space
                if whitespace.contains(string.unicodeScalars[start]) && whitespace.contains(textFieldText.unicodeScalars[location]){

                    //Manually replace the space with your own space, programmatically
                    textField.text = (textFieldText as NSString?)?.replacingCharacters(in: range, with: " ")

                    if let pos = textField.position(from: textField.beginningOfDocument, offset: range.location + 1)
                    {
                        //Make sure you update the text caret to reflect the programmatic change to the text view
                        textField.selectedTextRange = textField.textRange(from: pos, to: pos)


                        //Tell UIKit not to insert its space, because you've just inserted your own
                        return false
                    }
                }
            }
        }
        //return true
        if(textField.text!+string == "& other")
        {
        return true
        }
        else if(textField.text!.count >= 1 && string == "")
        {
            self.locationArray.removeAllObjects()
            placesTable.reloadData()
            return true
        }
        else
        {
        fetcher?.sourceTextHasChanged(textField.text!+string)
        return true
        }
    }
    
    @IBAction func retryBtnTapped(_ sender: Any) {
      if Utility().isConnectedToNetwork(){
        self.offlineView.isHidden = true
       placesTable.reloadData()
        }
        
        
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        Utility.shared.isfromdetailpage = false
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: Table view delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//         if(searchText.text==""){
//            return temporaryLocationArray.count
//        }
        if(self.locationArray.count == 0)
        {
            return 0
        }
        
        return locationArray.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let locationObj = tableView.dequeueReusableCell(withIdentifier: "SearchPalceCell", for: indexPath) as! SearchPalceCell
//        if(searchText.text==""){
//            locationObj.locationLbl.text = temporaryLocationArray[indexPath.row] as? String
//
//            locationObj.locationLbl.font = UIFont(name: "Avenir Next Demi Bold", size: 16.0)
//                //UIFont.boldSystemFont(ofSize:17)
//            locationObj.locationLbl.textColor = UIColor.black
//
//             return locationObj
//        }
//        else{
        if(self.locationArray.count == 0)
        {
          
        }
        else
        {
        let locationDict:NSDictionary =  self.locationArray.object(at: indexPath.row) as! NSDictionary
        locationObj.configCell(locationDict: locationDict)
        locationObj.locationLbl.frame = CGRect(x: 60, y: 20, width: FULLWIDTH-70, height: 20)
        }
        return locationObj
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
           if Utility().isConnectedToNetwork(){
            if(self.locationArray.count > 0)
            {
            let aString = ((self.locationArray.object(at: indexPath.row) as! NSDictionary).value(forKey: "address_full") as! String)
            let bString = ((self.locationArray.object(at: indexPath.row) as! NSDictionary).value(forKey: "address_first") as? String)!
            let cString = bString.replacingOccurrences(of: "&", with: "", options: .literal, range: nil)
            Utility.shared.locationfromSearch = aString.replacingOccurrences(of: "&", with: "", options: .literal, range: nil)
            self.getLocationDetails(address:Utility.shared.locationfromSearch!, primary_text:cString)
            }
            else
            {
                Utility.shared.isfromsearchLocationFilter = false
                Utility.shared.isfromdetailpage = false
                Utility.shared.locationfromSearch = ""
                self.dismiss(animated: true, completion: nil)
            }
           // Utility.shared.locationfromSearch = locationDict.value(forKey:"address_full") as? String
            
       // }
            
            
            
            
        }
           else{
            self.offlineView.isHidden = false
            searchText.resignFirstResponder()
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
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-75, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-55, width: FULLWIDTH, height: 55)
            }
        }
        
        
    }
    
    
    func getLocationDetails(address:String,primary_text:String)
    {
        let locationObj  = GoogleLocationService()
        locationObj.getlocationFromAddress(address: address, onSuccess: {response in
            let status:String = response.value(forKey: "status") as! String
            if status == "OK"{
                let locationArray:NSArray = response.value(forKey: "results") as! NSArray
                let locationDict :NSDictionary = locationArray.object(at: 0) as! NSDictionary
                let lat:NSNumber = locationDict.value(forKeyPath:"geometry.location.lat") as! NSNumber
                let lon:NSNumber =  locationDict.value(forKeyPath:"geometry.location.lng") as! NSNumber
                let lattitute:Double = Double(truncating: lat)
                let longitute:Double = Double(truncating: lon)
                let locDict = NSMutableDictionary()
                locDict.setValue(lattitute, forKey: "lat")
                locDict.setValue(longitute, forKey: "lon")
                
//                let Pageobj = ExplorePageVC()
//                Pageobj.searchLocationDict = locDict
//
//                self.present(Pageobj, animated: true, completion: nil)
                
                Utility.shared.searchLocationDict = locDict
                Utility.shared.isfromsearchLocationFilter = true
                Utility.shared.isfromdetailpage = false
                self.dismiss(animated: true, completion: nil)
//                let pageObj = SearchResultsPage()
//                pageObj.searchDataDict = locDict
//                self.present(pageObj, animated: true,  : nil)
            }
            else
            {
                let lattitute:Double = 9.9252
                let longitute:Double = 78.1198
                let locDict = NSMutableDictionary()
                locDict.setValue(lattitute, forKey: "lat")
                locDict.setValue(longitute, forKey: "lon")
                
//                let pageObj = SearchResultsPage()
//                pageObj.searchDataDict = locDict
//                self.present(pageObj, animated: true, completion: nil)
            }
            
        })
        
    }
    
}

//MARK: Location auto complete fetcher
extension SearchPageVC








: GMSAutocompleteFetcherDelegate {
    func didFailAutocompleteWithError(_ error: Error) {
        print(error.localizedDescription)
        
    }
    
    
    func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        self.locationArray.removeAllObjects()
        for prediction in predictions{
            let mutableDict = NSMutableDictionary()
            mutableDict.setValue(prediction.attributedPrimaryText.string, forKey: "address_first")
            mutableDict.setValue(prediction.attributedSecondaryText?.string, forKey: "address_second")
            mutableDict.setValue(prediction.attributedFullText.string, forKey: "address_full")
            self.locationArray.addObjects(from: [mutableDict])
            placesTable.reloadData()
            placesTable.separatorColor = UIColor.lightGray
            
        }
    }
}

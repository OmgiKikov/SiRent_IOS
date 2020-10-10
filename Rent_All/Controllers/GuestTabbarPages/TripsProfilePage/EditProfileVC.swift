//
//  EditProfileVC.swift
//  Rent_All
//
//  Created by RadicalStart on 06/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Alamofire
import AVFoundation
import SwiftyJSON
import Lottie
import Apollo
import IQKeyboardManagerSwift

class EditProfileVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate{
   
   
    
    
    
    //****************************************************** IBOUTLET CONNECTIONS **********************************************************>
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var editProfileTable: UITableView!
    
    @IBOutlet weak var emailWrongView: UIView!
    @IBOutlet weak var emailexistView: UIView!
    @IBOutlet weak var emailAlertview: UIView!
    @IBOutlet weak var profileAlertView: UIView!
    @IBOutlet weak var offlineView: UIView!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var updateerrorLabel: UILabel!
    @IBOutlet weak var emailexistLabel: UILabel!
    @IBOutlet weak var emailrequireLabel: UILabel!
    @IBOutlet weak var profilerequireLabel: UILabel!
    @IBOutlet weak var retryBtn: UIButton!
    @IBOutlet weak var editprofileTitleLabel: UILabel!
    
    
    
    
    
    
    
    
    let imagePicker = UIImagePickerController()
    var imageData = NSData()
    var imgChanged:Bool = false
    var imgGalleryChanged:Bool = false
    var pickedImage_profile = UIImage()
    let dateInputView = UIView()
    let genderInputView = UIView()
    var genderArray = [String]()
    let genderPicker = UIPickerView()
    var textfieldValueArray = NSMutableArray()
    var pickedimageString = String()
    var datePickerView = UIDatePicker()
    var date_value = Date()
   
    var lottieWholeView = UIView()
    var lottieView: LOTAnimationView!
    
    var DatePickerSender: Bool = false
    
    let apollo_headerClient: ApolloClient = {
    let configuration = URLSessionConfiguration.default
        // Add additional headers as needed
    configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
        
    let url = URL(string:graphQLEndpoint)!
        
    return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
        
    }()
    
     var EditProfileArray = GetProfileQuery.Data.UserAccount.Result()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.initialSetup()
        DispatchQueue.main.async{
             self.editProfileTable.reloadData()
        }
        if IS_IPHONE_XR
        {
            headerView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height:80)
        editProfileTable.frame = CGRect(x: 0, y: 85, width: FULLWIDTH-40, height: FULLHEIGHT-100)
        }
//        else
//        if IS_IPHONE_XR
//        {
//        headerView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height:80)
//        editProfileTable.frame = CGRect(x: 0, y: 85, width: FULLWIDTH-40, height: FULLHEIGHT-300)
//        }

//        {
//        editProfileTable.frame = CGRect(x: 0, y: 65, width: FULLWIDTH, height: FULLHEIGHT-65)
//        }

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        if Utility().isConnectedToNetwork(){
        imgChanged = false
        self.imagePicker.setNavigationBarHidden(false, animated:false)
        DispatchQueue.main.async {
            if(!Utility.shared.isfromPhoneVC)
            {
                self.EdiprofileAPICall()
                self.editProfileTable.reloadData()
            }
            else
            {
                self.scrollToBottom()
                self.editProfileTable.reloadData()
            }
            }
        }
        else {
            
            self.lottieView.isHidden = true
            self.lottieWholeView.isHidden = true
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
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-85, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-55, width: FULLWIDTH, height: 55)
            }
        }
        
    }
     func scrollToBottom() {
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(row:0,section: 0)
            self.editProfileTable.scrollToRow(at: indexPath, at:.top, animated:false)
        }
        
    }
    func lottieAnimation()
    {
        self.lottieView.isHidden = false
        self.lottieWholeView.isHidden = false
        self.lottieWholeView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height: FULLHEIGHT)
        self.lottieWholeView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.view.addSubview(lottieWholeView)
        self.lottieView.frame = CGRect(x:FULLWIDTH/2-50, y: FULLHEIGHT/2-50, width: 100, height: 100)
        self.lottieWholeView.addSubview(self.lottieView)
        self.lottieView.backgroundColor = UIColor.white
        self.lottieView.layer.cornerRadius = 6.0
        self.lottieView.clipsToBounds = true
        self.lottieView.play()
        Timer.scheduledTimer(timeInterval:0.3, target: self, selector: #selector(autoscroll), userInfo: nil, repeats: true)
    }
    @objc func autoscroll()
    {
        if Utility.shared.isConnectedToNetwork(){
            self.lottieView.play()
        }else{
            self.lottieView.isHidden = true
            self.lottieWholeView.isHidden = true
        }
        
    }
    
    func initialSetup()
    {
        self.offlineView.isHidden = true
        self.emailexistView.isHidden = true
        self.emailWrongView.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        editProfileTable.register(UINib(nibName: "EditImageCell", bundle: nil), forCellReuseIdentifier: "EditImageCell")
        editProfileTable.register(UINib(nibName: "EditnameCell", bundle: nil), forCellReuseIdentifier: "EditnameCell")
        editProfileTable.register(UINib(nibName: "EditAboutCell", bundle: nil), forCellReuseIdentifier: "EditAboutCell")
         lottieView = LOTAnimationView.init(name: "loading_qwe")
        let shadowSize : CGFloat = 3.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.headerView.frame.size.width+40 + shadowSize,
                                                   height: self.headerView.frame.size.height + shadowSize))
        
        self.headerView.layer.masksToBounds = false
        self.headerView.layer.shadowColor = TextLightColor.cgColor
        self.headerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.headerView.layer.shadowOpacity = 0.3
        self.headerView.layer.shadowPath = shadowPath.cgPath
        self.imagePicker.delegate = self
        self.emailAlertview.isHidden = true
        self.profileAlertView.isHidden = true
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
         self.datePickerInputView()
//        if EditProfileArray.gender != nil && EditProfileArray.gender == ""
//
//        print("Gender Issue  \(EditProfileArray.gender)")
        if EditProfileArray.gender != nil && EditProfileArray.gender != ""

        {
            let index = genderArray.index(where: { (item) -> Bool in
                item == EditProfileArray.gender!
            })
            genderPicker.selectRow(index!, inComponent: 0, animated: true)
            
        }else{
            print("Something wrong")
        }
        errorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
    
        retryBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
        updateerrorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"profileupdate_error"))!)"
         emailexistLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"emailexistserror"))!)"
         emailrequireLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"emailrequire"))!)"
         profilerequireLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"profilerequire"))!)"
         editprofileTitleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"editprofile"))!)"
       
    }
    
    func EdiprofileAPICall()
    {
        let profileQuery = GetProfileQuery()
        apollo_headerClient.fetch(query:profileQuery,cachePolicy:.fetchIgnoringCacheData){(result,error) in
            
            guard (result?.data?.userAccount?.result) != nil else
            {
                print("Missing Data")
                return
            }
            
            print(result?.data?.userAccount?.result as Any)
            Utility.shared.EditProfileArray  = ((result?.data?.userAccount?.result)!)
            self.EditProfileArray = ((result?.data?.userAccount?.result)!)
            if(self.EditProfileArray.preferredCurrency != nil){
                         Utility.shared.selectedCurrency = self.EditProfileArray.preferredCurrency!
                       }
            
//            if(Utility.shared.isfromPhoneVC)
//            {
            self.editProfileTable.reloadData()
          //  }
           

        }
        
        
    }
    @IBAction func retryBtnTapped(_ sender: Any) {
        
        if Utility.shared.isConnectedToNetwork(){
            self.offlineView.isHidden = true
            self.uploadProfileimageService(imageBase64: self.imageData as Data)
        }
       
    }
    
    
    func datePickerInputView()
    {
        
        dateInputView.frame = CGRect(x: 0, y: FULLHEIGHT-200, width: FULLWIDTH, height: 200)
        genderInputView.frame = CGRect(x: 0, y: FULLHEIGHT-200, width: FULLWIDTH, height: 200)
        genderPicker.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height: 200)
        genderInputView.addSubview(genderPicker)
        genderArray.append("Male")
        genderArray.append("Female")
        genderArray.append("Other")
        genderPicker.delegate = self
        genderPicker.tintColor = Theme.PRIMARY_COLOR
        genderPicker.backgroundColor = UIColor.white
        genderPicker.reloadAllComponents()
        datePickerView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height: 200)
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        dateInputView.addSubview(datePickerView) // add date picker to UIView
        datePickerView.maximumDate = NSCalendar.current.date(byAdding: .year, value: -18, to: NSDate() as Date)
        datePickerView.minimumDate = NSCalendar.current.date(byAdding: .year, value: -118, to: NSDate() as Date)
        dateInputView.isHidden = true
       
    
        
    }

    @IBAction func saveBtnTapped(_ sender: Any) {
        
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
         Utility.shared.isfromdetailpage = true
        if(self.profileAlertView.isHidden && self.emailAlertview.isHidden)
        {
        Utility.shared.selectedphoneNumber  = ""
            self.view.window?.rootViewController?.dismiss(animated:false, completion: nil)
        }
        else
        {
            
        }
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        date_value = sender.date
        EditProfileArray.iosDob = dateFormatter.string(from: sender.date)
       DatePickerSender = true
    }
    
    func EditProfileAPICall(fieldName:String,fieldValue:String)
    {
        let editprofileMutation = EditProfileMutation(userId:(Utility.shared.getCurrentUserID()! as String), fieldName: fieldName, fieldValue: fieldValue, deviceType: "iOS", deviceId:Utility.shared.pushnotification_devicetoken)
        apollo_headerClient.perform(mutation: editprofileMutation){ (result,error) in
            
            if(result?.data?.userUpdate?.status == 200)
            {
                print("success")
                self.EdiprofileAPICall()
            }
            else {
              self.view.makeToast(result?.data?.userUpdate?.errorMessage)
            }
        }
      }
    
    
    //MARK:*********************************************************** TABLEVIEW DELEGATE & DATASOURCE METHODS ****************************************************>
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView( _ tableView : UITableView,  titleForHeaderInSection section: Int)->String?
    {
        if(section == 0){
            return ""
        }
        else if(section == 1 ){
            return "\((Utility.shared.getLanguage()?.value(forKey:"privatedetails"))!)"
        }
        else if(section == 2){
            return "\((Utility.shared.getLanguage()?.value(forKey:"optionaldetails"))!)"
        }
        else if(section == 3)
        {
            return "\((Utility.shared.getLanguage()?.value(forKey:"verfiediinfo"))!)"
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        
        let lineLabel = UILabel(frame: CGRect(x:15, y: 0, width:
            tableView.bounds.size.width-30, height: 1.0))
        lineLabel.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        //headerView.addSubview(lineLabel)
        
        let headerLabel = UILabel(frame: CGRect(x: 20, y:0, width:
            tableView.bounds.size.width, height: 60))
        headerLabel.font = UIFont(name: "Circular-Medium", size:25)
        headerLabel.addCharacterSpacing(kernValue: 1.3)
        headerLabel.textColor = UIColor.black.withAlphaComponent(0.7)
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section==0){
            return CGFloat.leastNormalMagnitude
        }else if section == 1{
            return 50
        }else if section == 2{
            return 50
        }
        else if section == 3{
            return 50
        }
        return 50
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0)
        {
            return 3
        }
        else if(section == 1)
        {
            return 4
        }
        else if(section == 2)
        {
           return 3
        }
        else if(section == 3)
        {
            return 3
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0)
        {
            if(indexPath.row == 0)
            {
                return 280
            }
            else if(indexPath.row == 1){
                return 100
            }
                return 70
        }
        else if(indexPath.section == 1)
        {
            return 100
        }
        else if(indexPath.section == 2)
        {
           return 70
        }
        else if(indexPath.section == 3)
        {
            return 70
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 0)
        {
        if(indexPath.row == 0)
        {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditImageCell", for: indexPath) as! EditImageCell
            cell.selectionStyle = .none
            cell.tag = 2000
        
            if(imgChanged)
            {
                if(imgGalleryChanged)
                {
                  cell.editProfileimage.image = pickedImage_profile
                }
                else {
                    cell.editProfileimage.sd_setImage(with: URL(string:"\(IMAGE_AVATAR_MEDIUM)\(pickedimageString)"), completed: nil)
                //cell.editProfileimage.sd_setImage(with: URL(string:"\(IMAGE_AVATAR_MEDIUM)\(profImage)"), placeholderImage: #imageLiteral(resourceName: "unknown"))
                }
              //
            }

            else{
                
                if(Utility.shared.EditProfileArray.picture != nil)
                {
                    let profImage = Utility.shared.EditProfileArray.picture!
                    cell.editProfileimage.sd_setImage(with: URL(string:"\(IMAGE_AVATAR_MEDIUM)\(profImage)"), completed: nil)
                    //cell.editProfileimage.sd_setImage(with: URL(string:"\(IMAGE_AVATAR_MEDIUM)\(profImage)"), placeholderImage: #imageLiteral(resourceName: "unknown"))
                }
            }
        return cell
        }
        else if(indexPath.row == 1)
        {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "EditnameCell") as! EditnameCell
            
            cell.selectionStyle = .none
            cell.EditProfileTF.isUserInteractionEnabled = true
            cell.EditProfileTF.delegate = self
            cell.EditProfileTF.inputAccessoryView = nil
            cell.EditProfileTF.inputView = nil
            cell.textfieldNameLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"name"))!)"
            cell.EditProfileTF.autocorrectionType = .no
            cell.EditProfileTF.placeholder = "\((Utility.shared.getLanguage()?.value(forKey:"entername"))!)"
            let toolBar = UIToolbar().ToolbarPikerSelect(mySelect: #selector(dismissName))
            cell.EditProfileTF.inputAccessoryView = toolBar
            cell.EditProfileTF.text = EditProfileArray.displayName!
            cell.EditProfileTF.tag = 0
            return cell
        }
            else
            {
            
                let cell = tableView.dequeueReusableCell(withIdentifier: "EditAboutCell", for: indexPath)as! EditAboutCell
                cell.selectionStyle = .none
                cell.aboutLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"aboutme"))!)"
                cell.editLabel.isHidden = false
                cell.phoneLabel.isHidden = true
                cell.rightArrowimg.isHidden = true
                return cell
            
            }
            
        }
            else if(indexPath.section == 1)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EditnameCell") as! EditnameCell
            
            cell.selectionStyle = .none
            cell.EditProfileTF.isUserInteractionEnabled = true
            cell.EditProfileTF.delegate = self
            cell.EditProfileTF.inputAccessoryView = nil
            cell.EditProfileTF.inputView = nil
            cell.EditProfileTF.tag = 1
            if(indexPath.row == 0)
            {
                cell.textfieldNameLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"gender"))!)"
                //cell.textfieldNameLabel.textColor = .black
                cell.EditProfileTF.textColor = grayColorCode
                cell.EditProfileTF.placeholder = "\((Utility.shared.getLanguage()?.value(forKey:"selectgender"))!)"
                if(EditProfileArray.gender != nil)
                {
                cell.EditProfileTF.text = EditProfileArray.gender!
                }
                else
                {
                    cell.EditProfileTF.text = ""
                    
                }
               
                let toolBar = UIToolbar().ToolbarPikerSelect(mySelect: #selector(dismissgenderPicker))
                cell.EditProfileTF.inputAccessoryView = toolBar
                cell.EditProfileTF.inputView = genderInputView
            }
            else if(indexPath.row == 1)
            {
                
                cell.textfieldNameLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"birthdate"))!)"
                cell.EditProfileTF.placeholder = "\((Utility.shared.getLanguage()?.value(forKey:"selectbirthday"))!)"
                cell.EditProfileTF.textColor = grayColorCode
                cell.EditProfileTF.tag = 2
                if(EditProfileArray.iosDob != nil)
                {
                if(EditProfileArray.iosDob == "-undefined-undefined")
                {
                    cell.EditProfileTF.text = ""
                
                }
                    else
                {
                cell.EditProfileTF.text = EditProfileArray.iosDob!
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat =  "MM-dd-yyyy"
//
//                    let date = dateFormatter.dateFromString("17:00")
//
                    datePickerView.date = dateFormatter.date(from: EditProfileArray.iosDob!)!
                    }
                }
                else
                {
                 cell.EditProfileTF.text = ""
                }
                let toolBar = UIToolbar().ToolbarPikerSelect(mySelect: #selector(dismissdatePicker))
                cell.EditProfileTF.inputAccessoryView = toolBar
                cell.EditProfileTF.inputView = dateInputView
            }
            else if(indexPath.row == 2)
            {
                cell.textfieldNameLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"emailreadonly"))!)"
                cell.EditProfileTF.placeholder = "\((Utility.shared.getLanguage()?.value(forKey:"enteremail"))!)"
                cell.EditProfileTF.tag = 3
                textfieldValueArray.add(EditProfileArray.email!)
                cell.EditProfileTF.isUserInteractionEnabled = false
                cell.EditProfileTF.textColor = grayColorCode
                cell.EditProfileTF.text = EditProfileArray.email!
               
            }
            else if(indexPath.row == 3)
            {
                cell.textfieldNameLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"location"))!)"
                cell.EditProfileTF.placeholder = "\((Utility.shared.getLanguage()?.value(forKey:"enterlocation"))!)"
                cell.EditProfileTF.textColor = grayColorCode
                cell.EditProfileTF.tag = 4
                //        cell.EditProfileTF.textColor = UIColor.darkGray
                let toolBar = UIToolbar().ToolbarPikerSelect(mySelect: #selector(dismissLocation))
                cell.EditProfileTF.inputAccessoryView = toolBar
                
                if(EditProfileArray.location != nil)
                {
                DispatchQueue.main.async {
                cell.EditProfileTF.text = self.EditProfileArray.location!
                }
              
                
                }
                else {
                    cell.EditProfileTF.text = ""
                }
            }
            return cell
        }
        else if(indexPath.section == 2){
       
            let cell = tableView.dequeueReusableCell(withIdentifier: "EditAboutCell", for: indexPath)as! EditAboutCell
             cell.selectionStyle = .none
             if(indexPath.row == 0)
            {
                cell.aboutLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"phonenumber"))!)"
                cell.editLabel.isHidden = true
                cell.phoneLabel.isHidden = false
                if(Utility.shared.selectedphoneNumber != "")
                {
                    cell.phoneLabel.isHidden = false
                    cell.phoneLabel.text = Utility.shared.selectedphoneNumber
                }
                else {
                cell.phoneLabel.isHidden = false
                if(EditProfileArray.phoneNumber != nil)
                {
                cell.phoneLabel.text = EditProfileArray.phoneNumber!
                }
                else{
                cell.phoneLabel.text = ""
                }
                }
                cell.rightArrowimg.isHidden = false
                 cell.rightArrowimg.image = #imageLiteral(resourceName: "right-arrow")
                
            }
            else if(indexPath.row == 1)
            {
                cell.aboutLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"languages"))!)"
                cell.editLabel.isHidden = true
                
//                if(Utility.shared.selectedLanguage != "")
//                {
//                cell.phoneLabel.isHidden = false
//                cell.phoneLabel.text = Utility.shared.selectedLanguage
//                }
//                else {
//                    cell.phoneLabel.isHidden = false
//                    if(EditProfileArray.preferredLanguageName != nil)
//                    {
//                    cell.phoneLabel.text = EditProfileArray.preferredLanguageName!
//                    }
//                    else
//                    {
//                        cell.phoneLabel.text = ""
//                    }
//
//                }
                cell.phoneLabel.isHidden = false
                cell.phoneLabel.text = Utility.shared.getAppLanguage()!
                cell.rightArrowimg.isHidden = false
                 cell.rightArrowimg.image = #imageLiteral(resourceName: "right-arrow")
            }

            else if(indexPath.row == 2)
            {
                cell.aboutLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"currency"))!)"
                cell.editLabel.isHidden = true
                if(Utility.shared.selectedCurrency != "")
                {
                    cell.phoneLabel.isHidden = false
                    cell.phoneLabel.text = Utility.shared.selectedCurrency
                }
                else{
                    cell.phoneLabel.isHidden = false
                    if(EditProfileArray.preferredCurrency != nil)
                    {
                    Utility.shared.selectedCurrency = EditProfileArray.preferredCurrency!
                    cell.phoneLabel.text = EditProfileArray.preferredCurrency!
                    }
                    else {
                        cell.phoneLabel.text = ""
                    }
                }
                cell.rightArrowimg.isHidden = false
                 cell.rightArrowimg.image = #imageLiteral(resourceName: "right-arrow")
            }
            return cell
        }
        else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "EditAboutCell", for: indexPath)as! EditAboutCell
            cell.selectionStyle = .none
            if(indexPath.row == 0)
            {
                
                
                cell.editLabel.isHidden = true
                cell.phoneLabel.isHidden = true
                
                cell.rightArrowimg.isHidden = false
                if((EditProfileArray.verification?.isEmailConfirmed!)!)
                {
                    cell.rightArrowimg.image =  #imageLiteral(resourceName: "right_white").withRenderingMode(.alwaysTemplate)
                    cell.rightArrowimg.tintColor = Theme.PRIMARY_COLOR
                    cell.aboutLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"confirmedemail"))!)"
                 // cell.rightArrowimg.image = #imageLiteral(resourceName: "right_white")
                }
                else
                {
                   cell.rightArrowimg.image = #imageLiteral(resourceName: "right-arrow")
                    cell.aboutLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"confirmemail"))!)"
                }
                
            }
            else if(indexPath.row == 1)
            {
              
                cell.editLabel.isHidden = true
                cell.phoneLabel.isHidden = true
                cell.rightArrowimg.isHidden = false
                if((EditProfileArray.verification?.isFacebookConnected!)!)
                {
                    cell.rightArrowimg.image =  #imageLiteral(resourceName: "right_white").withRenderingMode(.alwaysTemplate)
                    cell.rightArrowimg.tintColor = Theme.PRIMARY_COLOR
                      cell.aboutLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"connectedfb"))!)"
                    // cell.rightArrowimg.image = #imageLiteral(resourceName: "right_white")
                }
                else
                {
                    cell.rightArrowimg.image = #imageLiteral(resourceName: "right-arrow")
                      cell.aboutLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"connectfb"))!)"
                }
                
            }
            else if(indexPath.row == 2)
            {
               
                cell.editLabel.isHidden = true
                cell.phoneLabel.isHidden = true       
                cell.rightArrowimg.isHidden = false
                if((EditProfileArray.verification?.isGoogleConnected!)!)
                {
                    cell.rightArrowimg.image =  #imageLiteral(resourceName: "right_white").withRenderingMode(.alwaysTemplate)
                    cell.rightArrowimg.tintColor = Theme.PRIMARY_COLOR
                    // cell.rightArrowimg.image = #imageLiteral(resourceName: "right_white")
                     cell.aboutLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"connectedgoogle"))!)"
                }
                else
                {
                    cell.rightArrowimg.image = #imageLiteral(resourceName: "right-arrow")
                     cell.aboutLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"connectgoogle"))!)"
                }
                
            }
             return cell
        }
                
       
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 0)
        {
            if(indexPath.row == 0)
            {
                let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                let camera = UIAlertAction(title:"\((Utility.shared.getLanguage()?.value(forKey:"camera"))!)", style: .default) { (action) in
                    if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
                        //already authorized
                        
                        self.moveToCamera()
                    } else {
                        AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                            if granted {
                                //access allowed
                                self.moveToCamera()
                            } else {
                                //access denied
                                DispatchQueue.main.async {
                                    self.cameraPermissionAlert()
                                }
                            }
                        })
                    }
                }
                let gallery = UIAlertAction(title: "\((Utility.shared.getLanguage()?.value(forKey:"gallery"))!)", style: .default) { (action) in
                    self.imagePicker.allowsEditing = false
                    self.imgGalleryChanged = true
                    self.imagePicker.sourceType = .photoLibrary
                    
                    self.present(self.imagePicker, animated: true, completion: nil)
                }
                let cancel = UIAlertAction(title:"\((Utility.shared.getLanguage()?.value(forKey:"cancel"))!)", style: .cancel)
                alertController.addAction(camera)
                alertController.addAction(gallery)
                alertController.addAction(cancel)
                self.present(alertController, animated: true, completion: nil)
            }
            else if(indexPath.row == 2)
            {
                let aboutobj  = AboutmeVC()
                aboutobj.aboutvaluArray = EditProfileArray
            //    let obj = MapLocateVC()
                 aboutobj.modalPresentationStyle = .fullScreen
                self.present(aboutobj, animated: true, completion: nil)
            }
        }
        else if(indexPath.section == 2)
        {
            if(indexPath.row == 0)
            {
                let phoneNumberObj = PhonekitVC()
                phoneNumberObj.userphonekitArray = EditProfileArray
                  phoneNumberObj.modalPresentationStyle = .fullScreen
                 //self.view.window?.rootViewController?.present(phoneNumberObj, animated: true, completion: nil)
               self.present(phoneNumberObj, animated: true, completion: nil)
            }
            else if(indexPath.row == 1)
            {
                let languageObj = LanguageVC()
                languageObj.userEditProfileArray = EditProfileArray
                Utility.shared.isfromLanguage = true
                Utility.shared.isfrom_payoutcurrency = false
                Utility.shared.isfromCurrency = false
                  languageObj.modalPresentationStyle = .fullScreen
                self.present(languageObj, animated: true, completion: nil)
            }
            else if(indexPath.row == 2)
            {
                let languageObj = LanguageVC()
                languageObj.userEditProfileArray = EditProfileArray
                Utility.shared.isfromLanguage = false
                Utility.shared.isfrom_payoutcurrency = false
                Utility.shared.isfromCurrency = true
                 languageObj.modalPresentationStyle = .fullScreen
                self.present(languageObj, animated: true, completion: nil)
            }
        }
        else if(indexPath.section == 3)
        {
            let verifyObj = EmailGoogleFBViewController()
            verifyObj.is_fb_verify = (EditProfileArray.verification?.isFacebookConnected!)!
            verifyObj.is_google_verify = (EditProfileArray.verification?.isGoogleConnected!)!
            verifyObj.is_email_verify = (EditProfileArray.verification?.isEmailConfirmed!)!
            verifyObj.modalPresentationStyle = .fullScreen
            self.present(verifyObj, animated: true, completion: nil)
        }
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderArray.count
    }
    
   func pickerView( _ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = genderArray[row]
    
        let myTitle = NSAttributedString(string: titleData as! String, attributes: [NSAttributedString.Key.font:UIFont(name: "Circular-Medium", size: 15.0)!,NSAttributedString.Key.foregroundColor:Theme.PRIMARY_COLOR])
        return myTitle
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent  component: Int) {
        EditProfileArray.gender = (genderArray[row] as! String)
        
       //
    }
    @objc func dismissdatePicker() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-yyyy-dd"
        let dob = dateFormatter.string(from:date_value)
        if DatePickerSender == false{
            
        }else{
            self.EditProfileAPICall(fieldName: "dateOfBirth", fieldValue:dob)
            
            editProfileTable.reloadData()
        }

        view.endEditing(true)
        
    }
    @objc func dismissgenderPicker() {
        if(EditProfileArray.gender != nil)
        {
            self.EditProfileAPICall(fieldName: "gender", fieldValue: "\(EditProfileArray.gender!)")
        }
        else{
            EditProfileArray.gender = "\((Utility.shared.getLanguage()?.value(forKey:"gender_male"))!)"
            self.EditProfileAPICall(fieldName: "gender", fieldValue: "Male")
        }
        editProfileTable.reloadData()
        view.endEditing(true)
        
    }
    @objc func dismissLocation() {
        
        view.endEditing(true)
        
    }
     @objc func dismissName() {
        
        self.view.endEditing(true)
        
    }
    
    //move to camera
    func moveToCamera()   {
        
        DispatchQueue.main.async {
            self.imagePicker.allowsEditing = true
            self.imgGalleryChanged = false
            self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }

        }
    
   
    //MARK:location restriction alert
    func cameraPermissionAlert(){
        AJAlertController.initialization().showAlert(aStrMessage: "\((Utility.shared.getLanguage()?.value(forKey:"camerapermission"))!)", aCancelBtnTitle:"\((Utility.shared.getLanguage()?.value(forKey:"cancel"))!)", aOtherBtnTitle: "\((Utility.shared.getLanguage()?.value(forKey:"settings"))!)", completion: { (index, title) in
            print(index,title)
            if index == 1{
                //open settings page
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        })
    }
    
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
     
        if Utility.shared.isConnectedToNetwork() {
            let cell = view.viewWithTag(2000) as? EditImageCell
            if let pickedImage = info[.originalImage] as? UIImage {
                // self.profilePic.image = pickedImage
                self.pickedImage_profile = pickedImage
                //cell?.editProfileimage.image = pickedImage
                self.lottieAnimation()
                if(!imgGalleryChanged)
                {
                    
                    let orientedimage = fixOrientation(img: pickedImage)
                    self.imageData = orientedimage.jpegData(compressionQuality: 0.75)! as NSData
                } else {
                    self.imageData = pickedImage.jpegData(compressionQuality: 0.75)! as NSData
                }
                
                self.uploadProfileimageService(imageBase64: self.imageData as Data)
                
            }
            self.dismiss(animated: true, completion: nil)
        }else{
            self.view.makeToast("Please connect to intenet and try again")
        }

       
        
    }
    func fixOrientation(img: UIImage) -> UIImage {
        if (img.imageOrientation == .up) {0
            return img
        }
        
        UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale)
        let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
        img.draw(in: rect)
        
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return normalizedImage
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.imagePicker.setNavigationBarHidden(false, animated:false)
        self.dismiss(animated: true, completion: nil)
    }
    
    func uploadProfileimageService(imageBase64:Data)
    {
        
        if Utility().isConnectedToNetwork(){
            
       self.uploadProfilePic(profileimage:imageBase64,onSuccess:{response in
        
            let status = response.value(forKey: "status") as! Int
       
        
        if(status == 200)
        {
            DispatchQueue.global(qos: .background).async {
                self.EdiprofileAPICall()
            }
             DispatchQueue.main.async {
            self.editProfileTable.reloadData()
            }
            self.lottieView.isHidden = true
            self.lottieWholeView.isHidden = true
        }
        else{
            
            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"maximumupload"))!)")
            self.lottieView.isHidden = true
            self.lottieWholeView.isHidden = true
        }
        
        })
        }
        else
        {
            self.lottieView.isHidden = true
            self.lottieWholeView.isHidden = true
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
      
        
    }
    
    func uploadProfilePic(profileimage:Data,onSuccess success: @escaping (NSDictionary) -> Void) {
        if Utility().isConnectedToNetwork(){
        let BaseUrl = URL(string: IMAGE_UPLOAD_PHOTO)
        print("BASE URL : \(IMAGE_UPLOAD_PHOTO)")

        let header = ["auth": "\(Utility.shared.getCurrentUserToken()!)"]
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(profileimage, withName: "file", fileName: "file.jpeg", mimeType: "image/jpeg")
        }, to:BaseUrl!,method:.post,headers:header)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                })
                upload.responseJSON { response in
                    let JSON_Dict = response.result.value as? NSDictionary
                    if(JSON_Dict != nil)
                    {
                    let file = JSON_Dict?.value(forKey: "file") as! NSDictionary
                    self.pickedimageString = "\(JSON(file)["filename"])"
                    
                    self.imgChanged = true
                       // self.EdiprofileAPICall()
                    print("RESPONSE \(response)")
                    success(JSON_Dict!)
                    }
                }
            case .failure(let error):
                print("FAILURE RESPONSE: \(error.localizedDescription)")
                if error._code == NSURLErrorTimedOut{
                    //                    Utility.shared.showAlert(msg: Utility.shared.getLanguage()?.value(forKey: "timed_out") as! String)
                }else if error._code == NSURLErrorNotConnectedToInternet{
                    //Utility.shared.goToOffline()
                }else{
                    // Utility.shared.showAlert(msg: Utility.shared.getLanguage()?.value(forKey: "server_alert") as! String)
                }
            }
        }
        }
        else {
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
    }
    
    
    func checkexistingemailAPI(currentTF:UITextField)
    {

       self.lottieAnimation()
        let checkemail = CheckEmailExistsQuery(email:currentTF.text!)
        apollo.fetch(query: checkemail){ (result,error) in
            
            if(result?.data?.validateEmailExist?.status == 200){
                self.emailexistView.isHidden = true
                self.EditemailAPICall(fieldName: "email", fieldValue:currentTF.text!)
                self.lottieView.isHidden = true
                self.lottieWholeView.isHidden = true
            }
            else{
                
                self.lottieView.isHidden = true
                self.lottieWholeView.isHidden = true
                self.emailWrongView.isHidden = true
                self.emailexistView.isHidden = false
                if IS_IPHONE_X || IS_IPHONE_XR{
                    self.emailexistView.frame = CGRect.init(x: 0, y: FULLHEIGHT-85, width: FULLWIDTH, height: 55)
                }else{
                    self.emailexistView.frame = CGRect.init(x: 0, y: FULLHEIGHT-55, width: FULLWIDTH, height: 55)
                }
            }
        }
        
        
    }
    
    func EditemailAPICall(fieldName:String,fieldValue:String)
    {
        let editprofileMutation = EditProfileMutation(userId: (Utility.shared.getCurrentUserID()! as String), fieldName: fieldName, fieldValue: fieldValue, deviceType: "iOS", deviceId:Utility.shared.pushnotification_devicetoken)
        apollo_headerClient.perform(mutation: editprofileMutation){ (result,error) in
            
            if(result?.data?.userUpdate?.status == 200)
            {
                self.EdiprofileAPICall()
                if(result?.data?.userUpdate?.userToken != nil)
                {
                Utility.shared.setUserToken(userID: (result?.data?.userUpdate?.userToken as AnyObject) as! NSString)
                }
                self.emailWrongView.isHidden = true
                self.lottieView.isHidden = true
                self.lottieWholeView.isHidden = true
            }
            else {
                self.lottieView.isHidden = true
                self.lottieWholeView.isHidden = true
                self.emailWrongView.isHidden = false
                if IS_IPHONE_X || IS_IPHONE_XR{
                    self.emailWrongView.frame = CGRect.init(x: 0, y: FULLHEIGHT-85, width: FULLWIDTH, height: 55)
                }else{
                    self.emailWrongView.frame = CGRect.init(x: 0, y: FULLHEIGHT-55, width: FULLWIDTH, height: 55)
                }
            }
        }
    }
    
    
    //Mark: ************************************ Keyboard show/Hide **********************************************>
    
    
    @objc func keyboardWillShow(sender: NSNotification) {
        let info = sender.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        
        //  self.GoBtn.frame.origin.y -= keyboardFrame.height
//        if((!emailWrongView.isHidden))
//        {
//            self.emailWrongView.frame.origin.y = keyboardFrame.origin.y - 75
//        }
//        else if(!emailexistView.isHidden)
//        {
//           self.emailexistView.frame.origin.y = keyboardFrame.origin.y - 75
//        }
//        else if(!emailAlertview.isHidden)
//        {
//            self.emailAlertview.frame.origin.y = keyboardFrame.origin.y - 75
//        }
//        else if(!profileAlertView.isHidden)
//        {
//            self.profileAlertView.frame.origin.y = keyboardFrame.origin.y - 75
//        }
//        else if(!offlineView.isHidden)
//        {
//            self.offlineView.frame.origin.y = keyboardFrame.origin.y - 75
//        }
        
        
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        let info = sender.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        if((!emailWrongView.isHidden))
        {
              self.emailWrongView.frame.origin.y = FULLHEIGHT - 90
        }
        else if(!emailexistView.isHidden)
        {
             self.emailexistView.frame.origin.y = FULLHEIGHT - 90
        }
        else if(!emailAlertview.isHidden)
        {
            self.emailAlertview.frame.origin.y = FULLHEIGHT - 90
        }
        else if(!profileAlertView.isHidden)
        {
            self.profileAlertView.frame.origin.y = FULLHEIGHT - 90
        }
        else if(!offlineView.isHidden)
        {
            self.offlineView.frame.origin.y = FULLHEIGHT - 90
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
extension UILabel {
    func addCharacterSpacing(kernValue: Double = 1.15) {
        if let labelText = text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}
extension UIToolbar {
    
    func ToolbarPikerSelect(mySelect : Selector) -> UIToolbar {
        
        let toolBar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = Theme.PRIMARY_COLOR
        toolBar.sizeToFit()
        toolBar.backgroundColor = UIColor.white
        
        let doneButton = UIBarButtonItem(title: "\((Utility.shared.getLanguage()?.value(forKey:"done"))!)", style: UIBarButtonItem.Style.plain, target: self, action: mySelect)
        doneButton.setTitleTextAttributes([kCTForegroundColorAttributeName as NSAttributedString.Key: Theme.PRIMARY_COLOR], for: .normal)
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
}
extension EditProfileVC:UITextFieldDelegate {
    
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        dateInputView.isHidden = false
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
    }
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if(textField.tag == 0)
//        {
//            
//            
//        }
//        return true
//    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {

         if(textField.tag == 0)
        {
            if(textField.text!.count>0)
            {
                self.profileAlertView.isHidden = true
                self.EditProfileAPICall(fieldName: "displayName", fieldValue:textField.text!)
            }
            else{
                self.profileAlertView.isHidden = false
                if IS_IPHONE_X || IS_IPHONE_XR {
                    profileAlertView.frame = CGRect.init(x: 0, y: FULLHEIGHT-85, width: FULLWIDTH, height: 55)
                }else{
                    profileAlertView.frame = CGRect.init(x: 0, y: FULLHEIGHT-55, width: FULLWIDTH, height: 55)
                }
                textField.resignFirstResponder()
            }
            
            
        }
            
      
        else if(textField.tag == 3)
        {
             if (textField.text?.isValidEmail())! {
                self.emailAlertview.isHidden = true
                self.EditemailAPICall(fieldName: "email", fieldValue:textField.text!)
               // self.checkexistingemailAPI(currentTF: textField)
            }
            else{
                
                self.emailAlertview.isHidden = false
                if IS_IPHONE_X || IS_IPHONE_XR {
                    emailAlertview.frame = CGRect.init(x: 0, y: FULLHEIGHT-85, width: FULLWIDTH, height: 55)
                }else{
                    emailAlertview.frame = CGRect.init(x: 0, y: FULLHEIGHT-55, width: FULLWIDTH, height: 55)
                }
                textField.resignFirstResponder()
            }
            
        }
         else if(textField.tag == 4)
         {
           // DispatchQueue.main.async {
                self.EditProfileArray.location = textField.text!
                self.EditProfileAPICall(fieldName: "location", fieldValue:textField.text!)
                Utility.shared.isfromPhonePage = false
           // }

        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        
        return true
     }
}

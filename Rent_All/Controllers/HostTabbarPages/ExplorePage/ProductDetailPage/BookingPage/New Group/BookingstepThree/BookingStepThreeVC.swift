//
//  BookingStepThreeVC.swift
//  Rent_All
//
//  Created by RadicalStart on 30/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Lottie
import Alamofire
import SwiftyJSON
import AVFoundation
import Apollo

class BookingStepThreeVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate  {
    
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bookingStepthreeTable: UITableView!
    
    @IBOutlet weak var offlineView: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var bottomView: UIView!
    
    var pickedImage_profile = UIImage()
     var imgGalleryChanged:Bool = false
    let imagePicker = UIImagePickerController()
    var imageData = NSData()
    var imgChanged:Bool = false
    var lottieWholeView = UIView()
     var pickedimageString = String()
    var lottieView: LOTAnimationView!
    var viewListingArray = ViewListingDetailsQuery.Data.ViewListing.Result()
    var ProfileAPIArray = GetProfileQuery.Data.UserAccount.Result()
    
    var apollo_headerClient: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
        
        let url = URL(string:graphQLEndpoint)!
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialsetup()
        self.profileAPICall()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    func initialsetup()
    {
        if IS_IPHONE_XR
        {
            self.topView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH-40, height: 80)
            bookingStepthreeTable.frame = CGRect(x: 0, y: 85, width: FULLWIDTH-40, height: FULLHEIGHT-300)
            
        }
        bookingStepthreeTable.register(UINib(nibName: "BookingthreeCell", bundle: nil), forCellReuseIdentifier: "BookingthreeCell")
        let shadowSize : CGFloat = 3.0
        
        let shadowPath1 = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                    y: -shadowSize / 2,
                                                    width: self.topView.frame.size.width+40 + shadowSize,
                                                    height: self.topView.frame.size.height + shadowSize))
        
        self.topView.layer.masksToBounds = false
        self.topView.layer.shadowColor = TextLightColor.cgColor
        self.topView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.topView.layer.shadowOpacity = 0.3
        self.topView.layer.shadowPath = shadowPath1.cgPath
        nextBtn.layer.cornerRadius = 5.0
        nextBtn.layer.masksToBounds = true
        self.imagePicker.delegate = self
        self.offlineView.isHidden = true
        lottieView = LOTAnimationView.init(name: "loading_qwe")
//        self.lottieView.isHidden = true
//        self.lottieWholeView.isHidden = true
        
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
        self.lottieView.play()
    }
    @IBAction func nextBtnTapped(_ sender: Any) {
        if(pickedimageString == "" && ProfileAPIArray.picture == nil)
        {
            self.view.makeToast("Please upload your profile")
        }
        else{
        let bookingfourObj = BookingStepFourVC()
        bookingfourObj.viewListingArray = viewListingArray
        self.present(bookingfourObj, animated: true, completion: nil)
        }
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
     @objc func uploadBtnTapped(){
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let camera = UIAlertAction(title:"Camera", style: .default) { (action) in
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
        let gallery = UIAlertAction(title: "Gallery", style: .default) { (action) in
            self.imagePicker.allowsEditing = false
            self.imgGalleryChanged = true
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title:"Cancel", style: .cancel)
        alertController.addAction(camera)
        alertController.addAction(gallery)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK*************************************************** TABLEVIEW DELEGATE & DATASOURCE METHODS *****************************************************************************>
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(ProfileAPIArray != nil)
        {
            return 1
        }
       return 0
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 540
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingthreeCell", for: indexPath)as! BookingthreeCell
        cell.uploadBTn.addTarget(self, action: #selector(uploadBtnTapped), for: .touchUpInside)
        cell.selectionStyle = .none
        if(imgChanged)
        {
        if(imgGalleryChanged)
        {
            cell.profileImage.image = pickedImage_profile
        }
        else {
            let profImage = pickedimageString
            cell.profileImage.sd_setImage(with: URL(string:"\(IMAGE_AVATAR_MEDIUM)\(profImage)"), completed: nil)
            //cell.editProfileimage.sd_setImage(with: URL(string:"\(IMAGE_AVATAR_MEDIUM)\(profImage)"), placeholderImage: #imageLiteral(resourceName: "unknown"))
        }
        }
        else{
            if(ProfileAPIArray.picture != nil)
            {
                let profImage = ProfileAPIArray.picture!
                cell.profileImage.sd_setImage(with: URL(string:"\(IMAGE_AVATAR_MEDIUM)\(profImage)"), completed: nil)
            }
            else
            {
            cell.profileImage.image = #imageLiteral(resourceName: "unknown")
            }
        }
        if(Utility.shared.isprofilepictureVerified)
        {
            cell.stepLabel.text =  "Step 3 of 4"
        }
    
    
        return cell
    }
    //move to camera
    func moveToCamera()   {
        self.imagePicker.allowsEditing = true
        self.imgGalleryChanged = false
        self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    
    //MARK:location restriction alert
    func cameraPermissionAlert(){
        AJAlertController.initialization().showAlert(aStrMessage: "camera_permission", aCancelBtnTitle: "cancel", aOtherBtnTitle: "settings", completion: { (index, title) in
            print(index,title)
            if index == 1{
                //open settings page
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        })
    }
    
    @IBAction func retryBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
         self.offlineView.isHidden = true
        }
    }
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        
        let cell = view.viewWithTag((1) + 1000) as? EditImageCell
        if let pickedImage = info[.originalImage] as? UIImage {
            // self.profilePic.image = pickedImage
            self.pickedImage_profile = pickedImage
            cell?.editProfileimage.image = pickedImage
            if(!imgGalleryChanged)
            {
               self.lottieAnimation()
                let orientedimage = fixOrientation(img: pickedImage)
                self.imageData = orientedimage.jpegData(compressionQuality: 0.75)! as NSData
            } else {
                self.imageData = pickedImage.jpegData(compressionQuality: 0.75)! as NSData
            }
            self.uploadProfileimageService(imageBase64: self.imageData as Data)
            
        }
        self.dismiss(animated: true, completion: nil)
        
        
    }
    func fixOrientation(img: UIImage) -> UIImage {
        if (img.imageOrientation == .up) {
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
        self.dismiss(animated: true, completion: nil)
    }
    
    func uploadProfileimageService(imageBase64:Data)
    {
        
        if Utility().isConnectedToNetwork(){
            self.uploadProfilePic(profileimage:imageBase64,onSuccess:{response in
                
                let status = response.value(forKey: "status") as! Int
                
                
                if(status == 200)
                {
                    self.bookingStepthreeTable.reloadData()
                    self.lottieView.isHidden = true
                    self.lottieWholeView.isHidden = true
                }
                else{
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
            if IS_IPHONE_X || IS_IPHONE_XR {
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-90, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-55, width: FULLWIDTH, height: 55)
            }
        }
        
        
    }
    
    func uploadProfilePic(profileimage:Data,onSuccess success: @escaping (NSDictionary) -> Void) {
        if Utility().isConnectedToNetwork(){
            let BaseUrl = URL(string: IMAGE_UPLOAD_PHOTO)
            print("BASE URL : \(IMAGE_UPLOAD_PHOTO)")
            //        let parameters = ["user_id": user_id]
            //        print("REQUEST : \(parameters)")
            print("data \(profileimage)")
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
                            print("RESPONSE \(response)")
                            success(JSON_Dict!)
                        }
                        else
                        {
                            self.lottieView.isHidden = true
                            self.lottieWholeView.isHidden = true
                            self.view.makeToast("Sorry,We can't upload your profile image.")
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
            if IS_IPHONE_X || IS_IPHONE_XR {
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-130, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
            }
        }
    }
    
    func profileAPICall()
    {
        let profileQuery = GetProfileQuery()
        
        apollo_headerClient.fetch(query:profileQuery,cachePolicy:.fetchIgnoringCacheData){(result,error) in
            
            guard (result?.data?.userAccount?.result) != nil else
            {
                print("Missing Data")
                return
            }
            
            print(result?.data?.userAccount?.result as Any)
            
            self.ProfileAPIArray = ((result?.data?.userAccount?.result)!)
            self.bookingStepthreeTable.reloadData()
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

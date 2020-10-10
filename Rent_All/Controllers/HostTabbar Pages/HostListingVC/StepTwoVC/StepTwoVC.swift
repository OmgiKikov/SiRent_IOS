//
//  StepTwoVC.swift
//  Rent_All
//
//  Created by RadicalStart on 27/07/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import AssetsPickerViewController
import Photos
import Alamofire
import Apollo
import Lottie

class StepTwoVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,AssetsPickerViewControllerDelegate{
   
    
    // MARK: - IBOUTLET & GLOABAL VARIABLE DECLARATIONS
    
    @IBOutlet weak var retryBtn: UIButton!
    @IBOutlet weak var erroRLabel: UILabel!
    @IBOutlet weak var nxtgreenImage: UIImageView!
    @IBOutlet weak var offlineView: UIView!
    @IBOutlet weak var nextImage: UIImageView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var photoAddTable: UITableView!
    @IBOutlet weak var topView: UIView!
    var addphotoCollection: UICollectionView?
    var longPressGesture = UILongPressGestureRecognizer()
    var saveexit_Activated = String()
     var longPressedEnabled:Bool = false
     
     var assets = [PHAsset]()
    lazy var cellSize: CGSize = {
        return CGSize(width:FULLWIDTH, height: 200)
    }()
    lazy var imageManager = {
        return PHCachingImageManager()
    }()
     var imagesData = [Data]()
     var showListingstepArray = ShowListingStepsQuery.Data.ShowListingStep.Result()
    var showListPhotosArray = [ShowListPhotosQuery.Data.ShowListPhoto.Result]()
    var getListingStep2Array = GetListingDetailsStep2Query.Data.GetListingDetail.Result()
    var apollo_headerClient: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
        
        let url = URL(string:graphQLEndpoint)!
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()
    var multiimages_Selected:Bool = false
    var multiimages_count:Int = 0
    var selected_Cover_Array =  NSMutableArray()
    var isdelete_API_call:Bool = false
    let appstatechecker = UIApplication.shared.applicationState
    override func viewDidLoad() {
        super.viewDidLoad()

         self.initialSetup()
     //   self.initialSetup()
 
      //  self.getListingDetailsStep2()
        

//        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadtableView(_:)), name: UIApplication.didBecomeActiveNotification
//                , object: nil)
   


        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.isdelete_API_call = false
       
        
    }
//    override func viewDidAppear(_ animated: Bool) {
//        DispatchQueue.main.async {
//            self.Scrolltoup()
//        }
//    }
    override func viewDidLayoutSubviews() {
        
       // self.ScrolltoBottom()
    }
 // MARK: - IBACTIONS & FUNCTIONS
    
    func initialSetup()
    {
        photoAddTable.register(UINib(nibName: "addPhotosCell", bundle: nil), forCellReuseIdentifier: "addPhotosCell")
        nextBtn.layer.cornerRadius = 6.0
        nextBtn.layer.masksToBounds = true
        skipBtn.layer.borderWidth = 1.5
        skipBtn.layer.borderColor = Theme.PRIMARY_COLOR.cgColor
        skipBtn.layer.cornerRadius = 6.0
        skipBtn.layer.masksToBounds = true
        skipBtn.isHidden = true
        nxtgreenImage.isHidden = true
        nextBtn.isHidden = true
        self.nextImage.image = self.nextImage.image?.withRenderingMode(.alwaysTemplate)
        self.nextImage.tintColor = UIColor.white
        if(saveexit_Activated == "true")
        {
            saveBtn.isHidden = false
        }
        else
        {
            saveBtn.isHidden = true
        }
        self.offlineView.isHidden = true
        erroRLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
        retryBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
        saveBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"saveexit"))!)", for:.normal)
        skipBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"skipnow"))!)", for:.normal)
         nextBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"next"))!)", for:.normal)
       
        
        nextBtn.backgroundColor = Theme.PRIMARY_COLOR
        saveBtn.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)

        
    


    }
    @objc func reloadtableView(_ notification: Notification) {
//            self.photoAddTable.shouldIgnoreScrollingAdjustment = true
//            // photoAddTable.showsHorizontalScrollIndicator  = true
//            self.photoAddTable.shouldRestoreScrollViewContentOffset = true
//            self.photoAddTable.isDirectionalLockEnabled = true
//            self.photoAddTable.isExclusiveTouch = false
   
          photoAddTable.setContentOffset(.zero, animated: true)
        }
     

    override func viewDidAppear(_ animated: Bool) {
       
//        DispatchQueue.main.async {
//            self.scrollToBottom()
//        }
    }
    @objc func scrollToBottom() {
        
            DispatchQueue.main.async {
                let indexPath = IndexPath(row:0,section: 0)
                self.photoAddTable.scrollToRow(at: indexPath, at:.top, animated:false)
            }
        
    }
    
    func showlistingPhotosAPICall()
    {
         if Utility().isConnectedToNetwork(){
        let showlistingphotosquery = ShowListPhotosQuery(listId: showListingstepArray.listId!)
        apollo_headerClient.fetch(query: showlistingphotosquery,cachePolicy:.fetchIgnoringCacheData){(result,error) in
            guard (result?.data?.showListPhotos?.results) != nil else{
                print("Missing Data")
                self.skipBtn.isHidden = false
                self.nxtgreenImage.isHidden = false
                self.nextBtn.isHidden = true
                self.showListPhotosArray.removeAll()
                self.photoAddTable.reloadData()
                return
            }
            self.showListPhotosArray = (result?.data?.showListPhotos?.results)! as! [ShowListPhotosQuery.Data.ShowListPhoto.Result]
            if(self.showListPhotosArray.count > 0)
            {
                self.skipBtn.isHidden = true
                self.nxtgreenImage.isHidden = true
                self.nextBtn.isHidden = false
            }

            if(!self.isdelete_API_call)
            {
                self.photoAddTable.reloadData()
                self.scrollToBottom()
            }
            else
            {
                self.photoAddTable.reloadSections([1], with: .automatic)
                
            }
        }
        }
        else
         {
            //self.photoAddTable.reloadSections([1], with: .automatic)
            self.photoAddTable.reloadData()
            self.offlineviewShow()
        }
    }
    
    func getListingDetailsStep2()
    {
        if Utility().isConnectedToNetwork(){
        let getlistingStep2query = GetListingDetailsStep2Query(listId:"\(showListingstepArray.listId!)", preview: true)
        apollo_headerClient.fetch(query: getlistingStep2query,cachePolicy:.fetchIgnoringCacheData){(result,error) in
            guard (result?.data?.getListingDetails?.results) != nil else{
                print("Missing Data")
                self.showlistingPhotosAPICall()
                return
            }
            self.getListingStep2Array = (result?.data?.getListingDetails?.results)!
            Utility.shared.host_step2_isfromEdit = true
            self.showlistingPhotosAPICall()
    }
        }
        else{
            self.offlineviewShow()
        }
    }
    
    
    func deleteAPICall(name:String)
    {
        if Utility().isConnectedToNetwork(){
        let RemoveListPhotosmutation = RemoveListPhotosMutation(listId:(showListingstepArray.listId!), name:name)
        apollo_headerClient.perform(mutation: RemoveListPhotosmutation){(result,error) in
            if(result?.data?.removeListPhotos?.status == 200)
            {
                self.isdelete_API_call = true
                self.showlistingPhotosAPICall()
                
            }
            else
            {
                if(result?.data?.removeListPhotos?.errorMessage != "filename not exist")
                {
                self.view.makeToast(result?.data?.removeListPhotos?.errorMessage!)
                }
            }
        }
        }
        else
        {
            self.offlineviewShow()
        }
    }
    func offlineviewShow()
    {
        self.offlineView.isHidden = false
        self.nextBtn.isHidden = true
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
    @IBAction func retryBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            self.nextBtn.isHidden = true
            self.offlineView.isHidden = true
             self.showlistingPhotosAPICall()
//            if showListPhotosArray.count > 0 {
//                addphotoCollection!.reloadData()
//            }
            
        }
    }
    
    @IBAction func saveexitTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
        if(saveexit_Activated == "true")
        {
        self.updateAPICall()
        }
        }
        else
        {
            self.offlineviewShow()
        }
    }
    
    func updateAPICall()
    {
        
        if(getListingStep2Array.id != nil)
        {
        var coverphoto = Int()
        var desc = String()
        var title = String()
        
        if(Utility.shared.host_photo_coverid == 0)
        {
            if(getListingStep2Array.coverPhoto != nil)
            {
          coverphoto = getListingStep2Array.coverPhoto!
                
            }
            else
            {
                coverphoto = 0
            }
        }
        else
        {
           coverphoto = Utility.shared.host_photo_coverid
        }
        if(getListingStep2Array.description != nil)
        {
            desc = getListingStep2Array.description!
        }
        else
        {
           desc = ""
        }
        if(getListingStep2Array.title != nil)
        {
            title = getListingStep2Array.title!
        }
        else
        {
            title = ""
        }
        let UpdateListingStep2mutation = UpdateListingStep2Mutation(id:getListingStep2Array.id!, description:desc, title:title, coverPhoto:coverphoto)
        apollo_headerClient.perform(mutation: UpdateListingStep2mutation){ (result,error) in
            
            if(result?.data?.updateListingStep2?.status == 200)
            {
                let becomeHostObj = BecomeHostVC()
                becomeHostObj.listID = "\(self.getListingStep2Array.id!)"
                becomeHostObj.showListingStepsAPICall(listID:"\(self.getListingStep2Array.id!)")
               // self.view.window!.layer.add(presentrightAnimation()!, forKey: kCATransition)
                 becomeHostObj.modalPresentationStyle = .fullScreen
                self.present(becomeHostObj, animated: false, completion: nil)
                
            }
        }
        }
        
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
     //   self.view!.layer.add(dismissrightAnimation()!, forKey: kCATransition)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func skipBtnTappe(_ sender: Any) {
    }
    @IBAction func nextBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
        let listTitleObj = ListingTitleVC()
        Utility.shared.host_step2_listId = showListingstepArray.listId!
        listTitleObj.saveexit_Activated = saveexit_Activated
        listTitleObj.getListingStep2Array = getListingStep2Array
        self.view.window?.backgroundColor = UIColor.white
      //  self.view?.layer.add(presentrightAnimation()!, forKey: kCATransition)
        listTitleObj.modalPresentationStyle = .fullScreen
        self.present(listTitleObj, animated:false, completion: nil)
        }
        else
        {
            self.offlineviewShow()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if(showListPhotosArray.count > 0)
        {
        return 2
        }
        else if(multiimages_Selected)
        {
            return 2
        }
        else{
        return 1
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0)
        {
            return 1
        }
        else{
            if(showListPhotosArray.count > 0 ||  multiimages_Selected)
            {
                return 1
            }
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addPhotosCell", for: indexPath)as! addPhotosCell
            cell.addphotoBtn.tag = indexPath.row
            cell.selectionStyle = .none
            cell.addphotoBtn.addTarget(self, action: #selector(addbtnTapped), for: .touchUpInside)
            return cell
        }
        else
        {
            let cellIdentifier = "cellIdentifier"
            var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
            }
            for subView in (cell?.contentView.subviews)!
            {
                subView.removeFromSuperview()
            }
            cell?.selectionStyle = UITableViewCell.SelectionStyle.none
            cell?.backgroundColor = UIColor.white
            cell?.selectionStyle = .none
            let contentview = UIView()
             let layout = UICollectionViewFlowLayout()
            if(!multiimages_Selected)
            {
            contentview.frame = CGRect(x: 0, y: 10, width: Int(FULLWIDTH), height: (240 * (showListPhotosArray.count)))
           
            addphotoCollection = UICollectionView(frame: CGRect(x: 0, y: 10, width: Int(FULLWIDTH), height: ((showListPhotosArray.count) * 240)),collectionViewLayout: layout)
            }
            else
            {
                if(showListPhotosArray.count == 0)
                {
                    contentview.frame = CGRect(x: 0, y: 10, width: Int(FULLWIDTH), height: (240 * (multiimages_count)))
                    
                    addphotoCollection = UICollectionView(frame: CGRect(x: 0, y: 10, width: Int(FULLWIDTH), height: ((multiimages_count) * 240)),collectionViewLayout: layout)
                }
                else
                {
                contentview.frame = CGRect(x: 0, y: 10, width: Int(FULLWIDTH), height: (240 * (showListPhotosArray.count)))
                
                addphotoCollection = UICollectionView(frame: CGRect(x: 0, y: 10, width: Int(FULLWIDTH), height: ((showListPhotosArray.count+multiimages_count) * 240)),collectionViewLayout: layout)
                }
            }
          //  addphotoCollection = UICollectionView(frame: CGRect(x:0, y: 0, width: FULLWIDTH, height:(210 * (imageArray.count))), collectionViewLayout: layout)
            
            addphotoCollection?.tag = indexPath.row
           // layout.scrollDirection = .vertical
            addphotoCollection?.isScrollEnabled = false
            addphotoCollection?.dataSource = self
            addphotoCollection?.delegate = self
            addphotoCollection?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellIdentifier")
            addphotoCollection?.backgroundColor = UIColor.white
            addphotoCollection?.showsHorizontalScrollIndicator = false
            if let aView = addphotoCollection {
                contentview.addSubview(aView)
            }
            if let flowLayout = addphotoCollection!.collectionViewLayout as? UICollectionViewFlowLayout {
                
                flowLayout.estimatedItemSize = CGSize(width:FULLWIDTH-30, height:230)
               // flowLayout.scrollDirection = .vertical
                //flowLayout.sectionInset = UIEdgeInsets(top:10, left:0, bottom:10, right:0)
//                layout.minimumInteritemSpacing = 10
//                layout.minimumLineSpacing = 10
                
            }
            longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longTap(_:)))
            addphotoCollection?.addGestureRecognizer(longPressGesture)
            addphotoCollection?.register(UINib(nibName: "AddphotoCell", bundle: nil), forCellWithReuseIdentifier: "AddphotoCell")
            
            DispatchQueue.main.async {
                self.addphotoCollection?.reloadData()
            }
            
            cell?.contentView.addSubview(contentview)
            return cell!
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(indexPath.section == 0)
        {
            return 255
        }
        else{
            if(showListPhotosArray.count > 0)
            {
                if(!multiimages_Selected)
                {
            return CGFloat(showListPhotosArray.count * 240)
                }
                else
                {
                    if(showListPhotosArray.count == 0)
                    {
                        return CGFloat(multiimages_count * 240)
                    }
                  return CGFloat((showListPhotosArray.count+multiimages_count) * 240)
                }
            }
            return 0
        }
        
        
    }
    
    @objc func addbtnTapped(_ sender: UIButton)
    {
        if Utility().isConnectedToNetwork(){
        self.isdelete_API_call = false
        let picker = AssetsPickerViewController()
        
        picker.pickerDelegate = self
        present(picker, animated: true, completion: nil)
        }
        else
        {
            self.offlineviewShow()
        }
        
    }
    
    @objc func longTap(_ gesture: UIGestureRecognizer){
        
        switch(gesture.state) {
        case .began:
            guard let selectedIndexPath = addphotoCollection!.indexPathForItem(at: gesture.location(in: addphotoCollection)) else {
                return
            }
            addphotoCollection!.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            addphotoCollection!.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case .ended:
            addphotoCollection!.endInteractiveMovement()
            
            longPressedEnabled = true
            self.addphotoCollection!.reloadData()
        default:
            addphotoCollection!.cancelInteractiveMovement()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(!multiimages_Selected)
        {
        return showListPhotosArray.count
        }
        else
        {
            if(showListPhotosArray.count == 0)
            {
                return multiimages_count
            }
            else
            {
          return showListPhotosArray.count + multiimages_count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddphotoCell", for: indexPath) as! AddphotoCell
        cell.tag = indexPath.row + 2000
//         if(indexPath.row == 0)
//         {
//            cell.coverLabel.isHidden = false
//         }
//        else
//         {
//            cell.coverLabel.isHidden = true
//         }
        cell.closebtn.tag = indexPath.row
        cell.closebtn.addTarget(self, action: #selector(deleteBtnTapped), for: .touchUpInside)
        if(showListPhotosArray.count > indexPath.row)
        {
            if(showListPhotosArray[indexPath.row].name != nil)
            {
                let profImage = showListPhotosArray[indexPath.row].name!
                cell.addphotoimage.sd_setImage(with: URL(string:"\(IMAGE_LISTING_MEDIUM)\(profImage)"), completed: nil)
              //  cell.coverbutton.target(forAction: #selector(<#T##@objc method#>), withSender: <#T##Any?#>)
            }
            else{
                cell.addphotoimage.image = #imageLiteral(resourceName: "box-with-like")
            }
            if(selected_Cover_Array.contains(showListPhotosArray[indexPath.row].id) || showListPhotosArray.count == 1)
            {
                cell.coverLabel.backgroundColor = Theme.PRIMARY_COLOR
                cell.coverbutton.backgroundColor = UIColor.clear
            }
            else
            {
                if(Utility.shared.host_step2_isfromEdit)
                {
                    if(getListingStep2Array.coverPhoto != nil)
                        {
                    if((getListingStep2Array.coverPhoto! == showListPhotosArray[indexPath.row].id) && (selected_Cover_Array.count == 0))
                    {
                        
                        cell.coverLabel.backgroundColor = Theme.PRIMARY_COLOR
                        cell.coverbutton.backgroundColor = UIColor.clear
                    }
                    else
                    {
                        cell.coverLabel.backgroundColor = photo_color
                        cell.coverbutton.backgroundColor = UIColor.clear
                    }
                    }
                }
                else
                {
                    cell.coverLabel.backgroundColor = photo_color
                    cell.coverbutton.backgroundColor = UIColor.clear
                }
            }
            
            cell.coverbutton.tag = indexPath.row
            cell.coverbutton.addTarget(self, action: #selector(CoverbtnTapped), for: .touchUpInside)
            
        }
        else{
        if(multiimages_Selected)
        {
           //cell.addphotoimage.backgroundColor = UIColor.lightGray
            cell.addphotoimage.image = nil
            cell.closebtn.isHidden = true
            cell.coverLabel.isHidden = true
            cell.lottieAnimation()
        }
        else{
            cell.lottieView.isHidden = true
        }
        }
        
        
        if(selected_Cover_Array.count == 0 && !Utility.shared.host_step2_isfromEdit && showListPhotosArray.count != 0)
        {
            Utility.shared.host_photo_coverid = showListPhotosArray[0].id
        }
        
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

        
        let tmp = showListPhotosArray[sourceIndexPath.item]
        showListPhotosArray[sourceIndexPath.item] = showListPhotosArray[destinationIndexPath.item]
        showListPhotosArray[destinationIndexPath.item] = tmp
        
        addphotoCollection?.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:FULLWIDTH-30, height:230)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let cell = view.viewWithTag(indexPath.row + 2000) as? AddphotoCell
         //cell?.coverLabel.backgroundColor = Theme.PRIMARY_COLOR
//
//        Utility.shared.host_step2_isfromEdit = false
//        if(selected_Cover_Array.contains(showListPhotosArray[indexPath.row].id))
//        {
//            selected_Cover_Array.remove(showListPhotosArray[indexPath.row].id)
//        }
//        else {
//            selected_Cover_Array.removeAllObjects()
//            selected_Cover_Array.add(showListPhotosArray[indexPath.row].id)
//            Utility.shared.host_photo_coverid = showListPhotosArray[indexPath.row].id
//        }
//        addphotoCollection?.reloadData()
    
    }
    @objc func CoverbtnTapped(_ sender: UIButton){
        if Utility().isConnectedToNetwork(){
            
            if(showListPhotosArray.count > 1)
            {
            Utility.shared.host_step2_isfromEdit = true
            if selected_Cover_Array.contains(showListPhotosArray[sender.tag].id){
                selected_Cover_Array.remove(showListPhotosArray[sender.tag].id)
            }else{
                selected_Cover_Array.removeAllObjects()
                selected_Cover_Array.add(showListPhotosArray[sender.tag].id)
                Utility.shared.host_photo_coverid = showListPhotosArray[sender.tag].id
            }
            addphotoCollection?.reloadData()
            }
        }
        
    }
    @objc func deleteBtnTapped(_ sender: UIButton)
    {
        if Utility().isConnectedToNetwork(){
        if((showListPhotosArray.count > sender.tag) && showListPhotosArray[sender.tag].name != nil)
        {
        self.deleteAPICall(name:showListPhotosArray[sender.tag].name!)
            }
        }
        else
        {
            self.offlineviewShow()
        }
    }
    // MARK: - AssetsPickerViewControllerDelegate
    
    func assetsPicker(controller: AssetsPickerViewController, selected assets: [PHAsset]) {
        
        if Utility.shared.isConnectedToNetwork(){
            self.offlineView.isHidden = true
            if(showListPhotosArray.count > 0)
            {
                self.ScrolltoBottom()
            }
            self.assets = assets
            self.imagesData.removeAll()
            // let imageWidth = cellSize.height * UIScreen.main.scale
            for asset in self.assets {
                
                let image =  self.getAssetThumbnail(asset: asset)
                
                //let orientedimage = self.fixOrientation(img: image)
                if((image.jpegData(compressionQuality:0.3)) != nil )
                {
                    self.imagesData.append((image.jpegData(compressionQuality:0.3))!)
                }
                //self.imagesData.append((image.resized(withPercentage: 0.5) as? Data)!)
            }
            multiimages_count = imagesData.count
            self.multiimages_Selected = true
            self.photoAddTable.reloadData()
            DispatchQueue.global(qos: .background).async {
                
                self.uploadProfilePic(profileimage: self.imagesData,onSuccess:{response in
                    
                    let status = response.value(forKey: "status") as! Int
                    
                    
                    if(status == 200)
                    {
                        print("success")
                        
                    }
                    else{
                        self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"somethingwrong"))!)")
                    }
                    
                })
            }
        }else{
            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)")
        }
       
       
    }
    func getUIImage(asset: PHAsset) -> UIImage? {
        
        var img: UIImage?
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.version = .original
        options.isSynchronous = true
        manager.requestImageData(for: asset, options: options) { data, _, _, _ in
            
            if let data = data {
                img = UIImage(data: data)
            }
        }
        return img!
    }
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width:FULLWIDTH, height:500), contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
           if(result != nil)
           {
            thumbnail = result!
            }
            else
           {
            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"somethingwrong"))!)")
//            manager.requestImageData(for: asset, options: option) { data, _, _, _ in
//                
//                if let data = data {
//                    thumbnail = UIImage(data: data)!
//                }
//            }
            }
        })
        return thumbnail
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
    func ScrolltoBottom()
    {
        DispatchQueue.main.async {
            if(self.showListPhotosArray.count > 0)
            {
            let indexPath = IndexPath(row:0,section:1)
            self.photoAddTable.scrollToRow(at: indexPath, at: .bottom, animated: false)
            }
        }
    }
    func Scrolltoup()
    {
        DispatchQueue.main.async {
            if(self.showListPhotosArray.count > 0)
            {
                let indexPath = IndexPath(row:0,section:1)
                self.photoAddTable.scrollToRow(at: indexPath, at: .top, animated: false)
            }
        }
    }
    
    func uploadProfilePic(profileimage:[Data],onSuccess success: @escaping (NSDictionary) -> Void) {
        if Utility().isConnectedToNetwork(){
            let BaseUrl = URL(string: LISTINGIMAGE_UPLOAD)
            print("BASE URL : \(LISTINGIMAGE_UPLOAD)")
            let header = ["auth": "\(Utility.shared.getCurrentUserToken()!)"]
            let parameters = ["listId": "\(showListingstepArray.listId!)"]
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                for imageData in self.imagesData {
                    multipartFormData.append(imageData, withName: "file", fileName: "file.jpeg", mimeType: "image/jpeg")
                }
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }

            }, to:BaseUrl!,method:.post,headers:header)
            { (result) in
                switch result {
                case .success(let upload, _, _):
                    upload.uploadProgress(closure: { (progress) in
                    })
                    upload.responseJSON { response in
                        print("RESPONSE \(response)")
                        self.multiimages_Selected = false
                        self.getListingDetailsStep2()
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
        else
        {
           self.offlineviewShow()
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

extension UIImage {
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        return UIGraphicsImageRenderer(size: canvas, format: imageRendererFormat).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        return UIGraphicsImageRenderer(size: canvas, format: imageRendererFormat).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}

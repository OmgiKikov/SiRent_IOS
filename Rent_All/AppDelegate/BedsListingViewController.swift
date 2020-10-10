//
//  BedsListingViewController.swift
//  Rent_All
//
//  Created by RadicalStart on 29/07/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Lottie

class BedsListingViewController: BaseHostTableviewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var nextarrow: UIImageView!
    @IBOutlet weak var offlineUIView: UIView!
    @IBOutlet weak var saveAndExit: UIButton!
    @IBOutlet weak var retryButn: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    //MARK: - This Property
    var singleArr = [Int]()
    var singleValue = Int()
    var doubleArr = [Int]()
    var doubleValue = Int()
    var queenArr = [Int]()
    var queenValue = Int()
    var kingArr = [Int]()
    var kingValue = Int()
    var bunkBedArr = [Int]()
    var bunkBedValue = Int()
    var indoorStallArr = [Int]()
    var indoorStallVal = Int()
    var bedTypeValue = ""
    var bedType = [String]()
    
    var bedtypeInfoArr = [[String : Any]]()
    var bed_id = [Int]()
    var bed_type_id = [Int]()
    var array_Count = [Int]()
  var lottieView1: LOTAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
      // self.lottieeAnimation()
       saveAndExit.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"saveexit"))!)", for:.normal)
        errorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
        retryButn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
        nextBtn.backgroundColor = Theme.PRIMARY_COLOR
        saveAndExit.setTitleColor(Theme.PRIMARY_COLOR, for:.normal)
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func lottieeAnimation() {
        
        lottieView = LOTAnimationView.init(name:"animation")
        lottieView.isHidden = false
        self.lottieView.frame = CGRect(x:FULLWIDTH/2-40, y: FULLHEIGHT/2-40, width:100, height:100)
        self.view.addSubview(self.lottieView)
        //        addLottieViewAsSubview()
        self.lottieView.backgroundColor = UIColor.clear
        self.lottieView.layer.cornerRadius = 6.0
        self.lottieView.clipsToBounds = true
        self.lottieView.play()
        Timer.scheduledTimer(timeInterval:0.2, target: self, selector: #selector(autoscrolling), userInfo: nil, repeats: true)
    }
    
    
    @objc func autoscrolling()
    {
        self.lottieView.play()
    }
    

    override func setUpUI() {
        if(Utility.shared.step1_inactivestatus == "inactive" || Utility.shared.step1_inactivestatus == "")
        {
            saveAndExit.isHidden = true
        }
        else {
            saveAndExit.isHidden = false
        }
        offlineUIView.isHidden = true
        callListingSettingsAPI(oflineView: offlineUIView, nextButton: nextBtn)
        tableView.isHidden = false
        // tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        nextBtn.setTitle("\(Utility.shared.getLanguage()?.value(forKey: "next")as! String)", for: .normal)
        nextBtn.layer.cornerRadius = 5
        nextBtn.clipsToBounds = true
        nextarrow.image = nextarrow.image?.withRenderingMode(.alwaysTemplate)
        nextarrow.tintColor = UIColor.white
        lottieView1 = LOTAnimationView.init(name: "animation")
    }
    
    override func setDropdownList() {
        
        let bedTypes = (Utility.shared.getListSettingsArray.bedType?.listSettings!)!
        bed_id.removeAll()
        bed_type_id.removeAll()
        bedtypeInfoArr.removeAll()
        bedType.removeAll()
        for bedItem in bedTypes
        {
            bedType.append((bedItem?.itemName)!)
            bed_type_id.append((bedItem?.id)!)
           
        }
         array_Count.removeAll()
        if Utility.shared.step1ValuesInfo.keys.contains("bedTypes")
        {
            
            if let bedTypeInfo = Utility.shared.step1ValuesInfo["bedTypes"] as? [Any]
            {

                for i in 0..<bedTypeInfo.count
                {
                    if let userBedTypes = bedTypeInfo[i] as? GetStep1ListingDetailsQuery.Data.GetListingDetail.Result.UserBedsType
                    {
                        let index = bedTypes.index(where: { (item) -> Bool in
                            item?.id == userBedTypes.bedType
                        })
                        bedTypeValue = bedType[index!]
//                        if bedType[indexPath.row] == bedType[index!]
//                        {
//                            cell?.countshowLabel.text = "\(String(describing: userBedTypes.bedCount!))"
//                        }
                        var bedTypeInfo = [String : Any]()
                        bedTypeInfo.updateValue((userBedTypes.bedType)!, forKey: "bedType")
                        Utility.shared.step1ValuesInfo.updateValue(userBedTypes.bedType!, forKey: "bedType")
                        bedTypeInfo.updateValue(userBedTypes.bedCount!, forKey: "bedCount")
                        //bedcount = userBedTypes.bedCount!
                       
                        array_Count.append(userBedTypes.bedCount!)
                        bedtypeInfoArr.append(bedTypeInfo)
                        bed_id.append((userBedTypes.bedType)!)
                    }
                    
                }
               
                Utility.shared.bedcount = array_Count.reduce(0, +)
            }
            

        }else{
            bedTypeValue = bedType.first!
            Utility.shared.bedcount = 0
            Utility.shared.step1ValuesInfo.updateValue((Utility.shared.getListSettingsArray.bedType?.listSettings![0]!.id!)!, forKey: "bedType")
            Utility.shared.step1ValuesInfo.updateValue("", forKey: "bedTypes")
        }
        tableView.reloadData()
    }
    
    override func registerCells() {
        tableView.register(UINib(nibName: "RoomsCell", bundle: nil), forCellReuseIdentifier: "RoomsCell")
    }
    
    //MARK: - Progress Indicator
    
    override func addLottieViewAsSubview()
    {
        
       // self.view.addSubview(self.lottieView)
    }
    
    @IBAction func retryBtnTapped(_ sender: Any) {
         if Utility().isConnectedToNetwork(){
            self.offlineUIView.isHidden = true
        }
    }
    //IBActions
    
    @IBAction func RedirectNextPage(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
        
            let bedsCount = Utility.shared.step1ValuesInfo["beds"] as? Int
            if(bedsCount != nil)
            {
            if(Utility.shared.bedcount>bedsCount!)
            {
                self.view.makeToast("\(Utility.shared.getLanguage()?.value(forKey: "bed_count_exceed")as! String)")
            }
            else
            {
            if(bedtypeInfoArr.count == 0)
            {
            var bedTypeInfo = [String : Any]()
            bedTypeInfo.updateValue(16, forKey: "bedType")
            bedTypeInfo.updateValue(1, forKey: "bedCount")
            bedtypeInfoArr.append(bedTypeInfo)
            }
        let data = try? JSONSerialization.data(withJSONObject:bedtypeInfoArr, options: .prettyPrinted)
        let bedtypes = String(data: data!, encoding: String.Encoding.utf8)!
        var bedTypeString = ""
        if !bedtypes.isEmpty {
            let bedTypesArr = bedtypes.components(separatedBy: "\n")
            for str in bedTypesArr{
                bedTypeString = bedTypeString + str
            }
        }
        Utility.shared.step1ValuesInfo.updateValue(bedTypeString.trimmingCharacters(in: .whitespaces), forKey: "bedTypes")
            if(Utility.shared.step1ValuesInfo["bedType"] == nil)
            {
                if(Utility.shared.getListSettingsArray.bedType?.listSettings![0]!.id != nil)
                {
        Utility.shared.step1ValuesInfo.updateValue((Utility.shared.getListSettingsArray.bedType?.listSettings![0]!.id!)!, forKey: "bedType")
                }
                else
                {
                 Utility.shared.step1ValuesInfo.updateValue(16, forKey: "bedType")
                }
            }
            
                
        let bathroomsListing = BathroomsListingViewController()
        self.view.window?.backgroundColor = UIColor.white
      // self.view.layer.add(dismissrightAnimation()!, forKey: kCATransition)
        bathroomsListing.modalPresentationStyle = .fullScreen
        self.present(bathroomsListing, animated: false, completion: nil)
            }
            }
        }
        else
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
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        let data = try? JSONSerialization.data(withJSONObject:bedtypeInfoArr, options: .prettyPrinted)
        let bedtypes = String(data: data!, encoding: String.Encoding.utf8)!
        var bedTypeString = ""
        if !bedtypes.isEmpty {
            let bedTypesArr = bedtypes.components(separatedBy: "\n")
            for str in bedTypesArr{
                bedTypeString = bedTypeString + str
            }
        }
        
        Utility.shared.step1ValuesInfo.updateValue(bedTypeString.trimmingCharacters(in: .whitespaces), forKey: "bedTypes")
     //   self.view.layer.add(dismissrightAnimation()!, forKey: kCATransition)
        self.dismiss(animated: true, completion: nil)
    }
    func lottieViewanimation()
    {
        saveAndExit.setTitle("", for:.normal)
        lottieView1 = LOTAnimationView.init(name: "animation")
        self.lottieView1.isHidden = false
        self.lottieView1.frame = CGRect(x:80, y:-35, width:100, height:100)
        self.saveAndExit.addSubview(self.lottieView1)
        self.view.bringSubviewToFront(self.lottieView1)
        self.lottieView1.backgroundColor = UIColor.clear
        self.lottieView1.play()
        Timer.scheduledTimer(timeInterval:0.3, target: self, selector: #selector(autoscroll), userInfo: nil, repeats: true)
    }
    @objc func autoscroll()
    {
        self.lottieView1.play()
    }
    
    @IBAction func saveAndExitAction(_ sender: Any) {
         if Utility().isConnectedToNetwork(){
           
            let bedsCount = Utility.shared.step1ValuesInfo["beds"] as? Int
            if(Utility.shared.bedcount>bedsCount!)
            {
                self.view.makeToast("\(Utility.shared.getLanguage()?.value(forKey: "bed_count_exceed")as! String)")
            }
            else
            {
            self.lottieViewanimation()
                if(bedtypeInfoArr.count == 0)
                {
                    var bedTypeInfo = [String : Any]()
                    bedTypeInfo.updateValue(16, forKey: "bedType")
                    bedTypeInfo.updateValue(1, forKey: "bedCount")
                    bedtypeInfoArr.append(bedTypeInfo)
                }
        let data = try? JSONSerialization.data(withJSONObject:bedtypeInfoArr, options: .prettyPrinted)
        let bedtypes = String(data: data!, encoding: String.Encoding.utf8)!
        var bedTypeString = ""
        if !bedtypes.isEmpty {
            let bedTypesArr = bedtypes.components(separatedBy: "\n")
            for str in bedTypesArr{
                bedTypeString = bedTypeString + str
            }
                }
        
        Utility.shared.step1ValuesInfo.updateValue(bedTypeString.trimmingCharacters(in: .whitespaces), forKey: "bedTypes")
        super.updateListingAPICall()
            }
        }
        else
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
    }
    //MARK: - UITAbleViewDatasource and UITableViewDelegates
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(Utility.shared.getLanguage()?.value(forKey: "bed_guest_use")as! String)"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bedType.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView
            .dequeueReusableCell(withIdentifier: "RoomsCell", for: indexPath) as? RoomsCell
        cell?.dashView.isHidden = false
          
        cell?.roomsTitleLabel.font = UIFont(name:"Circular-Book", size: 18.0)
        cell?.roomsTitleLabel.text = bedType[indexPath.row]
          array_Count.removeAll()
        if((Utility.shared.getListSettingsArray.bedType?.listSettings![indexPath.row]!.id!) == bed_type_id[indexPath.row])
        {
            let index = bedtypeInfoArr.index(where: { dictionary in
                guard let value = dictionary["bedType"] as? Int
                    else { return false }
                return value == (Utility.shared.getListSettingsArray.bedType?.listSettings![indexPath.row]!.id!)
            })
            if let index = index {
                cell?.countshowLabel.text = "\(bedtypeInfoArr[index]["bedCount"]!)"
            }
            else
            {
                if let bedtypeInfo = Utility.shared.step1ValuesInfo["bedTypes"] as? String
                {
                    if let dict = convertToDictionary(text: bedtypeInfo)
                    {
                        
                        for i in 0..<dict.count
                        {
                            let userBedTypes = dict[i]
                            if let userbedType = userBedTypes["bedType"] as? Int
                            {
                                let userbedCount = "\(userBedTypes["bedCount"]!)"
                                let bedTypes = (Utility.shared.getListSettingsArray.bedType?.listSettings!)!
                                let index = bedTypes.index(where: { (item) -> Bool in
                                    item?.id == userbedType
                                })
                                bedTypeValue = bedType[index!]
                                 if((Utility.shared.getListSettingsArray.bedType?.listSettings![indexPath.row]!.id!) == userbedType)
                                {
                                    cell?.countshowLabel.text = "\(String(describing: Int(userbedCount)!))"
                                    var bedTypeInfo = [String : Any]()
                                    
                                    bedTypeInfo.updateValue(userbedType, forKey: "bedType")
                                    Utility.shared.step1ValuesInfo.updateValue(userbedType, forKey: "bedType")
                                    bedTypeInfo.updateValue(Int(userbedCount)!, forKey: "bedCount")
                                    bedtypeInfoArr.append(bedTypeInfo)
                                    
                                }
                                array_Count.append(Int(userbedCount)!)
                                
                            }
                        }
                         Utility.shared.bedcount = array_Count.reduce(0, +)
                    }
                }
            }
            
        }

        else
        {
          cell?.countshowLabel.text = "0"
           
        }
        cell?.roomsTitleLabel.textColor = UIColor.darkText
        cell?.countshowLabel.textColor = UIColor.darkText
        cell?.countValue = 1
        cell?.plusBtn.tag = indexPath.row
        cell?.minusBtn.tag = indexPath.row
        cell?.tag = indexPath.row + 100
        cell?.plusBtn.addTarget(self, action: #selector(self.plusBtnTapped(sender:)), for: .touchUpInside)
        cell?.minusBtn.addTarget(self, action: #selector(self.minusBtnTapped(sender:)), for: .touchUpInside)
        cell?.plusBtn.layer.cornerRadius = (cell?.plusBtn.frame.size.width)!/2
        cell?.plusBtn.layer.borderWidth = 1.0
        cell?.plusBtn.layer.borderColor = Theme.PRIMARY_COLOR.cgColor
        cell?.minusBtn.layer.cornerRadius = (cell?.minusBtn.frame.size.width)!/2
        cell?.minusBtn.layer.borderWidth = 1.0
        cell?.minusBtn.layer.borderColor = Theme.PRIMARY_COLOR.cgColor
        cell?.selectionStyle = .none
        return cell!
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }

    @objc func plusBtnTapped(sender : UIButton)
    {
        if let cell = view.viewWithTag(sender.tag + 100) as? RoomsCell, let bedsCount = Utility.shared.step1ValuesInfo["beds"] as? Int
        {
            if Utility.shared.bedcount >= bedsCount
            {
                if Int(cell.countshowLabel.text!)! >= bedsCount
                {
//                    cell.plusBtn.isEnabled = false
                     cell.plusBtn.isEnabled = false
                    cell.plusBtn.isUserInteractionEnabled = false
                    cell.plusBtn.layer.borderColor = Theme.PRIMARY_COLOR.withAlphaComponent(0.5).cgColor
                    cell.minusBtn.isEnabled = true
                    cell.minusBtn.isUserInteractionEnabled = true
                    cell.minusBtn.layer.borderColor = Theme.PRIMARY_COLOR.cgColor
                }
                self.view.makeToast("\(Utility.shared.getLanguage()?.value(forKey: "Maximum_bed_selected")as! String)")
            }
            else{
                cell.countshowLabel.text = "\(Int(cell.countshowLabel.text!)! + 1)"
                Utility.shared.bedcount = Utility.shared.bedcount + 1
                cell.plusBtn.isEnabled = true
                 cell.minusBtn.isEnabled = true
                cell.plusBtn.isUserInteractionEnabled = true
                cell.minusBtn.isUserInteractionEnabled = true
                cell.plusBtn.layer.borderColor = Theme.PRIMARY_COLOR.cgColor
                cell.plusBtn.layer.borderColor = Theme.PRIMARY_COLOR.cgColor
               
//                cell.minusBtn.isEnabled = true
                var bedTypeInfo = [String : Any]()
                    if (bedtypeInfoArr.count > 0)
                    {
                        if((Utility.shared.getListSettingsArray.bedType?.listSettings![sender.tag]!.id!) == bed_type_id[sender.tag])
                        {
                            let index = bedtypeInfoArr.index(where: { dictionary in
                                guard let value = dictionary["bedType"] as? Int
                                    else { return false }
                                return value == (Utility.shared.getListSettingsArray.bedType?.listSettings![sender.tag]!.id!)
                            })
                            if let index = index {
                                bedtypeInfoArr.remove(at: index)
                                
                                bedTypeInfo.updateValue((Utility.shared.getListSettingsArray.bedType?.listSettings![sender.tag]!.id!)!, forKey: "bedType")
                                Utility.shared.step1ValuesInfo.updateValue((Utility.shared.getListSettingsArray.bedType?.listSettings![sender.tag]!.id!)!, forKey: "bedType")
                                bedTypeInfo.updateValue(cell.countshowLabel.text!, forKey: "bedCount")
                                bedtypeInfoArr.append(bedTypeInfo)
                            }
                            else
                            {
                                bedTypeInfo.updateValue((Utility.shared.getListSettingsArray.bedType?.listSettings![sender.tag]!.id!)!, forKey: "bedType")
                                Utility.shared.step1ValuesInfo.updateValue((Utility.shared.getListSettingsArray.bedType?.listSettings![sender.tag]!.id!)!, forKey: "bedType")
                                bedTypeInfo.updateValue(cell.countshowLabel.text!, forKey: "bedCount")
                               bedtypeInfoArr.append(bedTypeInfo)
                            }
                        }
                        
//
                   
                }
                else
                    {
                        bedTypeInfo.updateValue((Utility.shared.getListSettingsArray.bedType?.listSettings![sender.tag]!.id!)!, forKey: "bedType")
                        Utility.shared.step1ValuesInfo.updateValue((Utility.shared.getListSettingsArray.bedType?.listSettings![sender.tag]!.id!)!, forKey: "bedType")
                        bedTypeInfo.updateValue(cell.countshowLabel.text!, forKey: "bedCount")
                       bedtypeInfoArr.append(bedTypeInfo)
                }
            }
        }
    }
    
    func toJSONString(options: JSONSerialization.WritingOptions = .prettyPrinted) -> String {
        if let arr = self as? [[String:AnyObject]],
            let dat = try? JSONSerialization.data(withJSONObject: arr, options: options),
            let str = String(data: dat, encoding: String.Encoding.utf8) {
            return str
        }
        return "[]"
    }
    
    @objc func minusBtnTapped(sender : UIButton)
    {
        
       
        if let cell = view.viewWithTag(sender.tag + 100) as? RoomsCell, let bedsCount = Utility.shared.step1ValuesInfo["beds"] as? Int
        {
            if Int(cell.countshowLabel.text!)! <= 0
            {
                cell.minusBtn.isEnabled = false
                cell.minusBtn.isUserInteractionEnabled = false
                cell.minusBtn.layer.borderColor = Theme.PRIMARY_COLOR.withAlphaComponent(0.5).cgColor
                cell.plusBtn.isEnabled = true
                cell.plusBtn.isUserInteractionEnabled = true
                cell.plusBtn.layer.borderColor = Theme.PRIMARY_COLOR.cgColor
                
                
            }else{
                Utility.shared.bedcount = Utility.shared.bedcount - 1
                cell.countshowLabel.text = "\(Int(cell.countshowLabel.text!)! - 1)"
                cell.minusBtn.isEnabled = true
                cell.minusBtn.isUserInteractionEnabled = true
                cell.plusBtn.isEnabled = true
                cell.plusBtn.isUserInteractionEnabled = true
                cell.plusBtn.layer.borderColor = Theme.PRIMARY_COLOR.cgColor
                cell.minusBtn.layer.borderColor = Theme.PRIMARY_COLOR.cgColor
                
                if((Utility.shared.getListSettingsArray.bedType?.listSettings![sender.tag]!.id!) == bed_type_id[sender.tag])
                {
                    let index = bedtypeInfoArr.index(where: { dictionary in
                        guard let value = dictionary["bedType"] as? Int
                            else { return false }
                        return value == (Utility.shared.getListSettingsArray.bedType?.listSettings![sender.tag]!.id!)
                    })
                    if let index = index {
                        if((bedtypeInfoArr[index]["bedCount"] as? Int) == 1)
                        {
                            bedtypeInfoArr.remove(at: index)
                        }
                        else
                        {
                            var bedTypeInfo = [String : Any]()
                           bedtypeInfoArr.remove(at: index)
                            bedTypeInfo.updateValue((Utility.shared.getListSettingsArray.bedType?.listSettings![sender.tag]!.id!)!, forKey: "bedType")
                            Utility.shared.step1ValuesInfo.updateValue((Utility.shared.getListSettingsArray.bedType?.listSettings![sender.tag]!.id!)!, forKey: "bedType")
                            bedTypeInfo.updateValue(cell.countshowLabel.text!, forKey: "bedCount")
                            bedtypeInfoArr.append(bedTypeInfo)
                        }
                    }
                }

                
               
                
            }
        }
    }

}

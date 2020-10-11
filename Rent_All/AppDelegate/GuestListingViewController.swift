//
//  GuestListingViewController.swift
//  Rent_All
//
//  Created by RadicalStart on 27/07/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Lottie

protocol GuestListingViewControllerDelegate {
    func toatalguests(guest:String)
}

class GuestListingViewController: BaseHostTableviewController {

    //MARK: - IBOutlets
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var nextarrow: UIImageView!
    @IBOutlet weak var offlineUIview: UIView!
    @IBOutlet weak var saveAndExit: UIButton!
    @IBOutlet weak var retryButn: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    var lottieView1: LOTAnimationView!
    //MARK: - This Property
    var personCapacityArray = [Int]()
    var personCapacityValue = Int()
    var bedRoomCapacity = [Int]()
    var bedRoomCount = Int()
    var bedCapacity = [Int]()
    var bedCount = Int()
    var delegate:GuestListingViewControllerDelegate!
    //MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
         saveAndExit.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"saveexit"))!)", for:.normal)
       
        errorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
        retryButn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
        nextBtn.backgroundColor = Theme.PRIMARY_COLOR
        saveAndExit.setTitleColor(Theme.PRIMARY_COLOR, for:.normal)
    }
    
    override func setUpUI() {
        if(Utility.shared.step1_inactivestatus == "inactive" || Utility.shared.step1_inactivestatus == "")
        {
            saveAndExit.isHidden = true
        }
        else {
            saveAndExit.isHidden = false
        }
        offlineUIview.isHidden = true
        callListingSettingsAPI(oflineView: offlineUIview, nextButton: nextBtn)
        tableView.isHidden = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        nextBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey: "next"))!)", for: .normal)
        nextBtn.layer.cornerRadius = 5
        nextBtn.clipsToBounds = true
        nextarrow.image = nextarrow.image?.withRenderingMode(.alwaysTemplate)
        nextarrow.tintColor = UIColor.white
        lottieView1 = LOTAnimationView.init(name: "animation")
    }
    
    override func setDropdownList() {
        
        setPersonCapacity()
        setBedRoomsCount()
        setBedsCount()
        
        tableView.reloadData()
    }
    
    
    override func setPersonCapacity()
    {
        var incrVal = 1
        let personcapacity = (Utility.shared.getListSettingsArray.personCapacity?.listSettings![0]?.endValue)!
        for i in 0..<personcapacity
        {
            personCapacityArray.insert(incrVal , at: i)
            incrVal = (incrVal + 1)
        }
        if !Utility.shared.step1ValuesInfo.keys.contains("personCapacity")
        {
            personCapacityValue = personCapacityArray.first!
            Utility.shared.step1ValuesInfo.updateValue(1, forKey: "personCapacity")
        }else {
            personCapacityValue = Utility.shared.step1ValuesInfo["personCapacity"] as! Int
        }
        
    }
    
    func setBedRoomsCount()
    {
        var bedroomincrVal = 1
        let bedroomCapacityCount = (Utility.shared.getListSettingsArray.bedrooms?.listSettings![0]?.endValue)!
        for i in 0..<bedroomCapacityCount
        {
            bedRoomCapacity.insert(bedroomincrVal , at: i)
            bedroomincrVal = (bedroomincrVal + 1)
        }
        if !Utility.shared.step1ValuesInfo.keys.contains("bedrooms")
        {
            bedRoomCount = bedRoomCapacity.first!
            Utility.shared.step1ValuesInfo.updateValue(bedRoomCount, forKey: "bedrooms")
        }else {
            if let count = Utility.shared.step1ValuesInfo["bedrooms"]! as? Int
            {
                bedRoomCount = count
            }else if let bedRmCount = Utility.shared.step1ValuesInfo["bedrooms"] as? String{
                bedRoomCount = Int(bedRmCount)!
            }
            
        }
    }
    
    func setBedsCount()
    {
        var bedincrVal = 1
        let bedCapacityCount = (Utility.shared.getListSettingsArray.beds?.listSettings![0]?.endValue)!
        for i in 0..<bedCapacityCount
        {
            bedCapacity.insert(bedincrVal , at: i)
            bedincrVal = (bedincrVal + 1)
        }
        if !Utility.shared.step1ValuesInfo.keys.contains("beds")
        {
            bedCount = bedCapacity.first!
            Utility.shared.step1ValuesInfo.updateValue(bedCount, forKey: "beds")
        }else {
            bedCount = Utility.shared.step1ValuesInfo["beds"] as! Int
        }
    }
    
    override func registerCells() {
        tableView.register(UINib(nibName: "RoomsCell", bundle: nil), forCellReuseIdentifier: "RoomsCell")
    }
    
    //MARK: - Progress Indicator
    
    override func addLottieViewAsSubview()
    {
     //   self.view.addSubview(self.lottieView)
    }
    
    func lottieViewanimation()
    {
        saveAndExit.setTitle("", for:.normal)
        lottieView1 = LOTAnimationView.init(name: "animation")
        self.lottieView1.isHidden = false
        self.lottieView1.frame = CGRect(x:80, y:-35, width:100, height:100)
        self.saveAndExit.addSubview(self.lottieView1)
        self.lottieView1.backgroundColor = UIColor.clear
        self.lottieView1.play()
        Timer.scheduledTimer(timeInterval:0.3, target: self, selector: #selector(autoscroll), userInfo: nil, repeats: true)
    }
    @objc func autoscroll()
    {
        self.lottieView1.play()
    }
    
    //IBActions
    
    @IBAction func retryBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            self.offlineUIview.isHidden = true
        }
        
    }
    @IBAction func RedirectNextPage(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            
        let bedsListing = BedsListingViewController()
        self.view.window?.backgroundColor = UIColor.white
//        self.view?.layer.add(presentrightAnimation()!, forKey: kCATransition)
        bedsListing.modalPresentationStyle = .fullScreen
        self.present(bedsListing, animated: false, completion: nil)
            
        }
        else
        {
            self.offlineUIview.isHidden = false
            let shadowSize2 : CGFloat = 3.0
            let shadowPath2 = UIBezierPath(rect: CGRect(x: -shadowSize2 / 2,
                                                        y: -shadowSize2 / 2,
                                                        width: self.offlineUIview.frame.size.width + shadowSize2,
                                                        height: self.offlineUIview.frame.size.height + shadowSize2))
            
            self.offlineUIview.layer.masksToBounds = false
            self.offlineUIview.layer.shadowColor = TextLightColor.cgColor
            self.offlineUIview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            self.offlineUIview.layer.shadowOpacity = 0.3
            self.offlineUIview.layer.shadowPath = shadowPath2.cgPath
            if IS_IPHONE_X || IS_IPHONE_XR{
                offlineUIview.frame = CGRect.init(x: 0, y: FULLHEIGHT-130, width: FULLWIDTH, height: 55)
            }else{
                offlineUIview.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
            }
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        delegate?.toatalguests(guest:"\(Utility.shared.step1ValuesInfo["personCapacity"]!)")
        //self.view.layer.add(dismissrightAnimation()!, forKey: kCATransition)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveAndExit(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
             let bedsCount = Utility.shared.step1ValuesInfo["beds"] as? Int
            if(Utility.shared.bedcount>bedsCount!)
            {
                self.view.makeToast("\(Utility.shared.getLanguage()?.value(forKey: "bed_count_exceed")as! String)")
            }
            else
            {
        self.lottieViewanimation()
        super.updateListingAPICall()
            }
        }
        else
         {
            self.offlineUIview.isHidden = false
            let shadowSize2 : CGFloat = 3.0
            let shadowPath2 = UIBezierPath(rect: CGRect(x: -shadowSize2 / 2,
                                                        y: -shadowSize2 / 2,
                                                        width: self.offlineUIview.frame.size.width + shadowSize2,
                                                        height: self.offlineUIview.frame.size.height + shadowSize2))
            
            self.offlineUIview.layer.masksToBounds = false
            self.offlineUIview.layer.shadowColor = TextLightColor.cgColor
            self.offlineUIview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            self.offlineUIview.layer.shadowOpacity = 0.3
            self.offlineUIview.layer.shadowPath = shadowPath2.cgPath
            if IS_IPHONE_X || IS_IPHONE_XR{
                offlineUIview.frame = CGRect.init(x: 0, y: FULLHEIGHT-130, width: FULLWIDTH, height: 55)
            }else{
                offlineUIview.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
            }
        }
    }
    //MARK: - UITAbleViewDatasource and UITableViewDelegates
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(Utility.shared.getLanguage()?.value(forKey: "guest_stay")as! String)"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0
        {
            let cell = tableView
                .dequeueReusableCell(withIdentifier: "RoomsCell", for: indexPath) as? RoomsCell
            cell?.dashView.isHidden = false
           
            cell?.roomsTitleLabel.font = UIFont(name:"Circular-Book", size: 19.0)
            if indexPath.row == 0
            {
                
                cell?.roomsTitleLabel.text = "\(Utility.shared.getLanguage()?.value(forKey: "total_guest")as! String)\(personCapacityValue > 1 ? "": "")"
                cell?.countshowLabel.text = "\(personCapacityValue)"
                cell?.countValue = 1
                cell?.plusBtn.tag = indexPath.row
                cell?.minusBtn.tag = indexPath.row
                cell?.tag = indexPath.row + 100
                cell?.plusBtn.addTarget(self, action: #selector(self.plusBtnTapped), for: .touchUpInside)
                cell?.minusBtn.addTarget(self, action: #selector(self.minusBtnTapped), for: .touchUpInside)
            }else if indexPath.row == 1
            {
                cell?.roomsTitleLabel.text = "\(Utility.shared.getLanguage()?.value(forKey: "bedroom_guest")as! String)\(bedRoomCount > 1 ? "s": "") "
                cell?.countshowLabel.text = "\(bedRoomCount)"
                cell?.countValue = 1
                cell?.plusBtn.tag = indexPath.row
                cell?.minusBtn.tag = indexPath.row
                cell?.tag = indexPath.row + 100
                cell?.isHidden = true
                cell?.plusBtn.addTarget(self, action: #selector(self.plusBtnTapped), for: .touchUpInside)
                cell?.minusBtn.addTarget(self, action: #selector(self.minusBtnTapped), for: .touchUpInside)
            }else if indexPath.row == 2
            {
                cell?.roomsTitleLabel.text = "\(Utility.shared.getLanguage()?.value(forKey: "bed_guest")as! String)\(bedCount > 1 ? "s": "") "
                cell?.countshowLabel.text = "\(bedCount)"
                cell?.countValue = 1
                cell?.plusBtn.tag = indexPath.row
                cell?.minusBtn.tag = indexPath.row
                cell?.tag = indexPath.row + 100
                cell?.isHidden = true
                cell?.plusBtn.addTarget(self, action: #selector(self.plusBtnTapped), for: .touchUpInside)
                cell?.minusBtn.addTarget(self, action: #selector(self.minusBtnTapped), for: .touchUpInside)
            }
            cell?.plusBtn.layer.cornerRadius = (cell?.plusBtn.frame.size.width)!/2
            cell?.plusBtn.layer.borderWidth = 1.0
            cell?.plusBtn.layer.borderColor = Theme.PRIMARY_COLOR.cgColor
            cell?.minusBtn.layer.cornerRadius = (cell?.minusBtn.frame.size.width)!/2
            cell?.minusBtn.layer.borderWidth = 1.0
            cell?.minusBtn.layer.borderColor = Theme.PRIMARY_COLOR.cgColor
            cell?.selectionStyle = .none
          
            cell?.roomsTitleLabel?.font = UIFont(name:"Circular-Book", size: 18)
            cell?.roomsTitleLabel.textColor = UIColor.darkText
            cell?.countshowLabel.textColor = UIColor.darkText
            return cell!
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }

    @objc func plusBtnTapped(sender : UIButton)
    {
        if let cell = view.viewWithTag(sender.tag + 100) as? RoomsCell
        {
            if Int(cell.countshowLabel.text!)! >= personCapacityArray.count && sender.tag == 0
            {
                if(lottieView.isHidden)
                {
                cell.plusBtn.isEnabled = false
                cell.plusBtn.layer.borderColor = Theme.PRIMARY_COLOR.withAlphaComponent(0.5).cgColor
                cell.plusBtn.isUserInteractionEnabled = false
                }
            }else if Int(cell.countshowLabel.text!)! >= bedRoomCapacity.count && sender.tag == 1
            {
                if(lottieView.isHidden)
                {
                cell.plusBtn.isEnabled = false
                cell.plusBtn.layer.borderColor = Theme.PRIMARY_COLOR.withAlphaComponent(0.5).cgColor
                cell.plusBtn.isUserInteractionEnabled = false
                }
            }else if Int(cell.countshowLabel.text!)! >= bedCapacity.count && sender.tag == 2
            {
                if(lottieView.isHidden)
                {
                cell.plusBtn.isEnabled = false
                cell.plusBtn.layer.borderColor = Theme.PRIMARY_COLOR.withAlphaComponent(0.5).cgColor
                cell.plusBtn.isUserInteractionEnabled = false
                }
            }else
            {
                cell.countshowLabel.text = "\(Int(cell.countshowLabel.text!)! + 1)"
                if sender.tag == 0
                {
                    Utility.shared.step1ValuesInfo.updateValue(Int(cell.countshowLabel.text!)!, forKey: "personCapacity")
                }else if sender.tag == 1
                {
                    Utility.shared.step1ValuesInfo.updateValue(Int(cell.countshowLabel.text!)!, forKey: "bedrooms")
                }else if sender.tag == 2{
                    Utility.shared.step1ValuesInfo.updateValue(Int(cell.countshowLabel.text!)!, forKey: "beds")
                }
                cell.plusBtn.isEnabled = true
                
                cell.plusBtn.isUserInteractionEnabled = true
            }
            
            if(sender.tag == 0)
            {
             cell.roomsTitleLabel.text = "\(Utility.shared.getLanguage()?.value(forKey: "total_guest")as! String)\(Int(cell.countshowLabel.text!)! > 1 ? "s": "")"
            }
            if(sender.tag == 1)
            {
             cell.roomsTitleLabel.text = "\(Utility.shared.getLanguage()?.value(forKey: "bedroom_guest")as! String)\(Int(cell.countshowLabel.text!)! > 1 ? "s": "")"
            }
            if(sender.tag == 2)
            {
            cell.roomsTitleLabel.text = "\(Utility.shared.getLanguage()?.value(forKey: "bed_guest")as! String)\(Int(cell.countshowLabel.text!)! > 1 ? "s": "")"
            }
            cell.minusBtn.isEnabled = true
            cell.minusBtn.layer.borderColor = Theme.PRIMARY_COLOR.cgColor
            cell.minusBtn.isUserInteractionEnabled = true
        }
        
    }
    
    @objc func minusBtnTapped(sender : UIButton)
    {
        if let cell = view.viewWithTag(sender.tag + 100) as? RoomsCell
        {
            if Int(cell.countshowLabel.text!)! <= personCapacityArray.first! && sender.tag == 0
            {
                cell.minusBtn.isEnabled = false
                cell.minusBtn.layer.borderColor = Theme.PRIMARY_COLOR.withAlphaComponent(0.5).cgColor
                cell.minusBtn.isUserInteractionEnabled = false
            }else if Int(cell.countshowLabel.text!)! <= bedRoomCapacity.first! && sender.tag == 1
            {
                cell.minusBtn.isEnabled = false
                cell.minusBtn.layer.borderColor = Theme.PRIMARY_COLOR.withAlphaComponent(0.5).cgColor
                cell.minusBtn.isUserInteractionEnabled = false
            }else if Int(cell.countshowLabel.text!)! <= bedCapacity.first! && sender.tag == 2
            {
                cell.minusBtn.isEnabled = false
                cell.minusBtn.layer.borderColor = Theme.PRIMARY_COLOR.withAlphaComponent(0.5).cgColor
                cell.minusBtn.isUserInteractionEnabled = false
            }else{
                cell.countshowLabel.text = "\(Int(cell.countshowLabel.text!)! - 1)"
                if sender.tag == 0 {
                    Utility.shared.step1ValuesInfo.updateValue(Int(cell.countshowLabel.text!)!, forKey: "personCapacity")
                }else if sender.tag == 1
                {
                    Utility.shared.step1ValuesInfo.updateValue(Int(cell.countshowLabel.text!)!, forKey: "bedrooms")
                }else if sender.tag == 2{
                    Utility.shared.step1ValuesInfo.updateValue(Int(cell.countshowLabel.text!)!, forKey: "beds")
                }
                cell.minusBtn.isEnabled = true
                cell.minusBtn.isUserInteractionEnabled = true
            }
            if(sender.tag == 0)
            {
                cell.roomsTitleLabel.text = "\(Utility.shared.getLanguage()?.value(forKey: "total_guest")as! String)\(Int(cell.countshowLabel.text!)! > 1 ? "s": "")"
            }
            if(sender.tag == 1)
            {
                cell.roomsTitleLabel.text = "\(Utility.shared.getLanguage()?.value(forKey: "bedroom_guest")as! String)\(Int(cell.countshowLabel.text!)! > 1 ? "s": "")"
            }
            if(sender.tag == 2)
            {
                cell.roomsTitleLabel.text = "\(Utility.shared.getLanguage()?.value(forKey: "bed_guest")as! String)\(Int(cell.countshowLabel.text!)! > 1 ? "s": "")"
            }                                                   
            cell.plusBtn.isEnabled = true
            cell.plusBtn.layer.borderColor = Theme.PRIMARY_COLOR.cgColor
            cell.plusBtn.isUserInteractionEnabled = true
        }
    }
}

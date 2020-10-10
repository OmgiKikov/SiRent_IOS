//
//  TripLengthViewController.swift
//  Rent_All
//
//  Created by RadicalStart on 07/08/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Lottie

class TripLengthViewController: BaseHostTableviewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var nextarrow: UIImageView!
    @IBOutlet weak var saveAndExit: UIButton!
    @IBOutlet weak var offlineUIView: UIView!
    
    @IBOutlet weak var retryBtn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    //This Property
    var maxStay = ""
    var maxStayList = [[String: Any]]()
    var maxStayLimit = Int()
    var minStay = ""
    var minStayList = [[String : Any]]()
    var minStayLimit = Int()
     var lottieView1: LOTAnimationView!
    
    var selectedAmenityIdList = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
        retryBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
        saveAndExit.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"saveexit"))!)", for:.normal)
        saveAndExit.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
        nextBtn.backgroundColor = Theme.PRIMARY_COLOR
    }
    
    override func setUpUI() {
        offlineUIView.isHidden = true
        callListingSettingsAPI(oflineView: offlineUIView, nextButton: nextBtn)
        tableView.isHidden = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
          nextBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"next"))!)", for: .normal)
        nextBtn.layer.cornerRadius = 5
        nextBtn.clipsToBounds = true
        nextarrow.image = nextarrow.image?.withRenderingMode(.alwaysTemplate)
        nextarrow.tintColor = UIColor.white
        if(Utility.shared.step3_Edit)
        {
            self.saveAndExit.isHidden = false
        }
        else{
            self.saveAndExit.isHidden = true
        }
       
    }
    
    override func setDropdownList() {
        let minNights = (Utility.shared.getListSettingsArray.minNight?.listSettings!)!
         let maxNights = (Utility.shared.getListSettingsArray.maxNight?.listSettings!)!
        if((minNights[0]?.startValue!) != nil)
        {
          minStayLimit = (minNights[0]?.endValue!)!
        }
        
        if((maxNights[0]?.endValue!) != nil)
        {
          maxStayLimit = (maxNights[0]?.endValue!)!
        }

        if(Utility.shared.step3ValuesInfo["minNight"] != nil)
        {
            minStay = "\(Utility.shared.step3ValuesInfo["minNight"]!)"
        }
        else
        {
          minStay = "0"
        }
        
    
        if(Utility.shared.step3ValuesInfo["maxNight"] != nil)
        {
        maxStay = "\(Utility.shared.step3ValuesInfo["maxNight"]!)"
        
        }
        else
        {
        maxStay = "0"
        }
        Utility.shared.step3ValuesInfo.updateValue(Int(minStay)!, forKey: "minNight")
        Utility.shared.step3ValuesInfo.updateValue(Int(maxStay)!, forKey: "maxNight")
        tableView.reloadData()
    }
    override func registerCells() {
        tableView.register(UINib(nibName: "RoomsCell", bundle: nil), forCellReuseIdentifier: "RoomsCell")
    }
    
    //MARK: - Progress Indicator
    
    override func addLottieViewAsSubview()
    {
        self.view.addSubview(self.lottieView)
    }
    
    //IBActions
    
    @IBAction func RedirectNextPage(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
        if(Int(minStay) != nil && Int(maxStay) != nil)
        {
        let minNight : Int = Int(minStay)!
        let maxNight : Int = Int(maxStay)!
        if minNight > maxNight
        {
            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"minimumnights"))!)")
            return
        }
        let amenities = BasePriceViewController()
        self.view.window?.backgroundColor = UIColor.white
        //self.view.layer.add(presentrightAnimation()!, forKey: kCATransition)
        amenities.modalPresentationStyle = .fullScreen
        self.present(amenities, animated: false, completion: nil)
        }
        }
        else
        {
            self.offlineviewShow()
        }
    }
    @IBAction func retryBtnTapped(_ sender: Any) {
        
        if Utility().isConnectedToNetwork(){
           self.offlineUIView.isHidden = true
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
           // self.view.layer.add(dismissrightAnimation()!, forKey: kCATransition)
            self.dismiss(animated:false, completion: nil)
        }
        else
        {
            self.offlineviewShow()
        }
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
        Timer.scheduledTimer(timeInterval:0.3, target: self, selector: #selector(autoscrolling), userInfo: nil, repeats: true)
    }
    @objc func autoscrolling()
    {
        self.lottieView1.play()
    }
    func offlineviewShow()
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
    @IBAction func saveandexitAction(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            
            
            let minNight : Int = Int(minStay)!
            let maxNight : Int = Int(maxStay)!
            if minNight > maxNight
            {
                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"minimumnights"))!)")
                return
            }
            else if (Utility.shared.step3ValuesInfo["basePrice"] != nil &&  Utility.shared.step3ValuesInfo["basePrice"] as? String == "0")
            {
            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"invalidbaseprice"))!)")
                return
            }
            else if (Utility.shared.step3ValuesInfo["cleaningPrice"] != nil &&  Utility.shared.step3ValuesInfo["cleaningPrice"] as? String == "0")
                
            {
                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"invalidcleaning"))!)")
                return
            }
         self.lottieViewanimation()
        super.updateStep3ListingAPICall()
        }
        else
        {
            self.offlineviewShow()
        }
    }
    
    //MARK: - UITAbleViewDatasource and UITableViewDelegates
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       
        return "\((Utility.shared.getLanguage()?.value(forKey:"triplength"))!)"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomsCell", for: indexPath) as? RoomsCell
        cell?.dashView.isHidden = false
        cell?.roomsTitleLabel.font = UIFont(name: "Circular-Book", size:18)
        if indexPath.row == 0
        {
            
            cell?.roomsTitleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"ministay"))!)"
            cell?.countshowLabel.text = minStay
            cell?.countValue = 1
            cell?.plusBtn.tag = indexPath.row
            cell?.minusBtn.tag = indexPath.row
            cell?.tag = indexPath.row + 100
        }else
        {
            cell?.roomsTitleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"maxistay"))!)"
            cell?.countshowLabel.text = maxStay
            cell?.countValue = 1
            cell?.plusBtn.tag = indexPath.row
            cell?.minusBtn.tag = indexPath.row
            cell?.tag = indexPath.row + 100
        }
        
        
        cell?.plusBtn.addTarget(self, action: #selector(plusButtonTapped(_:)), for: .touchUpInside)
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
    
    @objc func plusButtonTapped(_ sender: UIButton)
    {
        var limit = Int()
        if sender.tag == 0
        {
            limit = minStayLimit
        }else {
            limit = maxStayLimit
        }
            if let cell = view.viewWithTag(sender.tag + 100) as? RoomsCell
            {
                if Int(cell.countshowLabel.text!)! >= limit && (sender.tag == 0 || sender.tag == 1)
                {
                    cell.plusBtn.isEnabled = false
                    cell.plusBtn.isUserInteractionEnabled = false
                }
                
                else
                {
                    cell.countshowLabel.text = "\(Int(cell.countshowLabel.text!)! + 1)"
                    if sender.tag == 0
                    {
                        Utility.shared.step3ValuesInfo.updateValue(Int(cell.countshowLabel.text!)!, forKey: "minNight")
                        minStay = "\(Utility.shared.step3ValuesInfo["minNight"]!)"
                    }else if sender.tag == 1{
                        Utility.shared.step3ValuesInfo.updateValue(Int(cell.countshowLabel.text!)!, forKey: "maxNight")
                        maxStay = "\(Utility.shared.step3ValuesInfo["maxNight"]!)"
                    }
                    cell.plusBtn.isEnabled = true
                    cell.plusBtn.isUserInteractionEnabled = true
                }
                cell.minusBtn.isEnabled = true
                cell.minusBtn.isUserInteractionEnabled = true
            }
        
    }
    
    @objc func minusBtnTapped(sender : UIButton)
    {
        var limit = Int()
        if sender.tag == 0
        {
            limit = 0
        }else {
            limit = 0
        }
        if let cell = view.viewWithTag(sender.tag + 100) as? RoomsCell
        {
            if Int(cell.countshowLabel.text!)! <= limit && (sender.tag == 0)
            {
                cell.minusBtn.isEnabled = false
                cell.minusBtn.isUserInteractionEnabled = false
            }
            else if(sender.tag == 1 && Int(cell.countshowLabel.text!)! <= limit)
            {
                cell.minusBtn.isEnabled = false
                cell.minusBtn.isUserInteractionEnabled = false
            }
            else{
                cell.countshowLabel.text = "\(Int(cell.countshowLabel.text!)! - 1)"
                if sender.tag == 0
                {
                    Utility.shared.step3ValuesInfo.updateValue(Int(cell.countshowLabel.text!)!, forKey: "minNight")
                    minStay = "\(Utility.shared.step3ValuesInfo["minNight"]!)"
                }else if sender.tag == 1{
                    Utility.shared.step3ValuesInfo.updateValue(Int(cell.countshowLabel.text!)!, forKey: "maxNight")
                    maxStay = "\(Utility.shared.step3ValuesInfo["maxNight"]!)"
                }
                cell.minusBtn.isEnabled = true
                cell.minusBtn.isUserInteractionEnabled = true
            }
            cell.plusBtn.isEnabled = true
            cell.plusBtn.isUserInteractionEnabled = true
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    
}

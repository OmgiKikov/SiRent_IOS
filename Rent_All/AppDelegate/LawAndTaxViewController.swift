//
//  LawAndTaxViewController.swift
//  Rent_All
//
//  Created by RadicalStart on 08/08/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Lottie

class LawAndTaxViewController: BaseHostTableviewController {
    
    @IBOutlet weak var retryBtn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var saveandExit: UIButton!
    @IBOutlet weak var imagearrowBtn: UIImageView!
    @IBOutlet weak var offlineUIView: UIView!
    
    var lottieView1: LOTAnimationView!
    var currencyDataArray = [GetCurrenciesListQuery.Data.GetCurrency.Result]()
    
    var weeklydiscountvalue = ""
    var monthlydiscountvalue = ""
    var updateResults = UpdateListingStep3Mutation.Data.UpdateListingStep3.Result()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
        retryBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
        saveandExit.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"saveexit"))!)", for:.normal)
        saveandExit.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
        nextBtn.backgroundColor = Theme.PRIMARY_COLOR
        // Do any additional setup after loading the view.
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
        imagearrowBtn.image = imagearrowBtn.image?.withRenderingMode(.alwaysTemplate)
        imagearrowBtn.tintColor = UIColor.white
        
        if(Utility.shared.step3_Edit)
        {
            self.saveandExit.isHidden = false
        }
        else{
            self.saveandExit.isHidden = true
        }
        
    }
    
    override func setDropdownList() {
        
        tableView.reloadData()
    }
    
    override func registerCells() {
    }
    
    func updateListingAPI()
    {
        let updatelist = UpdateListingStep3Mutation(id: Utility.shared.step3ValuesInfo["id"] as? Int,
                                                   houseRules: Utility.shared.step3ValuesInfo["houseRules"] as! [Int],
                                                   bookingNoticeTime: "\(Utility.shared.step3ValuesInfo["bookingNoticeTime"] ?? "")",
                                                   checkInStart: "\(Utility.shared.step3ValuesInfo["checkInStart"] ?? "")",
                                                   checkInEnd: "\(Utility.shared.step3ValuesInfo["checkInEnd"] ?? "")",
                                                   maxDaysNotice: "\(Utility.shared.step3ValuesInfo["maxDaysNotice"] ?? "")",
                                                   minNight: Utility.shared.step3ValuesInfo["minNight"] as? Int,
                                                   maxNight: Utility.shared.step3ValuesInfo["maxNight"] as? Int,
                                                   basePrice: Utility.shared.step3ValuesInfo["basePrice"] as? Double,
                                                   cleaningPrice: Utility.shared.step3ValuesInfo["cleaningPrice"] as? Double,
                                                   currency: "\(Utility.shared.step3ValuesInfo["currency"] ?? "")",
                                                   weeklyDiscount: Utility.shared.step3ValuesInfo["weeklyDiscount"] as? Int,
                                                   monthlyDiscount: Utility.shared.step3ValuesInfo["monthlyDiscount"] as? Int,
                                                   bookingType: "\(Utility.shared.step3ValuesInfo["bookingType"] ?? "")",
                                                   cancellationPolicy: Utility.shared.step3ValuesInfo["cancellationPolicy"] as? Int)
        apollo_headerClient.perform(mutation: updatelist){ (result,error) in
            
            if(result?.data?.updateListingStep3?.status == 200)
            {
               
                self.lottieView.isHidden = true
                if(result?.data?.updateListingStep3?.results != nil)
                    {
                self.updateResults = (result?.data?.updateListingStep3?.results)!
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    // code to remove your view
                    let becomeHostObj = BecomeHostVC()
                    becomeHostObj.listID = "\(Utility.shared.step3ValuesInfo["id"]!)"
                    becomeHostObj.showListingStepsAPICall(listID:"\(Utility.shared.step3ValuesInfo["id"]!)")
                  becomeHostObj.modalPresentationStyle = .fullScreen
                    self.present(becomeHostObj, animated:false, completion: nil)
                }
                }
                
                
            }
            else{
                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"somethingwrong"))!)")
            }
            
            
        }
    }
    //MARK: - Progress Indicator
    
    override func addLottieViewAsSubview()
    {
        self.view.addSubview(self.lottieView)
    }
    
    //IBActions
    
    func lottieViewanimation()
    {
        saveandExit.setTitle("", for:.normal)
        lottieView1 = LOTAnimationView.init(name: "animation")
        self.lottieView1.isHidden = false
        self.lottieView1.frame = CGRect(x:80, y:-35, width:100, height:100)
        self.saveandExit.addSubview(self.lottieView1)
        self.view.bringSubviewToFront(self.lottieView1)
        self.lottieView1.backgroundColor = UIColor.clear
        self.lottieView1.play()
        Timer.scheduledTimer(timeInterval:0.3, target: self, selector: #selector(autoscrolling), userInfo: nil, repeats: true)
    }
    func lottieViewnextanimation()
    {
        nextBtn.setTitle("", for:.normal)
        self.imagearrowBtn.isHidden = true
        lottieView1 = LOTAnimationView.init(name: "animation_white")
        self.lottieView1.isHidden = false
        self.lottieView1.frame = CGRect(x:15, y:-25, width:100, height:100)
        self.nextBtn.addSubview(self.lottieView1)
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
            offlineUIView.frame = CGRect.init(x: 0, y: FULLHEIGHT-85, width: FULLWIDTH, height: 55)
        }else{
            offlineUIView.frame = CGRect.init(x: 0, y: FULLHEIGHT-55, width: FULLWIDTH, height: 55)
        }
    }
    
    @IBAction func RedirectNextPage(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            self.lottieViewnextanimation()
            super.updateStep3ListingAPICall()
       // updateListingAPI()
        }
        else{
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
            //self.view.layer.add(dismissrightAnimation()!, forKey: kCATransition)
            //self.view.window!.layer.add(dismissrightAnimation()!, forKey: kCATransition)
            self.dismiss(animated:false, completion: nil)
        }
        else
        {
            self.offlineviewShow()
        }
    }
    
    @IBAction func saveandexitAction(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            self.lottieViewanimation()
            super.updateStep3ListingAPICall()
            // updateListingAPI()
        }
        else{
            self.offlineviewShow()
        }
    }
    
    //MARK: - UITAbleViewDatasource and UITableViewDelegates
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\((Utility.shared.getLanguage()?.value(forKey:"locallaws"))!)"

    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerLabel = UILabel(frame: CGRect(x:15, y: 8, width:FULLWIDTH-40, height:60))
        
        headerLabel.font =  UIFont(name: "Circular-Medium", size:25)
        headerLabel.addCharacterSpacing()
        headerLabel.textColor = UIColor.black
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        headerLabel.numberOfLines = 0
        headerLabel.sizeToFit()
        
        let headerView = UIView(frame: CGRect(x:15, y: 8, width: tableView.bounds.size.width - 20, height:60))
        headerView.backgroundColor = UIColor.white
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = UITableViewCell()
        cell.selectionStyle = .none
            
            if indexPath.row == 0
            {
                cell.textLabel?.text = "\((Utility.shared.getLanguage()?.value(forKey:"lawtitle"))!)"
                cell.textLabel?.textColor = UIColor.darkGray
                cell.textLabel?.font = UIFont(name: "Circular-Book", size:18)
                cell.textLabel?.numberOfLines = 0
            }
            else if indexPath.row == 1
            {
               let text = "\((Utility.shared.getLanguage()?.value(forKey:"lawdes"))!)"
                
                cell.textLabel?.attributedText = NSAttributedString(string:text,
                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 2.5
                
                let attrString = NSMutableAttributedString(string: text)
                attrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
                //cell.textLabel?.attributedText = attrString
                cell.detailTextLabel?.textColor = UIColor.lightGray
                cell.textLabel?.font = UIFont(name: "Circular-Book", size:18)
                cell.textLabel?.numberOfLines = 0
        }
            return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1
        {
            let cell = self.tableView(self.tableView, cellForRowAt: indexPath) as? UITableViewCell
            if cell?.imageView?.image == #imageLiteral(resourceName: "profile_Verify_Tick")
            {
                cell?.imageView?.image = #imageLiteral(resourceName: "unchecked")
            }else{
                cell?.imageView?.image = #imageLiteral(resourceName: "profile_Verify_Tick")
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 1)
        {
                    if Utility.shared.getAppLanguageCode() == "En" || Utility.shared.getAppLanguageCode() == "en"{
                        //return 460
                        return 630
                     }else{
                        //return 640
                         return 730
                     }
        }
        if  IS_IPHONE_678 || IS_IPHONE_X{
            return 110
        }else{
            return 110
        }
    }
    override func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.tag == 1
        {
            weeklydiscountvalue = textField.text!
        }
        if textField.tag == 2
        {
            monthlydiscountvalue = textField.text!
        }
    }
}

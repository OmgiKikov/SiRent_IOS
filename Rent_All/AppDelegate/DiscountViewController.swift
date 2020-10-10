//
//  DiscountViewController.swift
//  Rent_All
//
//  Created by RadicalStart on 08/08/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Lottie
import IQKeyboardManagerSwift

class DiscountViewController: BaseHostTableviewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var saveandExit: UIButton!
    @IBOutlet weak var imagearrowBtn: UIImageView!
    @IBOutlet weak var offlineUIView: UIView!
    @IBOutlet weak var retryBtn: UIButton!
    
    var currencyDataArray = [GetCurrenciesListQuery.Data.GetCurrency.Result]()
    
    @IBOutlet weak var errorLabel: UILabel!
    var weeklydiscountvalue = String()
    var monthlydiscountvalue = String()
    var lottieView1: LOTAnimationView!
    let characterset = NSCharacterSet(charactersIn: "0123456789.")
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
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
        if(Utility.shared.step3ValuesInfo["weeklyDiscount"] != nil)
        {
        weeklydiscountvalue = "\(Utility.shared.step3ValuesInfo["weeklyDiscount"]!)"
        }
        if(Utility.shared.step3ValuesInfo["monthlyDiscount"] != nil)
        {
        monthlydiscountvalue = "\(Utility.shared.step3ValuesInfo["monthlyDiscount"]!)"
        }
        self.lottieView.isHidden = true
        tableView.reloadData()
    }
    
    override func registerCells() {
        tableView.register(UINib(nibName: "TextFieldCell", bundle: nil), forCellReuseIdentifier: "textfieldcell")
    }
    
    //MARK: - Progress Indicator
    
    override func addLottieViewAsSubview()
    {
        self.view.addSubview(self.lottieView)
    }
    
    //IBActions
    
    @IBAction func RedirectNextPage(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
        self.view.endEditing(true)
        if !weeklydiscountvalue.isEmpty  || (weeklydiscountvalue.rangeOfCharacter(from: characterset.inverted) != nil){
            if(weeklydiscountvalue == ".")
            {
               
             self.view.makeToast( "\((Utility.shared.getLanguage()?.value(forKey:"invaliddiscount"))!)")
                return
            }
            if Double(weeklydiscountvalue)! > 100 {
                self.view.makeToast( "\((Utility.shared.getLanguage()?.value(forKey:"invaliddiscount"))!)")
                return
            }
        }
        if !monthlydiscountvalue.isEmpty || (weeklydiscountvalue.rangeOfCharacter(from: characterset.inverted) != nil)
        {
            if(monthlydiscountvalue == ".")
            {
                self.view.makeToast( "\((Utility.shared.getLanguage()?.value(forKey:"invaliddiscount"))!)")
                return
            }
            if Double(monthlydiscountvalue)! > 100 {
                self.view.makeToast( "\((Utility.shared.getLanguage()?.value(forKey:"invaliddiscount"))!)")
                return
            }
        }
        
        
        
        
        let amenities = IncreaseEarningViewController()
        self.view.window?.backgroundColor = UIColor.white
        //self.view.layer.add(presentrightAnimation()!, forKey: kCATransition)
        amenities.modalPresentationStyle = .fullScreen
        self.present(amenities, animated: false, completion: nil)
        }
        else
        {
            self.offlineviewShow()
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            
        self.view.endEditing(true)
       // Utility.shared.step3ValuesInfo.updateValue(weeklydiscountvalue, forKey: "weeklyDiscount")
      //  Utility.shared.step3ValuesInfo.updateValue(monthlydiscountvalue, forKey: "monthlyDiscount")
            
            //self.view.layer.add(dismissrightAnimation()!, forKey: kCATransition)
            if !weeklydiscountvalue.isEmpty || (weeklydiscountvalue.rangeOfCharacter(from: characterset.inverted) != nil) {
                if(weeklydiscountvalue == ".")
                {
                    self.view.makeToast( "\((Utility.shared.getLanguage()?.value(forKey:"invaliddiscount"))!)")
                    return
                }
                if Double(weeklydiscountvalue)! > 100 {
                    self.view.makeToast( "\((Utility.shared.getLanguage()?.value(forKey:"invaliddiscount"))!)")
                    return
                }
            }
            if !monthlydiscountvalue.isEmpty || (monthlydiscountvalue.rangeOfCharacter(from: characterset.inverted) != nil)
            {
                if(monthlydiscountvalue == ".")
                {
                    self.view.makeToast( "\((Utility.shared.getLanguage()?.value(forKey:"invaliddiscount"))!)")
                    return
                }
                if Double(monthlydiscountvalue)! > 100 {
                    self.view.makeToast( "\((Utility.shared.getLanguage()?.value(forKey:"invaliddiscount"))!)")
                    return
                }
            }
            
            self.dismiss(animated:false, completion: nil)
        }
        else
        {
            self.offlineviewShow()
        }
    }
    
    @IBAction func saveandexitAction(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            self.view.endEditing(true)
            if !weeklydiscountvalue.isEmpty || (weeklydiscountvalue.rangeOfCharacter(from: characterset.inverted) != nil) {
                if(weeklydiscountvalue == ".")
                {
                    self.view.hideToast()
                    self.view.hideToastActivity()
                    self.view.hideToast(self.view)
                    self.view.makeToast( "\((Utility.shared.getLanguage()?.value(forKey:"invaliddiscount"))!)")
                     self.view.clearToastQueue()
                    return
                }
                if Double(weeklydiscountvalue)! > 100 {
                    self.view.makeToast( "\((Utility.shared.getLanguage()?.value(forKey:"invaliddiscount"))!)")
                    return
                }
            }
            if !monthlydiscountvalue.isEmpty || (monthlydiscountvalue.rangeOfCharacter(from: characterset.inverted) != nil)
            {
                if(monthlydiscountvalue == ".")
                {
                    self.view.makeToast( "\((Utility.shared.getLanguage()?.value(forKey:"invaliddiscount"))!)")
                    return
                }
                if Double(monthlydiscountvalue)! > 100 {
                    self.view.makeToast( "\((Utility.shared.getLanguage()?.value(forKey:"invaliddiscount"))!)")
                    return
                }
            }
            
           // Utility.shared.step3ValuesInfo.updateValue(weeklydiscountvalue, forKey: "weeklyDiscount")
            //Utility.shared.step3ValuesInfo.updateValue(monthlydiscountvalue, forKey: "monthlyDiscount")
            self.lottieViewanimation()
            super.updateStep3ListingAPICall()
        }
        else{
            self.offlineviewShow()
        }
    }
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
    
    @IBAction func retryBtnTapped(_ sender: Any) {
        
        if Utility().isConnectedToNetwork(){
            self.offlineUIView.isHidden = true
        }
    }
    //MARK: - UITAbleViewDatasource and UITableViewDelegates
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       
        return  "\((Utility.shared.getLanguage()?.value(forKey:"discounts"))!)"
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0
        {
            let cell = UITableViewCell()
            
            cell.textLabel?.text =  "\((Utility.shared.getLanguage()?.value(forKey:"dislongerdays"))!)"
            cell.textLabel?.font = UIFont(name: "Circular-Book", size:18)
            cell.textLabel?.numberOfLines = 0
            return cell
        }
        else
        {
        
            let cell = tableView
                .dequeueReusableCell(withIdentifier: "textfieldcell", for: indexPath) as? TextFieldCell
            if indexPath.row == 1
            {
                cell?.stepnumberLbl.isHidden = true
                cell?.step1Height.constant = 0
               
                cell?.queryTitleLbl.text = "\((Utility.shared.getLanguage()?.value(forKey:"weeklydiscount"))!)"
                cell?.txtField.attributedPlaceholder = NSAttributedString(string: "% \((Utility.shared.getLanguage()?.value(forKey:"off"))!)",
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                cell?.txtField.tag = indexPath.row
                cell?.txtField.addTarget(self, action: #selector(weeklydiscount(field:)), for: .editingDidEnd)
                cell?.queryTitleLbl.font = UIFont(name: "Circular-Book", size:18)
                cell?.txtField.font = UIFont(name: "Circular-Book", size:18)
                cell?.txtField.text = weeklydiscountvalue
                if(Utility.shared.step3ValuesInfo["weeklyDiscount"] != nil)
                {
                    if("\(Utility.shared.step3ValuesInfo["weeklyDiscount"]!)" != "0")
                    {
                    cell?.txtField.text = "\(Utility.shared.step3ValuesInfo["weeklyDiscount"]!)"
                    }
                    else
                    {
                       cell?.txtField.text  = ""
                    }
                }
                
                cell?.txtField.keyboardType = .numberPad
                let toolBar = UIToolbar().ToolbarPikerSelect(mySelect: #selector(dismisskeyborad))
                cell?.txtField.inputAccessoryView = toolBar
                
            }
            else if indexPath.row == 2
            {
                cell?.stepnumberLbl.isHidden = true
                cell?.step1Height.constant = 0
              
                cell?.queryTitleLbl.text = "\((Utility.shared.getLanguage()?.value(forKey:"monthlydisc"))!)"
                cell?.txtField.attributedPlaceholder = NSAttributedString(string: "% \((Utility.shared.getLanguage()?.value(forKey:"off"))!)",
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                cell?.txtField.tag = indexPath.row
                cell?.txtField.addTarget(self, action: #selector(Monthlydiscount(field:)), for: .editingDidEnd)
                cell?.queryTitleLbl.font = UIFont(name: "Circular-Book", size:18)
                cell?.txtField.font = UIFont(name: "Circular-Book", size:18)
                cell?.txtField.keyboardType = .numberPad
                cell?.txtField.text = monthlydiscountvalue
                if(Utility.shared.step3ValuesInfo["monthlyDiscount"] != nil)
                {
                    if("\(Utility.shared.step3ValuesInfo["monthlyDiscount"]!)" != "0")
                    {
                 cell?.txtField.text = "\(Utility.shared.step3ValuesInfo["monthlyDiscount"]!)"
                    }
                    else
                    {
                        cell?.txtField.text  = ""
                    }
                }
            }
            
            cell?.txtField.textColor = UIColor.darkText
            cell?.step1Height.constant = 0
            cell?.stepnumberLbl.isHidden = true
            cell?.selectionStyle = .none
            cell?.txtField.delegate = self
        let toolBar = UIToolbar().ToolbarPikerSelect(mySelect: #selector(dismisskeyborad))
        cell?.txtField.inputAccessoryView = toolBar
            return cell!
        }
        
        
    }
    
    @objc func weeklydiscount(field: UITextField){
        
        if ((field.text?.containsNonEnglishNumbersChecking) != nil) {
            field.text = field.text?.english
            weeklydiscountvalue = field.text!
            print(field.text as Any)
        }
    }
    
    @objc func Monthlydiscount(field: UITextField){
        if ((field.text?.containsNonEnglishNumbersChecking) != nil) {
            field.text = field.text?.english
            monthlydiscountvalue = field.text!
            print(field.text as Any)
        }
    }
    
    @objc func dismisskeyborad() {
        
        view.endEditing(true)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(((textField.text?.contains("."))!) && (string == "."))
        {
            return false
        }
        return true
    }
    override func textFieldDidEndEditing(_ textField: UITextField) {
    
        if textField.tag == 1
        {
            weeklydiscountvalue = textField.text!
            Utility.shared.step3ValuesInfo.updateValue(weeklydiscountvalue, forKey: "weeklyDiscount")
        }
        if textField.tag == 2
        {
            monthlydiscountvalue = textField.text!
            Utility.shared.step3ValuesInfo.updateValue(monthlydiscountvalue, forKey: "monthlyDiscount")
        }
    }
}

//
//  BasePriceViewController.swift
//  Rent_All
//
//  Created by RadicalStart on 08/08/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Lottie

class BasePriceViewController: BaseHostTableviewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var saveandExit: UIButton!
    @IBOutlet weak var imagearrowBtn: UIImageView!
    @IBOutlet weak var offlineUIView: UIView!
    @IBOutlet weak var errorLabel:UILabel!
      @IBOutlet weak var retryBtn: UIButton!
    
    var currencyDataArray = [GetCurrenciesListQuery.Data.GetCurrency.Result]()
    
    var basePriceValue = ""
    var cleaningPriceValue = ""
    
    var inputPickerView = UIPickerView()
    var inputUIView = UIView()
    var lottieView1: LOTAnimationView!
    var currencyArr = [String]()
    let characterset = NSCharacterSet(charactersIn: "0123456789.")
    let cleaning_character = NSCharacterSet(charactersIn: "0123456789")
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyAPICall()
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
      //  Utility.shared.host_basePrice = Int(((Utility.shared.step3ValuesInfo["basePrice"])!) as! Double)
        
    }
    
    override func setDropdownList() {
        tableView.reloadData()
    }
    
    func currencyAPICall()
    {

        Utility.shared.currencyvalue = (Utility.shared.currencyDataArray.first?.symbol!)!
            for i in Utility.shared.currencyDataArray
            {
               self.currencyArr.append(i.symbol!)
            }
            if(Utility.shared.step3ValuesInfo["currency"] != nil && "\(Utility.shared.step3ValuesInfo["currency"]!)" != "")
            {
            let index = self.currencyArr.index(of:"\(Utility.shared.step3ValuesInfo["currency"]!)")
            self.inputPickerView.selectRow(index!, inComponent: 0, animated: true)
            }
            else
            {
             self.inputPickerView.selectRow(0, inComponent: 0, animated: true)
            }
            self.tableView.reloadData()
      
    }
    
    override func setdropdown()
    {
        inputUIView.frame = CGRect(x: 0, y: FULLHEIGHT-200, width: FULLWIDTH, height: 200)
        inputPickerView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height: 200)
        inputUIView.addSubview(inputPickerView)
        inputPickerView.delegate = self
        inputPickerView.tintColor = Theme.PRIMARY_COLOR
        inputPickerView.backgroundColor = UIColor.white
        inputPickerView.reloadAllComponents()
        
        
    }
    
    override func registerCells() {
        tableView.register(UINib(nibName: "TextFieldCell", bundle: nil), forCellReuseIdentifier: "textfieldcell")
    }
    
    //MARK: - Progress Indicator
    
    override func addLottieViewAsSubview()
    {
        self.view.addSubview(self.lottieView)
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
        self.offlineUIView.layer.shadowOffset = CGSize(width: 0.0, height: 00.0)
        self.offlineUIView.layer.shadowOpacity = 0.3
        self.offlineUIView.layer.shadowPath = shadowPath2.cgPath
        if IS_IPHONE_X || IS_IPHONE_XR{
            offlineUIView.frame = CGRect.init(x: 0, y: FULLHEIGHT-130, width: FULLWIDTH, height: 55)
        }else{
            offlineUIView.frame = CGRect.init(x: 0, y: FULLHEIGHT-100, width: FULLWIDTH, height: 55)
        }
    }
    
    //IBActions
    
    @IBAction func RedirectNextPage(_ sender: Any) {

//        if basePriceValue.isEmpty  || basePriceValue == "." ||  basePriceValue == "0" || Utility.shared.host_basePrice  < 1.0 || (basePriceValue.rangeOfCharacter(from: characterset.inverted) != nil) {
//            if((basePriceValue == "."  || basePriceValue == "0" || Utility.shared.host_basePrice < 1.0) && (basePriceValue != "") && (basePriceValue.rangeOfCharacter(from: characterset.inverted) == nil) )
//            {
//             self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"invalidbaseprice"))!)")
//            }
//            else
//            {
//
//            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"baseprice_require"))!)")
//            }
//            return
//        }
        if Utility().isConnectedToNetwork(){
        self.view.endEditing(true)
        if basePriceValue.isEmpty  || basePriceValue == "."  || basePriceValue == "0" || Utility.shared.host_basePrice < 1.0 || (basePriceValue.rangeOfCharacter(from: characterset.inverted) != nil) {
            if((basePriceValue == "."  || basePriceValue == "0" || Utility.shared.host_basePrice < 1.0) && (basePriceValue != "") && (basePriceValue.rangeOfCharacter(from: characterset.inverted) == nil) )
            {
                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"invalidbaseprice"))!)")
            
            }
            else
            {
                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"baseprice_require"))!)")
            }
            return
        }
        
        if(cleaningPriceValue == "0")
        {
           self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"invalidcleaning"))!)")
            return
        }
        
        Utility.shared.step3ValuesInfo.updateValue(Utility.shared.currencyvalue, forKey: "currency")
        let amenities = DiscountViewController()
        self.view.window?.backgroundColor = UIColor.white
       // self.view.layer.add(presentrightAnimation()!, forKey: kCATransition)
    amenities.modalPresentationStyle = .fullScreen
        self.present(amenities, animated: false, completion: nil)
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            view.endEditing(true)
            //self.view.layer.add(dismissrightAnimation()!, forKey: kCATransition)
            self.dismiss(animated:false, completion: nil)
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
    @IBAction func saveandexitAction(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
           self.view.endEditing(true)
            
            if basePriceValue.isEmpty  || basePriceValue == "."  || basePriceValue == "0" || Utility.shared.host_basePrice < 1.0 || (basePriceValue.rangeOfCharacter(from: characterset.inverted) != nil) {
                if((basePriceValue == "."  || basePriceValue == "0" || Utility.shared.host_basePrice < 1.0) && (basePriceValue != "") && (basePriceValue.rangeOfCharacter(from: characterset.inverted) == nil) )
                {
                    self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"invalidbaseprice"))!)")
                
                }
                else
                {
                    self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"baseprice_require"))!)")
                }
                return
            }
            if(cleaningPriceValue == ".")
            {
                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"invalidcleaning"))!)")
                return
            }
             self.lottieViewanimation()
            Utility.shared.step3ValuesInfo.updateValue(Utility.shared.currencyvalue, forKey: "currency")
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
        return "\((Utility.shared.getLanguage()?.value(forKey:"baseprice"))!)"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerLabel = UILabel(frame: CGRect(x:15, y: 8, width:FULLWIDTH-40, height: 100))
        
        headerLabel.font =  UIFont(name: "Circular-Medium", size:25)
        headerLabel.addCharacterSpacing()
        headerLabel.textColor = UIColor.black
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        headerLabel.numberOfLines = 0
        headerLabel.sizeToFit()
        
        let headerView = UIView(frame: CGRect(x:15, y: 8, width: tableView.bounds.size.width - 20, height: 100))
        headerView.backgroundColor = UIColor.white
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0
        {
            let cell = UITableViewCell()
           
            cell.textLabel?.text = "\((Utility.shared.getLanguage()?.value(forKey:"basedefault"))!)"
            cell.textLabel?.font = UIFont(name: "Circular-Book", size:18)
            cell.textLabel?.numberOfLines = 0
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView
                .dequeueReusableCell(withIdentifier: "textfieldcell", for: indexPath) as? TextFieldCell
            if indexPath.row == 1
            {
                cell?.stepnumberLbl.isHidden = true
                cell?.step1Height.constant = 0
                cell?.queryTitleLbl.text = "\((Utility.shared.getLanguage()?.value(forKey:"baseprice"))!)"
                
                
                cell?.txtField.attributedPlaceholder = NSAttributedString(string: "\((Utility.shared.getLanguage()?.value(forKey:"pricepernight"))!)",
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                cell?.txtField.tag = indexPath.row
                
                cell?.txtField.addTarget(self, action: #selector(didChangeText(field:)), for: .editingChanged)
                if(Utility.shared.step3ValuesInfo["basePrice"] != nil)
                {
                    
                    basePriceValue = "\(Utility.shared.step3ValuesInfo["basePrice"]!)"
                    let base_value = Double(basePriceValue)?.clean
                    cell?.txtField.text = "\(base_value!)"
                }
                cell?.queryTitleLbl.font = UIFont(name: "Circular-Book", size:20)
                cell?.txtField.font = UIFont(name: "Circular-Book", size:20)
                cell?.txtField.keyboardType = .decimalPad
                let toolBar = UIToolbar().ToolbarPikerSelect(mySelect: #selector(dismisskeyborad))
                cell?.txtField.inputAccessoryView = toolBar
            }
            else if indexPath.row == 2
            {
                cell?.stepnumberLbl.isHidden = true
                cell?.step1Height.constant = 0
                cell?.queryTitleLbl.text = "\((Utility.shared.getLanguage()?.value(forKey:"cleaningprice"))!)"
                cell?.txtField.attributedPlaceholder = NSAttributedString(string: "\((Utility.shared.getLanguage()?.value(forKey:"cleaningprice"))!)",
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                cell?.txtField.tag = indexPath.row
                cell?.txtField.addTarget(self, action: #selector(CleaningText(field:)), for: .editingChanged)
                if(Utility.shared.step3ValuesInfo["cleaningPrice"] != nil && ((Utility.shared.step3ValuesInfo["cleaningPrice"]as? Double) != 0.0))
                {
                 
                    cleaningPriceValue =  "\(Utility.shared.step3ValuesInfo["cleaningPrice"]!)"
                    let cleaning_value = Double(cleaningPriceValue)?.clean
                     cell?.txtField.text = "\(cleaning_value!)"
                }
                cell?.queryTitleLbl.font = UIFont(name: "Circular-Book", size:20)
                cell?.txtField.font = UIFont(name: "Circular-Book", size:20)
                cell?.txtField.keyboardType = .decimalPad
                let toolBar = UIToolbar().ToolbarPikerSelect(mySelect: #selector(dismisskeyborad))
                cell?.txtField.inputAccessoryView = toolBar
                
            }else if indexPath.row == 3
            {
                cell?.stepnumberLbl.isHidden = true
                cell?.step1Height.constant = 0
                cell?.queryTitleLbl.text = "\((Utility.shared.getLanguage()?.value(forKey:"currency"))!)"
                cell?.txtField.attributedPlaceholder = NSAttributedString(string: "",
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                if(Utility.shared.step3ValuesInfo["currency"] != nil)
                {
                    
                cell?.txtField.text = "\(Utility.shared.step3ValuesInfo["currency"]!)"
                Utility.shared.currencyvalue = "\(Utility.shared.step3ValuesInfo["currency"]!)"
                    
                }
                else
                {
                cell?.txtField.text = Utility.shared.currencyvalue
                }
                cell?.txtField.tag = indexPath.row
                cell?.queryTitleLbl.font = UIFont(name: "Circular-Book", size:20)
                cell?.txtField.font = UIFont(name: "Circular-Book", size:20)
                let toolBar = UIToolbar().ToolbarPikerSelect(mySelect: #selector(dismissgenderPicker))
                cell?.txtField.inputAccessoryView = toolBar
                cell?.txtField.inputView = inputPickerView
                cell?.txtField.delegate = self
            }
            
            cell?.txtField.textColor = UIColor.darkText
            cell?.step1Height.constant = 0
            cell?.stepnumberLbl.isHidden = true
            cell?.selectionStyle = .none
            cell?.txtField.delegate = self
            return cell!

        }
    }
    @objc func dismisskeyborad() {
        
        view.endEditing(true)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 3
        {
            selectedTextfield = 3
        }
        inputPickerView.reloadAllComponents()
    }
    
    //MARK: - UIPickerViewDelegate and Datasource
    
    override func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    override func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return  Utility.shared.currencyDataArray.count
    }
    
    override func pickerView( _ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        var titleData = ""
        
        if(selectedTextfield == 3)
        {
            titleData =  Utility.shared.currencyDataArray[row].symbol!
        }
        
        let myTitle = NSAttributedString(string: titleData , attributes: [NSAttributedString.Key.font:UIFont(name: "Circular-Book", size: 15.0)!,NSAttributedString.Key.foregroundColor:Theme.PRIMARY_COLOR])
        return myTitle
    }
    
    override func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent  component: Int) {
        
        if(selectedTextfield == 3)
        {
            Utility.shared.currencyvalue =  Utility.shared.currencyDataArray[row].symbol!
            Utility.shared.step3ValuesInfo.updateValue(Utility.shared.currencyvalue, forKey: "currency")
            pickerView.selectRow(row, inComponent: component, animated: true)
            //tableView.reloadData()
        }
    }
    
    //MARK: - UITextFieldDelegates
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        selectedTextfield = textField.tag
        inputPickerView.reloadAllComponents()
    }
    

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentCharacterCount = textField.text?.count ?? 0
        if range.length + range.location > currentCharacterCount || (((textField.text?.contains("."))!) && (string == ".")) {
            return false
        }else{
            let newlength = currentCharacterCount + string.count - range.length
            return newlength <= 5
        }

        return true
    }
    
//    textField.addTarget(self, action: #selector(didChangeText(field:)), for: .editingChanged)
    @objc func didChangeText(field: UITextField) {
        if ((field.text?.containsNonEnglishNumbersChecking) != nil) {
            field.text = field.text?.english
            basePriceValue = field.text!
            print(field.text as Any)
        }
    }
    @objc func CleaningText(field: UITextField){
        
        if ((field.text?.containsNonEnglishNumbersChecking) != nil) {
            field.text = field.text?.english
            cleaningPriceValue = field.text!
            print(field.text as Any)
        }
    }
    override func textFieldDidEndEditing(_ textField: UITextField) {
        

     if(textField.text == "." || textField.text?.rangeOfCharacter(from: characterset.inverted) != nil)
     {
        self.view.endEditing(true)
        
       
        if textField.tag == 1
        {
        basePriceValue = textField.text!
        self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"invalidbaseprice"))!)")
        }
        else if textField.tag == 2
        {
          cleaningPriceValue = textField.text!
        self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"invalidcleaning"))!)")
        }
     }
        else
     {
        if textField.tag == 1
        {
            
            basePriceValue = textField.text!
        
            if(basePriceValue != "")
            {
            Utility.shared.host_basePrice = (Double(basePriceValue))!
            Utility.shared.step3ValuesInfo.updateValue((Double(basePriceValue)?.clean)!, forKey: "basePrice")
            }
            
        }
        if textField.tag == 2
        {
            cleaningPriceValue = textField.text!
            if(cleaningPriceValue == "")
            {
                Utility.shared.host_cleanPrice = 0.0
                Utility.shared.step3ValuesInfo.updateValue(0.0, forKey: "cleaningPrice")
            }
            else
            {
               Utility.shared.host_cleanPrice = (Double(cleaningPriceValue))!
               Utility.shared.step3ValuesInfo.updateValue((Double(cleaningPriceValue)?.clean)!, forKey: "cleaningPrice")
            }
        }

       // tableView.reloadData()
        }
        
        if textField.tag == 3{
            tableView.reloadData()
        }
        
        view.endEditing(true)
    }
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
extension String {
    var containsNonEnglishNumbersChecking: Bool {
        return !isEmpty && range(of: "[^0-9]", options: .regularExpression) == nil
    }
    
    var english: String {
        return self.applyingTransform(StringTransform.toLatin, reverse: false) ?? self
    }
}
extension FloatingPoint {
  var isInteger: Bool { rounded() == self }
}

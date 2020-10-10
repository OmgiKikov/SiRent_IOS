//
//  BathroomsListingViewController.swift
//  Rent_All
//
//  Created by RadicalStart on 31/07/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Lottie

class BathroomsListingViewController: BaseHostTableviewController {

    //IBOutlets
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var nextarrow: UIImageView!
    @IBOutlet weak var offlineUIView: UIView!
    @IBOutlet weak var saveAndExit: UIButton!
    @IBOutlet weak var retryButn: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    //This Property
    var bathroomsArr = [Float]()
    var bathroomsCount = Float()
    var bathroomTypeArr = [String]()
    var bathroomTypeLbl = String()
    var inputListView = UIView()
    var pickerView = UIPickerView()
    var lottieView1: LOTAnimationView!
    var bathroomJSONValue = Float()
    
    //MARK: - ViewController Life cycle
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
        offlineUIView.isHidden = true
        callListingSettingsAPI(oflineView: offlineUIView, nextButton: nextBtn)
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
    
    override func setdropdown()
    {
        inputListView.frame = CGRect(x: 0, y: FULLHEIGHT-200, width: FULLWIDTH, height: 200)
        pickerView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height: 200)
        inputListView.addSubview(pickerView)
        pickerView.delegate = self
        pickerView.tintColor = Theme.PRIMARY_COLOR
        pickerView.backgroundColor = UIColor.white
        pickerView.reloadAllComponents()
    }
    
    override func setDropdownList() {
        
        setBathroomsCount()
        setBathroomType()
        
        tableView.reloadData()
    }
    
    func setBathroomsCount()
    {
        var incrVal = 1.0
        let bathrooms = (Utility.shared.getListSettingsArray.bathrooms?.listSettings![0]?.endValue)!
        let valcount = bathrooms + bathrooms - 1
        for i in 0..<valcount
        {
            bathroomsArr.insert(Float(incrVal) , at: i)
            incrVal = (incrVal + 0.5)
        }
        
        if Utility.shared.step1ValuesInfo.keys.contains("bathrooms")
        {
            if let bedRoomsCountValues = (Utility.shared.step1ValuesInfo["bathrooms"]!) as? Double
            {
                bathroomsCount = Float(bedRoomsCountValues)
                bathroomJSONValue = Float(bedRoomsCountValues)
            }
        }else{
            bathroomsCount = bathroomsArr.first!
            bathroomJSONValue = 1
            Utility.shared.step1ValuesInfo.updateValue(Double(bathroomJSONValue), forKey: "bathrooms")
        }
    }
    
    func setBathroomType()
    {
        let typeListSettings = (Utility.shared.getListSettingsArray.bathroomType?.listSettings!)!
        for item in typeListSettings
        {
            bathroomTypeArr.append((item?.itemName)!)
        }
        bathroomTypeLbl = bathroomTypeArr.first!
        //pickerView.selectRow(0, inComponent: 0, animated: true)
        if !Utility.shared.step1ValuesInfo.keys.contains("bathroomType")
        {
            bathroomTypeLbl = bathroomTypeArr.first!
            pickerView.selectRow(0, inComponent: 0, animated: true)
            
            Utility.shared.step1ValuesInfo.updateValue((Utility.shared.getListSettingsArray.bathroomType?.listSettings!.first??.id!)!, forKey: "bathroomType")
        }else{
            _ = typeListSettings.filter({ (item) -> Bool in
                if (Utility.shared.step1ValuesInfo["bathroomType"]! as? Int) == item?.id
                {
                    bathroomTypeLbl = (item?.itemName!)!
                    return true
                }else{
                    return false
                }
            })
            if !bathroomTypeLbl.isEmpty
            {
                let index = bathroomTypeArr.index(where: { (item) -> Bool in
                    item == bathroomTypeLbl
                })
                pickerView.selectRow(index!, inComponent: 0, animated: true)
            }
        }
    }
    
    override func registerCells() {
        tableView.register(UINib(nibName: "RoomsCell", bundle: nil), forCellReuseIdentifier: "RoomsCell")
        tableView.register(UINib(nibName: "TextFieldCell", bundle: nil), forCellReuseIdentifier: "textfieldcell")
    }
    
    //MARK: - Progress Indicator
    
    override func addLottieViewAsSubview()
    {
      //  self.view.addSubview(self.lottieView)
    }
    
    //IBActions
    @IBAction func retryBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            self.offlineUIView.isHidden = true
        }
        
    }
    
    @IBAction func RedirectNextPage(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
        if(Double(bathroomJSONValue) < 1)
        {
          Utility.shared.step1ValuesInfo.updateValue(Double(1),forKey: "bathrooms")
        }
        else
        {
        Utility.shared.step1ValuesInfo.updateValue(Double(bathroomJSONValue),forKey: "bathrooms")
            }
        let location = AddressListingViewController()
        self.view.window?.backgroundColor = UIColor.white
      // self.view.layer.add(dismissrightAnimation()!, forKey: kCATransition)
         location.modalPresentationStyle = .fullScreen
        self.present(location, animated: false, completion: nil)
        }
        else
        {
          self.offlineViewShow()
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
         Utility.shared.step1ValuesInfo.updateValue(Double(bathroomJSONValue),forKey: "bathrooms")
       /// self.view.layer.add(dismissrightAnimation()!, forKey: kCATransition)
        self.dismiss(animated: true, completion: nil)
    }
    
    func offlineViewShow()
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
    @IBAction func saveandexit(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
        self.lottieViewanimation()
            if(Double(bathroomJSONValue) < 1)
            {
                Utility.shared.step1ValuesInfo.updateValue(Double(1),forKey: "bathrooms")
            }
            else
            {
                Utility.shared.step1ValuesInfo.updateValue(Double(bathroomJSONValue),forKey: "bathrooms")
            }
        super.updateListingAPICall()
        }
        else
        {
         self.offlineViewShow()
        }
    }
    
    //MARK: - UITAbleViewDatasource and UITableViewDelegates
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(Utility.shared.getLanguage()?.value(forKey: "How_many_bath")as! String)"
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
        
        if indexPath.section == 0
        {
            if indexPath.row == 0
            {
                let cell = tableView
                .dequeueReusableCell(withIdentifier: "RoomsCell", for: indexPath) as? RoomsCell
                cell?.dashView.isHidden = false
                cell?.roomsTitleLabel.text = "\(1) \(Utility.shared.getLanguage()?.value(forKey: "bathroom")as! String)"
                cell?.countshowLabel.text = "1"
                if bathroomsCount > 1
                {
                    let val = Double(bathroomsCount).clean
                    cell?.roomsTitleLabel.text = "\(val) \(Utility.shared.getLanguage()?.value(forKey: "bathrooms")as! String)"
                    cell?.countshowLabel.text = "\(val)"
                    bathroomJSONValue = Float(bathroomsCount)
                }else{
                    if(bathroomsCount != 0)
                    {
                    cell?.roomsTitleLabel.text = "\(Int(bathroomsCount)) \(Utility.shared.getLanguage()?.value(forKey: "bathroom")as! String)"
                    cell?.countshowLabel.text = "\(Int(bathroomsCount))"
                    bathroomJSONValue = Float(bathroomsCount)
                    }
                }
                cell?.roomsTitleLabel.textColor = UIColor.darkText
                cell?.countshowLabel.textColor = UIColor.darkText
                
                cell?.roomsTitleLabel.font = UIFont(name:"Circular-Book", size: 18.0)
                cell?.countValue = 1
                cell?.plusBtn.tag = indexPath.row
                cell?.minusBtn.tag = indexPath.row
                cell?.tag = indexPath.row + 100
                cell?.plusBtn.addTarget(self, action: #selector(self.plusBtnTapped(sender:)), for: .touchUpInside)
                cell?.minusBtn.addTarget(self, action: #selector(self.minusBtnTapped(sender:)), for: .touchUpInside)
                cell?.selectionStyle = .none
                cell?.plusBtn.layer.cornerRadius = (cell?.plusBtn.frame.size.width)!/2
                cell?.plusBtn.layer.borderWidth = 1.0
                cell?.plusBtn.layer.borderColor = Theme.PRIMARY_COLOR.cgColor
                cell?.minusBtn.layer.cornerRadius = (cell?.minusBtn.frame.size.width)!/2
                cell?.minusBtn.layer.borderWidth = 1.0
                cell?.minusBtn.layer.borderColor = Theme.PRIMARY_COLOR.cgColor
                return cell!
            }else
            {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldcell", for: indexPath) as? TextFieldCell
                cell?.queryTitleLbl.text = "\(Utility.shared.getLanguage()?.value(forKey: "Place_kind")as! String)"
                cell?.txtField.attributedPlaceholder = NSAttributedString(string: bathroomTypeLbl,
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkText])
                cell?.selectionStyle = .none
                cell?.tag = indexPath.row + 200
                cell?.step1Height.constant = 0
                cell?.stepnumberLbl.isHidden = true
                cell?.selectionStyle = .none
                let toolBar = UIToolbar().ToolbarPikerSelect(mySelect: #selector(dismissgenderPicker))
                cell?.txtField.inputAccessoryView = toolBar
                cell?.txtField.inputView = inputListView
                cell?.txtField.tag = 1
                cell?.txtField.delegate = self
                return cell!
                
//
//                cell?.textField.text = bathroomTypeLbl
//                cell?.tag = indexPath.row + 200
//                cell?.selectionStyle = .none
//                let toolBar = UIToolbar().ToolbarPikerSelect(mySelect: #selector(dismissgenderPicker))
//                cell?.textField.inputAccessoryView = toolBar
//                cell?.textField.inputView = inputListView
//                cell?.textField.tag = 1
//                cell?.textField.delegate = self
//                cell?.selectionStyle = .none
//                return cell!
                
            }
            
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1
        {
            selectedTextfield = 1
            if !bathroomTypeLbl.isEmpty
            {
                let index = bathroomTypeArr.index(where: { (item) -> Bool in
                    item == bathroomTypeLbl
                })
                pickerView.selectRow(index!, inComponent: 0, animated: true)
            }
        }
        pickerView.reloadAllComponents()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0)
        {
            return 70
        }
        return 100
    }
    
    //MARK: - Increment and decrement actions
    
    @objc func plusBtnTapped(sender : UIButton)
    {
        if let cell = view.viewWithTag(sender.tag + 100) as? RoomsCell
        {
            if bathroomsArr.count > 0
            {
                if Float(cell.countshowLabel.text!)! >= bathroomsArr.last! && sender.tag == 0
                {
                    cell.plusBtn.isEnabled = false
                    cell.plusBtn.isUserInteractionEnabled = false
                }else{
                    cell.countshowLabel.text = "\((Double(cell.countshowLabel.text!)! + 0.5))"
                    bathroomsCount = Float(cell.countshowLabel.text!)!
                    cell.plusBtn.isEnabled = true
                    cell.plusBtn.isUserInteractionEnabled = true
                    cell.minusBtn.isUserInteractionEnabled = true
                    cell.minusBtn.isEnabled = true
                    bathroomJSONValue = Float(cell.countshowLabel.text!)!
                    if (Double(cell.countshowLabel.text!)!) > 1.0
                    {
                        let array = cell.countshowLabel.text!.components(separatedBy: ".")
                        if array[1].contains("0")
                        {
                            cell.roomsTitleLabel.text = "\(array[0]) \(Utility.shared.getLanguage()?.value(forKey: "bathrooms")as! String)"
                            cell.countshowLabel.text! = array[0]
                        }else{
                            cell.roomsTitleLabel.text = "\(cell.countshowLabel.text!) \(Utility.shared.getLanguage()?.value(forKey: "bathrooms")as! String)"
                        }
                    }else{
                        let array = cell.countshowLabel.text!.components(separatedBy: ".")
                        if array[1].contains("0")
                        {
                            cell.roomsTitleLabel.text = "\(array[0]) \(Utility.shared.getLanguage()?.value(forKey: "bathroom")as! String)"
                            cell.countshowLabel.text! = array[0]
                        }else{
                            cell.roomsTitleLabel.text = "\(cell.countshowLabel.text!) \(Utility.shared.getLanguage()?.value(forKey: "bathroom")as! String)"
                        }
                    }
                }
            }
        }
    }
    
    @objc func minusBtnTapped(sender : UIButton)
    {
        if let cell = view.viewWithTag(sender.tag + 100) as? RoomsCell
        {
            if Float(cell.countshowLabel.text!)! <= bathroomsArr.first! && sender.tag == 0
            {
                cell.minusBtn.isEnabled = false
                cell.minusBtn.isUserInteractionEnabled = false
            }else{

                cell.countshowLabel.text = "\((Double(cell.countshowLabel.text!)! - 0.5))"
                bathroomsCount = Float(cell.countshowLabel.text!)!
                cell.minusBtn.isEnabled = true
                cell.minusBtn.isUserInteractionEnabled = true
                cell.plusBtn.isEnabled = true
                cell.plusBtn.isUserInteractionEnabled = true
                bathroomJSONValue = Float(cell.countshowLabel.text!)!
                if (Double(cell.countshowLabel.text!)!) > 1.0
                {
                    let array = cell.countshowLabel.text!.components(separatedBy: ".")
                    if array[1].contains("0")
                    {
                        cell.roomsTitleLabel.text = "\(array[0]) \(Utility.shared.getLanguage()?.value(forKey: "bathrooms")as! String)"
                        cell.countshowLabel.text! = array[0]
                    }else{
                        cell.roomsTitleLabel.text = "\(cell.countshowLabel.text!) \(Utility.shared.getLanguage()?.value(forKey: "bathrooms")as! String)"
                    }
                }else{
                    
                    let array = cell.countshowLabel.text!.components(separatedBy: ".")
                    if array[1].contains("0")
                    {
                        cell.roomsTitleLabel.text = "\(array[0]) \(Utility.shared.getLanguage()?.value(forKey: "bathroom")as! String)"
                        cell.countshowLabel.text! = array[0]
                    }else{
                        cell.roomsTitleLabel.text = "\(cell.countshowLabel.text!) \(Utility.shared.getLanguage()?.value(forKey: "bathroom")as! String)"
                    }
                }
            }
        }
        
    }
    
    //MARK: - UIPickerViewDelegate and Datasource
    
    override func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if selectedTextfield == 1
        {
            return bathroomTypeArr.count
        }
        else{
            return 0
        }
    }
    
    override func pickerView( _ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var titleData = ""
        
        if selectedTextfield == 1
        {
            titleData = bathroomTypeArr[row]
        }
        
        let myTitle = NSAttributedString(string: titleData , attributes: [NSAttributedString.Key.font:UIFont(name:"Circular-Book", size: 15.0)!,NSAttributedString.Key.foregroundColor:Theme.PRIMARY_COLOR])
        return myTitle
    }
    
    override func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent  component: Int) {
        
        if selectedTextfield == 1
        {
            bathroomTypeLbl = bathroomTypeArr[row]
        }
        pickerView.selectRow(row, inComponent: component, animated: true)
        Utility.shared.step1ValuesInfo.updateValue((Utility.shared.getListSettingsArray.bathroomType?.listSettings![row]!.id!)!, forKey: "bathroomType")
    }
    
    //MARK: - UITextFieldDelegates
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        selectedTextfield = textField.tag
        if !bathroomTypeLbl.isEmpty
        {
            let index = bathroomTypeArr.index(where: { (item) -> Bool in
                item == bathroomTypeLbl
            })
            pickerView.selectRow(index!, inComponent: 0, animated: true)
        }
        pickerView.reloadAllComponents()
    }
    
    override func textFieldDidEndEditing(_ textField: UITextField) {
        tableView.reloadData()
        view.endEditing(true)
    }
    
}

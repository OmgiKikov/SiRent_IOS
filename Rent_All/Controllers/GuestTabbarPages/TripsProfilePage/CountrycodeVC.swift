//
//  CountrycodeVC.swift
//  Rent_All
//
//  Created by RadicalStart on 09/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Lottie

protocol CountryDelegate {
    func setSelectedCountry(selectedCountry : String, selectedcountryCode : String,selectdialcode : String)
}

class CountrycodeVC: UIViewController,UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate {
   
    
    //IBOutlets
    @IBOutlet weak var countryTable: UITableView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var label: UILabel!
     @IBOutlet var bottomConstraint: NSLayoutConstraint!
    //This property
    var countrycodeArray = [GetCountrycodeQuery.Data.GetCountry.Result]()
    var titleForHeader = "\((Utility.shared.getLanguage()?.value(forKey:"selectcountry"))!)"
    var tabFilterData = [[String : Any]]()
    var countryStringArr = [String]()
    var lottieView: LOTAnimationView!
    var delegate : CountryDelegate?
    
    //MARK: - ViewController Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//        let toolBar = UIToolbar().ToolbarPikerSelect(mySelect: #selector(dismissview))
//              searchTF.inputAccessoryView = toolBar
        searchTF.addTarget(self, action: #selector(CountrycodeVC.textFieldDidChange(_:)),
        for: UIControl.Event.editingChanged)
        self.initialSetup()
        self.CountryAPICAll()
         self.lottieAnimation()
    }
    @objc func dismissview() {
           view.endEditing(true)
           
       }
    
    //MARK: - Initial Set up
    func initialSetup()
    {
        self.topView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height: 64)
        self.countryTable.frame = CGRect(x: 0, y: 64, width: FULLWIDTH, height: FULLHEIGHT-64)
        countryTable.register(UINib(nibName: "EditAboutCell", bundle: nil), forCellReuseIdentifier: "EditAboutCell")
        
//        let toolBar = UIToolbar().ToolbarPikerSelect(mySelect: #selector(dismissPicker))
//        searchTF.inputAccessoryView = toolBar
        searchTF.delegate = self
        searchTF.keyboardType = .asciiCapable
        searchTF.autocorrectionType = .no
        searchTF.becomeFirstResponder()
        IQKeyboardManager.shared.enable = true
         IQKeyboardManager.shared.enableAutoToolbar = false
        searchTF.placeholder = "\((Utility.shared.getLanguage()?.value(forKey:"searchhere"))!)"
    }
    @objc func keyboardWillShow(sender: NSNotification) {
         let info = sender.userInfo!
         let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
         let keyboardHeight = keyboardFrame.height
      bottomConstraint.constant = keyboardHeight
         
     }
     
     @objc func keyboardWillHide(sender: NSNotification) {
    
         
     }

    @IBAction func closeBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func CountryAPICAll()
    {
        let getcountrycodeQuery = GetCountrycodeQuery()
        apollo.fetch(query: getcountrycodeQuery){(result,error) in
            guard (result?.data?.getCountries?.results) != nil else{
                print("Missing Data")
                return
            }
            self.countrycodeArray =  ((result?.data?.getCountries?.results)!) as! [GetCountrycodeQuery.Data.GetCountry.Result]
             self.lottieView.isHidden = true
            self.countryTable.reloadData()
           
            
        }
    }
    
    @objc func dismissPicker()
    {
        self.dismiss(animated: true, completion: nil)
        
        
    }
    func lottieAnimation(){
        lottieView = LOTAnimationView.init(name:"animation")
        lottieView.isHidden = false
        self.lottieView.frame = CGRect(x:FULLWIDTH/2-40, y:FULLHEIGHT/2-150, width:100, height:100)
        self.countryTable.addSubview(self.lottieView)
        self.lottieView.backgroundColor = UIColor.clear
        self.lottieView.layer.cornerRadius = 6.0
        self.lottieView.clipsToBounds = true
        self.lottieView.play()
        Timer.scheduledTimer(timeInterval:0.3, target: self, selector: #selector(autoscroll), userInfo: nil, repeats: true)
    }
    @objc func autoscroll()
    {
        self.lottieView.play()
    }
    //MARK: - TABLEVIEW DELEGATE & DATASOURCE METHODS
    func numberOfSections(in tableView: UITableView) -> Int {
        if(countrycodeArray.count > 0)
        {
            return 1
        }
        else{
            return 0
        }
        
    }
    
    func tableView( _ tableView : UITableView,  titleForHeaderInSection section: Int)->String?
    {
        if(section == 0)
        {
            if(countrycodeArray.count > 0)
            {
                if !Utility.shared.isPhonenumberCountrycode
                {
                    return titleForHeader
                }
                return "\((Utility.shared.getLanguage()?.value(forKey:"regionnumber"))!)"
            }
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        
        let headerLabel = UILabel(frame: CGRect(x: 20, y:10, width:FULLWIDTH-35, height: 40))
        headerLabel.font = UIFont(name: "Circular-Medium", size:23)
        headerLabel.textColor = UIColor.black
        headerLabel.numberOfLines = 4
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section==0){
            
            if(countrycodeArray.count > 0)
            {
                if titleForHeader == "\((Utility.shared.getLanguage()?.value(forKey:"selectcountry"))!)"
                               {
            return 60
                }
                else
                {
                    return 80
                }
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !(searchTF.text!.isEmpty) && tabFilterData.count > 0
        {
            return tabFilterData.count
        }
        if(countrycodeArray.count > 0)
        {
            return countrycodeArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditAboutCell", for: indexPath)as! EditAboutCell
        cell.phoneLabel.isHidden = true
        cell.rightArrowimg.isHidden = true
        cell.editLabel.isHidden = true
        cell.selectionStyle = .none
        if titleForHeader == "\((Utility.shared.getLanguage()?.value(forKey:"selectcountry"))!)"
        {
            if !(searchTF.text!.isEmpty) && tabFilterData.count > 0 && (indexPath.row < tabFilterData.count)
            {
               
                cell.aboutLabel.text = "\(tabFilterData[indexPath.row]["countryName"] ?? "")"
                
            }else{
                cell.aboutLabel.text = "\(countrycodeArray[indexPath.row].countryName!)"
            }
        }else{
            cell.aboutLabel.text = "\(countrycodeArray[indexPath.row].countryName!)"
            //\((countrycodeArray[indexPath.row].dialCode!))"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if titleForHeader == "\((Utility.shared.getLanguage()?.value(forKey:"selectcountry"))!)"
        {
            if !(searchTF.text!.isEmpty) && tabFilterData.count > 0
            {
                delegate?.setSelectedCountry(selectedCountry: tabFilterData[indexPath.row]["countryName"] as! String, selectedcountryCode: tabFilterData[indexPath.row]["countryCode"] as! String, selectdialcode: tabFilterData[indexPath.row]["countrydialcode"] as! String)
            }else{
                delegate?.setSelectedCountry(selectedCountry: countrycodeArray[indexPath.row].countryName!, selectedcountryCode: countrycodeArray[indexPath.row].countryCode!, selectdialcode: countrycodeArray[indexPath.row].dialCode!)
                
            }
        }
        else
        {
          if !(searchTF.text!.isEmpty) && tabFilterData.count > 0
            {
                delegate?.setSelectedCountry(selectedCountry: tabFilterData[indexPath.row]["countryName"] as! String, selectedcountryCode: tabFilterData[indexPath.row]["countryCode"] as! String, selectdialcode:  tabFilterData[indexPath.row]["countrydialcode"] as! String)
            }else{
            delegate?.setSelectedCountry(selectedCountry: countrycodeArray[indexPath.row].countryName!, selectedcountryCode: countrycodeArray[indexPath.row].countryCode!, selectdialcode: countrycodeArray[indexPath.row].dialCode!)
                
            }
            
        }
        self.dismiss(animated: true, completion: nil)

    }
    
    //MARK: - UIText Field Delegate
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        tabFilterData.removeAll()
//    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if(textField.text!.count == 0)
        {
         countryTable.isHidden = false
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let searchText  = (textField.text?.trimmingCharacters(in: .whitespaces))! + string
        let newString = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
       
             tabFilterData.removeAll()
//        let  char = string.cStringUsingEncoding(NSUTF8StringEncoding)!
//        let isBackSpace = strcmp(char, "\\b")
//
//        if (isBackSpace == -92) {
//            println("Backspace was pressed")
//        }
//
        
        print(newString.count, range.length , string.count)
        if !(newString.count <= 0) {
            countryTable.isHidden = false
            
            for index in 0..<countrycodeArray.count
            {
                if ((countrycodeArray[index].countryName!).lowercased().contains(searchText) || (countrycodeArray[index].countryName!).contains(searchText))
                {
                    var countryInfo = [String : Any]()
                    countryInfo.updateValue(countrycodeArray[index].countryName!, forKey: "countryName")
                    countryInfo.updateValue(countrycodeArray[index].countryCode!, forKey: "countryCode")
                    countryInfo.updateValue(countrycodeArray[index].dialCode!, forKey: "countrydialcode")
                    tabFilterData.append(countryInfo)
                    countryTable.isHidden = false
                       lottieView.isHidden = true
                }
            }
            
            if tabFilterData.count == 0 && newString.isBlank == false
            {
                     lottieView.isHidden = true
                countryTable.isHidden = true
                label.text = "\((Utility.shared.getLanguage()?.value(forKey:"notfound"))!)"
            }
            countryTable.reloadData()
        }
        else{
            tabFilterData = []
            countryTable.reloadData()
        }
        return true
    }
    

}
extension UITextField {
    
    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {

        if action == #selector(UIResponderStandardEditActions.select(_:)) ||  action == #selector(UIResponderStandardEditActions.selectAll(_:))  || action == #selector(UIResponderStandardEditActions.cut(_:))  ||  action == #selector(UIResponderStandardEditActions.copy(_:))  || action == #selector(UIResponderStandardEditActions.paste(_:)) || action == #selector(UIResponderStandardEditActions.responds(to:)) {
            return false
        }else{
            return super.canPerformAction(action, withSender: sender)
        }
    }
    var noText: Bool {
          return text?.isEmpty ?? true
      }
    
}


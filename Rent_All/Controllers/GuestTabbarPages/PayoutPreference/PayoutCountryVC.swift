//
//  PayoutCountryVC.swift
//  Rent_All
//
//  Created by RadicalStart on 19/08/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class PayoutCountryVC: UIViewController,CountryDelegate {
    
    func setSelectedCountry(selectedCountry: String, selectedcountryCode: String, selectdialcode: String) {
         Utility.shared.selected_Countrycode_Payout = selectedcountryCode
        country = selectedCountry
    }
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var selectcountryLabel: UILabel!
    
    @IBOutlet weak var nextbtnImage: UIImageView!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var changeBtn: UIButton!
    @IBOutlet weak var countryLabel: UILabel!
    var country = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialsetup()

        // Do any additional setup after loading the view.
    }

    
    func initialsetup()
    {
        self.continueBtn.layer.cornerRadius = 22.0
        self.continueBtn.layer.masksToBounds = true
        self.nextbtnImage.image = self.nextbtnImage.image?.withRenderingMode(.alwaysTemplate)
        self.nextbtnImage.tintColor = .white
        changeBtn.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
       continueBtn.backgroundColor = Theme.PRIMARY_COLOR
        Utility.shared.selected_Countrycode_Payout = "US"
        country = "\((Utility.shared.getLanguage()?.value(forKey:"unitedstates"))!)"
        changeBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"change"))!)", for:.normal)
       continueBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"next"))!)", for:.normal)
        selectcountryLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"selectcountryregion"))!)"
    }
    override func viewWillAppear(_ animated: Bool) {
        countryLabel.text = country
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueBtnTapped(_ sender: Any) {
        let payaddressObj = PayoutAddressVC()
        payaddressObj.countryText = countryLabel.text!
        payaddressObj.modalPresentationStyle = .fullScreen
        self.present(payaddressObj, animated: true, completion: nil)
    }
    @IBAction func changeBtnTapped(_ sender: Any) {
        
        let countryList = CountrycodeVC()
        Utility.shared.isPhonenumberCountrycode = false
        countryList.titleForHeader = "\((Utility.shared.getLanguage()?.value(forKey:"selectcountry"))!)"
        countryList.delegate = self
        countryList.modalPresentationStyle = .fullScreen
        self.present(countryList, animated: true, completion: nil)
      
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

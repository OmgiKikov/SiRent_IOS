//
//  CalendarDetailVC.swift
//  Rent_All
//
//  Created by RadicalStart on 10/08/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

protocol CalendarDetailVCDelegate {
    // func manageListingAPICall()
    func BlockedlistAPICall(listId:Int)
    func APICall(listImage:String,title:String,entireTitle:String,listId:Int)
    
}

class CalendarDetailVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "CalendarDetailVC", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    // MARK: - IBOUTLET CONNECTIONS & VARIABLE DECLARATIONS

    @IBOutlet weak var nodetailLabel: UILabel!
    @IBOutlet weak var noView: UIView!
    @IBOutlet weak var calendarDetailTable: UITableView!
    @IBOutlet weak var topView: UIView!
    var listId = Int()
    var listImage = String()
    var title_val = String()
    var entireTitle = String()
    var delegate:CalendarDetailVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialsetup()

        // Do any additional setup after loading the view.
    }
    
    func initialsetup()
    {
     self.calendarDetailTable.register(UINib(nibName: "CalendardetailCell", bundle: nil), forCellReuseIdentifier: "CalendardetailCell")
        
        
        if(Utility.shared.host_blockedDates_Array.count == 0 && Utility.shared.host_bookedPricing_Array.count == 0 && Utility.shared.host_specialPricing_Array.count == 0)
        {
            self.noView.isHidden = false
        }
        else
        {
          self.noView.isHidden = true
        }
        
        let shadowSize : CGFloat = 3.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.topView.frame.size.width+40 + shadowSize,
                                                   height: self.topView.frame.size.height + shadowSize))
        
        
        self.topView.layer.masksToBounds = false
        self.topView.layer.shadowColor = TextLightColor.cgColor
        self.topView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.topView.layer.shadowOpacity = 0.3
        self.topView.layer.shadowPath = shadowPath.cgPath
        nodetailLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"dontcalendardetail"))!)"
    
    }
    @IBAction func closeBtnTapped(_ sender: Any) {
        
        Utility.shared.isfrom_availability_calendar_date = true
        Utility.shared.isfrom_availability_calendar = true
        self.delegate?.BlockedlistAPICall(listId: self.listId)
        self.delegate?.APICall(listImage: self.listImage, title: self.title_val, entireTitle: self.entireTitle, listId: self.listId)
        self.dismiss(animated: true, completion: nil)

    }
     // MARK: - TABLEVIEW DELEGATE & DATASOURCE METHODS
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0)
        {
            if(Utility.shared.host_bookedPricing_Array.count > 0)
            {
                return Utility.shared.host_bookedPricing_Array.count
            }
            return 0
        }
        else if(section == 1)
        {
            if(Utility.shared.host_specialPricing_Array.count > 0)
            {
                return Utility.shared.host_specialPricing_Array.count
            }
            return 0
        }
        else
        {
            if(Utility.shared.host_blockedDates_Array.count > 0)
            {
                return Utility.shared.host_blockedDates_Array.count
            }
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView( _ tableView : UITableView,  titleForHeaderInSection section: Int)->String?
    {
        if(section == 0){
            if(Utility.shared.host_bookedPricing_Array.count > 0)
            {
            return "\((Utility.shared.getLanguage()?.value(forKey:"bookeddates"))!)"
            }
            return ""
        }
        else if(section == 1 ){
            if(Utility.shared.host_specialPricing_Array.count > 0)
            {
            return "\((Utility.shared.getLanguage()?.value(forKey:"availabledates"))!)"
            }
            return ""
        }
        else if(section == 2){
            if(Utility.shared.host_blockedDates_Array.count > 0)
            {
            return "\((Utility.shared.getLanguage()?.value(forKey:"notavailabledates"))!)"
            }
            return ""
        }
        
        return ""
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if(Utility.shared.host_blockedDates_Array.count > 0 || Utility.shared.host_bookedPricing_Array.count > 0 || Utility.shared.host_specialPricing_Array.count > 0)
       {
        return 3
        }
     //  else{
//        if(Utility.shared.host_blockedDates_Array.count > 0 && Utility.shared.host_bookedPricing_Array.count > 0)
//        {
//            return 2
//        }
//        else if(Utility.shared.host_specialPricing_Array.count > 0 && Utility.shared.host_bookedPricing_Array.count > 0)
//        {
//            return 2
//        }
//        else if(Utility.shared.host_specialPricing_Array.count > 0 && Utility.shared.host_blockedDates_Array.count > 0)
//        {
//            return 2
//        }
//        else if(Utility.shared.host_blockedDates_Array.count > 0)
//        {
//            return 1
//        }
//        else if(Utility.shared.host_specialPricing_Array.count > 0)
//        {
//            return 1
//        }
//        else if(Utility.shared.host_bookedPricing_Array.count > 0)
//        {
//            return 1
//        }
        
        
       // }
        return 0
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if(section == 0)
        {
            if(Utility.shared.host_bookedPricing_Array.count > 0)
            {
                return 30
            }
            else
            {
            return CGFloat.leastNormalMagnitude
            }
        
        }
        else if(section == 1)
        {
            if(Utility.shared.host_specialPricing_Array.count > 0)
            {
                return 25
            }
            else
            {
            return CGFloat.leastNormalMagnitude
            }
            
        }
        else
        {
            if(Utility.shared.host_blockedDates_Array.count > 0)
            {
                return 25
            }
            else
            {
            return CGFloat.leastNormalMagnitude
            }
            
        }
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        
    
        
        let headerLabel = UILabel(frame: CGRect(x:25, y:-5, width:
            tableView.bounds.size.width, height:30))
        headerLabel.font = UIFont(name: "Circular-Medium", size:22)
        headerLabel.textColor = UIColor.black
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0)
        {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalendardetailCell", for: indexPath) as! CalendardetailCell
        cell.AvailableLabel.text = ""
        cell.dateLabel.text = "\(Utility.shared.host_bookedPricing_Array[indexPath.row])"
        cell.dayLabel.text = "\(Utility.shared.host_bookDay_Array[indexPath.row])"
        cell.priceLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"booked"))!)"
        cell.priceLabel.textColor = cell.AvailableLabel.textColor
       // cell.priceLabel.isHidden = true
        
        return cell
        }
        else if(indexPath.section == 1)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalendardetailCell", for: indexPath) as! CalendardetailCell
            cell.AvailableLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"available"))!)"
            cell.priceLabel.isHidden = false
           // cell.AvailableLabel.textColor = SPECIAL_PRICING_COLOR
            cell.dateLabel.text = "\(Utility.shared.host_specialPricing_Array[indexPath.row])"
            cell.dayLabel.text = "\(Utility.shared.host_specialDay_Array[indexPath.row])"
            if(Utility.shared.getPreferredCurrency() != nil && Utility.shared.getPreferredCurrency() != "")
            {
                let currencysymbol = Utility.shared.getSymbol(forCurrencyCode: Utility.shared.getPreferredCurrency()!)
                let from_currency = "\(Utility.shared.host_currency_Array[indexPath.row])"
                let currency_amount = Utility.shared.host_specialPrice_value_Array[indexPath.row]
                let price_value = self.getCurrencyRate(basecurrency:Utility.shared.currencyvalue_from_API_base, fromCurrency:from_currency, toCurrency:Utility.shared.getPreferredCurrency()!, CurrencyRate:Utility.shared.currency_Dict, amount:currency_amount as! Double)
                let restricted_price =  Double(String(format: "%.2f",price_value))
                cell.priceLabel.text =  "\(currencysymbol!)\(restricted_price!.clean)"
                cell.priceLabel.textColor = Theme.PRIMARY_COLOR
            }
            else
            {
                let currencysymbol = Utility.shared.getSymbol(forCurrencyCode:Utility.shared.host_currency_Array[indexPath.row] as! String)
                let from_currency = "\(Utility.shared.host_currency_Array[indexPath.row])"
                let currency_amount = Utility.shared.host_specialPrice_value_Array[indexPath.row]
                let price_value = self.getCurrencyRate(basecurrency:Utility.shared.currencyvalue_from_API_base, fromCurrency:from_currency, toCurrency:Utility.shared.currencyvalue_from_API_base, CurrencyRate:Utility.shared.currency_Dict, amount:currency_amount as! Double)
                let restricted_price =  Double(String(format: "%.2f",price_value))
                cell.priceLabel.text = "\(currencysymbol!)\(restricted_price!.clean)"
                cell.priceLabel.textColor = Theme.PRIMARY_COLOR
            }
          //  cell.priceLabel.text = "\(Utility.shared.host_specialPrice_value_Array[indexPath.row])"
            return cell
        }
       else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalendardetailCell", for: indexPath) as! CalendardetailCell
            cell.AvailableLabel.text = ""
            //cell.AvailableLabel.textColor = Red_color
            cell.dateLabel.text = "\(Utility.shared.host_blockedDates_Array[indexPath.row])"
            cell.dayLabel.text = "\(Utility.shared.hosr_blockDay_Array[indexPath.row])"
            cell.priceLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"notavailable"))!)"
            cell.priceLabel.textColor = cell.AvailableLabel.textColor
            //cell.priceLabel.isHidden = true
            return cell
        }
        
    }
    
    func getCurrencyRate(basecurrency:String,fromCurrency:String,toCurrency:String,CurrencyRate:NSDictionary,amount:Double) -> Double
    {
        if(fromCurrency == basecurrency)
        {
            return (CurrencyRate.object(forKey: toCurrency) as! Double) * (amount)
        }
        else if(toCurrency == basecurrency)
        {
            return  (1 / (CurrencyRate.object(forKey: fromCurrency)as! Double) * (amount))
        }
        else{
            return amount * ((CurrencyRate.object(forKey: toCurrency)as! Double) * ((1 / (CurrencyRate.object(forKey: fromCurrency)as! Double))))
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

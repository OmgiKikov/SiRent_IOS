//
//  ReceiptVC.swift
//  Rent_All
//
//  Created by RadicalStart on 03/06/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import WebKit
import PDFKit
import MKToolTip

@available(iOS 11.0, *)
class ReceiptVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UIDocumentInteractionControllerDelegate,UIPrintInteractionControllerDelegate{
    
    

    @IBOutlet weak var receiptTable: UITableView!
    @IBOutlet weak var topView: UIView!
    var documentInteractionController: UIDocumentInteractionController!
    
    var getReservationArray = GetReservationQuery.Data.GetReservation.Result()
     var getbillingArray = GetBillingCalculationQuery.Data.GetBillingCalculation.Result()
    var getReservation_currencyArray = GetReservationQuery.Data.GetReservation()
    var totalPriceLabel = String()
    var currencyvalue_from_API_base = String()
    var ISfromShortcut = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialsetup()
        receiptTable.reloadData()
        let pdfFilePath = self.receiptTable.exportAsPdfFromTable()
        let url = URL(fileURLWithPath:pdfFilePath)
        self.documentInteractionController = UIDocumentInteractionController.init(url: url)
        self.documentInteractionController?.delegate = self
        //self.documentInteractionController?.presentPreview(animated: true)
        if UIPrintInteractionController.canPrint(url) {
            let printInfo = UIPrintInfo(dictionary: nil)
            printInfo.jobName = url.lastPathComponent
            printInfo.outputType = .photo
            let printController = UIPrintInteractionController.shared
            printController.printInfo = printInfo
            printController.showsNumberOfCopies = false
            printController.delegate = self
            printController.printingItem = url
            printController.present(animated:true, completionHandler: nil)
        }
        self.receiptTable.isHidden = true
//
//        let state = UIApplication.shared.applicationState
//        if state == .background || state == .inactive {
//            // background
//        } else if state == .active {
//            // foreground
//        }
//
//        switch UIApplication.shared.applicationState {
//            case .background, .inactive:
//                // background
//            print("Inactive")
//            break
//            case .active:
//                // foreground
//            print("Active")
//                       break
//            default:
//                break
//        }
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(AppBackGround), name: UIApplication.willEnterForegroundNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    @objc func AppBackGround(){
        print("App in background")
       // self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func backbtnTapped(_ sender: Any) {
    self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    func printInteractionControllerDidDismissPrinterOptions(_ printInteractionController: UIPrintInteractionController)
    {

        self.presentingViewController?.dismiss(animated: false, completion: {
            Utility.shared.isreceiptAccepted = true
            Utility.shared.isreceiptAcceptedHost = true
        })
    }
        
        func printInteractionControllerWillDismissPrinterOptions(_ printInteractionController: UIPrintInteractionController) {
            self.presentingViewController?.dismiss(animated: false, completion: {
                Utility.shared.isreceiptAccepted = true
                Utility.shared.isreceiptAcceptedHost = true
            })
         
        }
    
    
    func initialsetup()
    {
        if IS_IPHONE_XR || IS_IPHONE_X
        {
            self.topView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH-40, height: 80)
            receiptTable.frame = CGRect(x: 0, y: 85, width: FULLWIDTH-40, height: FULLHEIGHT-300)
            
        }
        
        let shadowSize : CGFloat = 3.0
        
        let shadowPath1 = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                    y: -shadowSize / 2,
                                                    width: self.topView.frame.size.width+40 + shadowSize,
                                                    height: self.topView.frame.size.height + shadowSize))
        
        self.topView.layer.masksToBounds = false
        self.topView.layer.shadowColor = TextLightColor.cgColor
        self.topView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.topView.layer.shadowOpacity = 0.3
        self.topView.layer.shadowPath = shadowPath1.cgPath
        receiptTable.register(UINib(nibName: "customerReceiptCell", bundle: nil), forCellReuseIdentifier: "customerReceiptCell")
        receiptTable.register(UINib(nibName: "NameReceiptCell", bundle: nil), forCellReuseIdentifier: "NameReceiptCell")
         receiptTable.register(UINib(nibName: "AccommadationCell", bundle: nil), forCellReuseIdentifier: "AccommadationCell")
         receiptTable.register(UINib(nibName: "ItenarycheckCell", bundle: nil), forCellReuseIdentifier: "ItenarycheckCell")
         receiptTable.register(UINib(nibName: "RequestBookcellTableViewCell", bundle: nil), forCellReuseIdentifier: "RequestBookcellTableViewCell")
         receiptTable.register(UINib(nibName: "BookingTotalCell", bundle: nil), forCellReuseIdentifier: "BookingTotalCell")
        receiptTable.register(UINib(nibName: "RentpaymentReceiptCell", bundle: nil), forCellReuseIdentifier: "RentpaymentReceiptCell")
        receiptTable.register(UINib(nibName: "ReservationCell", bundle: nil), forCellReuseIdentifier: "ReservationCell")
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
       
        return 8
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 5)
        {
            if(getReservationArray.cleaningPrice == 0)
            {
                if(getReservationArray.discountType != nil && getReservationArray.discount != 0)
                {
                    return 3
                }
                return 2
                
            }
            else
            {
                if(getReservationArray.discountType != nil && getReservationArray.discount != 0)
                {
                    return 4
                }
                return 3
            }
        }
            
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0)
        {
            return 195
        }
        else if(indexPath.section == 1)
        {
            return 340
        }
        else if(indexPath.section == 2)
        {
           // return 225
            return UITableView.automaticDimension
        }
        else if(indexPath.section == 3)
        {
            return 155
        }
        else if(indexPath.section == 4)
        {
            return 45
        }
        else if(indexPath.section == 5)
        {
            return 55
        }
        else if(indexPath.section == 6)
        {
            return 100
        }
        else if(indexPath.section == 7)
        {
            return 450
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "customerReceiptCell", for: indexPath)as! customerReceiptCell
            cell.receiptNumberLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"receipt"))!) #\(getReservationArray.id!)"
            cell.confirmCodeLAbel.text = "\((Utility.shared.getLanguage()?.value(forKey:"confirmationcode"))!) \(getReservationArray.confirmationCode!)"
            let timestamValue = Int(getReservationArray.createdAt!)!/1000
            let showDate = Date(timeIntervalSince1970:TimeInterval(timestamValue))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            dateFormatter.locale = NSLocale(localeIdentifier:Utility.shared.getAppLanguageCode()!) as Locale
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "EEE"
            dateFormatter1.locale = NSLocale(localeIdentifier:Utility.shared.getAppLanguageCode()!) as Locale
            let day = dateFormatter1.string(from: showDate)
            let date = dateFormatter.string(from: showDate)
            cell.dateLabel.text = "\(day), \(date)"
            cell.selectionStyle = .none
            return cell
        }
        if(indexPath.section == 1)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NameReceiptCell", for: indexPath)as! NameReceiptCell
            cell.selectionStyle = .none
            cell.nameLabel.text = getReservationArray.guestData?.displayName!
            cell.destinationLabel.text = getReservationArray.listData?.city!
            cell.durationLbel.text = "\(getReservationArray.nights!) \((Utility.shared.getLanguage()?.value(forKey:"night"))!)\(getReservationArray.nights! > 1 ? "s" : "")"
            cell.accomadationLabel.text = getReservationArray.listData?.roomType!
            
            return cell
        }
        if(indexPath.section == 2)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccommadationCell", for: indexPath)as! AccommadationCell
            cell.selectionStyle = .none
            cell.listName.text = "\((getReservationArray.listData?.title!)!)"
            cell.listName.numberOfLines = 2
            cell.addressLAbel.text = "\((getReservationArray.listData?.street!)!), \((getReservationArray.listData?.city!)!), \((getReservationArray.listData?.state!)!), \((getReservationArray.listData?.country!)!), \((getReservationArray.listData?.zipcode!)!)"
            cell.hostnameLabel.text = getReservationArray.hostData?.displayName!
            cell.listName.text = getReservationArray.listData?.title!
            return cell
        }
        if(indexPath.section == 3)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItenarycheckCell", for: indexPath)as! ItenarycheckCell
            cell.selectionStyle = .none
            let day = getdayValue(timestamp: getReservationArray.checkIn!)
            let date = getdateValue(timestamp: getReservationArray.checkIn!)
            cell.checkinLabel.text = "\(day), \(date)"
            if(getReservationArray.checkInStart != "" && getReservationArray.checkInStart != ""){
            if (getReservationArray.checkInStart == "Flexible" && getReservationArray.checkInEnd == "Flexible" ) {
            
                               cell.checkinTimeLabel.text = "\(getReservationArray.checkInStart!) check in time"
                
            } else if (getReservationArray.checkInStart != "Flexible" && getReservationArray.checkInEnd == "Flexible") {
                let date = conversionRailwaytime(time:(getReservationArray.checkInStart!))
                cell.checkinTimeLabel.text = "From \(date)"
                
            }else if (getReservationArray.checkInStart == "Flexible" && getReservationArray.checkInEnd != "Flexible") {
                let date = conversionRailwaytime(time:(getReservationArray.checkInEnd!))
                               cell.checkinTimeLabel.text = "Upto \(date)"
                
            } else if (getReservationArray.checkInStart != "Flexible" && getReservationArray.checkInEnd != "Flexible") {
                let date = conversionRailwaytime(time:(getReservationArray.checkInStart!))
                let date1 = conversionRailwaytime(time:(getReservationArray.checkInEnd!))
                cell.checkinTimeLabel.text = "\(date) - \(date1)"
                }}else{
                cell.checkinTimeLabel.text = ""
            }
//            if(getReservationArray.listData?.listingData?.checkInStart != "Flexible")
//            {
//                //let day = getdayValue(timestamp:(getReservationArray.listData?.listingData?.checkInStart!)!)
//                let date = conversionRailwaytime(time:(getReservationArray.listData?.listingData?.checkInStart!)!)
//                cell.checkinTimeLabel.text = "\(date)"
//
//            }
//            else
//            {
//            cell.checkinTimeLabel.text = getReservationArray.listData?.listingData?.checkInStart!
//            }
//            if(getReservationArray.listData?.listingData?.checkInEnd != "Flexible")
//            {
//             //   let day = getdayValue(timestamp:(getReservationArray.listData?.listingData?.checkInEnd!)!)
//                let date = conversionRailwaytime(time:(getReservationArray.listData?.listingData?.checkInEnd!)!)
//                cell.checkouttimeLabel.text = "\(date)"
//            }
//            else
//            {
//            cell.checkouttimeLabel.text = getReservationArray.listData?.listingData?.checkInEnd!
//            }
            cell.checkouttimeLabel.text = ""
            let day1 = getdayValue(timestamp: getReservationArray.checkOut!)
            let date1 = getdateValue(timestamp: getReservationArray.checkOut!)
            cell.checkoutLabel.text = "\(day1), \(date1)"
            return cell
        }
       if(indexPath.section == 4)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationCell", for: indexPath)as! ReservationCell
            cell.selectionStyle = .none
            return cell
        }
        if(indexPath.section == 5)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RequestBookcellTableViewCell", for: indexPath)as! RequestBookcellTableViewCell
            cell.selectionStyle = .none
            var currencysymbol = String()
            

            cell.specialImage.isHidden = true
             cell.specialImage.addTarget(self, action: #selector(tooltipBtnTapped),for:.touchUpInside)
            if(getReservationArray.cleaningPrice == 0)
            {
                if(getReservationArray.discountType != nil && getReservationArray.discount != 0)
                {
                    if(indexPath.row == 0)
                    {
                        if(Utility.shared.getPreferredCurrency() != nil && Utility.shared.getPreferredCurrency() != "")
                        {
                            let currencysymbol = Utility.shared.getSymbol(forCurrencyCode: Utility.shared.getPreferredCurrency()!)
                            let from_currency = getReservationArray.currency!
                            var total = Double()
                            if(getReservation_currencyArray.convertedIsSpecialAverage != nil)
                            {
                            total = Double(getReservation_currencyArray.convertedIsSpecialAverage!)
                            }
                            else
                            {
                            total = Double(getReservation_currencyArray.convertedBasePrice!)
                            }
                            if(getReservation_currencyArray.convertedIsSpecialAverage != getReservation_currencyArray.convertedBasePrice)
                            {
                              //  cell.specialImage.isHidden = false
                            }
                           
                            cell.priceLabel.text =  "\(currencysymbol!)\(total.clean) x \(getReservationArray.nights!) \((Utility.shared.getLanguage()?.value(forKey:"night"))!)\(getReservationArray.nights! > 1 ? "s" : "")"
                            let calculated_Price = Double(String(format: "%.2f",(getReservation_currencyArray.convertedTotalNightsAmount!)))
                            cell.priceLeftLabel.text = "\(currencysymbol!)\(calculated_Price!.clean)"
            
                            
                        }
                        else
                        {
                            let currencysymbol = Utility.shared.getSymbol(forCurrencyCode:Utility.shared.currencyvalue_from_API_base)
                            let from_currency = getReservationArray.currency!
                            var total = Double()
                            if(getReservation_currencyArray.convertedIsSpecialAverage != nil)
                            {
                                total = Double(getReservation_currencyArray.convertedIsSpecialAverage!)
                            }
                            else
                            {
                                total = Double(getReservation_currencyArray.convertedBasePrice!)
                            }
                            if(getReservationArray.isSpecialPriceAverage != getReservationArray.basePrice)
                            {
                             //   cell.specialImage.isHidden = false
                            }
                           
                            cell.priceLabel.text =  "\(currencysymbol!)\(total.clean) x \(getReservationArray.nights!) \((Utility.shared.getLanguage()?.value(forKey:"night"))!)\(getReservationArray.nights! > 1 ? "s" : "")"
                            let calculated_Price = Double(String(format: "%.2f",getReservation_currencyArray.convertedTotalNightsAmount!))
                            cell.priceLeftLabel.text = "\(currencysymbol!)\(calculated_Price!.clean)"
                    
                        }

                    }
                    else if(indexPath.row == 1)
                    {
                        cell.priceLabel.text =  "\((Utility.shared.getLanguage()?.value(forKey:"servicefee"))!)"
                        if(Utility.shared.getPreferredCurrency() != nil && Utility.shared.getPreferredCurrency() != "")
                        {
                            let currencysymbol = Utility.shared.getSymbol(forCurrencyCode: Utility.shared.getPreferredCurrency()!)

                            
                            if(!Utility.shared.host_isfrom_hostRecipt)
                            {
                                 let restricted_price =  Double(String(format: "%.2f",getReservation_currencyArray.convertedGuestServicefee!))
                            cell.priceLeftLabel.text = "\(currencysymbol!)\(restricted_price!.clean)"
                            }
                            else
                            {
                                 let restricted_price =  Double(String(format: "%.2f",getReservation_currencyArray.convertedHostServiceFee!))
                              cell.priceLeftLabel.text = "-\(currencysymbol!)\(restricted_price!.clean)"
                            }
        
                        }
                        else
                        {
                            let currencysymbol = Utility.shared.getSymbol(forCurrencyCode:Utility.shared.currencyvalue_from_API_base)

                            
                            if(!Utility.shared.host_isfrom_hostRecipt)
                            {
                                let restricted_price =  Double(String(format: "%.2f",getReservation_currencyArray.convertedGuestServicefee!))
                            cell.priceLeftLabel.text = "\(currencysymbol!)\(restricted_price!.clean)"
                            }
                            else
                            {
                                  let restricted_price =  Double(String(format: "%.2f",getReservation_currencyArray.convertedHostServiceFee!))
                             cell.priceLeftLabel.text = "-\(currencysymbol!)\(restricted_price!.clean)"
                            }
                            
                            
                        }
                        
                       
                    }
                    else{
                        
                        if(Utility.shared.getPreferredCurrency() != nil && Utility.shared.getPreferredCurrency() != "")
                        {
                            let currencysymbol = Utility.shared.getSymbol(forCurrencyCode: Utility.shared.getPreferredCurrency()!)
                            
                           let restricted_price =  Double(String(format: "%.2f",getReservation_currencyArray.convertedDiscount!))
                            cell.priceLeftLabel.text = "-\(currencysymbol!)\(restricted_price!.clean)"
                            cell.priceLabel.text = "\(getReservationArray.discountType!.capitalized)"
                            
                            
                        }
                        else
                        {
                            let currencysymbol = Utility.shared.getSymbol(forCurrencyCode:Utility.shared.currencyvalue_from_API_base)
                            

                            let restricted_price =  Double(String(format: "%.2f",getReservation_currencyArray.convertedDiscount!))
                            cell.priceLeftLabel.text = "-\(currencysymbol!)\(restricted_price!.clean)"
                            cell.priceLabel.text = "\(getReservationArray.discountType!.capitalized)"
                            
                        }
                        
                       // cell.priceLeftLabel.text = "\(getReservationArray.discount!)"
                    }
                    return cell
                }
                else
                {
                    if(indexPath.row == 0)
                    {
                        if(Utility.shared.getPreferredCurrency() != nil && Utility.shared.getPreferredCurrency() != "")
                        {
                            let currencysymbol = Utility.shared.getSymbol(forCurrencyCode: Utility.shared.getPreferredCurrency()!)
                            let from_currency = getReservationArray.currency!
                            var total = Double()
                            if(getReservation_currencyArray.convertedIsSpecialAverage != nil)
                            {
                                total = Double(getReservation_currencyArray.convertedIsSpecialAverage!)
                            }
                            else
                            {
                                total = Double(getReservation_currencyArray.convertedBasePrice!)
                            }
                            if(getReservationArray.isSpecialPriceAverage != getReservationArray.basePrice)
                            {
                              //  cell.specialImage.isHidden = false
                            }

                            cell.priceLabel.text =  "\(currencysymbol!)\(total.clean) x \(getReservationArray.nights!) \((Utility.shared.getLanguage()?.value(forKey:"night"))!)\(getReservationArray.nights! > 1 ? "s" : "")"
                            let calculated_Price = Double(String(format: "%.2f",getReservation_currencyArray.convertedTotalNightsAmount!))
                            cell.priceLeftLabel.text = "\(currencysymbol!)\(calculated_Price!.clean)"
                            
                            
                        }
                        else
                        {
                            let currencysymbol = Utility.shared.getSymbol(forCurrencyCode:Utility.shared.currencyvalue_from_API_base)
                            let from_currency = getReservationArray.currency!
                            var total = Double()
                            if(getReservation_currencyArray.convertedIsSpecialAverage != nil)
                            {
                                total = Double(getReservation_currencyArray.convertedIsSpecialAverage!)
                            }
                            else
                            {
                                total = Double(getReservation_currencyArray.convertedBasePrice!)
                            }
                            if(getReservationArray.isSpecialPriceAverage != getReservationArray.basePrice)
                            {
                              //  cell.specialImage.isHidden = false
                            }

                            cell.priceLabel.text =  "\(currencysymbol!)\(total.clean) x \(getReservationArray.nights!) \((Utility.shared.getLanguage()?.value(forKey:"night"))!)\(getReservationArray.nights! > 1 ? "s" : "")"
                            let calculated_Price = Double(String(format: "%.2f",getReservation_currencyArray.convertedTotalNightsAmount!))
                            cell.priceLeftLabel.text = "\(currencysymbol!)\(calculated_Price!.clean)"
                            
                            
                        }

                    }
                    else if(indexPath.row == 1)
                    {
                        cell.priceLabel.text =  "\((Utility.shared.getLanguage()?.value(forKey:"servicefee"))!)"
                        
                        if(Utility.shared.getPreferredCurrency() != nil && Utility.shared.getPreferredCurrency() != "")
                        {
                            let currencysymbol = Utility.shared.getSymbol(forCurrencyCode: Utility.shared.getPreferredCurrency()!)
                            
                   
                           
                            if(!Utility.shared.host_isfrom_hostRecipt)
                            {
                                 let restricted_price =  Double(String(format: "%.2f",getReservation_currencyArray.convertedGuestServicefee!))
                              cell.priceLeftLabel.text = "\(currencysymbol!)\(restricted_price!.clean)"
                            }
                            else
                            {
                                let restricted_price =  Double(String(format: "%.2f",getReservation_currencyArray.convertedHostServiceFee!))
                              cell.priceLeftLabel.text = "-\(currencysymbol!)\(restricted_price!.clean)"
                            }
                            
                            
                            
                            
                        }
                        else
                        {
                            let currencysymbol = Utility.shared.getSymbol(forCurrencyCode:Utility.shared.currencyvalue_from_API_base)
                            
                          
                            
                            if(!Utility.shared.host_isfrom_hostRecipt)
                            {
                                let restricted_price =  Double(String(format: "%.2f",getReservation_currencyArray.convertedGuestServicefee!))
                            cell.priceLeftLabel.text = "\(currencysymbol!)\(restricted_price!.clean)"
                            }
                            else
                            {
                                let restricted_price =  Double(String(format: "%.2f",getReservation_currencyArray.convertedHostServiceFee!))
                              cell.priceLeftLabel.text = "-\(currencysymbol!)\(restricted_price!.clean)"
                            }
                            
                            
                        }
                    }
                    return cell
                    
                }
                
            }
            else{
                
                if(getReservationArray.discountType != nil && getReservationArray.discount != 0)
                {
                    if(indexPath.row == 0)
                    {
                        var currencysymbol = String()
                        if(Utility.shared.getPreferredCurrency() != nil && Utility.shared.getPreferredCurrency() != "")
                        {
                            currencysymbol = Utility.shared.getSymbol(forCurrencyCode: Utility.shared.getPreferredCurrency()!)!
                        }
                        else
                        {
                            currencysymbol = Utility.shared.getSymbol(forCurrencyCode:Utility.shared.currencyvalue_from_API_base)!
                        }
                        var total = Double()
                        if(getReservation_currencyArray.convertedIsSpecialAverage != nil)
                        {
                            total = Double(getReservation_currencyArray.convertedIsSpecialAverage!)
                        }
                        else
                        {
                            total = Double(getReservation_currencyArray.convertedBasePrice!)
                        }
                        if(getReservationArray.isSpecialPriceAverage != getReservationArray.basePrice)
                        {
                           // cell.specialImage.isHidden = false
                        }
                        cell.priceLabel.text =  "\(currencysymbol)\(total.clean) x \(getReservationArray.nights!) \((Utility.shared.getLanguage()?.value(forKey:"night"))!)\(Utility.shared.numberofnights_Selected > 1 ? "s" : "")"
                        let calculated_Price = Double(String(format: "%.2f",getReservation_currencyArray.convertedTotalNightsAmount!))
                        cell.priceLeftLabel.text = "\(currencysymbol)\(calculated_Price!.clean)"
                        if(getReservationArray.isSpecialPriceAverage != getReservationArray.basePrice)
                        {
                            //cell.specialImage.isHidden = false
                        }
                        else
                        {
                            //cell.specialImage.isHidden = true
                        }
                    }
                    else if(indexPath.row == 1)
                    {
                        cell.priceLabel.text =  "\((Utility.shared.getLanguage()?.value(forKey:"cleaningfee"))!)"
                        if(Utility.shared.getPreferredCurrency() != nil && Utility.shared.getPreferredCurrency() != "")
                        {
                            let currencysymbol = Utility.shared.getSymbol(forCurrencyCode: Utility.shared.getPreferredCurrency()!)
                            
                            let restricted_price =  Double(String(format: "%.2f",getReservation_currencyArray.convertedCleaningPrice!))
                            cell.priceLeftLabel.text = "\(currencysymbol!)\((restricted_price!).clean)"
                            
                            
                            
                        }
                        else
                        {
                            let currencysymbol = Utility.shared.getSymbol(forCurrencyCode:Utility.shared.currencyvalue_from_API_base)
                            
                            let restricted_price =  Double(String(format: "%.2f",getReservation_currencyArray.convertedCleaningPrice!))
                            cell.priceLeftLabel.text = "\(currencysymbol!)\(restricted_price!.clean)"
                            
                            
                        }
                        
                    }
                    else if(indexPath.row == 2)
                    {
                        cell.priceLabel.text =  "\((Utility.shared.getLanguage()?.value(forKey:"servicefee"))!)"
                        
                        if(Utility.shared.getPreferredCurrency() != nil && Utility.shared.getPreferredCurrency() != "")
                        {
                            let currencysymbol = Utility.shared.getSymbol(forCurrencyCode: Utility.shared.getPreferredCurrency()!)
                            
                            
                            if(!Utility.shared.host_isfrom_hostRecipt)
                            {
                                let restricted_price =  Double(String(format: "%.2f",getReservation_currencyArray.convertedGuestServicefee!))
                            cell.priceLeftLabel.text = "\(currencysymbol!)\(restricted_price!.clean)"
                            }
                            else
                            {
                                let restricted_price =  Double(String(format: "%.2f",getReservation_currencyArray.convertedHostServiceFee!))
                                cell.priceLeftLabel.text = "-\(currencysymbol!)\(restricted_price!.clean)"
                                
                            }
                            
                            
                            
                        }
                        else
                        {
                            let currencysymbol = Utility.shared.getSymbol(forCurrencyCode:Utility.shared.currencyvalue_from_API_base)
                            
                            
                            if(!Utility.shared.host_isfrom_hostRecipt)
                            {
                                let restricted_price =  Double(String(format: "%.2f",getReservation_currencyArray.convertedGuestServicefee!))
                            cell.priceLeftLabel.text = "\(currencysymbol!)\(restricted_price!.clean)"
                            }
                            else
                            {
                                let restricted_price =  Double(String(format: "%.2f",getReservation_currencyArray.convertedHostServiceFee!))
                               cell.priceLeftLabel.text = "-\(currencysymbol!)\(restricted_price!.clean)"
                            }
                            
                            
                        }
                    }
                    else{
                        cell.priceLabel.text =  getReservationArray.discountType!.capitalized
                        
                        if(Utility.shared.getPreferredCurrency() != nil && Utility.shared.getPreferredCurrency() != "")
                        {
                            let currencysymbol = Utility.shared.getSymbol(forCurrencyCode: Utility.shared.getPreferredCurrency()!)
            
                            let restricted_price =  Double(String(format: "%.2f",getReservation_currencyArray.convertedDiscount!))
                            cell.priceLeftLabel.text = "-\(currencysymbol!)\(restricted_price!.clean)"
                            
                            
                            
                        }
                        else
                        {
                            let currencysymbol = Utility.shared.getSymbol(forCurrencyCode:Utility.shared.currencyvalue_from_API_base)
                            
            
                            let restricted_price =  Double(String(format: "%.2f",getReservation_currencyArray.convertedDiscount!))
                            cell.priceLeftLabel.text = "-\(currencysymbol!)\(restricted_price!.clean)"
                            
                            
                        }
                    }
                    return cell
                }
                    
                else{
                    if(indexPath.row == 0)
                    {
                        if(Utility.shared.getPreferredCurrency() != nil && Utility.shared.getPreferredCurrency() != "")
                        {
                            let currencysymbol = Utility.shared.getSymbol(forCurrencyCode: Utility.shared.getPreferredCurrency()!)
                            let from_currency = getReservationArray.currency!
                           
                            var restricted_price:Double!
                            if(getReservation_currencyArray.convertedIsSpecialAverage != nil && getReservation_currencyArray.convertedIsSpecialAverage != 0.0)
                            {
                                restricted_price =  Double(String(format: "%.2f",getReservation_currencyArray.convertedIsSpecialAverage!))
                            }
                            else
                            {
                                  restricted_price =  Double(String(format: "%.2f",getReservation_currencyArray.convertedTotalNightsAmount ?? 0))
                            }
                            cell.priceLabel.text =  "\(currencysymbol!)\(restricted_price!.clean) x \(getReservationArray.nights!) \((Utility.shared.getLanguage()?.value(forKey:"night"))!)\(getReservationArray.nights! > 1 ? "s" : "")"
                            if(getReservationArray.isSpecialPriceAverage != getReservationArray.basePrice)
                            {
                              //  cell.specialImage.isHidden = false
                            }
                            let calculated_Price = Double(String(format: "%.2f",getReservation_currencyArray.convertedTotalNightsAmount ?? 0))
                            cell.priceLeftLabel.text = "\(currencysymbol!)\(calculated_Price!.clean)"
                        }
                        else
                        {
                            let currencysymbol = Utility.shared.getSymbol(forCurrencyCode:Utility.shared.currencyvalue_from_API_base)
                            let from_currency = getReservationArray.currency!
                            let total = Double(getReservationArray.isSpecialPriceAverage!)
                            if(getReservationArray.isSpecialPriceAverage != getReservationArray.basePrice)
                            {
                               // cell.specialImage.isHidden = false
                            }
                          
                            cell.priceLabel.text =  "\(currencysymbol!)\(getReservation_currencyArray.convertedIsSpecialAverage!.clean) x \(getReservationArray.nights!) \((Utility.shared.getLanguage()?.value(forKey:"night"))!)\(getReservationArray.nights! > 1 ? "s" : "")"
                             let calculated_Price = Double(String(format: "%.2f",(getReservation_currencyArray.convertedTotalNightsAmount!)))
                            cell.priceLeftLabel.text = "\(currencysymbol!)\(calculated_Price!.clean)"
                            if(getReservationArray.isSpecialPriceAverage != getReservationArray.basePrice)
                            {
                              //  cell.specialImage.isHidden = false
                            }
                            else
                            {
                                cell.specialImage.isHidden = true
                            }
                            
                        }
                    }
                    else if(indexPath.row == 1)
                    {
                        cell.priceLabel.text =  "\((Utility.shared.getLanguage()?.value(forKey:"cleaningfee"))!)"
                        
                        if(Utility.shared.getPreferredCurrency() != nil && Utility.shared.getPreferredCurrency() != "")
                        {
                            let currencysymbol = Utility.shared.getSymbol(forCurrencyCode: Utility.shared.getPreferredCurrency()!)
                            
                           
                            let restricted_price =  Double(String(format: "%.2f",getReservation_currencyArray.convertedCleaningPrice!))
                            cell.priceLeftLabel.text = "\(currencysymbol!)\(restricted_price!.clean)"
                        }
                        else
                        {
                            let currencysymbol = Utility.shared.getSymbol(forCurrencyCode:Utility.shared.currencyvalue_from_API_base)
        
                            let restricted_price =  Double(String(format: "%.2f",getReservation_currencyArray.convertedCleaningPrice!))
                            cell.priceLeftLabel.text = "\(currencysymbol!)\(restricted_price!.clean)"
                        }
                    }
                    else if(indexPath.row == 2)
                    {
                        cell.priceLabel.text =  "\((Utility.shared.getLanguage()?.value(forKey:"servicefee"))!)"
                        if(Utility.shared.getPreferredCurrency() != nil && Utility.shared.getPreferredCurrency() != "")
                        {
                            let currencysymbol = Utility.shared.getSymbol(forCurrencyCode: Utility.shared.getPreferredCurrency()!)
                            if(!Utility.shared.host_isfrom_hostRecipt)
                            {
                            let restricted_price =  Double(String(format: "%.2f",getReservation_currencyArray.convertedGuestServicefee!))
                            cell.priceLeftLabel.text = "\(currencysymbol!)\(restricted_price!.clean)"
                               
                            }
                            else
                            {
                                let restricted_price =  Double(String(format: "%.2f",getReservation_currencyArray.convertedHostServiceFee!))
                             cell.priceLeftLabel.text = "-\(currencysymbol!)\(restricted_price!.clean)"
                            }
                        }
                        else
                        {
                            let currencysymbol = Utility.shared.getSymbol(forCurrencyCode:Utility.shared.currencyvalue_from_API_base)
                            
                            if(!Utility.shared.host_isfrom_hostRecipt)
                            {
                                let restricted_price =  Double(String(format: "%.2f",getReservation_currencyArray.convertedGuestServicefee!))
                            cell.priceLeftLabel.text = "\(currencysymbol!)\(restricted_price!.clean)"
                            }
                            else
                            {
                                let restricted_price =  Double(String(format: "%.2f",getReservation_currencyArray.convertedHostServiceFee!))
                            cell.priceLeftLabel.text = "-\(currencysymbol!)\(restricted_price!.clean)"
                            }
                        }
                    }
                    return cell
                }
            }
        }
        if(indexPath.section == 6)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookingTotalCell", for: indexPath)as! BookingTotalCell
            cell.selectionStyle = .none
           
            if(Utility.shared.getPreferredCurrency() != nil && Utility.shared.getPreferredCurrency() != "")
            {
                let currencysymbol = Utility.shared.getSymbol(forCurrencyCode: Utility.shared.getPreferredCurrency()!)
               if(!Utility.shared.host_isfrom_hostRecipt)
               {
                cell.totalPriceLabel.text = "\(currencysymbol!)\(getReservation_currencyArray.convertTotalWithGuestServiceFee!.clean)"
                totalPriceLabel = "\(currencysymbol!)\(getReservation_currencyArray.convertTotalWithGuestServiceFee!.clean)"
                }
                else
               {
                if(getReservation_currencyArray.convertedTotalWithHostServiceFee!.clean.contains("-"))
                {
                 let val = (getReservation_currencyArray.convertedTotalWithHostServiceFee!.clean.replacingOccurrences(of:"-", with: ""))
                    cell.totalPriceLabel.text = "-\(currencysymbol!)\(val)"
                    totalPriceLabel = "-\(currencysymbol!)\(val)"
                }
                else
                {
                cell.totalPriceLabel.text = "\(currencysymbol!)\(getReservation_currencyArray.convertedTotalWithHostServiceFee!.clean)"
                totalPriceLabel = "\(currencysymbol!)\(getReservation_currencyArray.convertedTotalWithHostServiceFee!.clean)"
                }
            }
        }
            else
            {
                let currencysymbol = Utility.shared.getSymbol(forCurrencyCode:Utility.shared.currencyvalue_from_API_base)
                if(!Utility.shared.host_isfrom_hostRecipt)
                {
                cell.totalPriceLabel.text = "\(currencysymbol!)\(getReservation_currencyArray.convertTotalWithGuestServiceFee!.clean)"
                totalPriceLabel = "\(currencysymbol!)\(getReservation_currencyArray.convertTotalWithGuestServiceFee!.clean)"
                }
                else
                {
                    cell.totalPriceLabel.text = "\(currencysymbol!)\(getReservation_currencyArray.convertedTotalWithHostServiceFee!.clean)"
                    totalPriceLabel = "\(currencysymbol!)\(getReservation_currencyArray.convertedTotalWithHostServiceFee!.clean)"
                }
            }
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RentpaymentReceiptCell", for: indexPath)as! RentpaymentReceiptCell
            cell.selectionStyle = .none
            let day = getdayValue(timestamp: getReservationArray.updatedAt!)
            let date = getdateValue(timestamp: getReservationArray.updatedAt!)
            cell.paymentDateLabel.text = "\(day), \(date)"
            cell.totalLabel.text = totalPriceLabel
            return cell 
        }
    }
    @objc func tooltipBtnTapped(_ sender: UIButton!)
    {
        let preference = ToolTipPreferences()
        preference.drawing.bubble.color = UIColor.darkGray
        preference.drawing.bubble.spacing = 10
        preference.drawing.bubble.cornerRadius = 5
        preference.drawing.bubble.inset = 15
        preference.drawing.bubble.border.color = UIColor.darkGray
        preference.drawing.bubble.border.width = 1
        preference.drawing.arrow.tipCornerRadius = 5
        preference.drawing.message.color = UIColor.white
        preference.drawing.message.font = UIFont(name: "Circular-Book", size:15)!
        preference.drawing.button.color = UIColor(red: 0.074, green: 0.231, blue: 0.431, alpha: 1.000)
        preference.drawing.button.font = UIFont(name: "Circular-Book", size:15)!
        sender.showToolTip(identifier: "", message:"\((Utility.shared.getLanguage()?.value(forKey:"specialtooltip"))!)", button:nil, arrowPosition: .bottom, preferences: preference, delegate: nil)
    }
    //  fun getRate(base: String, to: String, from: String, rateStr: String, amount: Double) : Double {
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
    func pdfDataWithTableView(tableView: UITableView)->URL {
        let priorBounds = tableView.bounds
        let fittedSize = tableView.sizeThatFits(CGSize(width:priorBounds.size.width, height:tableView.contentSize.height))
        tableView.bounds = CGRect(x:0, y:0, width:fittedSize.width, height:fittedSize.height)
        let pdfPageBounds = CGRect(x:0, y:0, width:tableView.frame.width, height:self.view.frame.height)
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageBounds,nil)
        var pageOriginY: CGFloat = 0
        while pageOriginY < fittedSize.height {
            UIGraphicsBeginPDFPageWithInfo(pdfPageBounds, nil)
            UIGraphicsGetCurrentContext()!.saveGState()
            UIGraphicsGetCurrentContext()!.translateBy(x: 0, y: -pageOriginY)
            tableView.layer.render(in: UIGraphicsGetCurrentContext()!)
            UIGraphicsGetCurrentContext()!.restoreGState()
           
            
            pageOriginY += pdfPageBounds.size.height
        }
         let screenRect = UIScreen.main.bounds
//        UIGraphicsBeginImageContextWithOptions(screenRect.size, false, 0.0)
        UIGraphicsEndPDFContext()
        tableView.bounds = priorBounds
        var docURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
        docURL = docURL.appendingPathComponent("myDocument.pdf")
        pdfData.write(to: docURL as URL, atomically: true)
       return docURL
    }
   func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController
   {
        return self
    }
    func getdateValue(timestamp:String) -> String
    {
        let timestamValue = Int(timestamp)!/1000
        let showDate = Date(timeIntervalSince1970:TimeInterval(timestamValue))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        dateFormatter.locale = NSLocale(localeIdentifier:Utility.shared.getAppLanguageCode()!) as Locale
        let date = dateFormatter.string(from: showDate)
        return date
    }
    
    func getdayValue(timestamp:String) -> String
    {
        let timestamValue = Int(timestamp)!/1000
        let showDate = Date(timeIntervalSince1970:TimeInterval(timestamValue))
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "EEE"
        dateFormatter1.locale = NSLocale(localeIdentifier:Utility.shared.getAppLanguageCode()!) as Locale
        let day = dateFormatter1.string(from: showDate)
        return day
    }
    func conversionRailwaytime(time:String) -> String
    {
        var dateAsString = time
        var strArr = time.split{$0 == ":"}.map(String.init)
        let hour = Int(strArr[0])!
        if(hour > 12 && hour != 24 && hour != 25 && hour != 26){
            dateAsString = "\(Int(dateAsString)!-12)" + " " +  "PM"
        }
        else if(hour == 25)
        {
            dateAsString = "1 AM"
        }
        else if(hour == 26)
        {
            dateAsString = "2 AM"
        }
        else if(hour == 12)
        {
            dateAsString = "12 PM"
        }
        else if(hour == 24)
        {
            dateAsString = "12 AM"
        }
        else{
            let trimmedString = dateAsString.replacingOccurrences(of: "^0+", with: "", options: .regularExpression)
            dateAsString = trimmedString +  " " +  "AM"
        }
        return dateAsString
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
extension UITableView {
    
    // Export pdf from UITableView and save pdf in drectory and return pdf file path
    func exportAsPdfFromTable() -> String {
        
        let originalBounds = self.bounds
        self.bounds = CGRect(x:originalBounds.origin.x, y: originalBounds.origin.y, width: self.contentSize.width, height:FULLHEIGHT+900)
        let pdfPageFrame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: FULLHEIGHT+900)
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageFrame, nil)
        UIGraphicsBeginPDFPageWithInfo(pdfPageFrame, nil)
        let printPageRenderer = UIPrintPageRenderer()
        guard let pdfContext = UIGraphicsGetCurrentContext() else {
            return ""
        }
        self.layer.render(in: pdfContext)
        UIGraphicsEndPDFContext()
        return self.saveTablePdf(data: pdfData)
    }
    // Save pdf file in document directory
    func saveTablePdf(data: NSMutableData) -> String {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDirectoryPath = paths[0]
        let pdfPath = docDirectoryPath.appendingPathComponent("customerReceipt.pdf")
        if data.write(to: pdfPath, atomically: true) {
            return pdfPath.path
        } else {
            return ""
        }
    }
}

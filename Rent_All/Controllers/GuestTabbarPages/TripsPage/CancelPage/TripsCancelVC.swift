//
//  TripsCancelVC.swift
//  Rent_All
//
//  Created by RadicalStart on 07/06/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Apollo
import Lottie

class TripsCancelVC: UIViewController,UITableViewDelegate,UITableViewDataSource,CancelTextviewCellDelegate{
    
    @IBOutlet weak var retryBtn: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var offlineView: UIView!
    var apollo_headerClient: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
        
        let url = URL(string:graphQLEndpoint)!
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()
     var cancelResrvarionArray  = CancellationDataQuery.Data.CancelReservationDatum.Result()
    var checkinDate = String()
    var checkoutDate = String()
    var textviewValue = String()
    var listID = Int()
    var lottieView: LOTAnimationView!

    @IBOutlet weak var cancelTable: UITableView!
    @IBOutlet weak var topView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lottieAnimation()
        initialsetup()

        // Do any additional setup after loading the view.
    }

    @IBAction func backBtnTapped(_ sender: Any) {
        Utility.shared.isfromcancelPAge = false
        self.dismiss(animated: true, completion: nil)
    }
    func lottieAnimation(){
        lottieView = LOTAnimationView.init(name:"animation")
        lottieView.isHidden = false
        self.lottieView.frame = CGRect(x:FULLWIDTH/2-40, y:FULLHEIGHT/2-50, width:100, height:100)
        self.view.addSubview(self.lottieView)
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
    
    func initialsetup()
    {
        if IS_IPHONE_XR
        {
            self.topView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH-40, height: 80)
            cancelTable.frame = CGRect(x: 0, y: 85, width: FULLWIDTH-40, height: FULLHEIGHT-400)
            
        }
        cancelTable.register(UINib(nibName: "tripscancellCell", bundle: nil), forCellReuseIdentifier: "tripscancellCell")
        cancelTable.register(UINib(nibName: "CancelTextviewCell", bundle: nil), forCellReuseIdentifier: "CancelTextviewCell")
         cancelTable.register(UINib(nibName: "ReservationCancelCell", bundle: nil), forCellReuseIdentifier: "ReservationCancelCell")
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
        cancelTable.rowHeight = UITableView.automaticDimension
        self.offlineView.isHidden = true
     //   cancelTable.estimatedRowHeight = 500
        
        errorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
        retryBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(cancelResrvarionArray.reservationId != nil)
        {
        return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0)
        {
            if Utility.shared.getAppLanguageCode() == "en" || Utility.shared.getAppLanguageCode() == "En"{
                 return 245
            }else{
                return 255
            }
            
        }
        else if(indexPath.section == 1)
        {
            return 105
        }
        else{
            return 500
        }

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0)
        {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "tripscancellCell", for: indexPath)as! tripscancellCell
            cell.selectionStyle = .none
           // cell.backgroundColor = .gray
            cell.startLabel.text = "\(cancelResrvarionArray.startedIn!) \((Utility.shared.getLanguage()?.value(forKey:"day"))!)\(cancelResrvarionArray.startedIn! > 1 ? "" : "")"
             let night = Double(cancelResrvarionArray.stayingFor!)
            cell.nightsLabel.text = "\(night.clean) \((Utility.shared.getLanguage()?.value(forKey:"night"))!)\(cancelResrvarionArray.stayingFor! > 1 ? "" : "")"
            cell.travellingLabel.text = "\(cancelResrvarionArray.guests!) \((Utility.shared.getLanguage()?.value(forKey:"guest"))!)\(cancelResrvarionArray.guests! > 1 ? "" : "")"
            if(!Utility.shared.host_cancel_isfromCancel)
            {
            cell.tellLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"tell"))!) \(cancelResrvarionArray.hostName!) \((Utility.shared.getLanguage()?.value(forKey:"whycancel"))!)"
            }
            else
            {
              cell.tellLabel.text = "Tell \(cancelResrvarionArray.guestName!) \((Utility.shared.getLanguage()?.value(forKey:"whycancel"))!)"
            }
            return cell
        }
        else if(indexPath.section == 1)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CancelTextviewCell", for: indexPath)as! CancelTextviewCell
            cell.selectionStyle = .none
           // cell.backgroundColor = .darkGray
            if(!Utility.shared.host_cancel_isfromCancel)
            {
           cell.placeholderLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"personhelp"))!) \(cancelResrvarionArray.hostName!) \((Utility.shared.getLanguage()?.value(forKey:"understandforcancel"))!)"
            }
            else
            {
              cell.placeholderLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"personhelp"))!) \(cancelResrvarionArray.guestName!) \((Utility.shared.getLanguage()?.value(forKey:"understandforcancel"))!)"
            }
            cell.borderView.layer.cornerRadius = 6.0
            cell.borderView.layer.masksToBounds = true
            cell.borderView.layer.borderWidth = 1.0
            cell.borderView.layer.borderColor = TextBorderColor.cgColor
           // cell.checkTxtView.becomeFirstResponder()
            cell.delegate = self
            return cell
        }
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationCancelCell", for: indexPath)as! ReservationCancelCell
            cell.Listimage.layer.cornerRadius = cell.Listimage.frame.size.width/2
            cell.Listimage.layer.masksToBounds = true
            cell.selectionStyle = .none
           // cell.backgroundColor = .blue
            cell.keepReservationBtn.setBorder(color: UIColor().hexValue(hex:"FF4081"))
            cell.keepReservationBtn.layer.cornerRadius = 6.0
            cell.keepReservationBtn.layer.masksToBounds = true
            cell.cancelReservationBtn.layer.cornerRadius = 6.0
            cell.cancelReservationBtn.layer.masksToBounds = true
            let currencysymbol = Utility.shared.getSymbol(forCurrencyCode: cancelResrvarionArray.currency!)
            let restricted_price = Double(String(format: "%.2f",cancelResrvarionArray.nonRefundableNightPrice!))
            cell.priceLAbel.attributedText = "\(currencysymbol!)\(restricted_price!.clean)".strikingThrough()
            let total_price = Double(String(format: "%.2f",cancelResrvarionArray.refundToGuest!))
            if(total_price != 0.0)
            
            {
            cell.totalLabel.text = "\(currencysymbol!)\(total_price!.clean)"
                 cell.inLabel.isHidden = false
                
            }else{
                cell.totalLabel.text  = ""
                 cell.inLabel.isHidden = true
            }
            if(!Utility.shared.host_cancel_isfromCancel)
            {
            cell.nameLabel.text = cancelResrvarionArray.hostName!
               
            }
            else
            {
             cell.nameLabel.text = cancelResrvarionArray.guestName!
            }
            cell.titleLabel.text = cancelResrvarionArray.listData?.title!
            let tap = UITapGestureRecognizer(target: self, action: #selector(TripsCancelVC.titleClicked))
            cell.titleLabel.isUserInteractionEnabled = true
            //let tap = UITapGestureRecognizer(target: self, action: #selector(titleClicked))
            tap.numberOfTapsRequired = 1
            tap.view?.tag = indexPath.row
            cell.titleLabel.addGestureRecognizer(tap)
            cell.dateLabel.text = "\(checkinDate) - \(checkoutDate)"
            if(!Utility.shared.host_cancel_isfromCancel)
            {
            cell.hostnightLabel.isHidden = true
            cell.missedearningsLabel.isHidden = true
            }
            else
            {
                cell.hostnightLabel.isHidden = false
                cell.missedearningsLabel.isHidden = false
                cell.nonrefundableLabel.isHidden = true
                cell.inLabel.isHidden = true
                if(Utility.shared.getPreferredCurrency() != nil && Utility.shared.getPreferredCurrency() != "")
                {
                    let currencysymbol = Utility.shared.getSymbol(forCurrencyCode: Utility.shared.getPreferredCurrency()!)
                    let from_currency = cancelResrvarionArray.listData?.listingData?.currency!
                   // let currency_amount = (cancelResrvarionArray.listData?.listingData?.basePrice!)!
                    let currency_amount = (cancelResrvarionArray.isSpecialPriceAverage!)
                    let restricted_price =  Double(String(format: "%.2f",currency_amount))
                    cell.hostnightLabel.text =  "\(currencysymbol!)\(restricted_price!.clean)  x \(cancelResrvarionArray.stayingFor!.clean) \((Utility.shared.getLanguage()?.value(forKey:"night"))!)\(cancelResrvarionArray.stayingFor! > 1 ? "" : "")"
                }
                else
                {
                    let currencysymbol = Utility.shared.getSymbol(forCurrencyCode:Utility.shared.currencyvalue_from_API_base)
                    let from_currency = cancelResrvarionArray.listData?.listingData?.currency!
                    let currency_amount = cancelResrvarionArray.isSpecialPriceAverage!
                    let restricted_price =  Double(String(format: "%.2f",currency_amount))
                    cell.hostnightLabel.text = "\(currencysymbol!)\(restricted_price!.clean) x \(cancelResrvarionArray.stayingFor!.clean) \((Utility.shared.getLanguage()?.value(forKey:"night"))!)\(cancelResrvarionArray.stayingFor! > 1 ? "" : "")"
                }
                cell.totalLabel.isHidden = true
            }
            if(cancelResrvarionArray.hostProfilePicture != nil)
            {
                if(!Utility.shared.host_cancel_isfromCancel)
                {
            let listimage = cancelResrvarionArray.hostProfilePicture!
                
            cell.Listimage.sd_setImage(with: URL(string: "\(IMAGE_AVATAR_MEDIUM)\(listimage)"), placeholderImage: #imageLiteral(resourceName: "unknown"))
                }
                else if(cancelResrvarionArray.guestProfilePicture != nil)
                {
                    let listimage = cancelResrvarionArray.guestProfilePicture!
                    
                    cell.Listimage.sd_setImage(with: URL(string: "\(IMAGE_AVATAR_MEDIUM)\(listimage)"), placeholderImage: #imageLiteral(resourceName: "unknown"))
                }
                else
                {
                   cell.Listimage.image = #imageLiteral(resourceName: "unknown")
                }
            }
            else{
                cell.Listimage.image = #imageLiteral(resourceName: "unknown")
            }
            
            if(cancelResrvarionArray.nonRefundableNightPrice! <= 0 && !Utility.shared.host_cancel_isfromCancel)
            {
                cell.totalLabel.frame = CGRect(x: cell.totalLabel.frame.origin.x, y: 225, width: cell.totalLabel.frame.size.width, height: 35)
                 cell.inLabel.frame = CGRect(x: cell.inLabel.frame.origin.x, y: 225, width: cell.inLabel.frame.size.width, height: 30)
                cell.aboveCostLAbel.frame = CGRect(x: cell.aboveCostLAbel.frame.origin.x, y: 263, width: cell.aboveCostLAbel.frame.size.width, height:25)
                cell.keepReservationBtn.frame = CGRect(x: cell.keepReservationBtn.frame.origin.x, y: 316, width: cell.keepReservationBtn.frame.size.width, height:45)
                cell.cancelReservationBtn.frame = CGRect(x: cell.cancelReservationBtn.frame.origin.x, y: 376, width: cell.cancelReservationBtn.frame.size.width, height:45)

            }
            
            
            if(cancelResrvarionArray.refundToGuest! == 0 )
            
            {
                cell.totalLabel.isHidden = true
                 cell.inLabel.isHidden = true
                cell.aboveCostLAbel.isHidden = true
                cell.keepReservationBtn.frame = CGRect(x: cell.keepReservationBtn.frame.origin.x, y: 278, width: cell.keepReservationBtn.frame.size.width, height:45)
                cell.cancelReservationBtn.frame = CGRect(x: cell.cancelReservationBtn.frame.origin.x, y: 338, width: cell.cancelReservationBtn.frame.size.width, height:45)
            }
            if(Utility.shared.host_cancel_isfromCancel){
                cell.aboveCostLAbel.isHidden = true
                cell.keepReservationBtn.frame = CGRect(x: cell.keepReservationBtn.frame.origin.x, y: 308, width: cell.keepReservationBtn.frame.size.width, height:45)
                cell.cancelReservationBtn.frame = CGRect(x: cell.cancelReservationBtn.frame.origin.x, y: 368, width: cell.cancelReservationBtn.frame.size.width, height:45)
            }
            
            cell.keepReservationBtn.addTarget(self, action: #selector(keepBtnTapped), for: .touchUpInside)
            cell.cancelReservationBtn.addTarget(self, action: #selector(cancelBtnTapped), for: .touchUpInside)
            return cell
        }
    }
    @objc func titleClicked(_ sender: UITapGestureRecognizer) {
        let guestdetailObj = GuestDetailVC()
        Utility.shared.unpublish_preview_check = false
        guestdetailObj.currencyvalue_from_API_base = Utility.shared.currencyvalue_from_API_base
        guestdetailObj.currency_Dict = Utility.shared.currency_Dict
        guestdetailObj.listID = listID
        guestdetailObj.modalPresentationStyle = .fullScreen
        self.present(guestdetailObj, animated: true, completion: nil)
        
    }
    @objc func keepBtnTapped(_ sender: UIButton)
    {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func cancelBtnTapped(_ sender: UIButton)
    {
         if Utility().isConnectedToNetwork(){
        if(textviewValue.containsNothing)
        {
            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"messagealert"))!)")
        }
        else
        {
     cancellationBookingAPICall()
        }
        }
         else{
            self.offlineView.isHidden = false
            let shadowSize2 : CGFloat = 3.0
            let shadowPath2 = UIBezierPath(rect: CGRect(x: -shadowSize2 / 2,
                                                        y: -shadowSize2 / 2,
                                                        width: self.offlineView.frame.size.width + shadowSize2,
                                                        height: self.offlineView.frame.size.height + shadowSize2))
            
            self.offlineView.layer.masksToBounds = false
            self.offlineView.layer.shadowColor = TextLightColor.cgColor
            self.offlineView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            self.offlineView.layer.shadowOpacity = 0.3
            self.offlineView.layer.shadowPath = shadowPath2.cgPath
            if IS_IPHONE_X || IS_IPHONE_XR {
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-95, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-55, width: FULLWIDTH, height: 55)
            }
        }
    }
    @IBAction func retryBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
            self.offlineView.isHidden = true
        }
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
    func didChangeText(text: String?, cell: CancelTextviewCell) {
//        cancelTable.beginUpdates()
//        cancelTable.endUpdates()
    }
    func textendEditing(text: String?, cell: CancelTextviewCell) {
        textviewValue = text!
    }
    
   
    
    
    
func getcancellationAPICall(reservationId:Int,userType:String,currency:String)
{
    let getcancellationquery = CancellationDataQuery(reservationId: reservationId, userType: userType, currency: currency)
    apollo_headerClient.fetch(query: getcancellationquery,cachePolicy:.fetchIgnoringCacheData){(result,error) in
        guard (result?.data?.cancelReservationData?.results) != nil else{
            print("Missing Data")
            self.lottieView.isHidden = true
            self.view.makeToast(result?.data?.cancelReservationData?.errorMessage!)
            
            return
            //self.dismiss(animated: false, completion: nil)
        }
        self.lottieView.isHidden = true
        self.cancelResrvarionArray = (result?.data?.cancelReservationData?.results)!
        self.cancelTable.reloadData()
       
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
   
    
    func cancellationBookingAPICall()
    {
        if(cancelResrvarionArray.payoutToHost == nil)
        {
           cancelResrvarionArray.payoutToHost = 0
        }
        let cancelBookingMutation = CancelReservationMutation(reservationId: cancelResrvarionArray.reservationId!, cancellationPolicy: cancelResrvarionArray.cancellationPolicy!, refundToGuest: cancelResrvarionArray.refundToGuest!, payoutToHost: cancelResrvarionArray.payoutToHost!, guestServiceFee: cancelResrvarionArray.guestServiceFee!, hostServiceFee: cancelResrvarionArray.hostServiceFee!, total: cancelResrvarionArray.total!, currency: cancelResrvarionArray.currency!, threadId: cancelResrvarionArray.threadId!, cancelledBy: cancelResrvarionArray.cancelledBy!, message: textviewValue, checkIn: cancelResrvarionArray.checkIn!, checkOut: cancelResrvarionArray.checkOut!, guests: cancelResrvarionArray.guests!)
        apollo_headerClient.perform(mutation: cancelBookingMutation){(result,error)in
            if(result?.data?.cancelReservation?.status) != 200 {
                return
            }
            Utility.shared.isfromcancelPAge = true
            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"reservationcancel"))!)")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                // code to remove your view
                
                if Utility.shared.isFromMessageListingPage_host{
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.settingRootViewControllerFunction()
                    
                }else if Utility.shared.isFromMessageListingPage_guest {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    Utility.shared.setTab(index: 3)
                    appDelegate.GuestTabbarInitialize(initialView: CustomTabbar())
                    
                }else{
                       self.dismiss(animated: true, completion: nil)
                }
             
            }
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
extension String {
    
    var containsNothing: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
}

//
//  BookingStepFourVC.swift
//  Rent_All
//
//  Created by RadicalStart on 30/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Apollo
import Lottie
import SwiftyJSON
import MKToolTip
import Stripe

class BookingStepFourVC: UIViewController,UITableViewDataSource,UITableViewDelegate,STPPaymentCardTextFieldDelegate,STPAddCardViewControllerDelegate{
   
    struct specialPrice: Codable {
        let blockedDates: String
        let isSpecialPrice: Double
    }
    var paymentIntentClientSecret: String?
    

    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var offlineView: UIView!
    
    @IBOutlet weak var retryBtn: UIButton!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bookingStepFourTable: UITableView!
    
    @IBOutlet weak var paymentBtn: UIButton!
    @IBOutlet weak var bottomView: UIView!
    var currencyvalue_from_API_base = String()
    var totalPriceLabel = String()
    var getbillingArray = GetBillingCalculationQuery.Data.GetBillingCalculation.Result()
     var viewListingArray = ViewListingDetailsQuery.Data.ViewListing.Result()
    var attdList : JSON = [:]
    var JSON_obj = [GetBillingCalculationQuery.Data.GetBillingCalculation.Result.SpecialPricing]()
    var lottieWholeView = UIView()
    var lottieView =  LOTAnimationView()
    var array = NSMutableArray()
    let stripeView = UIView()
    var isStripeviewpresent:Bool = false
    
    var apollo_headerClient: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
        
        let url = URL(string:graphQLEndpoint)!
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()
    var error: NSError?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getbillingArray = Utility.shared.passbillingArray
        currencyvalue_from_API_base = Utility.shared.passCurrencyvaluefromAPI
        self.initialsetup()
        self.stripeUISetup()
        
        
        
    }
    
    
func stripeUISetup()
{
//
//    stripeView.frame = CGRect(x:20, y:85, width: FULLWIDTH, height: FULLHEIGHT-40)
//    stripeView.backgroundColor = UIColor.white
//    self.view.addSubview(stripeView)
//    view.backgroundColor = .white
//    //let stackView = UIStackView(arrangedSubviews: [cardTextField, payButton])
//    stackView.axis = .vertical
//    stackView.spacing = 20
//    stackView.translatesAutoresizingMaskIntoConstraints = false
//    stripeView.addSubview(stackView)
//
//    if #available(iOS 11.0, *) {
//        NSLayoutConstraint.activate([
//            stackView.leftAnchor.constraint(equalToSystemSpacingAfter: view.leftAnchor, multiplier: 2),
//            view.rightAnchor.constraint(equalToSystemSpacingAfter: stackView.rightAnchor, multiplier: 2),
//            stackView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier:15),
//        ])
//    } else {
//        // Fallback on earlier versions
//    }
    
    
}
   
     func stringify(json: Any, prettyPrinted: Bool = false) -> String {
        var options: JSONSerialization.WritingOptions = []
        if prettyPrinted {
            options = JSONSerialization.WritingOptions.prettyPrinted
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: options)
            if let string = String(data: data, encoding: String.Encoding.utf8) {
                return string
            }
        } catch {
            print(error)
        }
        
        return ""
    }

    func initialsetup()
    {
        if IS_IPHONE_XR
        {
            self.topView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH-40, height: 80)
            bookingStepFourTable.frame = CGRect(x: 0, y: 85, width: FULLWIDTH-40, height: FULLHEIGHT-400)
            
        }
        bookingStepFourTable.register(UINib(nibName: "BookingFourCell", bundle: nil), forCellReuseIdentifier: "BookingFourCell")
        bookingStepFourTable.register(UINib(nibName: "AgreetermsCell", bundle: nil), forCellReuseIdentifier: "AgreetermsCell")
        bookingStepFourTable.register(UINib(nibName: "RequestBookcellTableViewCell", bundle: nil), forCellReuseIdentifier: "RequestBookcellTableViewCell")
        bookingStepFourTable.register(UINib(nibName: "ReservationCell", bundle: nil), forCellReuseIdentifier: "ReservationCell")
        bookingStepFourTable.register(UINib(nibName: "BookingTotalCell", bundle: nil), forCellReuseIdentifier: "BookingTotalCell")
        bookingStepFourTable.register(UINib(nibName: "bookcancellationCell", bundle: nil), forCellReuseIdentifier: "bookcancellationCell")
        let shadowSize : CGFloat = 3.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.bottomView.frame.size.width+40 + shadowSize,
                                                   height: self.bottomView.frame.size.height + shadowSize))
        
        self.bottomView.layer.masksToBounds = false
        self.bottomView.layer.shadowColor = TextLightColor.cgColor
        self.bottomView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.bottomView.layer.shadowOpacity = 0.3
        self.bottomView.layer.shadowPath = shadowPath.cgPath
        paymentBtn.backgroundColor = Theme.TERTIARY_COLOR
        
        let shadowPath1 = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                    y: -shadowSize / 2,
                                                    width: self.topView.frame.size.width+40 + shadowSize,
                                                    height: self.topView.frame.size.height + shadowSize))
        
        self.topView.layer.masksToBounds = false
        self.topView.layer.shadowColor = TextLightColor.cgColor
        self.topView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.topView.layer.shadowOpacity = 0.3
        self.topView.layer.shadowPath = shadowPath1.cgPath
        paymentBtn.layer.cornerRadius = 5.0
        paymentBtn.layer.masksToBounds = true
        self.lottieWholeView.isHidden = true
        self.lottieView.isHidden = true
        self.offlineView.isHidden = true
        lottieView = LOTAnimationView.init(name: "loading_qwe")
        paymentBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"addpayment"))!)", for: .normal)
        
        errorLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)"
        retryBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"retry"))!)", for:.normal)
    }
    
    func lottieAnimation()
    {
        self.lottieView.isHidden = false
        self.lottieWholeView.isHidden = false
        self.lottieWholeView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height: FULLHEIGHT)
        self.lottieWholeView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.view.addSubview(lottieWholeView)
        self.lottieView.frame = CGRect(x:FULLWIDTH/2-50, y: FULLHEIGHT/2-50, width: 100, height: 100)
        self.lottieWholeView.addSubview(self.lottieView)
        self.lottieView.backgroundColor = UIColor.white
        self.lottieView.layer.cornerRadius = 6.0
        self.lottieView.clipsToBounds = true
        self.lottieView.play()
         Timer.scheduledTimer(timeInterval:0.3, target: self, selector: #selector(autoscroll), userInfo: nil, repeats: true)
    }
    @objc func autoscroll()
    {
        self.lottieView.play()
    }

    @IBAction func backbtntapped(_ sender: Any) {
       
       self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func retryBtnTappped(_ sender: Any) {
        self.offlineView.isHidden = true
    }

    @IBAction func addPaymentTapped(_ sender: Any) {

                let addCardViewController = STPAddCardViewController()


                addCardViewController.delegate = self


                // Present add card view controller
                let navigationController = UINavigationController(rootViewController: addCardViewController)


                navigationController.modalPresentationStyle = .fullScreen
               present(navigationController, animated: true)
    }




    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    @objc func dismissController()
    {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 2)
        {
            if(getbillingArray.cleaningPrice == 0)
            {
                if(getbillingArray.discountLabel != nil && getbillingArray.discount != 0)
                {
                    return 3
                }
                return 2
                
            }
            else
            {
                if(getbillingArray.discountLabel != nil && getbillingArray.discount != 0)
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
            return 215
        }
        else if(indexPath.section == 1)
        {
            return  45
        }
        else if(indexPath.section == 2)
        {
            return 55
        }
        else if(indexPath.section == 3)
        {
            return 100
        }
            else if(indexPath.section == 4)
        {
            return 160
        }
            
        else{
            return 135
        }
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0)
        {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "BookingFourCell", for: indexPath)as! BookingFourCell
            cell.listnameLabel.text = Utility.shared.bookingListname
            cell.dateLabel.text = Utility.shared.bookingdateLabel
            let listimage = Utility.shared.bookingListimage
            cell.listImage.layer.cornerRadius = 6.0
            cell.selectionStyle = .none
            if(Utility.shared.isprofilepictureVerified)
            {
                cell.stepLabel.text =  "\((Utility.shared.getLanguage()?.value(forKey:"step4of4"))!)"
            }
            else
            {
                cell.stepLabel.text =  "\((Utility.shared.getLanguage()?.value(forKey:"step3of3"))!)"
            }
            cell.listImage.layer.masksToBounds = true
            cell.listImage.sd_setImage(with: URL(string:"\(IMAGE_LISTING_MEDIUM)\(String(describing: listimage))"),placeholderImage: #imageLiteral(resourceName: "unknown"))
            cell.listBtn.tag = indexPath.row
            cell.listBtn.addTarget(self, action: #selector(listBtnTapped), for: .touchUpInside)
            return cell
        }
        else if(indexPath.section == 1)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationCell", for: indexPath)as! ReservationCell
            cell.selectionStyle = .none
            return cell
        }
        else if(indexPath.section == 2)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RequestBookcellTableViewCell", for: indexPath)as! RequestBookcellTableViewCell
            cell.selectionStyle = .none
            var currencysymbol = String()
            cell.specialImage.isHidden = true
             cell.specialImage.addTarget(self, action: #selector(tooltipBtnTapped),for:.touchUpInside)
            if(Utility.shared.getPreferredCurrency() != nil && Utility.shared.getPreferredCurrency() != "")
            {
                currencysymbol = Utility.shared.getSymbol(forCurrencyCode: Utility.shared.getPreferredCurrency()!)!
            }
            else
            {
                currencysymbol = Utility.shared.getSymbol(forCurrencyCode:self.currencyvalue_from_API_base)!
            }
            
            if(getbillingArray.cleaningPrice == 0)
            {
                if(getbillingArray.discountLabel != nil && getbillingArray.discount != 0)
                {
                    if(indexPath.row == 0)
                    {
                        cell.priceLabel.text =  "\(currencysymbol)\(getbillingArray.averagePrice!.clean) x \(Utility.shared.numberofnights_Selected) \((Utility.shared.getLanguage()?.value(forKey:"night"))!)\(Utility.shared.numberofnights_Selected > 1 ? "" : "")"
                      //  let calculated_Price = Double(String(format: "%.2f",(getbillingArray.basePrice! * Double(Utility.shared.numberofnights_Selected))))as! Double
                        cell.priceLeftLabel.text = "\(currencysymbol)\(getbillingArray.priceForDays!.clean)"
                        cell.priceLabel.sizeToFit()
                        if(getbillingArray.isSpecialPriceAssigned == true)
                        {
                            cell.specialImage.isHidden = false
                             cell.specialImage.frame = CGRect(x: cell.priceLabel.frame.size.width+cell.priceLabel.frame.origin.x+5, y:17, width: 20, height: 20)
                        }
                        
                    }
                    else if(indexPath.row == 1)
                    {
                        cell.priceLabel.text =  "\((Utility.shared.getLanguage()?.value(forKey:"servicefee"))!)"
                        
                        cell.priceLeftLabel.text = "\(currencysymbol)\(getbillingArray.guestServiceFee!.clean)"
                    }
                    else{
                        cell.priceLabel.text =  getbillingArray.discountLabel!.capitalized
                        
                        cell.priceLeftLabel.text = "-\(currencysymbol)\((getbillingArray.discount!.clean))"
                    }
                    return cell
                }
                else
                {
                    if(indexPath.row == 0)
                    {
                        cell.priceLabel.text =  "\(currencysymbol)\(getbillingArray.averagePrice!.clean) x \(Utility.shared.numberofnights_Selected) \((Utility.shared.getLanguage()?.value(forKey:"night"))!)\(Utility.shared.numberofnights_Selected > 1 ? "" : "")"
                        let calculated_Price = Double(String(format: "%.2f",(getbillingArray.basePrice! * Double(Utility.shared.numberofnights_Selected))))as! Double
                        cell.priceLabel.sizeToFit()
                        if(getbillingArray.isSpecialPriceAssigned == true)
                        {
                            cell.specialImage.isHidden = false
                             cell.specialImage.frame = CGRect(x: cell.priceLabel.frame.size.width+cell.priceLabel.frame.origin.x+5, y:17, width: 20, height: 20)
                        }
                        
                        cell.priceLeftLabel.text = "\(currencysymbol)\(getbillingArray.priceForDays!.clean)"
                    }
                    else if(indexPath.row == 1)
                    {
                        cell.priceLabel.text =  "\((Utility.shared.getLanguage()?.value(forKey:"servicefee"))!)"
                        
                        cell.priceLeftLabel.text = "\(currencysymbol)\(getbillingArray.guestServiceFee!.clean)"
                    }
                    return cell
                    
                }
                
            }
            else{
                
                if(getbillingArray.discountLabel != nil && getbillingArray.discount != 0)
                {
                    if(indexPath.row == 0)
                    {
                        cell.priceLabel.text =  "\(currencysymbol)\(getbillingArray.averagePrice!.clean) x \(Utility.shared.numberofnights_Selected) \((Utility.shared.getLanguage()?.value(forKey:"night"))!)\(Utility.shared.numberofnights_Selected > 1 ? "" : "")"
                        let calculated_Price = Double(String(format: "%.2f",(getbillingArray.basePrice! * Double(Utility.shared.numberofnights_Selected))))as! Double
                        cell.priceLabel.sizeToFit()
                        if(getbillingArray.isSpecialPriceAssigned == true)
                        {
                            cell.specialImage.isHidden = false
                             cell.specialImage.frame = CGRect(x: cell.priceLabel.frame.size.width+cell.priceLabel.frame.origin.x+5, y:17, width: 20, height: 20)
                        }
                        
                        cell.priceLeftLabel.text = "\(currencysymbol)\(getbillingArray.priceForDays!.clean)"
                    }
                    else if(indexPath.row == 1)
                    {
                        cell.priceLabel.text =  "\((Utility.shared.getLanguage()?.value(forKey:"cleaningfee"))!)"
                        
                        cell.priceLeftLabel.text = "\(currencysymbol)\(getbillingArray.cleaningPrice!.clean)"
                    }
                    else if(indexPath.row == 2)
                    {
                        cell.priceLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"servicefee"))!)"
                        
                        cell.priceLeftLabel.text = "\(currencysymbol)\(getbillingArray.guestServiceFee!.clean)"
                    }
                    else{
                        cell.priceLabel.text =  getbillingArray.discountLabel!.capitalized
                        
                        cell.priceLeftLabel.text = "-\(currencysymbol)\((getbillingArray.discount!.clean))"
                    }
                    return cell
                }
                    
                else{
                    if(indexPath.row == 0)
                    {
                        
                        cell.priceLabel.text =  "\(currencysymbol)\(getbillingArray.averagePrice!.clean) x \(Utility.shared.numberofnights_Selected) \((Utility.shared.getLanguage()?.value(forKey:"night"))!)\(Utility.shared.numberofnights_Selected > 1 ? "" : "")"
                        let calculated_Price = Double(String(format: "%.2f",(getbillingArray.basePrice! * Double(Utility.shared.numberofnights_Selected))))as! Double
                        cell.priceLabel.sizeToFit()
                        if(getbillingArray.isSpecialPriceAssigned == true)
                        {
                            cell.specialImage.isHidden = false
                             cell.specialImage.frame = CGRect(x: cell.priceLabel.frame.size.width+cell.priceLabel.frame.origin.x+5, y:17, width: 20, height: 20)
                        }
                       
                        cell.priceLeftLabel.text = "\(currencysymbol)\(getbillingArray.priceForDays!.clean)"
                    }
                    else if(indexPath.row == 1)
                    {
                        cell.priceLabel.text =  "\((Utility.shared.getLanguage()?.value(forKey:"cleaningfee"))!)"
                        
                        cell.priceLeftLabel.text = "\(currencysymbol)\(getbillingArray.cleaningPrice!.clean)"
                    }
                    else if(indexPath.row == 2)
                    {
                        cell.priceLabel.text =  "\((Utility.shared.getLanguage()?.value(forKey:"servicefee"))!)"
                        
                        cell.priceLeftLabel.text = "\(currencysymbol)\(getbillingArray.guestServiceFee!.clean)"
                    }
                    return cell
                }
                
                
            }
            
            
        }
       else if(indexPath.section == 3)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookingTotalCell", for: indexPath)as! BookingTotalCell
            cell.selectionStyle = .none
            var currencysymbol = String()
            if(Utility.shared.getPreferredCurrency() != nil && Utility.shared.getPreferredCurrency() != "")
            {
                currencysymbol = Utility.shared.getSymbol(forCurrencyCode: Utility.shared.getPreferredCurrency()!)!
            }
            else
            {
                currencysymbol = Utility.shared.getSymbol(forCurrencyCode:self.currencyvalue_from_API_base)!
            }
            cell.totalPriceLabel.text = "\(currencysymbol)\(getbillingArray.total!.clean)"
            totalPriceLabel = "\(currencysymbol)\(getbillingArray.total!.clean)"
            return cell
        }
        else if(indexPath.section == 4)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "bookcancellationCell", for: indexPath) as! bookcancellationCell
            cell.cancelpolicyLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"cancellationPolicy"))!): \(Utility.shared.cancelpolicy)"
            cell.cancelpolicycontentLabel.text = "\(Utility.shared.cancelpolicy_content)"
            cell.selectionStyle = .none
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AgreetermsCell", for: indexPath)as! AgreetermsCell
            cell.selectionStyle = .none
            return cell
        }
    }
    
     // MARK: STPAddCardViewControllerDelegate
    
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        dismiss(animated: true, completion: nil)
    }

    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreatePaymentMethod paymentMethod: STPPaymentMethod, completion: @escaping STPErrorBlock) {
        self.lottieAnimation()
        print("paymentmethodid:\(paymentMethod.stripeId)")
        paymentIntentClientSecret = "\(paymentMethod.stripeId)"
        self.PaymentAPICall(cardtoken: "\(paymentMethod.stripeId)")
        dismiss(animated: true, completion: nil)
    }
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
        
        //self.PaymentAPICall(cardtoken: "\(token)")
       // dismiss(animated: true, completion: nil)
    }
func handlePayment(reservationId:Int,paymentIntentId:String)
{
    
    STPPaymentHandler.shared().handleNextAction(
        forPayment: paymentIntentId,
        authenticationContext:self,
        returnURL: nil,
        completion: { status, paymentIntent, error in
            if case .succeeded = status, let paymentIntent = paymentIntent {
                //completion(.success(paymentIntent))
                self.confirmPaymentCall(reservationId: reservationId, paymentIntentId:"\(paymentIntent.stripeId)")
            } else {
                //completion(.failure(error ?? AppError.invalid))
                self.lottieView.isHidden = true
                self.lottieWholeView.isHidden = true
            }
    })

}
    
    func confirmPaymentCall(reservationId:Int,paymentIntentId:String){
        let confirmpaymentmutation = ConfirmReservationMutation(reservationId: reservationId, paymentIntentId: paymentIntentId)
        apollo_headerClient.perform(mutation: confirmpaymentmutation){(result,error) in
            
            if(result?.data?.confirmReservation?.status == 200)
            {
                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"paymentsuccess"))!)")
                           if #available(iOS 11.0, *) {
                               Utility.shared.PreApprovedID = false
                               let itenaryPageObj = BookingItenaryVC()
                               Utility.shared.isfromTripsPage = false
                               itenaryPageObj.getbillingArray = self.getbillingArray
                               itenaryPageObj.currencyvalue_from_API_base = self.currencyvalue_from_API_base
                               itenaryPageObj.createReservationAPICall(reservationid:reservationId)
                               self.lottieWholeView.isHidden = true
                               self.lottieView.isHidden = true
                               itenaryPageObj.modalPresentationStyle = .fullScreen
                               self.present(itenaryPageObj, animated: true, completion: nil)
                           } else {
                               // Fallback on earlier versions
                           }
            }
            else if(result?.data?.confirmReservation?.status == 400)
            {
                self.handlePayment(reservationId:reservationId, paymentIntentId: paymentIntentId)
            }
        }
    }
    @objc func tooltipBtnTapped(_ sender: UIButton!)
    {
        let preference = ToolTipPreferences()
        preference.drawing.bubble.color = UIColor.darkGray
        preference.drawing.bubble.spacing = 10
        preference.drawing.bubble.cornerRadius = 5
        preference.drawing.bubble.inset = 15
        preference.drawing.bubble.border.color = UIColor(red: 0.768, green: 0.843, blue: 0.937, alpha: 1.000)
        preference.drawing.bubble.border.width = 1
        preference.drawing.arrow.tipCornerRadius = 5
        preference.drawing.message.color = UIColor.white
        preference.drawing.message.font = UIFont(name: "Circular-Book", size:15)!
        preference.drawing.button.color = UIColor(red: 0.074, green: 0.231, blue: 0.431, alpha: 1.000)
        preference.drawing.button.font = UIFont(name: "Circular-Book", size:15)!
        sender.showToolTip(identifier: "", message:"\((Utility.shared.getLanguage()?.value(forKey:"specialtooltip"))!)", button:nil, arrowPosition: .bottom, preferences: preference, delegate: nil)
    }
    func PaymentAPICall(cardtoken:String)
    {
        var currency_con = String()
        if(Utility.shared.getPreferredCurrency() != nil && Utility.shared.getPreferredCurrency() != "")
        {
            currency_con = Utility.shared.getPreferredCurrency()!
        }
        else
        {
            currency_con = self.currencyvalue_from_API_base
        }
        var discountLabel = String()
        if(getbillingArray.discountLabel == nil)
        {
          discountLabel = ""
        }
        else
        {
          discountLabel = getbillingArray.discountLabel!
        }
        
        
        var bookedArrayType = String()
        if Utility.shared.PreApprovedID{
            
            bookedArrayType = "instant"
            
        }else{
            
            bookedArrayType = viewListingArray.bookingType!
            
        }
        
        
        let paymentMutation = CreateReservationMutation(listId: viewListingArray.id!, checkIn: getbillingArray.checkIn!, checkOut: getbillingArray.checkOut!, guests: getbillingArray.guests!, message: Utility.shared.booking_message, basePrice: getbillingArray.averagePrice!, cleaningPrice: getbillingArray.cleaningPrice!, currency: getbillingArray.currency!, discount: getbillingArray.discount!,discountType:getbillingArray.discountLabel, guestServiceFee: getbillingArray.guestServiceFee!, hostServiceFee: getbillingArray.hostServiceFee!, total: getbillingArray.total!, bookingType: bookedArrayType, cardToken: cardtoken, paymentType:2, convCurrency: currency_con,averagePrice:getbillingArray.averagePrice!, nights:getbillingArray.nights!)
        
        apollo_headerClient.perform(mutation: paymentMutation){ (result,error) in
            if(result?.data?.createReservation?.status == 400)
            { self.lottieWholeView.isHidden = true
                self.lottieView.isHidden = true
                if(result?.data?.createReservation?.reservationId != nil)
                {
                self.handlePayment(reservationId: (result?.data?.createReservation?.reservationId!)!, paymentIntentId: (result?.data?.createReservation?.paymentIntentSecret!)!)
                }
                else{
                 self.view.makeToast(result?.data?.createReservation?.errorMessage!)
                }
                print("Missing Data")
//                self.view.makeToast(result?.data?.createReservation?.errorMessage!)
//                self.lottieWholeView.isHidden = true
//                self.lottieView.isHidden = true
//
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                Utility.shared.setTab(index: 0)
//                Utility.shared.host_message_isfromHost = false
//                Utility.shared.host_message_isfrommessage = false
//                Utility.shared.isfromfloatmap_Page = false
//                Utility.shared.isfromsearchLocationFilter = false
//                Utility.shared.locationfromSearch  = ""
//                Utility.shared.TotalFilterCount = 0
//                if(Utility.shared.searchLocationDict.count > 0)
//                {
//                    Utility.shared.searchLocationDict.setValue(nil, forKey: "lat")
//                    Utility.shared.searchLocationDict.setValue(nil, forKey: "lon")
//                }
//                Utility.shared.instantBook = ""
//                Utility.shared.roomtypeArray.removeAllObjects()
//                Utility.shared.amenitiesArray.removeAllObjects()
//                Utility.shared.priceRangeArray.removeAllObjects()
//                Utility.shared.facilitiesArray.removeAllObjects()
//                Utility.shared.houseRulesArray.removeAllObjects()
//                Utility.shared.beds_count = 0
//                Utility.shared.bedrooms_count = 0
//                Utility.shared.bathroom_count = 0
//                if(Utility.shared.isSwitchEnable)
//                {
//                    Utility.shared.isSwitchEnable = false
//                }
//                Utility.shared.isfromGuestProfile = false
//                Utility.shared.setopenTabbar(iswhichtabbar: false)
//                 DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
//                appDelegate.GuestTabbarInitialize(initialView: CustomTabbar())
//                }
                
                return
            }
            else
             {
            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"paymentsuccess"))!)")
            if #available(iOS 11.0, *) {
                Utility.shared.PreApprovedID = false
                let itenaryPageObj = BookingItenaryVC()
                Utility.shared.isfromTripsPage = false
                itenaryPageObj.getbillingArray = self.getbillingArray
                itenaryPageObj.currencyvalue_from_API_base = self.currencyvalue_from_API_base
                itenaryPageObj.createReservationAPICall(reservationid: (result?.data?.createReservation?.results?.id!)!)
                self.lottieWholeView.isHidden = true
                self.lottieView.isHidden = true
                itenaryPageObj.modalPresentationStyle = .fullScreen
                self.present(itenaryPageObj, animated: true, completion: nil)
            } else {
                // Fallback on earlier versions
            }
            }
        }
        
        
        
    }
    @objc func listBtnTapped(_ sender: UIButton)
    {
        if Utility().isConnectedToNetwork(){
            let guestdetailObj = GuestDetailVC()
            Utility.shared.unpublish_preview_check = false
            guestdetailObj.listID = viewListingArray.id!
            guestdetailObj.currencyvalue_from_API_base = Utility.shared.currencyvalue_from_API_base
            guestdetailObj.currency_Dict = Utility.shared.currency_Dict
            guestdetailObj.modalPresentationStyle = .fullScreen
            self.present(guestdetailObj, animated: true, completion: nil)
        }
        else
        {
            self.view.endEditing(true)
            self.offlineView.isHidden = false
            self.bottomView.isHidden = true
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
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-85, width: FULLWIDTH, height: 55)
            }else{
                offlineView.frame = CGRect.init(x: 0, y: FULLHEIGHT-55, width: FULLWIDTH, height: 55)
            }
            
        }
    }
    
    
    
  
}


extension BookingStepFourVC: STPAuthenticationContext {
    func authenticationPresentingViewController() -> UIViewController {
        return self
    }
}

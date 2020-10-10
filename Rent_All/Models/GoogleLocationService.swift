//
//  GoogleLocationService.swift
//  Rent_All
//
//  Created by Radicalstart on 30/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Alamofire


class GoogleLocationService: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    public func getlocationFromAddress(address:String, onSuccess success: @escaping (NSDictionary) -> Void)
    {
        let urlString:String = "https://maps.google.com/maps/api/geocode/json?sensor=false&address=\(address)&key=\(GOOGLE_API_KEY)"
        let finalURL =  urlString.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)
        let GetBaseUrl = URL(string: finalURL!)!
        
        print("BASE URL : \(String(describing: GetBaseUrl))")
        if Utility().isConnectedToNetwork(){
            //webservice call
            Alamofire.request(GetBaseUrl, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {response in
                let JSON = response.result.value as? NSDictionary
                
                switch response.result {
                case .success:
                    print("RESPONSE SUCCESS: \(JSON!)")
                    success(JSON!)
                    break
                case .failure(let error):
                    print("FAILURE RESPONSE: \(error.localizedDescription)")
                    if error._code == NSURLErrorTimedOut{
                    
                    }else if error._code == NSURLErrorNotConnectedToInternet{
                       
                    }else{
                      
                    }
                }
            })
        }
    }
}

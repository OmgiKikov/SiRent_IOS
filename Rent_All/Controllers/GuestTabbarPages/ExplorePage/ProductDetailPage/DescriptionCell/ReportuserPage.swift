//
//  ReportuserPage.swift
//  Rent_All
//
//  Created by RadicalStart on 28/11/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import Apollo
import Lottie
class ReportuserPage: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    
    @IBOutlet var saveBtn: UIButton!
    @IBOutlet var topview: UIView!
    @IBOutlet var reportuserTable: UITableView!
    
    
    @IBOutlet var backBtn: UIButton!
    
    var selectedArray = [String]()
    var reportType = String()
     var lottieView: LOTAnimationView!
    
    let apollo_headerClient: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
        
        let url = URL(string:graphQLEndpoint)!
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
        
    }()
    var reportAPIArray = [String]()
    var profileid = Int()
    
    var reportcontentArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
      self.registerCell()
        reportuserTable.estimatedRowHeight = 50
        reportuserTable.rowHeight = UITableView.automaticDimension
        reportcontentArray = ["\((Utility.shared.getLanguage()?.value(forKey:"shoudnotavailable"))!)","\((Utility.shared.getLanguage()?.value(forKey:"attemptinfo"))!)","\((Utility.shared.getLanguage()?.value(forKey:"inappropriatespam"))!)"]
        reportAPIArray = ["shouldnt_available","direct_contact","spam"]
        saveBtn.layer.cornerRadius = 6.0
        saveBtn.layer.masksToBounds = true
        lottieView = LOTAnimationView.init(name: "animation_white")
        saveBtn.isEnabled = false
        saveBtn.backgroundColor = Theme.PRIMARY_COLOR.withAlphaComponent(0.3)
        self.saveBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"submit"))!)", for: .normal)
        // Do any additional setup after loading the view.
    }

    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func saveBtnTapped(_ sender: Any) {
        if Utility().isConnectedToNetwork(){
       
      self.reportUserAPICall(reportType: reportType, profileid: profileid)
        
        }
        else
        {
            self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)")
            
        }
    }
    
    func registerCell()
    {
        reportuserTable.register(UINib(nibName: "ReportuserheaderCell", bundle: nil), forCellReuseIdentifier: "ReportuserheaderCell")
        reportuserTable.register(UINib(nibName: "ReportuserSelectionCell", bundle: nil), forCellReuseIdentifier: "ReportuserSelectionCell")
       
    }
    func lottieanimation()
    {
        saveBtn.setTitle("", for:.normal)
        lottieView = LOTAnimationView.init(name: "animation_white")
        
        self.lottieView.isHidden = false
        self.lottieView.frame = CGRect(x:saveBtn.frame.size.width/2-60, y:-25, width:100, height:100)
        self.saveBtn.addSubview(self.lottieView)
        self.lottieView.backgroundColor = UIColor.clear
        self.lottieView.play()
        // animation_white.json
        Timer.scheduledTimer(timeInterval:0.3, target: self, selector: #selector(autoscroll), userInfo: nil, repeats: true)
    }
    @objc func autoscroll()
    {
        self.lottieView.play()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReportuserheaderCell", for: indexPath)as! ReportuserheaderCell
           
            cell.selectionStyle = .none
            return cell
        }
        else if(indexPath.section == 1)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReportuserSelectionCell", for: indexPath)as! ReportuserSelectionCell
            cell.selectionStyle = .none
            cell.reportuserLabel.text = reportcontentArray[indexPath.section-1]
            if(selectedArray.contains(reportcontentArray[indexPath.section-1]))
            {
                cell.selectionImg.image = #imageLiteral(resourceName: "profile_Verify_Tick")
            }
            else
            {
             cell.selectionImg.image = #imageLiteral(resourceName: "price_unclick")
            }
            return cell
        }
        else if(indexPath.section == 2)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReportuserSelectionCell", for: indexPath)as! ReportuserSelectionCell
          cell.reportuserLabel.text = reportcontentArray[indexPath.section-1]
            if(selectedArray.contains(reportcontentArray[indexPath.section-1]))
            {
                cell.selectionImg.image = #imageLiteral(resourceName: "profile_Verify_Tick")
            }
            else
            {
                cell.selectionImg.image = #imageLiteral(resourceName: "price_unclick")
            }
            cell.selectionStyle = .none
            return cell
            
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReportuserSelectionCell", for: indexPath)as! ReportuserSelectionCell
            cell.reportuserLabel.text = reportcontentArray[indexPath.section-1]
            if(selectedArray.contains(reportcontentArray[indexPath.section-1]))
            {
                cell.selectionImg.image = #imageLiteral(resourceName: "profile_Verify_Tick")
            }
            else
            {
                cell.selectionImg.image = #imageLiteral(resourceName: "price_unclick")
            }
            cell.selectionStyle = .none
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         if Utility().isConnectedToNetwork(){
            if(indexPath.section > 0)
            {
        if(selectedArray.contains(reportcontentArray[indexPath.section-1]))
        {
            saveBtn.isEnabled = false
            saveBtn.backgroundColor = Theme.PRIMARY_COLOR.withAlphaComponent(0.3)
          selectedArray.removeAll()
        }
        else
            {
            selectedArray.removeAll()
            selectedArray.append(reportcontentArray[indexPath.section-1])
            reportType = reportAPIArray[indexPath.section-1]
                saveBtn.isEnabled = true
                saveBtn.backgroundColor = Theme.PRIMARY_COLOR.withAlphaComponent(1.0)
        }
        reportuserTable.reloadData()
            }
        }
        else
         {
           self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"error_field"))!)")
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func reportUserAPICall(reportType:String,profileid:Int)
    {
        
        let reportuserMutation = CreateReportUserMutation(reporterId:Utility.shared.getCurrentUserID()! as String, reportType: reportType, profileId:profileid)
        apollo_headerClient.perform(mutation: reportuserMutation){(result,error) in
            
            
            if (result?.data?.createReportUser?.status == 200)
                
            {
                self.lottieView.isHidden = true
                self.saveBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"submit"))!)", for: .normal)
                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"reportalert"))!)")
           
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    // code to remove your view
                    self.dismiss(animated: true, completion: nil)
                }
                
            }
            else
            {
                self.lottieView.isHidden = true
                self.saveBtn.setTitle("\((Utility.shared.getLanguage()?.value(forKey:"submit"))!)", for: .normal)
                self.view.makeToast("\((Utility.shared.getLanguage()?.value(forKey:"reportalert"))!)")
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

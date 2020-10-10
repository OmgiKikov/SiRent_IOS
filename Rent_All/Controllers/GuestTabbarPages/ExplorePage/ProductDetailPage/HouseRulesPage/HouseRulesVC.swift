//
//  HouseRulesVC.swift
//  Rent_All
//
//  Created by RadicalStart on 17/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class HouseRulesVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var houseTitleLabel: UILabel!
    
    @IBOutlet weak var houseTV: UITableView!
    @IBOutlet weak var topView: UIView!
    
    var houserulesArray = [ViewListingDetailsQuery.Data.ViewListing.Result.HouseRule]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()

        // Do any additional setup after loading the view.
    }
    func initialSetup()
    {
    houseTV.register(UINib(nibName: "EditAboutCell", bundle: nil), forCellReuseIdentifier: "EditAboutCell")
        
   houseTitleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"houserules"))!)"
        
    }

    @IBAction func closeBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK:TABLEVIEW DELEGATE & DATASOURCE MRTHODS*********************************************************************>
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return houserulesArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "EditAboutCell", for: indexPath)as! EditAboutCell
        cell.rightArrowimg.isHidden = true
        cell.selectionStyle = .none
        cell.editLabel.isHidden = true
        cell.aboutLabel.text = houserulesArray[indexPath.row].itemName!
        return cell
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

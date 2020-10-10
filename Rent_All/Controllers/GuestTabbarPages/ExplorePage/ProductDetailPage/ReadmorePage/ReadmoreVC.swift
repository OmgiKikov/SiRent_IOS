//
//  ReadmoreVC.swift
//  Rent_All
//
//  Created by RadicalStart on 05/04/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class ReadmoreVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var readmoreTable: UITableView!
    
     var ReadmoreText = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        readmoreTable.estimatedRowHeight = 100.0 //you can provide any
        readmoreTable.rowHeight = UITableView.automaticDimension
        readmoreTable.register(UINib(nibName: "ReadmoreCell", bundle: nil), forCellReuseIdentifier: "ReadmoreCell")
        if IS_IPHONE_5{
            
            readmoreTable.frame = CGRect(x: 0, y:75, width: FULLWIDTH+55, height:FULLHEIGHT+25)
        }
        else if IS_IPHONE_XR
        {
            
            readmoreTable.frame = CGRect(x: 0, y:75, width: FULLWIDTH-40, height:FULLHEIGHT)
            
        }
        titleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"details"))!)"
        // Do any additional setup after loading the view.
    }

    
    //MARK:*************************************** TABLEVIEW DELEGATE & DATASOURCE METHODS *************************************>
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReadmoreCell", for: indexPath)as! ReadmoreCell
        cell.selectionStyle = .none
        if(ReadmoreText != nil)
        {
        cell.descriptionLabel.text = ReadmoreText
        }
        else{
        cell.descriptionLabel.text = ""
        }
        cell.descriptionLabel.sizeToFit()
        return cell
        //return 1
        
    }
    @IBAction func closeBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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

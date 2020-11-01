//
//  CancellationVC.swift
//  Rent_All
//
//  Created by RadicalStart on 17/05/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class CancellationVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var cancellationTable: UITableView!
    
    @IBOutlet weak var headerView: UIView!
    var cancellationArray = NSMutableArray()
     var isShowmoreClicked:Bool = false
    var cancelpolicy = String()
    var cancelpolicy_content = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        cancellationTable.estimatedRowHeight = 200//you can provide any
//        cancellationTable.rowHeight = UITableView.automaticDimension
        cancellationTable.register(UINib(nibName: "CancellationCell", bundle: nil), forCellReuseIdentifier: "CancellationCell")
        cancellationTable.register(UINib(nibName: "ReadmoreCell", bundle: nil), forCellReuseIdentifier: "ReadmoreCell")
        if IS_IPHONE_5{
            
            cancellationTable.frame = CGRect(x: 0, y:0, width: FULLWIDTH+55, height:FULLHEIGHT+25)
        }

        
        let shadowSize : CGFloat = 3.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.headerView.frame.size.width+40 + shadowSize,
                                                   height: self.headerView.frame.size.height + shadowSize))
        
        self.headerView.layer.masksToBounds = false
        self.headerView.layer.shadowColor = TextLightColor.cgColor
        self.headerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.headerView.layer.shadowOpacity = 0.3
        self.headerView.layer.shadowPath = shadowPath.cgPath

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK:*************************************** TABLEVIEW DELEGATE & DATASOURCE METHODS *************************************>
    
      func numberOfSections(in tableView: UITableView) -> Int {
        if(!isShowmoreClicked)
        {
            return 1
        }
        else
        {
            return 2
        }
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isShowmoreClicked)
        {
        if(section == 0)
        {
            return 1
        }
        return 1
        }
        else
        {
        return 1
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(isShowmoreClicked)
        {
            if(indexPath.section == 0)
            {
                return 465
            }
            else if(indexPath.section == 1)
            {
               
                if IS_IPHONE_X || IS_IPHONE_678{
                    if Utility.shared.getAppLanguageCode() == "en" || Utility.shared.getAppLanguageCode() == "En"{
                     
                         return 920
                    }else{
                         return  1100
                    }
                   
                }else{
                    
                    if Utility.shared.getAppLanguage() == "Français"{
                        return  930
                    }else{
                       return 850
                    }
                    
                }
            }
        }
       
        return 465
        
 }
    
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?
    {
        if(section == 0){
            if(!isShowmoreClicked){
                return "\((Utility.shared.getLanguage()?.value(forKey:"getdetails"))!)"
            }
            else{
            return ""
            }
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.white
        
        let showmore = UIButton()
        showmore.frame = CGRect(x: 32, y:10, width:tableView.bounds.size.width, height:30)
        showmore.backgroundColor = UIColor.white
        showmore.setTitleColor(Theme.PRIMARY_COLOR, for: .normal)
        showmore.titleLabel?.font =  UIFont(name: "Circular-Book", size:18)
        showmore.contentHorizontalAlignment = .left
        showmore.setTitle(self.tableView(tableView, titleForFooterInSection: section), for: .normal)
        showmore.tag = section
        showmore.addTarget(self, action: #selector(addBtnTapped(_:)), for: .touchUpInside)
        footerView.addSubview(showmore)
        
        return footerView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if(section==0){
            if(!isShowmoreClicked){
            return 40
            }
            return 0
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0)
        {
           let cell = tableView.dequeueReusableCell(withIdentifier: "CancellationCell", for: indexPath)as! CancellationCell
//            cell.flexibleLabel.text = "\(cancelpolicy): \(cancelpolicy_content)"
            cell.selectionStyle = .none
           // isShowmoreClicked = false
            return cell
        }
       else
        {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReadmoreCell", for: indexPath)as! ReadmoreCell
       // cell.descriptionLabel.attributedText = add(stringList: cancellationArray as! [String], font: cell.descriptionLabel.font, bullet: "")
        let description = "\((Utility.shared.getLanguage()?.value(forKey:"cleaningdescription"))!)"
            
            cell.descriptionLabel?.attributedText = NSAttributedString(string:description,
                                                                attributes: [NSAttributedString.Key.foregroundColor:TextDarkColor])
        //cell.descriptionLabel.frame = CGRect(x: 50, y: 0, width: FULLWIDTH-20, height:1500)
        cell.descriptionLabel.textColor = TextDarkColor
        cell.descriptionLabel.numberOfLines = 0
        cell.selectionStyle = .none
        return cell
        }
    }
    
    func add(stringList: [String],
             font: UIFont,
             bullet: String = "\u{2022}",
             indentation: CGFloat = 20,
             lineSpacing: CGFloat = 2,
             paragraphSpacing: CGFloat = 12,
             textColor: UIColor = .gray,
             bulletColor: UIColor = .black) -> NSAttributedString {
        
        let textAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: textColor]
        let bulletAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: bulletColor]
        
        let paragraphStyle = NSMutableParagraphStyle()
        let nonOptions = [NSTextTab.OptionKey: Any]()
        paragraphStyle.tabStops = [
            NSTextTab(textAlignment: .left, location: indentation, options: nonOptions)]
        paragraphStyle.defaultTabInterval = indentation
        //paragraphStyle.firstLineHeadIndent = 0
        //paragraphStyle.headIndent = 20
        //paragraphStyle.tailIndent = 1
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.paragraphSpacing = paragraphSpacing
        paragraphStyle.headIndent = indentation
        
        let bulletList = NSMutableAttributedString()
        for string in stringList {
            let formattedString = "\(bullet)\t\(string)\n"
            let attributedString = NSMutableAttributedString(string: formattedString)
            
            attributedString.addAttributes(
                [NSAttributedString.Key.paragraphStyle : paragraphStyle],
                range: NSMakeRange(0, attributedString.length))
            
            attributedString.addAttributes(
                textAttributes,
                range: NSMakeRange(0, attributedString.length))
            
            let string:NSString = NSString(string: formattedString)
            let rangeForBullet:NSRange = string.range(of: bullet)
            attributedString.addAttributes(bulletAttributes, range: rangeForBullet)
            bulletList.append(attributedString)
        }
        
        return bulletList
    }

    
    @objc func addBtnTapped(_ sender: UIButton){
        let btnsendtag: UIButton = sender
        btnsendtag.setTitle("", for: .normal)
        isShowmoreClicked = true
        cancellationTable.reloadData()
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

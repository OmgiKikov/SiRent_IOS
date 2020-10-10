//
//  ReviewShowVC.swift
//  Rent_All
//
//  Created by RadicalStart on 10/07/20.
//  Copyright © 2020 RADICAL START. All rights reserved.
//

import UIKit
import Apollo

class ReviewShowVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    

    @IBOutlet weak var reviewTable: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    var apollo_headerClient: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["auth": "\(Utility.shared.getCurrentUserToken()!)"] // Replace `<token>`
        
        let url = URL(string:graphQLEndpoint)!
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()
    var reiewListingArray = [UserReviewsQuery.Data.UserReview.Result]()
    var profileID = Int()
    var pageIndex : Int = 1
    var reviewcount = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewTable.register(UINib(nibName: "ReviewlistCellTableViewCell", bundle: nil), forCellReuseIdentifier: "ReviewlistCellTableViewCell")
        if(reviewcount > 1)
        {
            titleLabel.text = "\(reviewcount) \((Utility.shared.getLanguage()?.value(forKey:"reviews"))!)"
              
        }
        else{
            titleLabel.text = "\(reviewcount) \((Utility.shared.getLanguage()?.value(forKey:"review"))!)"
            
        }
  self.reviewcountAPICall(profileid:profileID)
       
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
        // Do any additional setup after loading the view.
    }

    @IBAction func closeBtnTapped(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reiewListingArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewlistCellTableViewCell", for: indexPath)as! ReviewlistCellTableViewCell
        cell.selectionStyle = .none
       // cell.nameLabel.text = ""
        if(reiewListingArray[indexPath.row].reviewContent != nil){
            cell.messageLabel.text = reiewListingArray[indexPath.row].reviewContent!}
        else{
            cell.messageLabel.text = ""
        }
        if(self.reiewListingArray[indexPath.row].createdAt != nil){
        cell.dateLabel.text = self.timestampconvert(timestamp:self.reiewListingArray[indexPath.row].createdAt!)
        }
        if(self.reiewListingArray[indexPath.row].isAdmin! == true){
            cell.profileImg.image = #imageLiteral(resourceName: "adminAvatar")
            cell.nameLabel.text = "Verify by RentALL"
        }
        else
        {
            let profImage = (reiewListingArray[indexPath.row].authorData?.fragments.profileFields.picture!)!
            cell.profileImg.sd_setImage(with: URL(string:"\(IMAGE_AVATAR_MEDIUM)\(String(describing: profImage))"),placeholderImage: #imageLiteral(resourceName: "adminAvatar"))
            cell.nameLabel.text = "\((reiewListingArray[indexPath.row].authorData?.fragments.profileFields.firstName!)!) \((reiewListingArray[indexPath.row].authorData?.fragments.profileFields.lastName!)!)"
        }
        cell.profileImg.layer.cornerRadius = cell.profileImg.frame.size.width/2
        cell.profileImg.layer.masksToBounds = true
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func reviewcountAPICall(profileid:Int)
      {
          let reviewListquery = UserReviewsQuery(ownerType: "others", currentPage:pageIndex, profileId: profileid)
          
          apollo_headerClient.fetch(query: reviewListquery){(result,error) in
              
              
            guard (result?.data?.userReviews?.results) != nil else{
                  print("Missing Data")
                  return
              }
            self.reiewListingArray.append(contentsOf: ((result?.data?.userReviews?.results)!) as! [UserReviewsQuery.Data.UserReview.Result])
       
            
           //   self.reiewListingArray = (result?.data?.userReviews?.results)! as! [UserReviewsQuery.Data.UserReview.Result]
             
            self.reviewTable.reloadData()
            // self.timestampconvert(timestamp:)
          }
          
      }
    func timestampconvert(timestamp:String) -> String
      {
          let timestamValue = Int(timestamp)!/1000
          let newTime = Date(timeIntervalSince1970: TimeInterval(timestamValue))
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "MMMM yyyy" //Specify your format that you want
          
        let reviewDate = dateFormatter.string(from: newTime)
        return reviewDate
      }
      func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
      {
        let totalPages = (reviewcount/10)
               let height = scrollView.frame.size.height
               let contentYoffset = scrollView.contentOffset.y
               let distanceFromBottom = scrollView.contentSize.height - contentYoffset
               if((self.reviewTable.contentOffset.y + self.reviewTable.bounds.height) >= self.reviewTable.contentSize.height)
               {
                   //   if distanceFromBottom < height {
                   if(totalPages >= pageIndex){
                       self.pageIndex = self.pageIndex + 1
                        self.reviewcountAPICall(profileid:profileID)
                       
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

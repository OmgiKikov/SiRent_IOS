//
//  CustomHostTabbar.swift
//  Rent_All
//
//  Created by RadicalStart on 24/07/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit

class CustomHostTabbar: UITabBarController,UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.configureTabBarView()
        self.tabBar.tintColor = Red_color
        self.tabBar.unselectedItemTintColor = .black
        self.delegate = self
        
        
        //  bannerViewConfig()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: setup tab bar colors
    func configureTabBarView()  {
        self.tabBar.backgroundColor = .white
        self.tabBar.barTintColor = .white
        self.view.backgroundColor = .white
        self.ConfigureView()
    }
    
    //MARK: setup bottom tab bar
    func ConfigureView() {
        //ExplorePageVC
        let exploreObj = HostListingVC()
        self.config(viewController:exploreObj, selImg:#imageLiteral(resourceName: "tablisting_red"),unselectImg:#imageLiteral(resourceName: "home-25-2"), index:0,title:"LISTINGS")
        //SavedPageVC
        let saveObj = HostCalendarVC()
        self.config(viewController:saveObj, selImg: #imageLiteral(resourceName: "tabcalendar_red"),unselectImg:#imageLiteral(resourceName: "calendar-25-2"), index:1,title:"CALENDAR")
        // TripsMainVC
        let tripsObj = HostProgressVC()
        self.config(viewController:tripsObj,selImg:#imageLiteral(resourceName: "tabtrip_red"),unselectImg:#imageLiteral(resourceName: "tabtrip"), index:2,title:"PROGRESS")
        // TripsMessageVC
        let messgaeObj = TripsMessageVC()
        self.config(viewController:messgaeObj,selImg:#imageLiteral(resourceName: "tabchat_red"),unselectImg:#imageLiteral(resourceName: "tabchat"), index:3,title:"INBOX")
        //ProfilePageVC
        let profileObj = ProfilePageVC()
        self.config(viewController:profileObj,selImg:#imageLiteral(resourceName: "tabprofile_red"),unselectImg:#imageLiteral(resourceName: "tabprofile"), index:4,title:"PROFILE")
        
        let tabBarList = [exploreObj,saveObj,tripsObj,messgaeObj,profileObj]
        viewControllers = tabBarList
        self.selectedIndex  = Utility.shared.tabHostIndex()
        
    }
    
    //configure tabBarItem
    func config(viewController:UIViewController,selImg:UIImage, unselectImg:UIImage,index:Int,title:String) {
        let iconImageView = UIImageView()
        iconImageView.image = unselectImg
        let customBarItem = UITabBarItem.init(title:title, image: unselectImg, selectedImage: selImg.withRenderingMode(.alwaysOriginal))
        // change and adjust center icon by using image insets
        customBarItem.imageInsets = UIEdgeInsets(top:2, left: 0, bottom: -2, right: 0)
        viewController.tabBarItem = customBarItem
    }
    
    //table view delegate
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        //DispatchQueue.main.async {
            //apply spring animation
            let index = self.tabBar.items?.index(of: item)
            let subView = tabBar.subviews[index!].subviews.first as! UIImageView
            self.performSpringAnimation(imgView: subView)
       // }
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if(viewController is ProfilePageVC)
        {
            if((Utility.shared.getCurrentUserToken()) == nil || (Utility.shared.getCurrentUserToken()) == "")
            {
                let welcomeObj = SignInViewController()
                welcomeObj.modalPresentationStyle = .fullScreen
                self.present(welcomeObj, animated:false, completion: nil)
                //  appDelegate.setInitialViewController(initialView: welcomeObj)
            }

        }
        else if(viewController is TripsMessageVC)
        {
            if((Utility.shared.getCurrentUserToken()) == nil || (Utility.shared.getCurrentUserToken()) == "")
            {
                let welcomeObj = SignInViewController()
                  welcomeObj.modalPresentationStyle = .fullScreen
                self.present(welcomeObj, animated:false, completion: nil)
                //  appDelegate.setInitialViewController(initialView: welcomeObj)
            }
//            else
//            {
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                Utility.shared.setHostTab(index:3)
//                appDelegate.setInitialViewController(initialView:CustomHostTabbar())
//            }
            
            
        }
        else if(viewController is HostProgressVC)
        {
            if((Utility.shared.getCurrentUserToken()) == nil || (Utility.shared.getCurrentUserToken()) == "")
            {
                let welcomeObj = SignInViewController()
                  welcomeObj.modalPresentationStyle = .fullScreen
                self.present(welcomeObj, animated:false, completion: nil)
                //  appDelegate.setInitialViewController(initialView: welcomeObj)
            }
//            else
//            {
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                Utility.shared.setHostTab(index: 2)
//                appDelegate.setInitialViewController(initialView:CustomHostTabbar())
//            }
            
        }
        else if(viewController is HostCalendarVC)
        {
            if((Utility.shared.getCurrentUserToken()) == nil || (Utility.shared.getCurrentUserToken()) == "")
            {
                let welcomeObj = SignInViewController()
                welcomeObj.modalPresentationStyle = .fullScreen
                self.present(welcomeObj, animated:false, completion: nil)
                //  appDelegate.setInitialViewController(initialView: welcomeObj)
            }
//            else
//            {
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                Utility.shared.setHostTab(index: 1)
//                appDelegate.setInitialViewController(initialView:CustomHostTabbar())
//            }
            
        }
        
    }
    
    
    
    
    //func to perform spring animation on imageview
    func performSpringAnimation(imgView: UIImageView) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            imgView.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
            //reducing the size
            UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                imgView.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }) { (flag) in
            }
        }) { (flag) in
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

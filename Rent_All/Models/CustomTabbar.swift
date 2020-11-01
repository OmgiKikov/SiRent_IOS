//
//  CustomTabbar.swift
//  Rent_All
//
//  Created by RadicalStart on 13/06/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import MaterialComponents

class CustomTabbar: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTabBarView()
        self.tabBar.tintColor = Red_color
        self.tabBar.unselectedItemTintColor = .black
        self.delegate = self
    
        if let tabItems = self.tabBar.items {

        }
       
      //  bannerViewConfig()
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }

    // MARK: setup tab bar colors
    func configureTabBarView()  {
        self.tabBar.backgroundColor = .white
        self.tabBar.barTintColor = .white
        self.view.backgroundColor = .white
        self.ConfigureView()
    }
  func configBtn(){
        let floatingButton = MDCFloatingButton()
        floatingButton.setImage( #imageLiteral(resourceName: "rentall").withRenderingMode(.alwaysTemplate), for: .normal)
        floatingButton.tintColor = .black
        floatingButton.backgroundColor = .white
        floatingButton.setElevation(ShadowElevation(rawValue: 6), for: .normal)
        if(IS_IPHONE_X){
            floatingButton.frame = CGRect(x:0.0, y:FULLHEIGHT - 77, width:48, height:75)
        }else{
            floatingButton.frame = CGRect(x:0.0, y:FULLHEIGHT - 60, width:50, height:50)
            
        }
        floatingButton.center = CGPoint(x:self.tabBar.center.x , y: floatingButton.center.y)
         self.view.addSubview(floatingButton)
    }
    @objc func goLiveBtnTapped()  {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.isFrontCameraSelected = true
//        let goliveObj  = GoLiveStartPage()
//        self.navigationController?.present(goliveObj, animated: true, completion: nil)
    }
    func setBottomBorder()  {
        let selectedImageView = UIView()
        selectedImageView.frame = CGRect.init(x: self.tabBar.frame.origin.x, y: self.tabBar.frame.origin.y, width: self.tabBar.frame.size.width/5, height: 49)
        
        let borderImgView = UIImageView()
        borderImgView.frame = CGRect.init(x: selectedImageView.frame.origin.x, y: selectedImageView.frame.size.height-2, width: self.tabBar.frame.size.width/5, height: 3)
        borderImgView.backgroundColor = .clear
        selectedImageView.addSubview(borderImgView)
        self.tabBar.selectionIndicatorImage = changeSelectionView(toImage: selectedImageView)
    }
    func changeSelectionView(toImage viewForImage: UIView) -> UIImage {
        UIView.transition(from: viewForImage, to: viewForImage, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        
        UIGraphicsBeginImageContext(viewForImage.bounds.size)
        viewForImage.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img ?? UIImage()
    }
    //MARK: setup bottom tab bar
    func ConfigureView() {
        //ExplorePageVC
        let exploreObj = ExplorePageVC()
        print(Utility.shared.getLanguage()?.value(forKey: "tabexplore"))
        
        self.config(viewController:exploreObj, selImg:#imageLiteral(resourceName: "tabsearch_red"),unselectImg:#imageLiteral(resourceName: "tabsearch"), index: 0,title:"Главная")
        //SavedPageVC
        let saveObj = SavedPageVC()
        self.config(viewController:saveObj, selImg: #imageLiteral(resourceName: "tabsaved_red"),unselectImg:#imageLiteral(resourceName: "tabsaved"), index: 1,title:"Избранное")
        // TripsMainVC
        let tripsObj = TripsMainVC()
        self.config(viewController:tripsObj,selImg:#imageLiteral(resourceName: "tabtrip_red"),unselectImg:#imageLiteral(resourceName: "tabtrip"), index: 2,title:"Поездки")
        // TripsMessageVC
        let messgaeObj = TripsMessageVC()
        self.config(viewController:messgaeObj,selImg:#imageLiteral(resourceName: "tabchat_red"),unselectImg:#imageLiteral(resourceName: "tabchat"), index:3,title:"Сообщения")
        //ProfilePageVC
        let profileObj = ProfilePageVC()
        self.config(viewController:profileObj,selImg:#imageLiteral(resourceName: "tabprofile_red"),unselectImg:#imageLiteral(resourceName: "tabprofile"), index:4,title:"Профиль")
       
        //self.configBtn()
        let tabBarList = [exploreObj,saveObj,tripsObj,messgaeObj,profileObj]
        viewControllers = tabBarList
        self.selectedIndex  = Utility.shared.tabIndex()
//        if(Utility.shared.tabIndex() == 4)
//        {
       
       // }
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
        DispatchQueue.main.async {
            //apply spring animation
            let index = self.tabBar.items?.index(of: item)
            let subView = tabBar.subviews[index!+1].subviews.first as! UIImageView
            self.performSpringAnimation(imgView: subView)
        }
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if(viewController is ProfilePageVC)
        {
             if((Utility.shared.getCurrentUserToken()) == nil || (Utility.shared.getCurrentUserToken()) == "")
             {
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let welcomeObj = WelcomePageVC()
               // self.present(welcomeObj, animated:false, completion: nil)
                appDelegate.setInitialViewController(initialView: welcomeObj)
            }

        }
        else if(viewController is SavedPageVC)
        {
            if((Utility.shared.getCurrentUserToken()) == nil || (Utility.shared.getCurrentUserToken()) == "")
            {
                let welcomeObj = WelcomePageVC()
                 welcomeObj.modalPresentationStyle = .fullScreen
                
                self.present(welcomeObj, animated:false, completion: nil)
            }
        }
        else if(viewController is TripsMainVC)
        {
            if((Utility.shared.getCurrentUserToken()) == nil || (Utility.shared.getCurrentUserToken()) == "")
            {
                
                let welcomeObj = WelcomePageVC()
                 welcomeObj.modalPresentationStyle = .fullScreen
                self.present(welcomeObj, animated:false, completion: nil)
                //  appDelegate.setInitialViewController(initialView: welcomeObj)
            }
        }
        else if(viewController is TripsMessageVC)
        {
            if((Utility.shared.getCurrentUserToken()) == nil || (Utility.shared.getCurrentUserToken()) == "")
            {
                
                let welcomeObj = WelcomePageVC()
                 welcomeObj.modalPresentationStyle = .fullScreen
                self.present(welcomeObj, animated:false, completion: nil)
                //  appDelegate.setInitialViewController(initialView: welcomeObj)
            }
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
extension UIButton{
    func setButtonCornerRadius() {
        //self.layer.cornerRadius = self.frame.size.height/2
        self.layer.cornerRadius = 35.0
        self.clipsToBounds = true
    }
    
}

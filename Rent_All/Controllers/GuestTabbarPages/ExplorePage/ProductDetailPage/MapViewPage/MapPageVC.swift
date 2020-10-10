//
//  MapPageVC.swift
//  Rent_All
//
//  Created by RadicalStart on 05/04/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker

class MapPageVC: UIViewController,GMSMapViewDelegate {

    @IBOutlet weak var locationTitleLabel: UILabel!
    
    var mapView: GMSMapView!
    var cirlce: GMSCircle!
    var mapArray = ViewListingDetailsQuery.Data.ViewListing.Result()
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var HeadlocationLabel: UILabel!
    
    @IBOutlet weak var bookingLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let lat = mapArray.lat!
        let long = mapArray.lng!
        let camera = GMSCameraPosition.camera(withLatitude: lat,
                                                          longitude: long, zoom:15)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        self.view = mapView
         headerView.frame = CGRect(x: 0, y: 0, width: FULLWIDTH, height: 80)
        mapView.addSubview(headerView)
       // mapView.frame = CGRect(x: 0, y: 54, width: FULLWIDTH, height: FULLHEIGHT-134)
        bottomView.frame = CGRect(x: 0, y: FULLHEIGHT-78, width: FULLWIDTH, height: 78)
        mapView.addSubview(bottomView)
        mapView.delegate = self
//        do {
//            if let styleURL = Bundle.main.url(forResource: "Style", withExtension: "json") {
//                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
//            } else {
//                print("Unable to find style.json")
//            }
//        } catch {
//            print("One or more of the map styles failed to load. \(error)")
//        }
        cirlce = GMSCircle(position: camera.target, radius:400)
        cirlce.fillColor = UIColor(red: 0.0/255.0, green: 132.0/255.0, blue: 135.0/255.0, alpha:0.3)
        cirlce.strokeColor = Theme.PRIMARY_COLOR
        cirlce.strokeWidth = 2.5;
        cirlce.map = mapView
        HeadlocationLabel.text = "\(mapArray.title!) in \(mapArray.city!),\(mapArray.state!),\(mapArray.country!)"
        locationTitleLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"location"))!)"
        bookingLabel.text = "\((Utility.shared.getLanguage()?.value(forKey:"exactlocation"))!)"
    }
    
    private func mapView(mapView: GMSMapView!, didChangeCameraPosition position: GMSCameraPosition!) {
        cirlce.position = position.target
    }
func initialSetup()
{
   
    
    }
  

    @IBAction func closeBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

//
//  ViewController.swift
//  myLocationWithSwift
//
//  Created by 黄少华 on 16/4/29.
//  Copyright © 2016年 黄少华. All rights reserved.
//

import UIKit
import CoreLocation
class ViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var findBtn: UIButton!
    
    var locationManager:CLLocationManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    @IBAction func find(sender: AnyObject) {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!) { (placeMarks, error) in
            if error != nil {
                self.locationLabel.text = "Reverse geocoder failed with error" + error!.localizedDescription
                return
            }
            
            if placeMarks!.count > 0 {
                let pm = placeMarks![0]
                self.displayLocationInfo(pm)
            }
        }
    }
    
    func  displayLocationInfo(placeMark:  CLPlacemark?) {
        if let containsPlaceMark = placeMark {
            locationManager.stopUpdatingLocation()
            
            let locality = (containsPlaceMark.locality != nil) ? containsPlaceMark.locality : ""
            let postalCode = (containsPlaceMark.postalCode != nil) ? containsPlaceMark.postalCode : ""
            let adminstrativeArea = (containsPlaceMark.administrativeArea != nil) ? containsPlaceMark.administrativeArea : ""
            let country = containsPlaceMark.country != nil ? containsPlaceMark.country : ""
            self.locationLabel.text = locality! + postalCode! + adminstrativeArea! + country!
            
            
        }
    }

}


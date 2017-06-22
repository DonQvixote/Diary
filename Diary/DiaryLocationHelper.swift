//
//  DiaryLocationHelper.swift
//  Diary
//
//  Created by 夏语诚 on 2017/6/22.
//  Copyright © 2017年 Banana Inc. All rights reserved.
//

import CoreLocation

class DiaryLocationHelper: NSObject, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var address: String?
    var geocoder = CLGeocoder()
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        geocoder.reverseGeocodeLocation(locations[0]) { (placemarks, error) in
            if let error = error {
                print("查询失败: \(error.localizedDescription)")
            }
            
            if let pm = placemarks {
                if pm.count > 0 {
                    let placemark = pm.first
                    self.address = placemark?.locality
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "DiaryLocationUpdated"), object: self.address)
                }
            }
        }
    }
}

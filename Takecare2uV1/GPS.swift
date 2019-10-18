//
//  GPS.swift
//  Takecare2uV1
//
//  Created by Sherlock Ohm on 12/10/2562 BE.
//  Copyright © 2562 Sherlock Ohm. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class GPS: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lbLat: UILabel!
    @IBOutlet weak var lbLong: UILabel!
    
    var locationManager = CLLocationManager()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//
//
//    @IBAction func locateMe(sender: UIBarButtonItem) {
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//
//        mapView.showsUserLocation = true
//
//    }
//
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        let lat = locValue.latitude
        let long = locValue.longitude
        // lat, long มาเป็น Double ต้องใช้ "\(lat)" เพื่อแปลงเป็น String มาแสดงบน Label
        self.lbLat.text = "\(lat)"
        self.lbLong.text = "\(long)"
        
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        let userLocation = locations.last
        let viewRegion = MKCoordinateRegion(center: (userLocation?.coordinate)!, latitudinalMeters: 600, longitudinalMeters: 600)
        self.mapView.setRegion(viewRegion, animated: true)
    }
//        let userLocation:CLLocation = locations[0] as CLLocation
//
//        manager.stopUpdatingLocation()
//        let coordinations = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,longitude: userLocation.coordinate.longitude)
//       // let span = MKCoordinateSpanMake(0.2,0.2)
//        let region = MKCoordinateRegion()
//       // let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta,longDelta)
//        mapView.setRegion(region, animated: true)
//    }
}

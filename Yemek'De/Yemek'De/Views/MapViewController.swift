//
//  MapViewController.swift
//  Yemek'De
//
//  Created by Duygu Yesiloglu on 14.10.2023.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var kuryeHiz: UILabel!
    
    @IBOutlet weak var timeGoster: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Your Order"
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        
        // 39.898203,32.8696685
        
       /* let konum = CLLocationCoordinate2D(latitude: 39.898203, longitude: 32.8696685)
        let zoom = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let bolge = MKCoordinateRegion(center: konum, span: zoom)
        mapView.setRegion(bolge, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = konum
        pin.title = "Ankara"
        pin.subtitle = "Your Order"
        mapView.addAnnotation(pin) */
        
    }

}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let sonKonum = locations[locations.count-1]
        
        let enlem = sonKonum.coordinate.latitude
        let boylam = sonKonum.coordinate.longitude
        
        let random = Int.random(in: 10...35)
        
        timeGoster.text = "At your door in 10 minutes." 
        kuryeHiz.text = "Courier speed : \(sonKonum.speed)"
        
         let konum = CLLocationCoordinate2D(latitude: enlem, longitude: boylam)
         let zoom = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
         let bolge = MKCoordinateRegion(center: konum, span: zoom)
         mapView.setRegion(bolge, animated: true)
         
         let pin = MKPointAnnotation()
         pin.coordinate = konum
         pin.title = "Order"
         pin.subtitle = "\(enlem) - \(boylam)"
         // mapView.addAnnotation(pin)
        
        mapView.showsUserLocation = true
        
        
    }
}

//
//  ViewController.swift
//  lego_map
//
//  Created by Motoki on 2023/04/24.
//

import MapKit
import UIKit
import CoreLocation

class ViewController: UIViewController ,CLLocationManagerDelegate, MKMapViewDelegate{
    
    @IBOutlet weak var mapView: MKMapView!

    let locationManager = CLLocationManager()
    var val_x :Double = 0
    var val_y :Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    @IBAction func touchpin(){
        print("touchPin")
        print(val_y)
        print(val_x)
        addPin(latitude: val_y, longitude: val_x)
        
    }
    @IBAction func getcurrent(){
        locationManager.requestLocation()
        print("getcurrentlocation")
        print(val_y)
        print(val_x)
    }
    
    func addPin(latitude: Double, longitude: Double) {
        let coordinate = CLLocationCoordinate2DMake(latitude,longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated:true)
        
        let pin = MKPointAnnotation()
        pin.title = "現在地"
        pin.subtitle = "yeah!"
        pin.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        print(pin.coordinate)
        mapView.addAnnotation(pin)

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        guard let loc = locations.last else { return }
        //CurrentLocation = locations.first
        val_x = loc.coordinate.longitude
        val_y = loc.coordinate.latitude
        print("LocationManager")
        print(val_y)
        print(val_x)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
            print("error: \(error.localizedDescription)")
        }

}


//
//  ViewController.swift
//  near_display
//
//  Created by 山本聖留 on 2023/04/27.
//

import MapKit
import UIKit
import CoreLocation
import UserNotifications

class ViewController: UIViewController ,CLLocationManagerDelegate, MKMapViewDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    let pin = MKPointAnnotation()
    var a: [MKPointAnnotation]=[]
    
    var val_x :Double = -122.38
    var val_y :Double = 37.76
    var dinamic_x :Double = 0.0
    var dinamic_y :Double = 0.0
    var text_title:String = "test"
    var text_subtitle:String = "test2"
    var id_hash : Int = 0
    var near_data :[Double:Int] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        setupLocationManager()
        sendLocalNotification()

    }
    
    func setupLocationManager() {
        //locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = 10
        locationManager.requestAlwaysAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        
        locationManager.startUpdatingLocation()
    }
    
    
    
    @IBAction func touchpin(){
        print("touchPin")
        print(val_y)
        print(val_x)
        a = addPin(latitude: val_y, longitude: val_x,pin: a)
        
    }
    @IBAction func getcurrent(){
        locationManager.requestLocation()
        print("getcurrentlocation")
        val_x = dinamic_x
        val_y = dinamic_y
        //data <------
        print("Current")
        print(val_y)
        print(val_x)
        print("-------")
        text_title = "aiueo"
        text_subtitle = "kakiku"
    }
    
    
    
    func addPin(latitude: Double, longitude: Double,pin: [MKPointAnnotation]) -> [MKPointAnnotation] {
        let coordinate = CLLocationCoordinate2DMake(latitude,longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated:true)
        var pin:[MKPointAnnotation]=pin
        let aiu = MKPointAnnotation()
        //pin.append(aiu)
        //let pin = MKPointAnnotation()
        aiu.title = text_title
        aiu.subtitle = text_subtitle
        aiu.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        pin.append(aiu)
        print(aiu.coordinate)
        mapView.addAnnotation(aiu)
        id_hash = aiu.hash
        print(aiu.hash)
        return pin
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        guard let loc = locations.last else { return }
        //CurrentLocation = locations.first
        dinamic_x = loc.coordinate.longitude
        dinamic_y = loc.coordinate.latitude
        //print("LocationManager")
        //print(dinamic_y)
        //print(dinamic_x)
        near_locate()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print("error: \(error.localizedDescription)")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation.title == "My Location"{
            return nil
        }
        
        
        let pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        //pinView.image
        
        pinView.canShowCallout = true
        
        let button = UIButton()
        button.frame = CGRect(x:0,y:0,width:60,height:70)
        button.setImage(UIImage(systemName: "trash.square"), for: .normal)
        button.tintColor = UIColor.red
        
        
        pinView.rightCalloutAccessoryView = button
        
        print(pinView)
        
        return pinView
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation else {
            return
        }
        for i in 0 ..< a.count{
            //print(a[i].hash)
            if a[i].hash == annotation.hash{
                a.remove(at: i)
                break;
            }
        }
        self.mapView.removeAnnotation(annotation)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation{
            print(annotation.title!!)
            print(annotation.hash)
            print(annotation)
        }
    }
    func near_locate(){
        print(a.count)
        var dst :Double = 0.0
        var near_range :Double = 500.0

        for i in 0 ..< a.count{
            print(a[i].coordinate.latitude)
            dst = distance(current: (la: dinamic_y,lo:dinamic_x), target: (la: a[i].coordinate.latitude,lo: a[i].coordinate.longitude))
            if dst <= near_range {
                near_data.updateValue(a[i].hash, forKey: dst)
                print("近い")
               // sendLocalNotification()
                
            }
        }
    }
    func distance(current: (la: Double, lo: Double), target: (la: Double, lo: Double)) -> Double {
            
            // 緯度経度をラジアンに変換
            let currentLa   = current.la * Double.pi / 180
            let currentLo   = current.lo * Double.pi / 180
            let targetLa    = target.la * Double.pi / 180
            let targetLo    = target.lo * Double.pi / 180
     
            // 赤道半径
            let equatorRadius = 6378137.0;
            
            // 算出
            let averageLat = (currentLa - targetLa) / 2
            let averageLon = (currentLo - targetLo) / 2
            let distance = equatorRadius * 2 * asin(sqrt(pow(sin(averageLat), 2) + cos(currentLa) * cos(targetLa) * pow(sin(averageLon), 2)))
            return distance
        }
    func sendLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "お知らせ"
        content.body = "1km以内に入りました"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: "localNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    
    
}




import MapKit
import UIKit
import CoreLocation

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        setupLocationManager()

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
        var aiu = MKPointAnnotation()
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
        print("LocationManager")
        print(dinamic_y)
        print(dinamic_x)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print("error: \(error.localizedDescription)")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation.title == "My Location"{
            return nil
        }
        //print(pin[0].annotation.title)
        
        
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
        
        self.mapView.removeAnnotation(annotation)
    }
    
    
    
}

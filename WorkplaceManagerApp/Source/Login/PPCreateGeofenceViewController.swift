import UIKit
import MapKit

public class PPCreateGeofenceViewController: PPBaseViewController {
    lazy var locationManager: CLLocationManager = {
        return CLLocationManager()
    }()
    
    lazy var customView: GeofenceView =  {
        debugPrint("init GeofenceView...")
        return GeofenceView()
    }()
    
    var currentFenceRadius: Double = 100
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initMap()
    }
    
    private func initView() {
        self.view.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        customView.primaryButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onHome)))
        customView.centerButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onCenterCurLocOnMap)))
    }
    
    private func initMap() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    private func loadCurrentLocation(location: CLLocation) {
        customView.map.delegate = self
        customView.map.showsUserLocation = false
        
        addOverlays(location: location)
        moveMapToLocation(location: location)
    }
    
    private func updateDisplay(location: CLLocation) {
        addOverlays(location: location)
        loadAddress(location: location)
    }
    
    private func addOverlays(location: CLLocation) {
        let geofenceRegionCenter = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = customView.map.region.center
        customView.map.addAnnotation(annotation)
        
        let circle = MKCircle(center: geofenceRegionCenter, radius: currentFenceRadius as CLLocationDistance)
        customView.map.addOverlay(circle)
    }
    
    @objc func onHome() {
        let home = PPTabBarController()
        UIApplication.shared.windows.first?.rootViewController = home
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    @objc func onCenterCurLocOnMap() {
        moveMapToLocation(location: locationManager.location)
    }
    
    private func moveMapToLocation(location: CLLocation?) {
        if let curLoc = location {
            let center = CLLocationCoordinate2DMake(curLoc.coordinate.latitude, curLoc.coordinate.longitude)
            customView.map.setCenter(center, animated: true)
            if let zoomDistance = CLLocationDistance(exactly: 300) {
                let region = MKCoordinateRegion( center: curLoc.coordinate,
                                                 latitudinalMeters: zoomDistance,
                                                 longitudinalMeters: zoomDistance)
                customView.map.setRegion(customView.map.regionThatFits(region), animated: true)
            }
        }
    }
    
    private func loadAddress(location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location) {
            [weak self] placemark, error in
            guard let placemark = placemark,
                let strongSelf = self,
                  error == nil else {
                return
            }
            if let placemark = placemark.first {
                var address = placemark.name
                if let thoroughfare = placemark.thoroughfare {
                    address = address?.appending(", ")
                    address = address?.appending(thoroughfare)
                }
                if let subThoroughfare = placemark.subThoroughfare {
                    address = address?.appending(", ")
                    address = address?.appending(subThoroughfare)
                }
                if let subLocality = placemark.subLocality {
                    address = address?.appending(", ")
                    address = address?.appending(subLocality)
                }
                if let locality = placemark.locality {
                    address = address?.appending(", ")
                    address = address?.appending(locality)
                }
                if let administrativeArea = placemark.administrativeArea {
                    address = address?.appending(", ")
                    address = address?.appending(administrativeArea)
                }
                if let subAdministrativeArea = placemark.subAdministrativeArea {
                    address = address?.appending(", ")
                    address = address?.appending(subAdministrativeArea)
                }
                if let postalCode = placemark.postalCode {
                    address = address?.appending(", ")
                    address = address?.appending(postalCode)
                }
                if let country = placemark.country {
                    address = address?.appending(", ")
                    address = address?.appending(country)
                }
                strongSelf.customView.addressLabel.text = address
            }
        }
    }
}

extension PPCreateGeofenceViewController: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            if let curLoc = manager.location {
                loadCurrentLocation(location: curLoc)
                loadAddress(location: curLoc)
            }
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let curLoc = manager.location {
            loadAddress(location: curLoc)
        }
    }
}

extension PPCreateGeofenceViewController: MKMapViewDelegate {
    
    public func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let circle = MKCircleRenderer(overlay: overlay)
            circle.strokeColor = UIColor.red
            circle.fillColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.1)
            circle.lineWidth = 1
            return circle
        }
        return MKPolylineRenderer()
    }
    
    public func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation is MKUserLocation {
            customView.map.deselectAnnotation(view.annotation, animated: false)
        }
    }
    
    public func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        // To Remove annotation = Point on map befor add new one
        customView.map.removeAnnotations(customView.map.annotations)
        customView.map.removeOverlays(customView.map.overlays)

        let curLoc = CLLocation(latitude: mapView.region.center.latitude, longitude: mapView.region.center.longitude)
        updateDisplay(location: curLoc)
    }
}

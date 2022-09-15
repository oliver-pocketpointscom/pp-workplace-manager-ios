import UIKit
import MapKit

public class PPCreateGeofenceViewController: PPBaseViewController {
    
    public var updateMode: Bool = false
    lazy var locationManager: CLLocationManager = {
        return CLLocationManager()
    }()
    
    lazy var customView: GeofenceView =  {
        debugPrint("init GeofenceView...")
        return GeofenceView()
    }()
    
    var currentFenceRadius: Double = 100
    
    private var fenceCoordinates: [PPLocationCoordinate2D] = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initMap()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if updateMode {
            addTitle("Company Geofencing")
        } else {
            addNavBarTitle()
        }
    }
    
    private func initView() {
        self.view.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        if updateMode {
            customView.primaryButton.setTitle("Update", for: .normal)
            customView.progressLabel.isHidden = true
        }
        
        customView.primaryButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onProceed)))
        customView.centerButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onCenterCurLocOnMap)))
        customView.addPinButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onAddPin)))
//        customView.clearPinsButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClearPins)))
        navigationController?.navigationBar.backgroundColor = .black
    }
    
    private func initMap() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    private func loadCurrentLocation(location: CLLocation) {
        customView.map.delegate = self
        customView.map.showsUserLocation = false
        
        moveMapToLocation(location: location) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.addOverlays(location: location)
        }
    }
    
    private func updateDisplay(location: CLLocation) {
        addOverlays(location: location)
        loadAddress(location: location)
    }
    
    private func addOverlays(location: CLLocation) {
        addPinOnMap(location)
    }
    
    private func addPinOnMap(_ location: CLLocation) {
        let identifier = UUID.init().uuidString
        let annotation = PPPointAnnotation(identifier: identifier)
        annotation.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        annotation.title = "Remove"
        
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.customView.map.addAnnotation(annotation)
        }
        
        let coordinate = PPLocationCoordinate2D(identifier: identifier,
                                                coordinate: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
        fenceCoordinates.append(coordinate)
    }
    
    private func clearPins() {
        fenceCoordinates = []
        customView.map.removeAnnotations(customView.map.annotations)
        customView.map.removeOverlays(customView.map.overlays)
    }
    
    @objc func onProceed() {
        confirmGeofence()
    }
    
    private func confirmGeofence() {
        let alert = UIAlertController(title: "Please confirm that the Geolocation is correct.", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: {
            [weak self ]action in
            guard let strongSelf = self else { return }
            strongSelf.onConfirm()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func onConfirm() {
        if updateMode {
            self.navigationController?.popViewController(animated: true)
        } else {
            showSubscriptionPlans()
        }
    }
    
    private func showSubscriptionPlans() {
        let vc = PPChoosePlanViewController()
        push(vc: vc)
    }
    
    @objc func onCenterCurLocOnMap() {
        moveMapToLocation(location: locationManager.location, nil)
    }
    
    @objc func onAddPin() {
        if let curLoc = locationManager.location {
            addPinOnMap(curLoc)
        }
    }
    
    @objc func onClearPins() {
        clearPins()
    }
    
    private func moveMapToLocation(location: CLLocation?, _ completion: (()-> Void)?) {
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
        completion?()
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
                strongSelf.customView.addressTextField.text = address
            }
        }
    }
    
    private func drawPolyline(_ mapView: MKMapView) {
        mapView.overlays.forEach { overlay in
            if overlay is MKPolyline || overlay is MKPolygon {
                mapView.removeOverlay(overlay)
            }
        }
        
        var coordinates = toCLLocationCoordinate2D(fenceCoordinates)
        
        if let firstFence = coordinates.first {
            coordinates.append(CLLocationCoordinate2D(latitude: firstFence.latitude, longitude: firstFence.longitude))
        }
        
        let myPolyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
        mapView.addOverlay(myPolyline)
        
        let polygon = MKPolygon(coordinates: coordinates, count: coordinates.count)
        mapView.addOverlay(polygon)
    }
    
    @objc func removePinAt(_ sender: Any?) {
        if let btn = sender as? PPButton {
            if let identifier = btn.identifier {
                fenceCoordinates = fenceCoordinates.filter { $0.identifier != identifier }
                drawPolyline(customView.map)
                customView.map.annotations.forEach { annotation in
                    if let ppAnnotation = annotation as? PPPointAnnotation {
                        if ppAnnotation.identifier == identifier {
                            customView.map.removeAnnotation(ppAnnotation)
                        }
                    }
                }
            }
        }
    }
    
    private func toCLLocationCoordinate2D(_ coordinates: [PPLocationCoordinate2D]) -> [CLLocationCoordinate2D]{
        var dest:[CLLocationCoordinate2D] = []
        for fence in coordinates {
            dest.append(CLLocationCoordinate2D(latitude: fence.coordinate.latitude, longitude: fence.coordinate.longitude))
        }
        return dest
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
        if overlay is MKPolyline {
            // draw the track
            let polyLine = overlay
            let polyLineRenderer = MKPolylineRenderer(overlay: polyLine)
            polyLineRenderer.strokeColor = UIColor.blue
            polyLineRenderer.lineWidth = 2.0
            
            return polyLineRenderer
        } else if overlay is MKPolygon {
            let coordinates = toCLLocationCoordinate2D(fenceCoordinates)
            let polygon = MKPolygon(coordinates: coordinates, count: fenceCoordinates.count)
            let renderer = MKPolygonRenderer(polygon: polygon)
            renderer.fillColor = UIColor.blue.withAlphaComponent(0.25)
            return renderer
        }
        return MKOverlayRenderer()
    }
    
    public func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation is MKUserLocation {
            customView.map.deselectAnnotation(view.annotation, animated: false)
        }
    }
    
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if let pointAnnotation = annotation as? PPPointAnnotation {
            let reuseId = "pin"
            if let annotationView = self.customView.map.dequeueReusableAnnotationView(withIdentifier: reuseId) as? PPPinAnnotationView {
                annotationView.annotation = annotation
            } else {
                let annotationView = PPPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                annotationView.isDraggable = true
                annotationView.canShowCallout = true
                let btn = PPButton(type: .detailDisclosure)
                btn.setImage(UIImage(named: "trash"), for: .normal)
                btn.tintColor = .red
                btn.identifier = pointAnnotation.identifier
                btn.addTarget(self, action: #selector(removePinAt(_:)), for: .touchUpInside)
                annotationView.rightCalloutAccessoryView = btn
                
                return annotationView
            }
        }
        
        return nil
    }
    
    public func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        drawPolyline(mapView)
    }
    
    public func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
        
        if let pointAnnotation = view.annotation as? PPPointAnnotation {
            let identifier = pointAnnotation.identifier
            fenceCoordinates.filter({$0.identifier == identifier}).first?.coordinate = pointAnnotation.coordinate
        }
        
        drawPolyline(mapView)
    }
}

class PPPinAnnotationView: MKPinAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            displayPriority = MKFeatureDisplayPriority.required
        }
    }
}

class PPPointAnnotation : MKPointAnnotation {
    var identifier: String
    
    public init(identifier: String) {
        self.identifier = identifier
    }
}

class PPLocationCoordinate2D {
    var identifier: String
    var coordinate: CLLocationCoordinate2D
    
    public init(identifier: String, coordinate: CLLocationCoordinate2D) {
        self.identifier = identifier
        self.coordinate = coordinate
    }
}

class PPButton: UIButton {
    var identifier: String?
}

import UIKit
import MapKit
import GLKit

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
    
    private lazy var viewModel: CreateGeofenceViewModel = {
       PPCreateGeofenceViewModel()
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initMap()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if updateMode {
            addTitle("Geofencing")
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
        customView.segmentedControl.addTarget(self, action: #selector(onSelectMapType), for: .valueChanged)
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
        
        let movement = CLLocationDistance(5)
        var newLocation = location.movedBy(latitudinalMeters: movement, longitudinalMeters: movement)
        
        if let lastCoordinate = fenceCoordinates.last?.coordinate {
            newLocation = CLLocation(latitude: lastCoordinate.latitude, longitude: lastCoordinate.longitude)
            newLocation = newLocation.movedBy(latitudinalMeters: movement, longitudinalMeters: movement)
        }
        
        let latitude = newLocation.coordinate.latitude
        let longitude = newLocation.coordinate.longitude
        
        let coordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let coordinate = PPLocationCoordinate2D(identifier: identifier,
                                                coordinate: coordinate2D)
        debugPrint(coordinate2D)
        fenceCoordinates.append(coordinate)
        
        annotation.coordinate = coordinate2D
        annotation.title = "Remove"
        
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.customView.map.addAnnotation(annotation)
        }
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
            updateGeofence()
        } else {
            saveGeofence()
        }
    }
    
    private func saveGeofence() {
        viewModel.createGeofence(payload: getGeofenceParameters(), completion: {
            [weak self] error in
            guard let strongSelf = self else { return }
            
            if let _ = error {
                strongSelf.showFailedToCreateGeofenceMessage()
            } else {
                strongSelf.showSubscriptionPlans()
            }
        })
    }
    
    private func getGeofenceParameters() -> CreateGeofenceParameters {
        var coordinate2D = [CLLocationCoordinate2D]()
        for f in fenceCoordinates {
            coordinate2D.append(f.toCLLocationCoordinate2D())
        }
        
        let centerOfGeofence = getCenterCoord(coordinate2D)
        let latitude = centerOfGeofence.latitude
        let longitude = centerOfGeofence.longitude
        
        let tenantId = 1
        
        var geofence = [GeofenceCoordinateParameters]()
        for fence in fenceCoordinates {
            let fenceParam = GeofenceCoordinateParameters(latitude: fence.coordinate.latitude,
                                                          longitude: fence.coordinate.longitude)
            geofence.append(fenceParam)
        }
        
        return CreateGeofenceParameters(latitude: latitude,
                                              longitude: longitude,
                                              tenantId: tenantId,
                                              geofence: geofence)
    }
    
    private func getCenterCoord(_ LocationPoints: [CLLocationCoordinate2D]) -> CLLocationCoordinate2D{
            var x:Float = 0.0;
            var y:Float = 0.0;
            var z:Float = 0.0;
            for points in LocationPoints {
                let lat = GLKMathDegreesToRadians(Float(points.latitude));
                let long = GLKMathDegreesToRadians(Float(points.longitude));

                x += cos(lat) * cos(long);

                y += cos(lat) * sin(long);

                z += sin(lat);
            }
            x = x / Float(LocationPoints.count);
            y = y / Float(LocationPoints.count);
            z = z / Float(LocationPoints.count);
            let resultLong = atan2(y, x);
            let resultHyp = sqrt(x * x + y * y);
            let resultLat = atan2(z, resultHyp);
            let result = CLLocationCoordinate2D(latitude: CLLocationDegrees(GLKMathRadiansToDegrees(Float(resultLat))), longitude: CLLocationDegrees(GLKMathRadiansToDegrees(Float(resultLong))));
            return result;
        }
    
    private func updateGeofence() {
        showHome()
    }
    
    private func showHome() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func showSubscriptionPlans() {
        let vc = PPChoosePlanViewController()
        push(vc: vc)
    }
    
    private func showFailedToCreateGeofenceMessage() {
        let message = "Unable to create the Geofence. Please try again."
        let alert = UIAlertController(title: "Oops!",
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
    
    @objc func onSelectMapType() {
        switch customView.segmentedControl.selectedSegmentIndex {
        case 1:
            customView.map.mapType = .satellite
        default:
            customView.map.mapType = .standard
        }
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
    
    public func toCLLocationCoordinate2D() -> CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}

class PPButton: UIButton {
    var identifier: String?
}

extension CLLocation {
    
    func movedBy(latitudinalMeters: CLLocationDistance, longitudinalMeters: CLLocationDistance) -> CLLocation {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: abs(latitudinalMeters), longitudinalMeters: abs(longitudinalMeters))

        let latitudeDelta = region.span.latitudeDelta
        let longitudeDelta = region.span.longitudeDelta

        let latitudialSign = CLLocationDistance(latitudinalMeters.sign == .minus ? -1 : 1)
        let longitudialSign = CLLocationDistance(longitudinalMeters.sign == .minus ? -1 : 1)

        let newLatitude = coordinate.latitude + latitudialSign * latitudeDelta
        let newLongitude = coordinate.longitude + longitudialSign * longitudeDelta

        let newCoordinate = CLLocationCoordinate2D(latitude: newLatitude, longitude: newLongitude)

        let newLocation = CLLocation(coordinate: newCoordinate, altitude: altitude, horizontalAccuracy: horizontalAccuracy, verticalAccuracy: verticalAccuracy, course: course, speed: speed, timestamp: Date())

        return newLocation
    }
}

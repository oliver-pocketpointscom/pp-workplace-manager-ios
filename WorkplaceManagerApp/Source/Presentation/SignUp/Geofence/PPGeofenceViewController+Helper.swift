import UIKit
import MapKit
import GLKit

extension PPGeofenceViewController {
    
    public  func loadCurrentLocation(location: CLLocation) {
        getMap().delegate = self
        getMap().showsUserLocation = false
        
        moveMapToLocation(location: location) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.addOverlays(location: location)
        }
    }
    
    public func updateDisplay(location: CLLocation) {
        addOverlays(location: location)
        loadAddress(location: location)
    }
    
    public func addOverlays(location: CLLocation) {
        addPinOnMap(location)
    }
    
    public func addPinOnMap(_ location: CLLocation) {
        let movement = CLLocationDistance(5)
        var newLocation = location.movedBy(latitudinalMeters: movement, longitudinalMeters: movement)
        
        if let lastCoordinate = getFenceCoordinates().last?.coordinate {
            newLocation = CLLocation(latitude: lastCoordinate.latitude, longitude: lastCoordinate.longitude)
            newLocation = newLocation.movedBy(latitudinalMeters: movement, longitudinalMeters: movement)
        }
        
        let latitude = newLocation.coordinate.latitude
        let longitude = newLocation.coordinate.longitude
        
        renderAnnotation(latitude: latitude, longitude: longitude)
    }
    
    public func renderAnnotation(latitude: Double, longitude: Double) {
        let identifier = UUID.init().uuidString
        let annotation = PPPointAnnotation(identifier: identifier)
        
        let coordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let coordinate = PPLocationCoordinate2D(identifier: identifier,
                                                coordinate: coordinate2D)
        debugPrint(coordinate2D)
        addToFenceCoordinates(coordinate)
        
        annotation.coordinate = coordinate2D
        annotation.title = "Remove"
        
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.getMap().addAnnotation(annotation)
        }
    }
    
    public func clearPins() {
        clearCoordinates()
        getMap().removeAnnotations(getMap().annotations)
        getMap().removeOverlays(getMap().overlays)
    }
    
    public func moveMapToLocation(location: CLLocation?, _ completion: (()-> Void)?) {
        if let curLoc = location {
            let center = CLLocationCoordinate2DMake(curLoc.coordinate.latitude, curLoc.coordinate.longitude)
            getMap().setCenter(center, animated: true)
            if let zoomDistance = CLLocationDistance(exactly: 300) {
                let region = MKCoordinateRegion( center: curLoc.coordinate,
                                                 latitudinalMeters: zoomDistance,
                                                 longitudinalMeters: zoomDistance)
                getMap().setRegion(getMap().regionThatFits(region), animated: true)
            }
        }
        completion?()
    }
    
    public func loadAddress(location: CLLocation) {
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
                strongSelf.getAddressField().text = address
            }
        }
    }
    
    public func drawPolyline(_ mapView: MKMapView) {
        mapView.overlays.forEach { overlay in
            if overlay is MKPolyline || overlay is MKPolygon {
                mapView.removeOverlay(overlay)
            }
        }
        
        var coordinates = toCLLocationCoordinate2D(getFenceCoordinates())
        
        if let firstFence = coordinates.first {
            coordinates.append(CLLocationCoordinate2D(latitude: firstFence.latitude, longitude: firstFence.longitude))
        }
        
        let myPolyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
        mapView.addOverlay(myPolyline)
        
        let polygon = MKPolygon(coordinates: coordinates, count: coordinates.count)
        mapView.addOverlay(polygon)
    }
    
    public func toCLLocationCoordinate2D(_ coordinates: [PPLocationCoordinate2D]) -> [CLLocationCoordinate2D]{
        var dest:[CLLocationCoordinate2D] = []
        for fence in coordinates {
            dest.append(CLLocationCoordinate2D(latitude: fence.coordinate.latitude, longitude: fence.coordinate.longitude))
        }
        return dest
    }
    
    public func getGeofenceParameters() -> CreateGeofenceParameters {
        var coordinate2D = [CLLocationCoordinate2D]()
        for f in getFenceCoordinates() {
            coordinate2D.append(f.toCLLocationCoordinate2D())
        }
        
        let centerOfGeofence = getCenterCoord(coordinate2D)
        let latitude = centerOfGeofence.latitude
        let longitude = centerOfGeofence.longitude
        
        let tenantId = DataProvider.newInMemoryRealm().getTenantId()
        
        var geofence = [GeofenceCoordinateParameters]()
        for fence in getFenceCoordinates() {
            let fenceParam = GeofenceCoordinateParameters(latitude: fence.coordinate.latitude,
                                                          longitude: fence.coordinate.longitude)
            geofence.append(fenceParam)
        }
        
        return CreateGeofenceParameters(latitude: latitude,
                                              longitude: longitude,
                                              tenantId: tenantId,
                                              geofence: geofence)
    }
    
    public func getCenterCoord(_ LocationPoints: [CLLocationCoordinate2D]) -> CLLocationCoordinate2D{
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
}

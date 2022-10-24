import MapKit

extension PPGeofenceViewController: CLLocationManagerDelegate {
    
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

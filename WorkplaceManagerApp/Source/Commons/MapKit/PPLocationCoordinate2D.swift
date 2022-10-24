import MapKit

public class PPLocationCoordinate2D {
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

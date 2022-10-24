import MapKit

public class PPPointAnnotation : MKPointAnnotation {
    var identifier: String
    
    public init(identifier: String) {
        self.identifier = identifier
    }
}

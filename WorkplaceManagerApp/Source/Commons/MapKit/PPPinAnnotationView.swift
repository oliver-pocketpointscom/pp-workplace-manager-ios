import MapKit

public class PPPinAnnotationView: MKPinAnnotationView {
    public override var annotation: MKAnnotation? {
        willSet {
            displayPriority = MKFeatureDisplayPriority.required
        }
    }
}

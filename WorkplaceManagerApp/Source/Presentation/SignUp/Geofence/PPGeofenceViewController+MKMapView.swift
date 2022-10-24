import UIKit
import MapKit

extension PPGeofenceViewController: MKMapViewDelegate {
    
    public func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            // draw the track
            let polyLine = overlay
            let polyLineRenderer = MKPolylineRenderer(overlay: polyLine)
            polyLineRenderer.strokeColor = UIColor.blue
            polyLineRenderer.lineWidth = 2.0
            
            return polyLineRenderer
        } else if overlay is MKPolygon {
            let coordinates = toCLLocationCoordinate2D(getFenceCoordinates())
            let polygon = MKPolygon(coordinates: coordinates, count: getFenceCoordinates().count)
            let renderer = MKPolygonRenderer(polygon: polygon)
            renderer.fillColor = UIColor.blue.withAlphaComponent(0.25)
            return renderer
        }
        return MKOverlayRenderer()
    }
    
    public func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation is MKUserLocation {
            getMap().deselectAnnotation(view.annotation, animated: false)
        }
    }
    
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if let pointAnnotation = annotation as? PPPointAnnotation {
            let reuseId = "pin"
            if let annotationView = self.getMap().dequeueReusableAnnotationView(withIdentifier: reuseId) as? PPPinAnnotationView {
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
            getFenceCoordinates().filter({$0.identifier == identifier}).first?.coordinate = pointAnnotation.coordinate
        }
        
        drawPolyline(mapView)
    }
}

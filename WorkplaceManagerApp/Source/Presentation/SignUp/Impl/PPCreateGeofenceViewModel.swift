
public class PPCreateGeofenceViewModel: CreateGeofenceViewModel {
    
    public func createGeofence(payload: CreateGeofenceParameters, completion: @escaping (Error?) -> Void) {
        Wire.Company.createGeofence(payload: payload, completion: completion)
    }
}

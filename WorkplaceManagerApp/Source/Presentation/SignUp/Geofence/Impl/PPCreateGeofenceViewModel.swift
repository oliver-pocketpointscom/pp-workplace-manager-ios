import Foundation

public class PPCreateGeofenceViewModel: CreateGeofenceViewModel {
    
    public func createGeofence(payload: CreateGeofenceParameters, completion: @escaping (Error?) -> Void) {
        Wire.Company.createGeofence(payload: payload, completion: completion)
    }
    
    public func loadGeolocation(tenantId: Int, completion: @escaping(GeofenceModel?, Error?) -> Void) {
        Wire.Company.getGeolocation(tenantId: tenantId, completion: completion)
    }
}

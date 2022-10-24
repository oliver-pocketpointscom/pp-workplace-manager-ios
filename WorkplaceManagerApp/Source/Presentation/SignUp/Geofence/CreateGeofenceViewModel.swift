
public protocol CreateGeofenceViewModel {

    func loadGeolocation(tenantId: Int, completion: @escaping(GeofenceModel?,Error?) -> Void)
    func createGeofence(payload: CreateGeofenceParameters, completion: @escaping (Error?) -> Void)
}

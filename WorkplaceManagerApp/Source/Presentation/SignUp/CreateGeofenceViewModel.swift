
public protocol CreateGeofenceViewModel {

    func createGeofence(payload: CreateGeofenceParameters, completion: @escaping (Error?) -> Void)
}

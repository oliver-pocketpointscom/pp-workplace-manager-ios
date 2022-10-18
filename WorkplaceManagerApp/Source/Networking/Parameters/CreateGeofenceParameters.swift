import Alamofire

public struct CreateGeofenceParameters {
    private var latitude: Double
    private var longitude: Double
    private var tenantId: Int
    private var geofence: [GeofenceCoordinateParameters]
    
    public init(latitude: Double, longitude: Double, tenantId: Int, geofence: [GeofenceCoordinateParameters]) {
        self.latitude = latitude
        self.longitude = longitude
        self.tenantId = tenantId
        self.geofence = geofence
    }
    
    public func toJson() -> Parameters  {
        return [
            "latitude": self.latitude,
            "longitude": self.longitude,
            "tenantId": self.tenantId,
            "geofence": self.getGeofenceJsonArray()
        ]
    }
    
    private func getGeofenceJsonArray() -> [Parameters] {
        var param = [Parameters]()
        for fence in geofence {
            param.append(fence.toJson())
        }
        return param
    }
}

public struct GeofenceCoordinateParameters {
    private var latitude: Double
    private var longitude: Double
    
    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    public func toJson() -> Parameters  {
        return [
            "latitude": self.latitude,
            "longitude": self.longitude
        ]
    }
}

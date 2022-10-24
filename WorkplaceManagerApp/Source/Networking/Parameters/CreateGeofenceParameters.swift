import Alamofire

public struct CreateGeofenceParameters {
    var latitude: Double
    var longitude: Double
    var tenantId: Int
    var geofence: [GeofenceCoordinateParameters]

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
    var latitude: Double
    var longitude: Double
    
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

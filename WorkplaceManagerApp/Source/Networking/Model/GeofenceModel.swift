import Foundation

public struct GeofenceModel {
    var latitude: Double
    var longitude: Double
    var tenantId: Int
    var geofence: [GeofenceCoordinateModel]
}

extension GeofenceModel {
    public static func toModel(result: Any) -> GeofenceModel? {
        if let response = result as? NSDictionary {
            let latitude = response.object(forKey: "latitude") as? Double ?? 0.0
            let longitude = response.object(forKey: "longitude") as? Double ?? 0.0
            let tenantId = response.object(forKey: "tenantId") as? Int ?? 0
            let geofence = GeofenceCoordinateModel.toModels(result: response.object(forKey: "geofence"))
            
            return GeofenceModel(latitude: latitude,
                                 longitude: longitude,
                                 tenantId: tenantId,
                                 geofence: geofence)
        }
        return nil
    }
}


public struct GeofenceCoordinateModel {
    var latitude: Double
    var longitude: Double
}

extension GeofenceCoordinateModel {
    
    public static func toModels(result: Any?) -> [GeofenceCoordinateModel] {
        var dest = [GeofenceCoordinateModel]()
        if let geofenceResponse = result as? NSDictionary {
            if let verticesArray = geofenceResponse.object(forKey: "vertices") as? [NSDictionary] {
                for vertices in verticesArray {
                    let latitude = vertices.object(forKey: "lat") as? Double ?? 0.0
                    let longitude = vertices.object(forKey: "lon") as? Double ?? 0.0
                    dest.append(GeofenceCoordinateModel(latitude: latitude, longitude: longitude))
                }
            }
        }
        return dest
    }
}

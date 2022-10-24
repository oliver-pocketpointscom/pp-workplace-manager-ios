import Alamofire

public struct TenantSettingsParameters {
    var tenantId: Int
    var timePerPoint: Int
    var startEarnPoints: String
    var endEarnPoints: String
    var earningDays: [String]
    
    public func toJSON() -> Parameters {
        return [
            "tenant_id": self.tenantId,
            "timePerPoint": self.timePerPoint,
            "startEarnPoints": self.startEarnPoints,
            "endEarnPoints": self.endEarnPoints,
            "earningDays": earningDays.map{String($0)}.joined(separator: ",")
        ]
    }
}

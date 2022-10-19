import Alamofire

public struct UpdateUserStatusParameters {
    var id: Int = -1
    var tenantId: Int = -1
    var status: Int = -1
    
    public init(id: Int, tenantId: Int, status: Int) {
        self.id = id
        self.tenantId = tenantId
        self.status = status
    }
    
    public func toJSON() -> Parameters {
        return [
            "id": self.id,
            "tenant_id": self.tenantId,
            "status": self.status
        ]
    }
}

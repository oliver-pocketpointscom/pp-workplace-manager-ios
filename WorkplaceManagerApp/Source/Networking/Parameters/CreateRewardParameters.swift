import Alamofire

public struct CreateRewardParameters {
    var title: String
    var description: String
    var status: Int
    var tenantId: Int
    
    public func toJson() -> Parameters {
        return ["title": self.title,
                "description": self.description,
                "status": self.status,
                "tenant_id": self.tenantId
        ]
    }
}

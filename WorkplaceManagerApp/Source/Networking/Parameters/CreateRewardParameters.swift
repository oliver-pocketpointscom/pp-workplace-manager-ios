import Alamofire

public struct CreateRewardParameters {
    var title: String
    var description: String
    var status: Int
    var tenantId: Int
    
    public init(title: String, description: String, status: Int, tenantId: Int) {
        self.title = title
        self.description = description
        self.status = status
        self.tenantId = tenantId
    }
    
    public func toJson() -> Parameters {
        return ["title": self.title,
                "description": self.description,
                "status": self.status,
                "tenant_id": self.tenantId
        ]
    }
}

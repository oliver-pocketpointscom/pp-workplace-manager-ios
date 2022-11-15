import Alamofire

public struct CreateRewardParameters {
    var title: String
    var description: String
    var type: Int
    var status: Int
    var tenantId: Int
    var userId: Int
    
    public func toJson() -> Parameters {
        return ["title": self.title,
                "description": self.description,
                "reward_type": self.type,
                "status": self.status,
                "tenant_id": self.tenantId,
                "user_id": self.userId]
    }
}

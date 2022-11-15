import Alamofire

public struct RewardUserParameters {
    var reward_id: Int
    var status: Int
    var app_user_ids: [Int]
    
    
    public func toJSON() -> Parameters {
        return [
            "reward_id" : reward_id,
            "status": status,
            "app_user_ids": app_user_ids
        ]
    }
}

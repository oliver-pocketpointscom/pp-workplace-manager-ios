import Alamofire

public struct RewardUserParameters {
    var reward_id: Int
    var status: Int
    var app_user_ids: [Int]
    
    
    public func toJSON() -> Parameters {
        var param: Parameters = [
            "id" : reward_id,
            "status": status
        ]
        
        var count = 1
        for id in app_user_ids {
            param["app_user_ids[\(count)]"] = id
            count+=1
        }
        
        return param
    }
}

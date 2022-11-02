import Foundation
import Alamofire
import AlamofireActivityLogger

enum RewardRouter: URLRequestConvertible {
    
    case create(payload: CreateRewardParameters)
    case rewardUsers(payload: RewardUserParameters)
    
    var basePath: String {
        "rewards"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var route: String {
        switch self {
        case .create: return "createreward"
        case .rewardUsers: return "rewardusers"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .create(let payload):
            return payload.toJson()
        case .rewardUsers(let payload):
            return payload.toJSON()
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Wire.urlForPath(path: self.basePath).appendingPathComponent(self.route)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method.rawValue
        
        switch self {
        case .create, .rewardUsers:
            return try URLEncoding.default.encode(urlRequest, with: self.parameters)
        }
    }
}

extension Wire.Reward {
    
    public static func createReward(payload: CreateRewardParameters, completion: @escaping((Int, Error?) -> Void)) {
        let url = RewardRouter.create(payload: payload)
        let request = Wire.sessionManager.request(url)
            .log()
            .validate(statusCode: 200 ..< 300)
        request.responseJSON { response in
            switch response.result {
            case .success(let json):
                if let response = json as? NSDictionary {
                    let rewardId = response.object(forKey: "rewardId") as? Int ?? 0
                    completion(rewardId, nil)
                } else {
                    completion(-1, PPError.InvalidJSONObject)
                }
            case .failure(let error):
                debugPrint("Request failed with error: \(error)")
                completion(-1, error)
            }
        }
    }
}

extension Wire.Reward {
    
    public static func rewardUsers(payload: RewardUserParameters, completion: @escaping((Error?) -> Void)) {
        let url = RewardRouter.rewardUsers(payload: payload)
        let request = Wire.sessionManager.request(url)
            .log()
            .validate(statusCode: 200 ..< 300)
        request.responseJSON { response in
            switch response.result {
            case .success(_):
                completion(nil)
            case .failure(let error):
                debugPrint("Request failed with error: \(error)")
                completion(error)
            }
        }
    }
}

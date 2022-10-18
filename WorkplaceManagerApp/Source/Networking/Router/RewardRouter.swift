import Foundation
import Alamofire
import AlamofireActivityLogger

enum RewardRouter: URLRequestConvertible {
    
    case create(payload: CreateRewardParameters)
    
    var basePath: String {
        switch self {
        case .create: return "rewards"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .create: return .post
        }
    }
    
    var route: String {
        switch self {
        case .create: return "createreward"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .create(let payload):
            return payload.toJson()
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Wire.urlForPath(path: self.basePath).appendingPathComponent(self.route)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method.rawValue
        
        switch self {
        case .create:
            return try URLEncoding.default.encode(urlRequest, with: self.parameters)
        }
    }
}

extension Wire.Reward {
    
    public static func createReward(payload: CreateRewardParameters, completion: @escaping((Error?) -> Void)) {
        let url = RewardRouter.create(payload: payload)
        let request = Wire.sessionManager.request(url)
            .log()
            .validate(statusCode: 200 ..< 300)
        request.responseJSON { response in
            switch response.result {
            case .success(let json):
                completion(nil)
            case .failure(let error):
                debugPrint("Request failed with error: \(error)")
                completion(error)
            }
        }
    }
}

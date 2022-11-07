import Foundation
import Alamofire
import AlamofireActivityLogger

enum ChargebeeRouter: URLRequestConvertible {
    
    case getCheckoutUrl(tenantId: Int)
    
    var basePath: String {
        switch self {
        case .getCheckoutUrl: return "chargebee"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getCheckoutUrl: return .post
        }
    }
    
    var route: String {
        switch self {
        case .getCheckoutUrl: return "checkoutsuburl"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getCheckoutUrl(let tenantId):
            return ["tenant_id": tenantId]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Wire.urlForPath(path: self.basePath).appendingPathComponent(self.route)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method.rawValue
        
        switch self {
        case .getCheckoutUrl:
            return try URLEncoding.default.encode(urlRequest, with: self.parameters)
        }
    }
}

extension Wire.Chargebee {
    
    public static func getCheckoutUrl(tenantId: Int, completion: @escaping((String?, Error?) -> Void)) {
        let url = ChargebeeRouter.getCheckoutUrl(tenantId: tenantId)
        let request = Wire.sessionManager.request(url)
            .log()
            .validate(statusCode: 200 ..< 300)
        request.responseJSON { response in
            switch response.result {
            case .success(let json):
                if let response = json as? NSDictionary {
                    let urlString = response.object(forKey: "url") as? String ?? ""
                    completion(urlString, nil)
                } else {
                    completion(nil, PPError.InvalidJSONObject)
                }
            case .failure(let error):
                debugPrint("Request failed with error: \(error)")
                completion(nil, error)
            }
        }
    }
}

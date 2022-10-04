import Foundation
import Alamofire
import AlamofireActivityLogger

enum GetBusinessSectorRouter: URLRequestConvertible {
    
    case findAll
    
    var basePath: String {
        switch self {
        case .findAll: return "businesssector"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .findAll: return .get
        }
    }
    
    var route: String {
        switch self {
        case .findAll: return "sectors"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .findAll: return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Wire.urlForPath(path: self.basePath).appendingPathComponent(self.route)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method.rawValue
        
        switch self {
        case .findAll:
            return try JSONEncoding.default.encode(urlRequest, with: self.parameters)
        }
    }
}

extension Wire.BusinessSector {
    
    public static func findAllBusinessSectors(completion: @escaping((Error?) -> Void)) {
        let url = GetBusinessSectorRouter.findAll
        let request = Wire.sessionManager.request(url)
            .log()
            .validate(statusCode: 200 ..< 300)
        request.responseJSON { response in
            switch response.result {
            case .success(let json):
                Parser.BusinessSector.parse(businessSectors: BusinessSectorModel.toModels(result: json)) {
                    completion(nil)
                }
            case .failure(let error):
                debugPrint("Request failed with error: \(error)")
                completion(error)
            }
        }
    }
}

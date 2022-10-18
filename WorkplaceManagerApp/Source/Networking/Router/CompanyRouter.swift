import Foundation

import Alamofire
import AlamofireActivityLogger

enum CompanyRouter: URLRequestConvertible {
    
    case signup(payload: SignUpParameters)
    case createGeofence(payload: CreateGeofenceParameters)
    
    var basePath: String {
        switch self {
        case .signup(_), .createGeofence(_):
            return "company"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .signup(_), .createGeofence(_):
            return .post
        }
    }
    
    var route: String {
        switch self {
        case .signup(_):
            return "signupOwner"
        case .createGeofence(_):
            return "createTenantGeolocation"
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .signup(let payload):
            return payload.toJSON()
        case .createGeofence(let payload):
            return payload.toJson()
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try Wire.urlForPath(path: self.basePath).appendingPathComponent(self.route)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method.rawValue
        
        switch self {
        case .signup:
            return try URLEncoding.default.encode(urlRequest, with: self.parameters)
        case .createGeofence:
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            return try JSONEncoding.default.encode(urlRequest, with: self.parameters)
        }
    }
}

extension Wire.Company {
    
    public static func signUp(payload: SignUpParameters, completion: @escaping((Error?) -> Void)) {
        let url = CompanyRouter.signup(payload: payload)
        let request = Wire.sessionManager.request(url)
            .log()
            .validate(statusCode: 200 ..< 300)
        request.responseJSON { response in
            switch response.result {
            case .success(let json):
                Parser.SignUp.parse(signUp: SignUpModel.toModels(result: json)) {
                    completion(nil)
                }
            case .failure(let error):
                debugPrint("Backend Error: \(error)")
                completion(error)
            }
        }
        
    }
}

extension Wire.Company {
    
    public static func createGeofence(payload: CreateGeofenceParameters, completion: @escaping((Error?) -> Void)) {
        let url = CompanyRouter.createGeofence(payload: payload)
        let request = Wire.sessionManager.request(url)
            .log()
            .validate(statusCode: 200 ..< 300)
        request.responseJSON { response in
            switch response.result {
            case .success(let json):
                completion(nil)
            case .failure(let error):
                debugPrint("Backend Error: \(error)")
                completion(error)
            }
        }
        
    }
}



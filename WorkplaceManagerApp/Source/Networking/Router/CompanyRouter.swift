import Foundation

import Alamofire
import AlamofireActivityLogger

enum CompanyRouter: URLRequestConvertible {
    
    case signup(payload: SignUpParameters)
    case createGeofence(payload: CreateGeofenceParameters)
    case getTenantSettings(tenantId: Int)
    case user(tenantId: Int)
    case create(payload: CreateUserParameters)
    case update(payload: UpdateUserStatusParameters)
    case leaderBoard(tenantId: Int)
    case dashBoard(tenantId: Int)
    
    var basePath: String {
        switch self {
        case .signup, .createGeofence, .getTenantSettings, .user, .create, .update, .leaderBoard, .dashBoard:
            return "company"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .signup, .createGeofence, .getTenantSettings, .user, .create, .update, .leaderBoard, .dashBoard:
            return .post
        }
    }
    
    var route: String {
        switch self {
        case .signup:
            return "signupOwner"
        case .createGeofence:
            return "createTenantGeolocation"
        case .getTenantSettings:
            return "gettenantsettings"
        case .user(let tenantId):
            return "appusers/\(tenantId)"
        case .create:
            return "appuser/create"
        case .update:
            return "updateAppUserStatus"
        case .leaderBoard:
            return "getLeaderboard"
        case .dashBoard:
            return "dashboard"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .signup(let payload):
            return payload.toJSON()
        case .createGeofence(let payload):
            return payload.toJson()
        case .getTenantSettings(let tenantId):
            return ["tenantId" : tenantId]
        case .user(_):
            return nil
        case .create(let payload):
            return payload.toJson()
        case .update(let payload):
            return payload.toJSON()
        case .leaderBoard(let tenantId):
            return ["tenant_id" : tenantId]
        case .dashBoard(let tenantId):
            return ["tenant_id" : tenantId]
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try Wire.urlForPath(path: self.basePath).appendingPathComponent(self.route)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method.rawValue
        
        switch self {
        case .signup, .getTenantSettings, .create, .update, .leaderBoard, .dashBoard:
            return try URLEncoding.default.encode(urlRequest, with: self.parameters)
        case .createGeofence, .user:
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


extension Wire.Company {
    
    public static func getTenantSettings(tenantId: Int, completion: @escaping((TenantSettingsModel?, Error?) -> Void)) {
        let url = CompanyRouter.getTenantSettings(tenantId: tenantId)
        let request = Wire.sessionManager.request(url)
            .log()
            .validate(statusCode: 200 ..< 300)
        request.responseJSON { response in
            switch response.result {
            case .success(let json):
                let model = TenantSettingsModel.toModels(results: json as? [Any] ?? [])
                completion(model.first, nil)
            case .failure(let error):
                debugPrint("Backend Error: \(error)")
                completion(nil, error)
            }
        }
    }
}

extension Wire.Company {
    
    public static func getAppUsers(tenantId: Int, completion: @escaping((Error?) -> Void)) {
        let url = CompanyRouter.user(tenantId: tenantId)
        let request = Wire.sessionManager.request(url)
            .log()
            .validate(statusCode: 200 ..< 300)
        request.responseJSON { response in
            switch response.result {
            case .success(let json):
                Parser.User.parse(users: UserModel.toModels(result: json)) {
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
    
    public static func createAppUser(payload: CreateUserParameters, completion: @escaping((Error?) -> Void)) {
        let url = CompanyRouter.create(payload: payload)
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

extension Wire.Company {
    
    public static func updateAppUser(payload: UpdateUserStatusParameters, completion: @escaping((Error?) -> Void)) {
        let url = CompanyRouter.update(payload: payload)
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

extension Wire.Company {
    
    public static func getLeaderboard(tenantId: Int, completion: @escaping((Error?) -> Void)) {
        let url = CompanyRouter.leaderBoard(tenantId: tenantId)
        let request = Wire.sessionManager.request(url)
            .log()
            .validate(statusCode: 200 ..< 300)
        request.responseJSON { response in
            switch response.result {
            case .success(let json):
                Parser.User.parse(users: UserModel.toModels(result: json)) {
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
    
    public static func getDashBoard(tenantId: Int, completion: @escaping((Error?) -> Void)) {
        let url = CompanyRouter.dashBoard(tenantId: tenantId)
        let request = Wire.sessionManager.request(url)
            .log()
            .validate(statusCode: 200 ..< 300)
        request.responseJSON { response in
            switch response.result {
            case .success(let json):
                Parser.Dashboard.parse(dashboard: DashboardModel.toModels(result: json)) {
                    completion(nil)
                }
            case .failure(let error):
                debugPrint("Backend Error: \(error)")
                completion(error)
            }
        }
        
    }
}



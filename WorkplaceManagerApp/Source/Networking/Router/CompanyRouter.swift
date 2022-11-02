import Foundation

import Alamofire
import AlamofireActivityLogger

enum CompanyRouter: URLRequestConvertible {
    
    case signup(payload: SignUpParameters)
    case createGeofence(payload: CreateGeofenceParameters)
    case getGeolocation(tenantId: Int)
    case createTenantSettings(payload: TenantSettingsParameters)
    case updateTenantSettings(payload: TenantSettingsParameters)
    case getTenantSettings(tenantId: Int)
    case user(tenantId: Int)
    case create(payload: CreateUserParameters)
    case update(payload: UpdateUserStatusParameters)
    case leaderBoard(tenantId: Int)
    case dashBoard(tenantId: Int)
    case login(mobile: String)
    case verifyCode(mobile: String, code: String)
    
    var basePath: String {
        "company"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var route: String {
        switch self {
        case .signup:
            return "signupOwner"
        case .createGeofence:
            return "createTenantGeolocation"
        case .getGeolocation(let tenantId):
            return "getGeolocation/\(tenantId)"
        case .createTenantSettings:
            return "createtenantsettings"
        case .updateTenantSettings:
            return "updatetenantsettings"
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
        case .login:
            return "loginwp"
        case .verifyCode:
            return "verifycode"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .signup(let payload):
            return payload.toJSON()
        case .createGeofence(let payload):
            return payload.toJson()
        case .getGeolocation(let tenantId):
            return ["tenantId" : tenantId]
        case .createTenantSettings(let payload):
            return payload.toJSON()
        case .updateTenantSettings(let payload):
            return payload.toJSON()
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
        case .login(let mobile):
            return ["mobile_number" : mobile]
        case .verifyCode(let mobile, let code):
            return ["mobile_number" : mobile, "code" : code]
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try Wire.urlForPath(path: self.basePath).appendingPathComponent(self.route)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method.rawValue
        
        switch self {
        case .signup, .getTenantSettings, .create, .update, .leaderBoard, .dashBoard, .getGeolocation,
                .createTenantSettings, .updateTenantSettings, .login, .verifyCode:
            return try URLEncoding.default.encode(urlRequest, with: self.parameters)
        case .createGeofence, .user:
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            return try JSONEncoding.default.encode(urlRequest, with: self.parameters)
        }
    }
}

/// Sign Up
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

/// Geofence
extension Wire.Company {
    
    public static func createGeofence(payload: CreateGeofenceParameters, completion: @escaping((Error?) -> Void)) {
        let url = CompanyRouter.createGeofence(payload: payload)
        let request = Wire.sessionManager.request(url)
            .log()
            .validate(statusCode: 200 ..< 300)
        request.responseJSON { response in
            switch response.result {
            case .success(_):
                completion(nil)
            case .failure(let error):
                debugPrint("Backend Error: \(error)")
                completion(error)
            }
        }
    }
    
    public static func getGeolocation(tenantId: Int, completion: @escaping((GeofenceModel?, Error?) -> Void)) {
        let url = CompanyRouter.getGeolocation(tenantId: tenantId)
        let request = Wire.sessionManager.request(url)
            .log()
            .validate(statusCode: 200 ..< 300)
        request.responseJSON { response in
            switch response.result {
            case .success(let json):
                let geofenceModel = GeofenceModel.toModel(result: json)
                completion(geofenceModel, nil)
            case .failure(let error):
                debugPrint("Backend Error: \(error)")
                completion(nil, error)
            }
        }
    }
}


/// Settings
extension Wire.Company {
    
    public static func createTenantSettings(payload: TenantSettingsParameters, completion: @escaping((Error?) -> Void)) {
        let url = CompanyRouter.createTenantSettings(payload: payload)
        let request = Wire.sessionManager.request(url)
            .log()
            .validate(statusCode: 200 ..< 300)
        request.responseJSON { response in
            switch response.result {
            case .success(_):
                completion(nil)
            case .failure(let error):
                debugPrint("Backend Error: \(error)")
                completion(error)
            }
        }
    }
    
    public static func updateTenantSettings(payload: TenantSettingsParameters, completion: @escaping((Error?) -> Void)) {
        let url = CompanyRouter.updateTenantSettings(payload: payload)
        let request = Wire.sessionManager.request(url)
            .log()
            .validate(statusCode: 200 ..< 300)
        request.responseJSON { response in
            switch response.result {
            case .success(_):
                completion(nil)
            case .failure(let error):
                debugPrint("Backend Error: \(error)")
                completion(error)
            }
        }
    }
    
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

/// App Users
extension Wire.Company {
    
    public static func getAppUsers(tenantId: Int, completion: @escaping((Error?) -> Void)) {
        let url = CompanyRouter.user(tenantId: tenantId)
        let request = Wire.sessionManager.request(url)
            .log()
            .validate(statusCode: 200 ..< 300)
        request.responseJSON { response in
            switch response.result {
            case .success(let json):
                Parser.Employee.parse(users: EmployeeModel.toModels(result: json)) {
                    completion(nil)
                }
            case .failure(let error):
                debugPrint("Backend Error: \(error)")
                completion(error)
            }
        }
        
    }
    
    public static func createAppUser(payload: CreateUserParameters, completion: @escaping((Error?) -> Void)) {
        let url = CompanyRouter.create(payload: payload)
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
    
    public static func updateAppUser(payload: UpdateUserStatusParameters, completion: @escaping((Error?) -> Void)) {
        let url = CompanyRouter.update(payload: payload)
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

/// Scoreboard
extension Wire.Company {
    
    public static func getLeaderboard(tenantId: Int, completion: @escaping((Error?) -> Void)) {
        let url = CompanyRouter.leaderBoard(tenantId: tenantId)
        let request = Wire.sessionManager.request(url)
            .log()
            .validate(statusCode: 200 ..< 300)
        request.responseJSON { response in
            switch response.result {
            case .success(let json):
                Parser.Employee.parse(users: EmployeeModel.toModels(result: json)) {
                    completion(nil)
                }
            case .failure(let error):
                debugPrint("Backend Error: \(error)")
                completion(error)
            }
        }
    }
}

/// Dashboard
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

extension Wire.Company {
    
    public static func login(mobile: String, completion: @escaping((Error?) -> Void)) {
        let url = CompanyRouter.login(mobile: mobile)
        let request = Wire.sessionManager.request(url)
            .log()
            .validate(statusCode: 200 ..< 300)
        request.responseJSON { response in
            switch response.response?.statusCode {
            case 200:
                switch response.result {
                case .success(let json):
                    Parser.User.parse(users: UserModel.toModels(result: json)) {
                        completion(nil)
                    }
                default:
                    completion(nil)
                }
            case 400:
                debugPrint("Request failed with error: \(String(describing: response.result.error))")
                completion(response.result.error)
            default:
                completion(response.result.error)
            }
        }
        
    }
}

extension Wire.Company {
    
    public static func verifyCode(mobile: String, code: String, completion: @escaping((Error?) -> Void)) {
        let url = CompanyRouter.verifyCode(mobile: mobile, code: code)
        let request = Wire.sessionManager.request(url)
            .log()
            .validate(statusCode: 200 ..< 300)
        request.responseJSON { response in
            switch response.response?.statusCode {
            case 200:
                completion(nil)
            case 400:
                debugPrint("Request failed with error: \(String(describing: response.result.error))")
                completion(response.result.error)
            default:
                completion(response.result.error)
            }
        }
    }
}



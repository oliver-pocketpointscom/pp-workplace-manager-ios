import Foundation
import Alamofire
import AlamofireActivityLogger
import RealmSwift

enum SignUpRouter: URLRequestConvertible {
    
    case signup(payload: SignUpParameters)
    
    var basePath: String {
        switch self {
        case .signup(_):
            return "company"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .signup(_):
            return .post
        }
    }
    
    var route: String {
        switch self {
        case .signup(_):
            return "signupOwner"
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .signup(let payload):
            return payload.toJSON()
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try Wire.urlForPath(path: self.basePath).appendingPathComponent(self.route)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method.rawValue
        
        switch self {
        case .signup:
            return try URLEncoding.default.encode(urlRequest, with: self.parameters)
        }
    }
}

extension Wire.SignUp {
    public static func signUp(payload: SignUpParameters, completion: @escaping((Error?) -> Void)) {
        let url = SignUpRouter.signup(payload: payload)
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

public struct SignUpParameters {
    private var email: String
    private var phone: String
    private var firstname: String
    private var surname: String
    private var company_logo: String
    private var name: String
    private var companyName: String
    private var region: Int
    private var sector: Int
    private var status: Int
    
    public init(email: String, phone: String, firstname: String, surname: String, company_logo: String, name: String, companyName: String, region: Int, sector: Int, status: Int) {
        self.email = email
        self.phone = phone
        self.firstname = firstname
        self.surname = surname
        self.company_logo = company_logo
        self.name = name
        self.companyName = companyName
        self.region = region
        self.sector = sector
        self.status = status
    }
    
    public func toJSON() -> Parameters {
        return [
            "email": self.email,
            "phone": self.phone,
            "firstname": self.firstname,
            "surname": self.surname,
            "company_logo": self.company_logo,
            "name": self.name,
            "companyName": self.companyName,
            "region": self.region,
            "sector": self.sector,
            "status": self.status
        ]
    }
}



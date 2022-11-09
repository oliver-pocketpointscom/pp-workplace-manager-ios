import Foundation
import Alamofire

public class Wire {
    static let GENERIC_ERROR_MESSAGE = "Our system is not responding right now. Please try again later."
    
    public enum Environment: Int {
        case develop = 0
        case qa = 1
        case production = 2
        
        static func baseURL(`for` environment: Environment) throws -> URL {
            guard let delegate = Wire.default.delegate else {
                return URL(string:"https://api-3-0.pocketpoints.com")!
            }
            switch environment {
            case .develop:
                return delegate.devBaseUrl
            case .qa:
                return delegate.qaBaseUrl
            case .production:
                return delegate.prodBaseUrl
            }
        }
    }
    
    public weak var delegate: WireDelegate?
    
    public lazy var sessionId: String = {
        UUID().uuidString
    }()
    
    private init() {}
    
    public static let `default`: Wire = {
        Wire()
    }()
    
    internal func baseURL() throws -> URL {
        return try Environment.baseURL(for: .develop)
    }
    
    public class func urlForPath(path: String) throws -> URL {
        try! Wire.default.baseURL().appendingPathComponent(path)
    }
    
    public static var `sessionManager`: SessionManager = Wire.manager
    
    private class func newSessionManager() -> SessionManager {
        let configuration = URLSessionConfiguration.default
        //configuration.httpAdditionalHeaders =
        
        let sessionDelegate = SessionDelegate()
        
        /// Remove this for production
        let serverTrustPolicies: [String: ServerTrustPolicy] = ["ec2-34-211-28-161.us-west-2.compute.amazonaws.com": .disableEvaluation]
        
        let sessionManager = SessionManager(configuration: configuration,
                                     delegate: sessionDelegate,
                                            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
        
        return sessionManager
    }
    
    private static let `manager`: SessionManager = {
        assert(Wire.default.delegate != nil, "Wire delegate is nil!")
        let manager = Wire.newSessionManager()
        return manager
    }()
    
    public struct BusinessSector {}
    public struct Chargebee {}
    public struct Company {}
    public struct Reward {}
}


extension Wire {
    public static func parseError(response: DataResponse<Any>) -> String {
        if let data = response.data {
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? Dictionary<String,Any> {
                    if let message = jsonArray["message"] as? String {
                        return message
                    }
                    if let error = jsonArray["error"] as? String {
                        return error
                    }
                }
            } catch _ as NSError {
                /// We'll return the default error message
            }
        }
        return Wire.GENERIC_ERROR_MESSAGE
    }
}

public protocol WireDelegate: AnyObject {
    var devBaseUrl: URL { get }
    var qaBaseUrl: URL { get }
    var prodBaseUrl: URL { get }
}

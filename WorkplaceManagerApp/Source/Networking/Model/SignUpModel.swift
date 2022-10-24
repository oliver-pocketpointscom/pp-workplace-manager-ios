import Foundation

public struct SignUpModel {
    var userId: Int = -1
    var tenantId: Int = -1
}

extension SignUpModel {
    public static func toModels(result: Any) -> [SignUpModel] {
        var signUpResult = [SignUpModel]()
        if let response = result as? NSDictionary {
            let userId = response.object(forKey: "userId") as? Int ?? 0
            let tenantId = response.object(forKey: "tenantId") as? Int ?? 0
            
            signUpResult.append(SignUpModel(userId: userId, tenantId: tenantId))
        }
        return signUpResult
    }
}

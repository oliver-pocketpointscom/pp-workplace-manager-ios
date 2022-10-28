import Foundation

public struct UserModel {
    var id: Int = -1
    var firstname: String = ""
    var lastname: String = ""
    var tenantId: Int = -1
    var branch: String = ""
    var dept: String = ""
    var mobileNumber: String = ""
    
    public init(id: Int, firstname: String, lastname: String, tenantId: Int, branch: String, dept: String, mobileNumber: String) {
        self.id = id
        self.firstname = firstname
        self.lastname = lastname
        self.tenantId = tenantId
        self.branch = branch
        self.dept = dept
        self.mobileNumber = mobileNumber
    }
}

extension UserModel {
    public static func toModels(result: Any) -> [UserModel] {
        var usersResult = [UserModel]()
        if let response = result as? NSDictionary {
            if let appusers = response.object(forKey: "data") as? NSDictionary {
                let id = appusers.object(forKey: "id") as? Int ?? 0
                let firstname = appusers.object(forKey: "firstname") as? String ?? ""
                let lastname = appusers.object(forKey: "lastname") as? String ?? ""
                let tenantId = appusers.object(forKey: "tenant_id") as? Int ?? 0
                let branch = appusers.object(forKey: "branch") as? String ?? ""
                let dept = appusers.object(forKey: "dept") as? String ?? ""
                let mobileNumber = appusers.object(forKey: "mobile_number") as? String ?? ""
                
                usersResult.append(UserModel(id: id, firstname: firstname, lastname: lastname, tenantId: tenantId, branch: branch, dept: dept, mobileNumber: mobileNumber))
            }
        }
        return usersResult
    }
}

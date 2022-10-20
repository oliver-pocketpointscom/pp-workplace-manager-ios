import Foundation

public struct UserModel {
    var id: Int = -1
    var firstname: String = ""
    var surname: String = ""
    var status: Int = -1
    var tenantId: Int = -1
    var secondsOffPhone: Int = -1
    var minutesOffPhone: Int = -1
    
    public init(id: Int, firstname: String, surname: String, status: Int, tenantId: Int, secondsOffPhone: Int, minutesOffPhone: Int) {
        self.id = id
        self.firstname = firstname
        self.surname = surname
        self.status = status
        self.tenantId = tenantId
        self.secondsOffPhone = secondsOffPhone
        self.minutesOffPhone = minutesOffPhone
    }
}

extension UserModel {
    public static func toModels(result: Any) -> [UserModel] {
        var usersResult = [UserModel]()
        if let response = result as? NSDictionary {
            if let appusers = response.object(forKey: "appusers") as? [NSDictionary] {
                for appuser in appusers {
                    let id = appuser.object(forKey: "id") as? Int ?? 0
                    let firstname = appuser.object(forKey: "firstname") as? String ?? ""
                    let surname = appuser.object(forKey: "surname") as? String ?? ""
                    let status = appuser.object(forKey: "status") as? Int ?? 0
                    let tenantId = appuser.object(forKey: "tenant_id") as? Int ?? 0
                    let secondsOffPhone = appuser.object(forKey: "secondssOffPhone") as? Int ?? 0
                    let minutesOffPhone = appuser.object(forKey: "minutesOffPhone") as? Int ?? 0
                    
                    usersResult.append(UserModel(id: id, firstname: firstname, surname: surname, status: status, tenantId: tenantId, secondsOffPhone: secondsOffPhone, minutesOffPhone: minutesOffPhone))
                }
            }
        }
        return usersResult
    }
}

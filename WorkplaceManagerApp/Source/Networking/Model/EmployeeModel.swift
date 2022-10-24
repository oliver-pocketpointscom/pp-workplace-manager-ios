import Foundation

public struct EmployeeModel {
    var id: Int = -1
    var firstname: String = ""
    var surname: String = ""
    var status: Int = -1
    var tenantId: Int = -1
    var secondsOffPhone: Int = -1
    var minutesOffPhone: Int = -1
}

extension EmployeeModel {
    public static func toModels(result: Any) -> [EmployeeModel] {
        var usersResult = [EmployeeModel]()
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
                    
                    usersResult.append(EmployeeModel(id: id, firstname: firstname, surname: surname, status: status, tenantId: tenantId, secondsOffPhone: secondsOffPhone, minutesOffPhone: minutesOffPhone))
                }
            }
        }
        return usersResult
    }
}

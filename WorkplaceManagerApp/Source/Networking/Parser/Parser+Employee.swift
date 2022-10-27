import Foundation
import Alamofire

extension Parser {
    public struct Employee {
        
        public static func parse(users: [EmployeeModel], completion: @escaping() -> Void) {
            
            let realm = DataProvider.newInMemoryRealm()
            try! realm.write {
                realm.delete(realm.getAllEmployeeObject())
            }
            
            for model in users {
                let object = EmployeeObject()
                object.id = model.id
                object.firstname = model.firstname
                object.surname = model.surname
                object.status = model.status
                object.tenantId = model.tenantId
                object.secondsOffPhone = model.secondsOffPhone
                object.minutesOffPhone = model.minutesOffPhone
                
                do {
                    try realm.write {
                        if object.status == 2 || object.status == 3 { //save only status 2 (Activated) and status 3 (Deactivated)
                            realm.add(object)
                        }
                    }
                } catch {
                    debugPrint("Error - GetAppUsers")
                }
            }
            
            DispatchQueue.main.async {
                completion()
            }
            
        }
    }
}

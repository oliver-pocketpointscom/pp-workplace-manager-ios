import Foundation
import Alamofire

extension Parser {
    public struct User {
        
        public static func parse(users: [UserModel], completion: @escaping() -> Void) {
            
            let realm = DataProvider.newInMemoryRealm()
            
            realm.reset()
            
            for model in users {
                let object = UserObject()
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

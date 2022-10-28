import Foundation
import Alamofire

extension Parser {
    public struct User {
        
        public static func parse(users: [UserModel], completion: @escaping() -> Void) {
            
            let realm = DataProvider.newInMemoryRealm()
            try! realm.write {
                realm.delete(realm.getAllUserObject())
            }
            
            for model in users {
                let object = UserObject()
                
                object.id = model.id
                object.firstname = model.firstname
                object.lastname = model.lastname
                object.tenantId = model.tenantId
                object.branch = model.branch
                object.dept = model.dept
                object.mobileNumber = model.mobileNumber
                
                do {
                    try realm.write {
                        realm.add(object)
                    }
                } catch {
                    debugPrint("Error - Login")
                }
            }
            
            DispatchQueue.main.async {
                completion()
            }
            
        }
    }
}

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
                
                do {
                    try realm.write {
                        realm.add(object)
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

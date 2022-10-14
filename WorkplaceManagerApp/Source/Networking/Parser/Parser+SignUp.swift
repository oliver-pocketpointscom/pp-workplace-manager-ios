import Foundation
import Alamofire

extension Parser {
    public struct SignUp {
        
        public static func parse(signUp: [SignUpModel], completion: @escaping() -> Void) {
            
            let realm = DataProvider.newInMemoryRealm()
            
            realm.reset()
            
            for model in signUp {
                let object = SignUpObject()
                object.userId = model.userId
                object.tenantId = model.tenantId
                
                do {
                    try realm.write {
                        realm.add(object)
                    }
                } catch {
                    debugPrint("Error - SignUp")
                }
            }
            
            DispatchQueue.main.async {
                completion()
            }
            
        }
    }
}

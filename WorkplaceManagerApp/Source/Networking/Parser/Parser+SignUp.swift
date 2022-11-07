import Foundation
import Alamofire

extension Parser {
    public struct SignUp {
        
        public static func parse(signUp: [SignUpModel], completion: @escaping() -> Void) {
            
            let realm = DataProvider.newInMemoryRealm()
            try! realm.write {
                realm.delete(realm.getSignUpObject())
            }
            
            for model in signUp {
                let signUpObject = SignUpObject()
                signUpObject.userId = model.userId
                signUpObject.tenantId = model.tenantId
                
                do {
                    try realm.write {
                        realm.add(signUpObject)
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

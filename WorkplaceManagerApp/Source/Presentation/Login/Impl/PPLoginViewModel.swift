import Foundation

public class PPLoginViewModel: LoginViewModel {
    
    public func login(mobileNumber: String, completion: @escaping (String?) -> Void) {
        Wire.Company.login(mobile: mobileNumber) { error in
            if let error = error {
                completion(error)
            } else {
                let realm = DataProvider.newInMemoryRealm()
                let results = realm.getAllUserObject()
                
                var user: [PPUser] = []
                for r in results {
                    let userData = PPUser(id: r.id,
                                          firstname: r.firstname,
                                          lastname: r.lastname,
                                          tenantId: r.tenantId,
                                          branch: r.branch,
                                          dept: r.dept,
                                          mobileNumber: r.mobileNumber)
                    user.append(userData)
                }
                completion(nil)
            }
        }
    }
    
    public func verifyCode(mobileNumber: String, code: String, completion: @escaping (Error?) -> Void) {
        Wire.Company.verifyCode(mobile: mobileNumber, code: code, completion: completion)
    }
    
    public func deleteUserObject() {
        let realm = DataProvider.newInMemoryRealm()
        try! realm.write {
            realm.delete(realm.getAllUserObject())
        }
    }
}

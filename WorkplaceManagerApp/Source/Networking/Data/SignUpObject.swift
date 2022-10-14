import RealmSwift

public class SignUpObject: Object {
    @objc dynamic var userId: Int = 0
    @objc dynamic var tenantId: Int = 0
}

extension Realm {
    public func getSignUpObject() -> SignUpObject? {
        return self.objects(SignUpObject.self).first
    }
    
    public func getUserId() -> Int {
        guard let current = getSignUpObject() else { return 0 }
        return current.userId
    }
    
    public func getTenantId() -> Int {
        guard let current = getSignUpObject() else { return 0 }
        return current.tenantId
    }
}

import RealmSwift

public class UserObject: Object {
    @objc dynamic var id: Int = -1
    @objc dynamic var firstname: String = ""
    @objc dynamic var lastname: String = ""
    @objc dynamic var tenantId: Int = -1
    @objc dynamic var branch: String = ""
    @objc dynamic var dept: String = ""
    @objc dynamic var mobileNumber: String = ""
}

extension Realm {
    public func getAllUserObject() -> Results<UserObject> {
        self.objects(UserObject.self)
    }
    
    public func getTenantId() -> Int {
        guard let current = self.getAllUserObject().first else { return 0 }
        return current.tenantId
    }
}

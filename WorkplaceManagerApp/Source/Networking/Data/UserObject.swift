import RealmSwift

public class UserObject: Object {
    @objc dynamic var id: Int = -1
    @objc dynamic var firstname: String = ""
    @objc dynamic var surname: String = ""
    @objc dynamic var status: Int = -1
    @objc dynamic var tenantId: Int = -1
    @objc dynamic var secondsOffPhone: Int = -1
    @objc dynamic var minutesOffPhone: Int = -1
}

extension Realm {
    public func getAllUserObject() -> Results<UserObject> {
        self.objects(UserObject.self)
    }
}

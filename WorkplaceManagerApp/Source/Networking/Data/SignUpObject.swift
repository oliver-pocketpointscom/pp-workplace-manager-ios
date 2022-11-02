import RealmSwift

public class SignUpObject: Object {
    @objc dynamic var userId: Int = -1
    @objc dynamic var tenantId: Int = -1
}

extension Realm {
    public func getSignUpObject() -> Results<SignUpObject> {
        self.objects(SignUpObject.self)
    }
}

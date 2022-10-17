import RealmSwift

public class BusinessSectorObject: Object {
    @objc dynamic var key: Int = -1
    @objc dynamic var name: String = ""
    @objc dynamic var desc: String = ""
    
    override public static func primaryKey() -> String? {
        "key"
    }
}

extension Realm {
    
    public func findAllBusinessSectors() -> Results<BusinessSectorObject> {
        self.objects(BusinessSectorObject.self)
    }
}

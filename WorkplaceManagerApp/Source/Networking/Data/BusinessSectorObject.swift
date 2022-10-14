import RealmSwift

public class BusinessSectorObject: Object {
    @objc dynamic var key: Int = 0
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
    
    public func getBusinessSectorKey(name: String) -> Int {
        guard let result = self.findAllBusinessSectors().filter("name == %@", name).first else { return 0 }
        return result.key
    }
}

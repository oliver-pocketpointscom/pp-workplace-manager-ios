import RealmSwift

public class DataProvider {
    
    private init() {}
    
    public static let `default` = {
        DataProvider()
    }()
    
    public static func newInMemoryRealm() -> Realm {
        var config = Realm.Configuration.defaultConfiguration
        config.fileURL = Realm.Configuration.defaultConfiguration.fileURL?.deletingLastPathComponent().appendingPathComponent("pp-workplace-emp.realm")
        return try! Realm(configuration: config)
    }
    
    public static func reset() {
        DataProvider.newInMemoryRealm().reset()
    }
}

extension Realm {
    func reset() {
        try! self.write {
            self.deleteAll()
        }
    }
}

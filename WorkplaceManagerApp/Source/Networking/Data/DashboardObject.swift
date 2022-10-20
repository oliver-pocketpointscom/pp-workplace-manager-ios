import RealmSwift

public class DashboardObject: Object {
    @objc dynamic var totalHoursSaved: Double = 0.0
    @objc dynamic var totalRewardsAchieved: Int = -1
    @objc dynamic var totalAppUserCount: Int = -1
}

extension Realm {
    public func getDashboardObject() -> Results<DashboardObject> {
        self.objects(DashboardObject.self)
    }
}

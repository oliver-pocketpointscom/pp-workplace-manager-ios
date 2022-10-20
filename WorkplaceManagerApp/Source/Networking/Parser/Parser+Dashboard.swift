import Foundation
import Alamofire

extension Parser {
    public struct Dashboard {
        
        public static func parse(dashboard: [DashboardModel], completion: @escaping() -> Void) {
            
            let realm = DataProvider.newInMemoryRealm()
            
            realm.reset()
            
            for model in dashboard {
                let object = DashboardObject()
                object.totalAppUserCount = model.totalAppUserCount
                object.totalHoursSaved = model.totalHoursSaved
                object.totalRewardsAchieved = model.totalRewardsAchieved
                
                do {
                    try realm.write {
                        realm.add(object)
                    }
                } catch {
                    debugPrint("Error - GetDashboard")
                }
            }
            
            DispatchQueue.main.async {
                completion()
            }
            
        }
    }
}

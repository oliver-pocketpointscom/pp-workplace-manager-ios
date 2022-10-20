import Foundation

public struct DashboardModel {
    var totalHoursSaved: Double = 0.0
    var totalRewardsAchieved: Int = -1
    var totalAppUserCount: Int = -1
    
    public init(totalHoursSaved: Double, totalRewardsAchieved: Int, totalAppUserCount: Int) {
        self.totalHoursSaved = totalHoursSaved
        self.totalRewardsAchieved = totalRewardsAchieved
        self.totalAppUserCount = totalAppUserCount
    }
}

extension DashboardModel {
    public static func toModels(result: Any) -> [DashboardModel] {
        var dashboardResult = [DashboardModel]()
        if let response = result as? NSDictionary {
            let totalHoursSaved = response.object(forKey: "totalHoursSaved") as? Double ?? 0.0
            let totalRewardsAchieved = response.object(forKey: "totalRewardsAchieved") as? Int ?? 0
            let totalAppUserCount = response.object(forKey: "totalAppUserCount") as? Int ?? 0
            
            dashboardResult.append(DashboardModel(totalHoursSaved: totalHoursSaved, totalRewardsAchieved: totalRewardsAchieved, totalAppUserCount: totalAppUserCount))
        }
        return dashboardResult
    }
}

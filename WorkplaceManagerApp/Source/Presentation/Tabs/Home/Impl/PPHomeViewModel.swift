public class PPHomeViewModel: HomeViewModel {
    
    public func getTenantId() -> Int {
        return DataProvider.newInMemoryRealm().getTenantId()
    }
    
    public func loadData(tenantId: Int, completion: @escaping ((HomeCard?) -> Void)) {
        Wire.Company.getDashBoard(tenantId: 49, completion: { error in
            let realm = DataProvider.newInMemoryRealm()
            if let result = realm.getDashboardObject().first {
                let homeCard = HomeCard(totalHours: result.totalHoursSaved,
                                    totalRewards: result.totalRewardsAchieved,
                                    totalEmployees: result.totalAppUserCount)
                completion(homeCard)
            } else {
                completion(nil)
            }
        })
    }
}

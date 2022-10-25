public class PPCompanyPointsSetupViewModel: CompanyPointsSetupViewModel {
    
    public func createTenantSettings(payload: TenantSettingsModel, completion: @escaping (Error?) -> Void) {
        let tenantId = 58//DataProvider.newInMemoryRealm().getTenantId()
        let parameters = TenantSettingsParameters(tenantId: tenantId,
                                                  timePerPoint: payload.timePerPoint,
                                                  startEarnPoints: payload.startEarnPoints,
                                                  endEarnPoints: payload.endEarnPoints,
                                                  earningDays: payload.daysOfTheWeek)
        Wire.Company.createTenantSettings(payload: parameters, completion: completion)
    }
    
    public func updateTenantSettings(payload: TenantSettingsModel, completion: @escaping (Error?) -> Void) {
        let tenantId = 58//DataProvider.newInMemoryRealm().getTenantId()
        let parameters = TenantSettingsParameters(tenantId: tenantId,
                                                  timePerPoint: payload.timePerPoint,
                                                  startEarnPoints: payload.startEarnPoints,
                                                  endEarnPoints: payload.endEarnPoints,
                                                  earningDays: payload.daysOfTheWeek)
        Wire.Company.updateTenantSettings(payload: parameters, completion: completion)
    }
    
    public func getTenantSettings(completion: @escaping (TenantSettingsModel?, Error?) -> Void) {
        let tenantId = 58//DataProvider.newInMemoryRealm().getTenantId()
        Wire.Company.getTenantSettings(tenantId: tenantId, completion: completion)
    }
}

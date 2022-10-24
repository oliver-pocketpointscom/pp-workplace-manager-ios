public class PPCompanyPointsSetupViewModel: CompanyPointsSetupViewModel {
    
    public func createTenantSettings(payload: TenantSettingsModel, completion: @escaping (Error?) -> Void) {
        let tenantId = DataProvider.newInMemoryRealm().getTenantId()
        let parameters = TenantSettingsParameters(tenantId: tenantId,
                                                  timePerPoint: payload.timePerPoint,
                                                  startEarnPoints: payload.startEarnPoints,
                                                  endEarnPoints: payload.endEarnPoints,
                                                  earningDays: payload.daysOfTheWeek)
        Wire.Company.createTenantSettings(payload: parameters, completion: completion)
    }
    
    public func updateTenantSettings(payload: TenantSettingsModel, completion: @escaping (Error?) -> Void) {
        let tenantId = DataProvider.newInMemoryRealm().getTenantId()
        let parameters = TenantSettingsParameters(tenantId: tenantId,
                                                  timePerPoint: payload.timePerPoint,
                                                  startEarnPoints: payload.startEarnPoints,
                                                  endEarnPoints: payload.endEarnPoints,
                                                  earningDays: payload.daysOfTheWeek)
        Wire.Company.updateTenantSettings(payload: parameters, completion: completion)
    }
    
    public func getTenantSettings(tenantId: Int, completion: @escaping (TenantSettingsModel?, Error?) -> Void) {
        Wire.Company.getTenantSettings(tenantId: tenantId, completion: completion)
    }
}

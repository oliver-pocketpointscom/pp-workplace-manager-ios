public class PPCompanyPointsSetupViewModel: CompanyPointsSetupViewModel {
    
    public func getTenantSettings(tenantId: Int, completion: @escaping (TenantSettingsModel?, Error?) -> Void) {
        Wire.Company.getTenantSettings(tenantId: tenantId, completion: completion)
    }
}

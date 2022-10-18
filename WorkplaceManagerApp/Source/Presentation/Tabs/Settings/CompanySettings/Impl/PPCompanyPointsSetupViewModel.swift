public class PPCompanyPointsSetupViewModel: CompanyPointsSetupViewModel {
    
    public func getTenantSettings(tenantId: Int, completion: @escaping (Error?) -> Void) {
        Wire.Company.getTenantSettings(tenantId: tenantId, completion: completion)
    }
}

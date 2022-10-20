public protocol CompanyPointsSetupViewModel {
    
    func getTenantSettings(tenantId: Int, completion: @escaping(TenantSettingsModel?, Error?)->Void)
}

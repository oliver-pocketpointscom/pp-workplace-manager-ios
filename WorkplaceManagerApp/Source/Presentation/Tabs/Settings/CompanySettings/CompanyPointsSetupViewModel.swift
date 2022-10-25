public protocol CompanyPointsSetupViewModel {
    
    func createTenantSettings(payload: TenantSettingsModel, completion: @escaping(Error?)->Void)
    func updateTenantSettings(payload: TenantSettingsModel, completion: @escaping(Error?)->Void)
    func getTenantSettings(completion: @escaping(TenantSettingsModel?, Error?)->Void)
}

public protocol CompanyPointsSetupViewModel {
    
    func getTenantSettings(tenantId: Int, completion: @escaping(Error?)->Void)
}

public protocol HomeViewModel {
    func getTenantId() -> Int
    func loadData(tenantId: Int, completion: @escaping((HomeCard?) -> Void))
}

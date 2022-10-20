public protocol HomeViewModel {
    
    func loadData(tenantId: Int, completion: @escaping((HomeCard?) -> Void))
}

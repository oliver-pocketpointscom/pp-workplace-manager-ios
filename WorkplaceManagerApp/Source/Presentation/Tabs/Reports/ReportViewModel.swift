public protocol ReportViewModel {
    
    func getLeaderBoard(tenantId: Int, completion: @escaping (Error?) -> Void)
    
}

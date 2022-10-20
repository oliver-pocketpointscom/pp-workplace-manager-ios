public class PPReportViewModel: ReportViewModel {

    public func getLeaderBoard(tenantId: Int, completion: @escaping (Error?) -> Void) {
        Wire.Company.getLeaderboard(tenantId: tenantId, completion: completion)
    }
}

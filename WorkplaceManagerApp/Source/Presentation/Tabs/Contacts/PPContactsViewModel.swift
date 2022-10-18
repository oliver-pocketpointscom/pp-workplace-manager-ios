public class PPContactsViewModel: ContactsViewModel {
    
    public func getUsers(tenantId: Int, completion: @escaping (Error?) -> Void) {
        Wire.Company.getAppUsers(tenantId: tenantId, completion: completion)
    }
    
}

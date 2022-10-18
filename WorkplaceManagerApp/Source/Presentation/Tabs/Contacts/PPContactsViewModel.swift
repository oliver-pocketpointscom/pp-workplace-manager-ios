public class PPContactsViewModel: ContactsViewModel {
    
    public func getUsers(tenantId: Int, completion: @escaping (Error?) -> Void) {
        Wire.Company.getAppUsers(tenantId: tenantId, completion: completion)
    }
    
    public func createUsers(payload: CreateUserParameters, completion: @escaping (Error?) -> Void) {
        Wire.Company.createAppUser(payload: payload, completion: completion)
    }
    
}

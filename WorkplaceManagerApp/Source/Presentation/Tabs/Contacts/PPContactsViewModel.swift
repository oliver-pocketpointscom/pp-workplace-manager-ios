public class PPContactsViewModel: ContactsViewModel {
    
    public func getTenantId() -> Int {
        104//DataProvider.newInMemoryRealm().getTenantId()
    }
    
    public func getUserId() -> Int {
        DataProvider.newInMemoryRealm().getUserId()
    }
    
    public func getUsers(completion: @escaping ([PPContact], Error?) -> Void) {
        Wire.Company.getAppUsers(tenantId: getTenantId()) { error in
            if let error = error {
                completion([], error)
            } else {
                let realm = DataProvider.newInMemoryRealm()
                let results = realm.getAllUserObject()
                
                var employees: [PPContact] = []
                for r in results {
                    let contact = PPContact(id: r.id,
                                            firstName: r.firstname,
                                            lastName: r.surname,
                                            status: r.status)
                    employees.append(contact)
                }
                completion(employees, nil)
            }
        }
    }
    
    public func createUsers(payload: CreateUserParameters, completion: @escaping (Error?) -> Void) {
        Wire.Company.createAppUser(payload: payload, completion: completion)
    }
    
    public func updateUsers(payload: UpdateUserStatusParameters, completion: @escaping (Error?) -> Void) {
        Wire.Company.updateAppUser(payload: payload, completion: completion)
    }
    
}

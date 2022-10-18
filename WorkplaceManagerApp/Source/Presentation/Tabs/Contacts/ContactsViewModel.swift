public protocol ContactsViewModel {

    func getUsers(tenantId: Int, completion: @escaping (Error?) -> Void)
    
}

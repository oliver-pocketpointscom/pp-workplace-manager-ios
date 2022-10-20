public protocol ContactsViewModel {

    func getUsers(tenantId: Int, completion: @escaping (Error?) -> Void)
    func createUsers(payload: CreateUserParameters, completion: @escaping (Error?) -> Void)
    func updateUsers(payload: UpdateUserStatusParameters, completion: @escaping (Error?) -> Void)
}

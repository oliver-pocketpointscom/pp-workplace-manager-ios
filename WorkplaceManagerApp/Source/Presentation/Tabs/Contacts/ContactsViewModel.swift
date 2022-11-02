public protocol ContactsViewModel {

    func getTenantId() -> Int
    func getUserId() -> Int
    func getUsers(completion: @escaping ([PPContact], Error?) -> Void)
    func createUsers(payload: CreateUserParameters, completion: @escaping (Error?) -> Void)
    func updateUsers(payload: UpdateUserStatusParameters, completion: @escaping (Error?) -> Void)
}

import Foundation

public protocol LoginViewModel {
    func login(mobileNumber: String, completion: @escaping (String?) -> Void)
    func verifyCode(mobileNumber: String, code: String, completion: @escaping (Error?) -> Void)
    func deleteUserObject()
}

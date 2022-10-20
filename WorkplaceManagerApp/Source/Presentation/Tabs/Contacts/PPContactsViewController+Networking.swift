import UIKit

extension PPContactsViewController {
    
    public func getCreateUserParameters(firstName: String, lastname: String, phoneNumber: String) -> CreateUserParameters? {
        return CreateUserParameters(firstname: firstName, surname: lastname, phone: Int(phoneNumber) ?? 0, tenantId: 104, invitedBy: 277, status: 1)
    }
    
    public func onSend(payload: CreateUserParameters) {
        viewModel.createUsers(payload: payload, completion: { [weak self] error in
            guard let strongSelf = self else { return }
            if let _ = error {
                strongSelf.showErrorMessage()
            } else {
                strongSelf.showSuccessDialog()
            }
        })
    }
    
    public func getUpdateParameters(userId: Int, status: Int) -> UpdateUserStatusParameters? {
        return UpdateUserStatusParameters(id: userId, tenantId: 104, status: status)
    }
    
    public func onUpdate(userId:Int, status:Int, deleted : Bool = false) {
        guard let payload = getUpdateParameters(userId: userId, status: status) else {
            showErrorMessage()
            return
        }
        viewModel.updateUsers(payload: payload, completion: { [weak self] error in
            guard let strongSelf = self else { return }
            if let _ = error {
                strongSelf.showUpdateError()
            } else {
                strongSelf.showUpdateSuccess(deleted: deleted)
                strongSelf.loadUsers()
            }
        })
    }
}

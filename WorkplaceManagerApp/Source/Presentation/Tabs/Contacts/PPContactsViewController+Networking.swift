import UIKit

extension PPContactsViewController {
    
    public func getCreateUserParameters(firstName: String, lastname: String, phoneNumber: String) -> CreateUserParameters? {
        let tenantId = viewModel.getTenantId()
        let userId = viewModel.getUserId()
        return CreateUserParameters(firstname: firstName, surname: lastname, phone: Int(phoneNumber) ?? 0, tenantId: tenantId, invitedBy: userId, status: 1)
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
        let tenantId = viewModel.getTenantId()
        return UpdateUserStatusParameters(id: userId, tenantId: tenantId, status: status)
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

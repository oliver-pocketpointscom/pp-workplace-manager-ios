import UIKit

extension PPContactsViewController {
    
    public func inviteUsingNumber() {
        let alert = UIAlertController(title: "Send Invite", message: "Enter the name and phone number", preferredStyle: .alert)
        alert.addTextField() { newTextField in
            newTextField.backgroundColor = .white
            newTextField.textColor = .black
            newTextField.placeholder = "First Name"
            newTextField.keyboardType = .default
        }
        alert.addTextField() { newTextField in
            newTextField.backgroundColor = .white
            newTextField.textColor = .black
            newTextField.placeholder = "Last Name"
            newTextField.keyboardType = .default
        }
        alert.addTextField() { newTextField in
            newTextField.backgroundColor = .white
            newTextField.textColor = .black
            newTextField.placeholder = "Mobile Phone Number"
            newTextField.keyboardType = .numberPad
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            [weak self] action in
            
            if let textFields = alert.textFields {
                let tf = textFields[2]
                if let phoneNumber = tf.text {
                    guard let strongSelf = self else { return }
                    strongSelf.showConfirmationToSendSMSInvite(firstName: textFields[0].text ?? "", lastname: textFields[1].text ?? "", phone: phoneNumber)
                }
            }
        })
        self.present(alert, animated: true)
    }
    
    public func showConfirmationToSendSMSInvite(firstName: String, lastname: String, phone: String) {
        let message = "Pocket Points will send an invite to this number:\n\n\(phone)\n\n Standard SMS rates may apply."
        let alert = UIAlertController(title: "Confirm Invite",
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Send", style: UIAlertAction.Style.default, handler: { _ in
            guard let params = self.getCreateUserParameters(firstName: firstName, lastname: lastname, phoneNumber: phone) else {
                self.showErrorMessage()
                return
            }
            self.onSend(payload: params)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    public func showSuccessDialog() {
        let alert = UIAlertController(title: "Success",
                                      message: "User created and invite has been sent",
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
    public func showErrorMessage() {
        let message = "Unable to create the user. Kindly check your details and try again."
        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    public func showUpdateSuccess(deleted: Bool = false) {
        let title = deleted ? "User deleted!" : "User updated!"
        let alert = UIAlertController(title: title,
                                      message: nil,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    public func showUpdateError() {
        let title = "Error"
        let message = "Unable to update the user. Kindly check your details and try again."
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc public func switchChanged(statusSwitch: UISwitch) {
        let title = "Warning"
        let message = "Are you sure you want to update the status?"
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            let userId = statusSwitch.tag
            let status = statusSwitch.isOn ? 2 : 3
            self.onUpdate(userId: userId, status: status)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            statusSwitch.isOn = !statusSwitch.isOn
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc public func deleteButtonTapped(deleteButton: UIButton) {
        let title = "Delete"
        let message = "Are you sure you want to delete the user?"
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            let userId = deleteButton.tag
            self.onUpdate(userId: userId, status: 4, deleted: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
}

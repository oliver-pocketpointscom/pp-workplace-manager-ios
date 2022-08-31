import UIKit
import ContactsUI

public class PPContactsViewController: PPBaseTableViewController {
    
    var employees = ["Nikky", "Sheena", "Marlise", "Michelle"]
    public override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavBarTitle()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func initView() {
        tableView.backgroundColor = .backgroundColor()
        tableView.separatorColor = .clear
    }
    
    private func openContactList() {
        let cnPicker = CNContactPickerViewController()
        cnPicker.delegate = self
        self.present(cnPicker, animated: true, completion: nil)
    }
    
    private func openContactDetails(contact: CNContact) {
        let numbers = contact.phoneNumbers
        var phoneNumber: String?
        
        if let mainNumber = numbers.first(where: { $0.label == CNLabelPhoneNumberMain }) {
            phoneNumber = mainNumber.value.stringValue
        } else {
            phoneNumber = numbers.first?.value.stringValue
        }
        
        if let phone = phoneNumber {
            showConfirmationToSendSMSInvite(to: phone)
        }
    }
    
    private func inviteUsingNumber() {
        let alert = UIAlertController(title: "Send Invite", message: "Enter the phone number", preferredStyle: .alert)
        alert.addTextField() { newTextField in
            newTextField.placeholder = "Mobile Phone Number"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            [weak self] action in
            
            if let textFields = alert.textFields, let tf = textFields.first,
               let phoneNumber = tf.text {
                guard let strongSelf = self else { return }
                strongSelf.showConfirmationToSendSMSInvite(to: phoneNumber)
            }
        })
        self.present(alert, animated: true)
    }
    
    private func showConfirmationToSendSMSInvite(to phone: String) {
        let message = "Pocket Points will send an invite to this number:\n\n\(phone)\n\n Standard SMS rates may apply."
        let alert = UIAlertController(title: "Confirm Invite",
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Send", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension PPContactsViewController {
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                inviteUsingNumber()
            } else if indexPath.row == 1 {
                openContactList()
            }
        } else {
            showUnderConstructionDialog()
        }
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return ContactSections.allCases.count
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        return employees.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = AddEmployeeTableViewCell()
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
                return cell
            } else if indexPath.row == 1 {
                let cell = InviteFromContactTableViewCell()
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
                return cell
            } else {
                return UITableViewCell()
            }
        } else {
            let cell = ContactTableViewCell()
            cell.roundImageView.image = UIImage(named: "pp")
            cell.label.text = employees[indexPath.row]
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.accessoryType = .disclosureIndicator
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
            return cell
        }
    }
    
    public override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return ContactSections.contacts.name()
        }
        return nil
    }
}

extension PPContactsViewController: CNContactPickerDelegate {
    
    public func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        picker.dismiss(animated: true) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.openContactDetails(contact: contact)
        }
    }
}

public enum ContactSections: CaseIterable {
    case invite
    case contacts
    
    public func name() -> String {
        switch self {
        case .contacts: return "My Employees"
        default: return ""
        }
    }
}

import UIKit
import ContactsUI

public class PPContactsViewController: PPBaseTableViewController {
    
    private var employees: [UserObject] = []
    var position = ["Manager", "Barista", "Asst. Manager", "Barista"]
    var mobile = ["+27 78 315 2218", "+63 927 879 2202", "+27 84 280 8367", "+63 906 549 8051"]
    
    private let DISPLAY_LIMIT = 3
    
    private lazy var viewModel: ContactsViewModel = {
       PPContactsViewModel()
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        loadUsers()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavBarTitle()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func initView() {
        tableView.backgroundColor = .black
        tableView.separatorColor = .clear
    }
    
    private func loadUsers() {
        let realm = DataProvider.newInMemoryRealm()
        viewModel.getUsers(tenantId: 91, completion: { [weak self] error in
            let realm = DataProvider.newInMemoryRealm()
            let results = realm.getAllUserObject()
            
            guard let strongSelf = self else { return }
            for r in results {
                strongSelf.employees.append(r)
            }
            strongSelf.tableView.reloadData()
            
        })
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
        let alert = UIAlertController(title: "Send Invite", message: "Enter the name and phone number", preferredStyle: .alert)
        alert.addTextField() { newTextField in
            newTextField.backgroundColor = .white
            newTextField.textColor = .black
            newTextField.placeholder = "Full Name"
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
                let tf = textFields[1]
                if let phoneNumber = tf.text {
                    guard let strongSelf = self else { return }
                    strongSelf.showConfirmationToSendSMSInvite(to: phoneNumber)
                }
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
    
    private func openContactDetails(index: Int) {
        let vc = PPContactDetailedViewController(style: .grouped)
        var nameArray: [String] = []
        
        for user in employees {
            nameArray.append("\(user.firstname) \(user.surname)")
        }
        
        vc.name = nameArray[index]
        vc.id = index
        vc.profileImage = UIImage(named: "pp")
        vc.active = true
        vc.department = position[index]
        vc.mobile = mobile[index]
        vc.delegate = self
        push(vc: vc)
    }
    
    @objc func onViewActiveEmployees() {
        let vc = PPContactListViewController()
        var nameArray: [String] = []
        
        for user in employees {
            nameArray.append("\(user.firstname) \(user.surname)")
        }
        
        vc.employees = nameArray
        vc.position = position
        vc.mobile = mobile
        push(vc: vc)
    }
}

extension PPContactsViewController {
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = ContactSections(rawValue: indexPath.section)
        
        switch section {
        case .invite:
            let row = ContactActionRows(rawValue: indexPath.row)
            
            switch row {
            case .inviteByNumber:
                inviteUsingNumber()
            case .inviteByContact:
                openContactList()
            case .none: break
            }
        default: break
        }
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        ContactSections.allCases.count
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = ContactSections(rawValue: section)
        switch section {
        case .invite:
            return ContactActionRows.allCases.count
        case .active:
            return employees.count
        default:
            return 0
        }
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = ContactSections(rawValue: indexPath.section)
        
        switch section {
        case .invite:
            let row = ContactActionRows(rawValue: indexPath.row)
            
            switch row {
                case .inviteByNumber:
                    let cell = AddEmployeeTableViewCell()
                    cell.selectionStyle = .none
                    return cell
                case .inviteByContact:
                    let cell = InviteFromContactTableViewCell()
                    cell.selectionStyle = .none
                    return cell
                case .none: return UITableViewCell()
            }
        case .active:
            let cell = ContactWithActionsTableViewCell()
            var nameArray: [String] = []
            
            for user in employees {
                nameArray.append("\(user.firstname) \(user.surname)")
            }
            cell.label.text = nameArray[indexPath.row]
            cell.roundImageView.image = UIImage(named: "pp")
            cell.selectionStyle = .none
            cell.accessoryType = .none
            cell.tintColor = .white
            cell.statusSwitch.isOn = true
            cell.statusSwitch.tintColor = .lightGray
            if cell.label.text == "Marlise" {
                cell.statusSwitch.onTintColor = .red
            }
            
            if cell.label.text == "Angeline" {
                cell.statusSwitch.isOn = false
            }
            return cell
        default: return UITableViewCell()
        }
    }
    
    public override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = ContactSections(rawValue: section)
        
        switch section {
        case .active:
            return ContactSections.active.name()
        default: return nil
        }
    }
    
    public override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let section = ContactSections(rawValue: section)
        
        switch section {
        default: return nil
        }
    }
    
    public override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        if let footerView = view as? UITableViewHeaderFooterView {
            footerView.contentView.backgroundColor = .clear
            footerView.backgroundView?.backgroundColor = .clear
            footerView.textLabel?.textColor = .white
        }
    }
    
    public override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        
        if let footerView = view as? UITableViewHeaderFooterView {
            footerView.contentView.backgroundColor = .clear
            footerView.backgroundView?.backgroundColor = .clear
            footerView.textLabel?.textColor = .white
        }
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

extension PPContactsViewController: PPContactDetailedViewDelegate {
    
    public func onDelete(id: Int) {
        employees.remove(at: id)
        tableView.reloadData()
    }
}

public enum ContactSections: Int, Hashable, CaseIterable {
    case invite
    case summary
    case active
    
    public func name() -> String {
        switch self {
        case .summary: return "10 out of 25 Users are Active"
        case .active: return "Users Activated"
        default: return ""
        }
    }
}

public enum ContactActionRows: Int, Hashable, CaseIterable {
    case inviteByNumber
    case inviteByContact
}

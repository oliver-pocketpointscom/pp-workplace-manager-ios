import UIKit
import ContactsUI

public class PPContactsViewController: PPBaseTableViewController {
    
    var employees:[String] = ["Nikky", "Sheena", "Marlise", "Angeline", "Jess"]
    var pending:[String] = []
    var inactive:[String] = ["Nikky", "Sheena", "Marlise", "Angeline", "Jess"]
    var position = ["Manager", "Barista", "Asst. Manager", "Barista"]
    var mobile = ["+27 78 315 2218", "+63 927 879 2202", "+27 84 280 8367", "+63 906 549 8051"]
    
    private let DISPLAY_LIMIT = 3
    
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
        
        let sendBarButton = UIBarButtonItem(image: UIImage(named: "more"), style: .plain, target: self, action: #selector(onSettings))
        self.navigationItem.rightBarButtonItem  = sendBarButton
    }
    
    @objc func onSettings() {
        
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
            newTextField.backgroundColor = .clear
            newTextField.textColor = .black
            newTextField.placeholder = "Mobile Phone Number"
            newTextField.keyboardType = .numberPad
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
    
    private func openContactDetails(index: Int) {
        let vc = PPContactDetailedViewController(style: .grouped)
        vc.id = index
        vc.profileImage = UIImage(named: "pp")
        vc.name = employees[index]
        vc.active = true
        vc.department = position[index]
        vc.mobile = mobile[index]
        vc.delegate = self
        push(vc: vc)
    }
    
    @objc func onCancelInvite(_ sender: UITapGestureRecognizer?) {
        let message = "Are you sure you want to cancel this invite?"
        let alert = UIAlertController(title: "Cancel Invite",
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {
            [weak self] action in
            guard let strongSelf = self else { return }
            if let id = sender?.view?.tag {
                strongSelf.pending.remove(at: id)
                strongSelf.tableView.reloadData()
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func viewPendingInvites() {
        let vc = PPPendingInvitesViewController()
        vc.pendingInvites = pending
        push(vc: vc)
    }
    
    @objc func onViewPendingInvites() {
        viewPendingInvites()
    }
    
    @objc func onViewActiveEmployees() {
        let vc = PPContactListViewController()
        vc.employees = employees
        vc.position = position
        vc.mobile = mobile
        push(vc: vc)
    }
    
    @objc func onViewInactiveEmployees() {
        let vc = PPContactListViewController()
        vc.employees = inactive
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
        case .active, .inactive:
            openContactDetails(index: indexPath.row)
            break
        case .pending:
            viewPendingInvites()
            break
        case .none: break
        }
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        var sections = ContactSections.allCases.count
        if pending.count < 1 {
            sections -= 1
        }
        if inactive.count < 1 {
            sections -= 1
        }
        return sections
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = ContactSections(rawValue: section)
        switch section {
        case .invite:
            return ContactActionRows.allCases.count
        case .pending:
            return pending.count < DISPLAY_LIMIT ? pending.count : DISPLAY_LIMIT
        case .active:
            return employees.count < DISPLAY_LIMIT ? employees.count : DISPLAY_LIMIT
        case .inactive:
            return inactive.count < DISPLAY_LIMIT ? inactive.count : DISPLAY_LIMIT
        case .none:
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
        case .pending:
            let value = pending[indexPath.row]
            let cell = ContactTableViewCell()
            cell.selectionStyle = .none
            cell.accessoryType = .none
            cell.label.text = value
            cell.roundImageView.image = UIImage(named: "pp")
            cell.checkBox.image = UIImage(named: "remove")
            cell.checkBox.isHidden = false
            cell.checkBox.isUserInteractionEnabled = true
            cell.checkBox.tag = indexPath.row
            cell.checkBox.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onCancelInvite(_:))))
            return cell
        case .active:
            let cell = ContactTableViewCell()
            cell.roundImageView.image = UIImage(named: "pp")
            cell.label.text = employees[indexPath.row]
            cell.selectionStyle = .none
            cell.accessoryType = .disclosureIndicator
            return cell
        case .inactive:
            let cell = ContactTableViewCell()
            cell.roundImageView.image = UIImage(named: "pp")
            cell.label.text = inactive[indexPath.row]
            cell.selectionStyle = .none
            cell.accessoryType = .disclosureIndicator
            return cell
        case .none: return UITableViewCell()
        }
    }
    
    public override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = ContactSections(rawValue: section)
        
        switch section {
        case .active:
            return ContactSections.active.name()
        case .inactive:
            return inactive.count > 0 ? ContactSections.inactive.name() : nil
        case .pending:
            return pending.count > 0 ? ContactSections.pending.name() : nil
        case .invite, .none:
            return nil
        }
    }
    
    public override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let section = ContactSections(rawValue: section)
        
        switch section {
        case .pending: return pending.count > DISPLAY_LIMIT ? "view all pending invites" : nil
        case .active: return employees.count > DISPLAY_LIMIT ? "view all active employees" : nil
        case .inactive: return inactive.count > DISPLAY_LIMIT ? "view all inactive employees" : nil
        case .invite, .none:
            return nil
        }
    }
    
    public override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let section = ContactSections(rawValue: section)
        
        if let footerView = view as? UITableViewHeaderFooterView {
            footerView.contentView.backgroundColor = .backgroundColor()
            footerView.backgroundView?.backgroundColor = .backgroundColor()
            footerView.textLabel?.textColor = .darkGray
            
            let arrowRight = UIImageView(image: UIImage(named: "arrowRight")?.withRenderingMode(.alwaysTemplate))
            arrowRight.tintColor = .darkGray
            footerView.contentView.addSubview(arrowRight)
            guard let textLabel = footerView.textLabel else { return }
            arrowRight.snp.makeConstraints { make in
                make.leading.equalTo(textLabel.snp.trailing).offset(8)
                make.centerY.equalToSuperview()
            }
            
            switch section {
            case .pending:
                footerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onViewPendingInvites)))
                break
            case .active:
                footerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onViewActiveEmployees)))
                break
            case .inactive:
                footerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onViewInactiveEmployees)))
                break
            case .invite, .none:
                break
            }
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
    case pending
    case active
    case inactive
    
    public func name() -> String {
        switch self {
        case .pending: return "Pending Invites"
        case .active: return "Active Employees"
        case .inactive: return "Inactive Employees"
        default: return ""
        }
    }
}

public enum ContactActionRows: Int, Hashable, CaseIterable {
    case inviteByNumber
    case inviteByContact
}

import UIKit
import ContactsUI

public class PPContactsViewController: PPBaseTableViewController {
    
    private let DISPLAY_LIMIT = 3

    private var contacts: [PPContact] = []
    
    public func getContacts() -> [PPContact] {
        contacts
    }
    
    public lazy var viewModel: ContactsViewModel = {
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
    
    public func loadUsers() {
        viewModel.getUsers(completion: { [weak self] (contacts, error) in
            guard let strongSelf = self else { return }
            strongSelf.contacts = contacts
            strongSelf.tableView.reloadData()
        })
    }
    
    public func openContactList() {
        let cnPicker = CNContactPickerViewController()
        cnPicker.delegate = self
        self.present(cnPicker, animated: true, completion: nil)
    }
    
    public func openContactDetails(contact: CNContact) {
        let numbers = contact.phoneNumbers
        let firstName = contact.givenName
        let lastName = contact.familyName
        var phoneNumber: String?
        
        if let mainNumber = numbers.first(where: { $0.label == CNLabelPhoneNumberMain }) {
            phoneNumber = mainNumber.value.stringValue
        } else {
            phoneNumber = numbers.first?.value.stringValue
        }
        
        if let phone = phoneNumber {
            showConfirmationToSendSMSInvite(firstName: firstName, lastname: lastName, phone: phone)
        }
    }
    
    public func openContactDetails(index: Int) {
        let vc = PPContactDetailedViewController(style: .grouped)
        var nameArray: [String] = []
        
        for user in contacts {
            nameArray.append("\(user.firstName) \(user.lastName)")
        }
        
        vc.name = nameArray[index]
        vc.id = index
        vc.profileImage = UIImage(named: "pp")
        vc.active = true
        vc.delegate = self
        push(vc: vc)
    }
    
    public func getActiveUsersCount() -> Int {
        var count = 0
        for user in contacts {
            if user.status == 2 {
                count += 1
            }
        }
        return count
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
        contacts.remove(at: id)
        tableView.reloadData()
    }
}

public enum ContactSections: Int, Hashable, CaseIterable {
    case invite
    case summary
    case active
    
    public func name() -> String {
        switch self {
        case .active: return "Users Activated"
        default: return ""
        }
    }
}

public enum ContactActionRows: Int, Hashable, CaseIterable {
    case inviteByNumber
    case inviteByContact
}

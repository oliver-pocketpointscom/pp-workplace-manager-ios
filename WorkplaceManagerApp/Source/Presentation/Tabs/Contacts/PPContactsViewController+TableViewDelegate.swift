import UIKit

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
            return getContacts().count
        case .summary:
            return 1
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
        case .summary:
            let cell = UITableViewCell()
            cell.backgroundColor = .clear
            cell.textLabel?.text = "\(getActiveUsersCount()) out of \(getContacts().count) Users Active"
            cell.textLabel?.textColor = .white
            return cell
        case .active:
            let cell = ContactWithActionsTableViewCell()
            let fName = getContacts()[indexPath.row].firstName
            let lName = getContacts()[indexPath.row].lastName
            cell.label.text = "\(fName) \(lName)"
            cell.roundImageView.image = UIImage(named: "user")?.withRenderingMode(.alwaysTemplate).withTintColor(.white)
            cell.selectionStyle = .none
            cell.accessoryType = .none
            cell.tintColor = .white
            
            let status = getContacts()[indexPath.row].status
            switch status {
            case 2:
                cell.statusSwitch.isOn = true
            case 3:
                cell.statusSwitch.isOn = false
            default:
                break
            }
            cell.statusSwitch.tag = getContacts()[indexPath.row].id
            cell.statusSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
            
            cell.deleteButton.tag = getContacts()[indexPath.row].id
            cell.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
            
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

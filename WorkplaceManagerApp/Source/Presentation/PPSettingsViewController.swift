import UIKit

public class PPSettingsViewController: UITableViewController {
    
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
        tableView.backgroundColor = .white
        tableView.separatorColor = .clear
    }
}

extension PPSettingsViewController {
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.allCases.count
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = Sections(rawValue: section)
        if section == .one {
            return FirstSection.allCases.count
        } else if section == .two {
            return SecondSection.allCases.count
        } else if section == .three {
            return ThirdSection.allCases.count
        }
        return 0
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        
        let section = Sections(rawValue: indexPath.section)
        
        if section == .one {
            let row = FirstSection(rawValue: indexPath.row)
            cell.textLabel?.text = row?.name()
            cell.accessoryType = .disclosureIndicator
        } else if section == .two {
            let row = SecondSection(rawValue: indexPath.row)
            cell.textLabel?.text = row?.name()
            cell.accessoryType = .disclosureIndicator
        } else if section == .three {
            let row = ThirdSection(rawValue: indexPath.row)
            cell.textLabel?.text = row?.name()
        }
        return cell
    }
}

public enum Sections: Int, Hashable, CaseIterable {
    case one
    case two
    case three
}

public enum FirstSection: Int, Hashable, CaseIterable {
    case profile
    case company
    
    public func name() -> String {
        switch self {
        case .profile: return "My Profile"
        case .company: return "Company Settings"
        }
    }
}

public enum SecondSection: Int, Hashable, CaseIterable {
    case helpCenter
    case termsOfuse
    case privacyPolicy
    
    public func name() -> String {
        switch self {
        case .helpCenter: return "Help Center"
        case .termsOfuse: return "Terms of Use"
        case .privacyPolicy: return "Privacy Policy"
        }
    }
}

public enum ThirdSection: Int, Hashable, CaseIterable {
    case logout
    
    public func name() -> String {
        switch self {
        case .logout: return "Logout Account"
        }
    }
}

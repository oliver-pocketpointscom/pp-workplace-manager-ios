import UIKit

public class PPSettingsViewController: PPBaseTableViewController {
    
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
        tableView.separatorColor = .white
    }
    
    private func doLogout() {
        let alert = UIAlertController(title: "Warning",
                                      message: "Are you sure you want to logout?",
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Logout", style: UIAlertAction.Style.destructive) { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.showLoginScreen()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showLoginScreen() {
        let vc = PPOnboardingViewController()
        let nc = UINavigationController(rootViewController: vc)
        UIApplication.shared.windows.first?.rootViewController = nc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    private func showCompanySettingsScreen() {
        let vc  = PPCompanySettingsViewController()
        push(vc: vc)
    }
}

extension PPSettingsViewController {
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = SettingsSections(rawValue: indexPath.section)
        if section == .account {
            let row = Account(rawValue: indexPath.row)
            if row == .company {
                showCompanySettingsScreen()
            } else {
                showUnderConstructionDialog()
            }
        } else if section == .others {
            let row = Others(rawValue: indexPath.row)
            if row == .logout {
                doLogout()
            }
        } else {
            showUnderConstructionDialog()
        }
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        SettingsSections.allCases.count
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = SettingsSections(rawValue: section)
        if section == .account {
            return Account.allCases.count
        } else if section == .legalAndSupport {
            return LegalAndSupport.allCases.count
        } else if section == .others {
            return Others.allCases.count
        }
        return 0
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        cell.textLabel?.textColor = .black
        
        let section = SettingsSections(rawValue: indexPath.section)
        
        if section == .account {
            let row = Account(rawValue: indexPath.row)
            cell.textLabel?.text = row?.name()
            cell.accessoryType = .disclosureIndicator
        } else if section == .legalAndSupport {
            let row = LegalAndSupport(rawValue: indexPath.row)
            cell.textLabel?.text = row?.name()
            cell.accessoryType = .disclosureIndicator
        } else if section == .others {
            let row = Others(rawValue: indexPath.row)
            cell.textLabel?.text = row?.name()
            cell.textLabel?.textColor = .red
        }
        return cell
    }
}

public enum SettingsSections: Int, Hashable, CaseIterable {
    case account
    case legalAndSupport
    case others
}

public enum Account: Int, Hashable, CaseIterable {
    case profile
    case company
    
    public func name() -> String {
        switch self {
        case .profile: return "My Profile"
        case .company: return "Company Settings"
        }
    }
}

public enum LegalAndSupport: Int, Hashable, CaseIterable {
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

public enum Others: Int, Hashable, CaseIterable {
    case logout
    
    public func name() -> String {
        switch self {
        case .logout: return "Logout Account"
        }
    }
}

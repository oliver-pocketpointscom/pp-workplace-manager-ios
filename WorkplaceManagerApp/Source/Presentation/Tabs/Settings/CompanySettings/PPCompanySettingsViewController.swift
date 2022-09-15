import UIKit

public class PPCompanySettingsViewController: PPBaseTableViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        clearNavBarTitle()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)        
        addTitle("Settings")
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func initView() {
        tableView.backgroundColor = .black
        tableView.separatorColor = .clear
    }
    
    private func showPointsSetupScreen() {
        let vc = PPCompanyPointsSetupViewController(style: .grouped)
        push(vc: vc)
    }
    
    private func showPaymentsAndSubscriptions() {
        let vc = PPPaymentsSubscriptionsViewController(style: .grouped)
        push(vc: vc)
    }
    
    private func showGeofence() {
        let vc = PPCreateGeofenceViewController()
        vc.updateMode = true
        push(vc: vc)
    }
}

extension PPCompanySettingsViewController {
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = CompanySettingsRows(rawValue: indexPath.row)
        
        switch row {
        case .points:
            showPointsSetupScreen()
            break
        case .payment:
            showPaymentsAndSubscriptions()
            break
        case .geofence:
            showGeofence()
            break
        case .none: break
        }
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
       1
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CompanySettingsRows.allCases.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.tintColor = .white
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        
        let row = CompanySettingsRows(rawValue: indexPath.row)
        cell.textLabel?.text = row?.name()
        return cell
    }
}

public enum CompanySettingsRows: Int, Hashable, CaseIterable {
    case points
    case payment
    case geofence
    
    public func name() -> String {
        switch self {
        case .points: return "Company Pocket Points Setup"
        case .payment: return "Company Payment Details"
        case .geofence: return "Company Geofencing"
        }
    }
}


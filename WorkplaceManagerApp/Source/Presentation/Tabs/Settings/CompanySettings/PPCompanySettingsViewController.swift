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
        showDisclaimer()
    }
    
    private func showGeofence() {
        let vc = PPCreateGeofenceViewController()
        vc.updateMode = true
        push(vc: vc)
    }
    
    private func showDisclaimer() {
        let title = "Disclaimer"
        let message = "You will be redirected into an external browser to manage your subscription plan and payment details. Once you leave the Workplace app, you'll be covered by the policy and security measures of the site you are visiting."
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Proceed", style: .default, handler: {
            [weak self ]action in
            guard let strongSelf = self else { return }
            strongSelf.openSubscriptionPlanSite()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func openSubscriptionPlanSite() {
        guard let url = URL(string: "https://api-wp-dev.pocketpoints.com/managecbpp") else { return }
        UIApplication.shared.open(url, options: [:])
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


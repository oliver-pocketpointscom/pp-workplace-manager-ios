import UIKit

public class PPCompanySettingsViewController: PPBaseTableViewController {
    
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
    
    private func showPointsSetupScreen() {
        let vc = PPCompanyPointsSetupViewController()
        push(vc: vc)
    }
    
    private func showPaymentsAndSubscriptions() {
        let vc = PPPaymentsSubscriptionsViewController(style: .plain)
        push(vc: vc)
    }
}

extension PPCompanySettingsViewController {
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = CompanySettingsRows(rawValue: indexPath.row)
        
        if row == .points {
            showPointsSetupScreen()
        } else if row == .payment {
            showPaymentsAndSubscriptions()
        }
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
       1
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      2
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        
        let row = CompanySettingsRows(rawValue: indexPath.row)
        cell.textLabel?.text = row?.name()
        return cell
    }
}

public enum CompanySettingsRows: Int, Hashable, CaseIterable {
    case points
    case payment
    
    public func name() -> String {
        switch self {
        case .points: return "Points Setup"
        case .payment: return "Payments and Billing"
        }
    }
}


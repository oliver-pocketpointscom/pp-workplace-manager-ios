import UIKit
import SnapKit

public class PPPaymentsSubscriptionsViewController: PPBaseTableViewController {
    
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
}

extension PPPaymentsSubscriptionsViewController {
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        PaymentsSetupSections.allCases.count
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       let section  = PaymentsSetupSections(rawValue: section)
        switch section {
            case .cardDetails: return PaymentsCardDetails.allCases.count
            case .cancelSubscription: return PaymentsCancelSubscription.allCases.count
            case .none: return 0
        }
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none

        let section = PaymentsSetupSections(rawValue: indexPath.section)
        
        switch section {
        case .cardDetails:
            let row = PaymentsCardDetails(rawValue: indexPath.row)
            switch row {
            case .cardNumber:
                cell.imageView?.image = UIImage(named: "mastercard")
                cell.textLabel?.text = "xxxx-xxxx-xxxx-1234"
                break
            case .renewal:
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.lineBreakMode = .byWordWrapping
                cell.textLabel?.text = "Your subscription will automatically renew on 15 September 2022. You'll be charged USD50 per month."
                break
            case .updateCard:
                cell.textLabel?.text = "Update Card Details"
                cell.accessoryType = .disclosureIndicator
                break
            case .none: break
            }
            break
        case .cancelSubscription:
            let row = PaymentsCancelSubscription(rawValue: indexPath.row)
            cell.textLabel?.text = row?.name()
            cell.textLabel?.textColor = .red
            break
        case .none: break
        }
        
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        PaymentsSetupSections(rawValue: section)?.name()
    }
}

public enum PaymentsSetupSections: Int, Hashable, CaseIterable {
    case cardDetails
    case cancelSubscription
    
    public func name() -> String? {
        switch self {
            case .cardDetails: return "Payment Methods"
            case .cancelSubscription: return " "
        }
    }
}

public enum PaymentsCardDetails: Int, Hashable, CaseIterable {
    case cardNumber
    case renewal
    case updateCard
}

public enum PaymentsCancelSubscription: Int, Hashable, CaseIterable {
    case cancel
    
    public func name() -> String {
        switch self {
            case .cancel: return "Cancel Subscription"
        }
    }
}

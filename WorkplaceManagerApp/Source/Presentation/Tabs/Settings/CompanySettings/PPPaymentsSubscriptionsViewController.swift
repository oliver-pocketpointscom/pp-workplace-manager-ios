import UIKit
import SnapKit

public class PPPaymentsSubscriptionsViewController: PPBaseTableViewController {
    
    override init(style: UITableView.Style) {
        super.init(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addTitle("Payments and Billing")
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func initView() {
        tableView.backgroundColor = .backgroundColor()
        tableView.separatorColor = .white
    }
    
    private func onCancelSubscription() {
        let vc = PPCancelSubscriptionViewController(style: .grouped)
        push(vc: vc)
    }
}

extension PPPaymentsSubscriptionsViewController {
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = PaymentsSetupSections(rawValue: indexPath.section)
        switch section {
        case .cardDetails:
            showUnderConstructionDialog()
            break
        case .billingAddress:
            showUnderConstructionDialog()
            break
        case .cancelSubscription:
            let row = PaymentsCancelSubscription(rawValue: indexPath.row)
            switch row {
            case .cancel:
                onCancelSubscription()
                break
            case .none:
                break
            }
            break
        case .none:
            break
        }
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
            case .billingAddress: return PaymentBillingAddress.allCases.count
            case .cancelSubscription: return PaymentsCancelSubscription.allCases.count
            case .none: return 0
        }
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        
        let section = PaymentsSetupSections(rawValue: indexPath.section)
        
        switch section {
        case .cardDetails:
            let row = PaymentsCardDetails(rawValue: indexPath.row)
            switch row {
            case .cardNumber:
                cell.imageView?.image = UIImage(named: "mastercard")
                cell.textLabel?.text = "xxxx-xxxx-xxxx-1234"
                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
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
        case .billingAddress:
            let row = PaymentBillingAddress(rawValue: indexPath.row)
            switch row {
            case .address:
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.lineBreakMode = .byWordWrapping
                cell.textLabel?.text = "Marlise Coffee Shop (PTY) Ltd, 3 Seattle Ave, Dallas, Texas, 75002, United States"
                break
            case .updateAddress:
                cell.textLabel?.text = "Update Billing Address"
                cell.accessoryType = .disclosureIndicator
                break
            case .none:
                break
            }
            break
        case .cancelSubscription:
            let row = PaymentsCancelSubscription(rawValue: indexPath.row)
            cell.textLabel?.text = row?.name()
            cell.accessoryType = .disclosureIndicator
            break
        case .none: break
        }
        
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        PaymentsSetupSections(rawValue: section)?.name()
    }
    
    public override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = .backgroundColor()
    }
}

public enum PaymentsSetupSections: Int, Hashable, CaseIterable {
    case cardDetails
    case billingAddress
    case cancelSubscription
    
    public func name() -> String? {
        switch self {
            case .cardDetails: return "Payment Details"
            case .billingAddress: return "Billing Address"
            case .cancelSubscription: return " "
        }
    }
}

public enum PaymentsCardDetails: Int, Hashable, CaseIterable {
    case cardNumber
    case renewal
    case updateCard
}

public enum PaymentBillingAddress: Int, Hashable, CaseIterable {
    case address
    case updateAddress
}

public enum PaymentsCancelSubscription: Int, Hashable, CaseIterable {
    case cancel
    
    public func name() -> String {
        switch self {
            case .cancel: return "Cancel Subscription"
        }
    }
}

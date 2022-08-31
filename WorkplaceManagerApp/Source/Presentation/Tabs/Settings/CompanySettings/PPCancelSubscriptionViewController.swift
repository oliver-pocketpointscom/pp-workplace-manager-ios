import UIKit

public class PPCancelSubscriptionViewController: PPBaseTableViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addTitle("Cancel Subscription")
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func initView() {
        tableView.backgroundColor = .white
        tableView.separatorColor = .clear
    }
    
    private func cancelSubscriptionConfirmation() {
        let alert = UIAlertController(title: "Warning",
                                      message: "Are you sure you want to cancel your subscription?",
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive) { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.showLoginScreen()
        })
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showLoginScreen() {
        let vc = PPOnboardingViewController()
        let nc = UINavigationController(rootViewController: vc)
        UIApplication.shared.windows.first?.rootViewController = nc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    @objc func onCancelSubscription() {
        cancelSubscriptionConfirmation()
    }
}

extension PPCancelSubscriptionViewController {
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       1
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none

        let section = CancelSubscriptionSections(rawValue: indexPath.section)
        switch section {
        case .info:
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.textAlignment = .justified
            cell.textLabel?.lineBreakMode = .byWordWrapping
            cell.textLabel?.text = "You can still use the app until your subscription ends on 30 Sep 2022.\n\nEffective 01 October 2022, all active Pocket Points employeees will be deactivated and will no longer have access to the app.\nThey should receive a notification with instructions on how to delete their profile. \n\nIf you wish to re-activate your subscription, kindly contact our support team at support@pocketpoints.com."
            break
        case .cancelSubscription:
            let btnCell = ButtonTableViewCell()
            btnCell.button.setTitle("Cancel Subscription", for: .normal)
            btnCell.button.backgroundColor = .red
            btnCell.button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onCancelSubscription)))
            btnCell.selectionStyle = .none
            return btnCell
        case .none: break
        }
        
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        " "
    }
}

public enum CancelSubscriptionSections: Int, Hashable, CaseIterable {
    case info
    case cancelSubscription
}



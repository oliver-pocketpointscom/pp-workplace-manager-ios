import UIKit

public class PPChoosePlanViewController: PPBaseViewController {
    
    private let customView = ChoosePlanView()
    
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
        view.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        customView.primaryButton.addTarget(self, action: #selector(onSubscribe), for: .touchUpInside)
        customView.secondaryButton.addTarget(self, action: #selector(onFreeTrial), for: .touchUpInside)
    }
    
    @objc func onSubscribe() {
        showDisclaimer()
    }
    
    @objc func onFreeTrial() {
        showHome()
    }
    
    private func showDisclaimer() {
        let title = "Disclaimer"
        let message = "You will be redirected into an external browser to select your subscription plan and process the payment. Once you leave the Workplace app, you'll be covered by the policy and security measures of the site you are visiting."
        
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
        let url = URL(string:"https://api-wp-dev.pocketpoints.com/checkout")!
        UIApplication.shared.open(url, options: [:])
    }
    
    private func showHome() {
        let home = PPTabBarController()
        UIApplication.shared.windows.first?.rootViewController = home
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}

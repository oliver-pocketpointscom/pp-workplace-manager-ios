import UIKit

import SnapKit

public class PPChooseNumberOfLicenseViewController: PPBaseViewController {
    
    public var shouldShowPaymentDetails: Bool = false
    
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
        let customView = ChooseNumberOfLicenseView()
        customView.paymentDetailsView.isHidden = !shouldShowPaymentDetails
        view.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        customView.primaryButton.addTarget(self, action: #selector(onProceed), for: .touchUpInside)
    }
    
    @objc func onProceed() {
        navigateHome()
    }
    
    private func navigateHome() {
        let home = PPTabBarController()
        UIApplication.shared.windows.first?.rootViewController = home
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}

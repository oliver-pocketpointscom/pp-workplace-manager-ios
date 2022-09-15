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
        customView.primaryButton.addTarget(self, action: #selector(onProceed), for: .touchUpInside)
    }
    
    @objc func onProceed() {
        let vc = PPChooseNumberOfLicenseViewController()
        if let tag = customView.radioButton.selectedButton?.tag {
            if tag != 1 {
                vc.shouldShowPaymentDetails = true
            }
        }
        push(vc: vc)
    }
    
}
